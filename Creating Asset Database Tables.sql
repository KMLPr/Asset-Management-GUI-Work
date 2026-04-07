CREATE TABLE users(
user_id INT PRIMARY KEY AUTO_INCREMENT,
first_name varchar(50),
last_name varchar(50),
DOB DATE,
email varchar(50),
location varchar(50),
department varchar(50),
work_status ENUM('Available', 'Unavailable')
);

CREATE TABLE assets(
asset_id INT PRIMARY KEY AUTO_INCREMENT,
asset_tag varchar(50) UNIQUE,
asset_name varchar(50),
asset_cost FLOAT,
category_id INT,
purchase_date DATE,
asset_status ENUM('Assigned', 'Missing', 'Available', 'In Repair'),
location varchar(50),
FOREIGN KEY(category_id) REFERENCES categories(category_id)
);

CREATE TABLE categories(
category_id INT PRIMARY KEY AUTO_INCREMENT,
category_name ENUM('Desktop', 'Laptop', 'Virtual Machine', 'Printer', 'Mobile', 'Tablet')
);

CREATE TABLE assignments(
assignment_id INT PRIMARY KEY AUTO_INCREMENT,
asset_id INT,
user_id INT,
assigned_date DATE,
return_date DATE,
FOREIGN KEY(asset_id) REFERENCES assets(asset_id),
FOREIGN KEY(user_id) REFERENCES users(user_id)
);

CREATE TABLE maintenance(
maint_id INT PRIMARY KEY AUTO_INCREMENT,
asset_id INT,
issue_desc TEXT,
maint_status ENUM('Open', 'In progress', 'Closed'),
open_date DATE,
resolve_date DATE,
FOREIGN KEY(asset_id) REFERENCES assets(asset_id)
);