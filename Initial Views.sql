CREATE VIEW current_assignment AS
SELECT
a.asset_id, a.asset_tag, a.asset_name, u.user_id, CONCAT(u.first_name, ' ', u.last_name) AS full_name,
u.department,
asg.assigned_date
FROM assignments asg
JOIN assets a ON asg.asset_id = a.asset_id
JOIN users u ON asg.user_id = u.user_id
WHERE asg.return_date IS NULL;
-- Shows who currently has what with return date being null to show they still have it

CREATE VIEW available_assets AS
SELECT
asset_id, asset_tag, asset_name, location, asset_cost
FROM assets
WHERE asset_status = 'Available';
-- Drop down to show available assets, good for an inventory screen

CREATE VIEW assets_in_maintenance AS
SELECT
a.asset_id, a.asset_tag, a.asset_name, m.issue_desc, m.maint_status, m.open_date
FROM maintenance m 
JOIN assets a ON m.asset_id = a.asset_id
WHERE m.maint_status != 'Closed';
-- Track active issues/tickets
-- Possible alerts or service screen

CREATE VIEW asset_history AS
SELECT
a.asset_tag, a.asset_name, CONCAT(u.first_name, ' ', u.last_name) AS full_name,
asg.assigned_date, asg.return_date
FROM assignments asg
JOIN assets a ON asg.asset_id = a.asset_id
JOIN users u ON asg.user_id = u.user_id;
-- Shows tracking of who had what for periods of time

CREATE VIEW assets_per_user AS
SELECT
u.user_id, CONCAT(u.first_name, ' ', u.last_name) AS full_name,
COUNT(asg.asset_id) as total_assets
FROM users u
LEFT JOIN assignments asg ON u.user_id = asg.user_id AND asg.return_date IS NULL
GROUP BY u.user_id;
-- Keep track of the amount of assets each user has
-- Good for a possible dashboard

CREATE VIEW assets_by_department AS
SELECT
u.department,
COUNT(asg.asset_id) AS total_assets
FROM assignments asg
JOIN users u ON asg.user_id = u.user_id
WHERE asg.return_date IS NULL
GROUP BY u.department;
-- Real example of business analytics for a dashboard or some chart to work with

CREATE VIEW overdue_assignments AS
SELECT
a.asset_tag, CONCAT(u.first_name, ' ', u.last_name) as user_name,
asg.assigned_date, DATEDIFF(CURDATE(), asg.assigned_date) as days_assigned
FROM assignments asg
JOIN assets a ON asg.asset_id = a.asset_id
JOIN users u ON asg.user_id = u.user_id
WHERE asg.return_date IS NULL
AND DATEDIFF(CURDATE(), asg.assigned_date) > 730;
-- Keeping track of users still assigned to a device for over 2 years to determine who will need a new one

CREATE VIEW asset_summary AS
SELECT
asset_status, COUNT(*) as total
FROM assets
GROUP BY asset_status;
-- Similar to an audit board to get a full view of all assets and their status