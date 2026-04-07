INSERT INTO categories (category_name) VALUES
('Desktop'),
('Laptop'),
('Virtual Machine'),
('Printer'),
('Mobile'),
('Tablet');

INSERT INTO users (first_name, last_name, DOB, email, location, department, work_status) VALUES
('John', 'Doe', '1995-03-15', 'john.doe@company.com', 'New York', 'IT', 'Available'),
('Sarah', 'Lee', '1992-07-22', 'sarah.lee@company.com', 'Boston', 'HR', 'Available'),
('Michael', 'Smith', '1988-11-10', 'michael.smith@company.com', 'Chicago', 'Finance', 'Unavailable'),
('Emily', 'Davis', '1996-01-05', 'emily.davis@company.com', 'Seattle', 'Customer Support', 'Available'),
('David', 'Wilson', '1990-09-30', 'david.wilson@company.com', 'Austin', 'IT', 'Available'),
('Jessica', 'Brown', '1994-06-18', 'jessica.brown@company.com', 'Denver', 'Marketing', 'Unavailable');

INSERT INTO assets (asset_tag, asset_name, asset_cost, category_id, purchase_date, asset_status, location) VALUES
('DT-001', 'Dell OptiPlex 7090', 1200.00, 1, '2023-01-10', 'Available', 'HQ'),
('LT-002', 'MacBook Pro 14', 2000.00, 2, '2023-03-15', 'Assigned', 'HQ'),
('VM-003', 'AWS EC2 Instance', 500.00, 3, '2023-05-20', 'Available', 'Cloud'),
('PR-004', 'HP LaserJet Pro', 300.00, 4, '2022-11-01', 'In Repair', 'Office A'),
('MB-005', 'iPhone 13', 999.00, 5, '2023-02-25', 'Assigned', 'HQ'),
('TB-006', 'iPad Air', 600.00, 6, '2023-04-12', 'Available', 'Storage');

INSERT INTO assignments (asset_id, user_id, assigned_date, return_date) VALUES
(2, 1, '2024-01-10', NULL),
(5, 2, '2024-02-01', NULL);

INSERT INTO maintenance (asset_id, issue_desc, maint_status, open_date, resolve_date) VALUES
(4, 'Paper jam issue', 'In progress', '2024-03-01', NULL),
(1, 'Slow performance', 'Closed', '2024-01-15', '2024-01-20');

