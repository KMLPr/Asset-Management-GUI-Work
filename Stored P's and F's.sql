DELIMITER //
CREATE PROCEDURE assign_asset(
IN p_asset_id INT,
IN p_user_id INT
)
BEGIN
-- Check the status of the asset to see if it is available to assign
IF (SELECT asset_status FROM assets WHERE asset_id = p_asset_id) = 'Available' THEN
        INSERT INTO assignments (asset_id, user_id, assigned_date)
        VALUES (p_asset_id, p_user_id, CURDATE());
    UPDATE assets
    SET asset_status = 'Assigned'
    WHERE asset_id = p_asset_id;
    
    ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Asset is not available';
END IF;

END //

DELIMITER ;

-- When an asset is returned we change the status and update the return date
DELIMITER //
CREATE PROCEDURE return_asset(
IN p_asset_id INT
)
BEGIN
	UPDATE assignments
    SET return_date = CURDATE()
    WHERE asset_id = p_asset_id
    AND return_date IS NULL;
    
    UPDATE assets
    SET asset_status = 'Available'
    WHERE asset_id = p_asset_id;
END //

DELIMITER ;

-- Open a ticket for an asset that needs maintenance and update its status
DELIMITER //
CREATE PROCEDURE open_maintenance(
	IN p_asset_id INT,
    IN p_issue TEXT
)
BEGIN
	INSERT INTO maintenance(asset_id, issue_desc, maint_status, open_date)
    VALUES(p_asset_id, p_issue, 'Open', CURDATE());
    
    UPDATE assets
    SET asset_status = 'In Repair'
    WHERE asset_id = p_asset_id;
    
END //
DELIMITER ;

-- Close the maintenance ticket
DELIMITER //

CREATE PROCEDURE close_maintenance(
	IN p_maint_id INT
)
BEGIN
	UPDATE maintenance
    SET maint_status = 'Closed', resolve_date = CURDATE()
    WHERE maint_id = p_maint_id;
    
    UPDATE assets
    SET asset_status = 'Available'
    WHERE asset_id = (SELECT asset_id FROM maintenance WHERE maint_id = p_maint_id);
    
END //
DELIMITER ;

-- Create a new asset to add to the inventory management
DELIMITER //

CREATE PROCEDURE add_asset(
	IN p_tag VARCHAR(50),
    IN p_name VARCHAR(50),
    IN p_cost FLOAT,
    IN p_category INT,
    IN p_location VARCHAR(50)
)
BEGIN
    INSERT INTO assets (
        asset_tag, asset_name, asset_cost, category_id, purchase_date, asset_status, location)
    VALUES (p_tag, p_name, p_cost, p_category, CURDATE(), 'Available', p_location);
END //
DELIMITER ;

-- Get the days an asset has been assigned
DELIMITER //

CREATE FUNCTION days_assigned(p_asset_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE days INT;

    SELECT DATEDIFF(CURDATE(), assigned_date)
    INTO days
    FROM assignments
    WHERE asset_id = p_asset_id
    AND return_date IS NULL
    LIMIT 1;

    RETURN IFNULL(days, 0);
END //
DELIMITER ;

-- Get the number of assets each user has assigned to them
DELIMITER //

CREATE FUNCTION user_asset_count(p_user_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM assignments
    WHERE user_id = p_user_id
    AND return_date IS NULL;

    RETURN total;
END //
DELIMITER ;

-- Get total value of all assets assigned to the user
-- Might be good for cost center or audits
DELIMITER //

CREATE FUNCTION total_asset_value(p_user_id INT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE total FLOAT;

    SELECT SUM(a.asset_cost)
    INTO total
    FROM assignments asg
    JOIN assets a ON asg.asset_id = a.asset_id
    WHERE asg.user_id = p_user_id
    AND asg.return_date IS NULL;

    RETURN IFNULL(total, 0);
END //
DELIMITER ;