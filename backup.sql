-- Creating tables
CREATE DATABASE IF NOT EXISTS kilburnazon;
USE kilburnazon;

CREATE TABLE IF NOT EXISTS Area (
    area_id INTEGER AUTO_INCREMENT,
    area_name VARCHAR(30) NULL DEFAULT NULL,
    PRIMARY KEY (area_id)
) ENGINE = InnoDB;
-- ALTER TABLE Area AUTO_INCREMENT =

CREATE TABLE IF NOT EXISTS Office (
    office_id INTEGER NOT NULL ,
    area_id INTEGER NULL DEFAULT NULL,
    PRIMARY KEY(office_id),
    CONSTRAINT  fk_office_area_id FOREIGN KEY (area_id)
        REFERENCES Area(area_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Warehouse (
    warehouse_id INTEGER NOT NULL,
    warehouse_location VARCHAR(50) NULL DEFAULT NULL UNIQUE,
    warehouse_purpose VARCHAR(50) NULL DEFAULT NULL,
    warehouse_size VARCHAR(20) NULL DEFAULT NULL,
    area_id INTEGER NULL DEFAULT NULL,
    PRIMARY KEY(warehouse_id),
    CONSTRAINT  fk_warehouse_area_id FOREIGN KEY (area_id)
        REFERENCES Area(area_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Building (
    building_id INTEGER NOT NULL,
    warehouse_id INTEGER NOT NULL,
    office_id INTEGER NOT NULL,
    PRIMARY KEY(building_id),
    CONSTRAINT  fk_building_warehouse_id FOREIGN KEY (warehouse_id)
        REFERENCES Warehouse(warehouse_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT  fk_building_office_id FOREIGN KEY (office_id)
        REFERENCES Office(office_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Department (
    department_name VARCHAR(8) NOT NULL,
    amount_of_employee INTEGER NULL DEFAULT 0,
    department_leader VARCHAR(30) NULL DEFAULT NULL,
    area_id INTEGER NULL DEFAULT NULL,
    PRIMARY KEY(department_name),
    CONSTRAINT  fk_department_area_id FOREIGN KEY (area_id)
        REFERENCES Area(area_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Employee (
    employee_number INTEGER NOT NULL,
    employee_name VARCHAR(30) NOT NULL UNIQUE,
    employee_address VARCHAR(50) NOT NULL,
    employee_salary DECIMAL(9,2) NOT NULL,
    date_of_birth DATE NOT NULL ,
    NIN_number VARCHAR(9) NOT NULL UNIQUE ,
    department_name VARCHAR(8) NOT NULL,
    manager_id INTEGER NULL DEFAULT NULL,
    building_id INTEGER NULL DEFAULT NULL,
    working_hour VARCHAR(20) NULL DEFAULT NULL,
    PRIMARY KEY (employee_number),
    CONSTRAINT  fk_employee_department_name FOREIGN KEY (department_name)
        REFERENCES Department(department_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT  fk_employee_building_id FOREIGN KEY (building_id)
        REFERENCES Building(building_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Manager_Range (
    employee_number INTEGER NOT NULL,
    department_number INTEGER NOT NULL,
    PRIMARY KEY (employee_number, department_number)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Emergency_Contact (
    employee_number INTEGER NOT NULL PRIMARY KEY,
    EC_name VARCHAR(30) NOT NULL,
    EC_relationship VARCHAR(15) NOT NULL,
    EC_phone_number VARCHAR(15) NOT NULL,
    CONSTRAINT fk_employee FOREIGN KEY (employee_number)
        REFERENCES Employee(employee_number)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Complaint (
    complaint_number INTEGER NOT NULL,
    complaint_date DATETIME NOT NULL,
    customer_name VARCHAR(30) NULL DEFAULT NULL,
    complaint_reason VARCHAR(100) NOT NULL,
    employee_number INTEGER NOT NULL,
    PRIMARY KEY(complaint_number),
    CONSTRAINT  fk_complaint_employee_number FOREIGN KEY (employee_number)
        REFERENCES Employee(employee_number)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Stop (
    stop_name VARCHAR(30) NOT NULL,
    stop_time TIME NOT NULL,
    PRIMARY KEY(stop_name)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Vehicle (
    vehicle_id VARCHAR(20) NOT NULL,
    vehicle_name VARCHAR(20) NOT NULL,
    area_id INTEGER NOT NULL,
    PRIMARY KEY(vehicle_id),
    CONSTRAINT  fk_vehicle_area_id FOREIGN KEY (area_id)
        REFERENCES Area(area_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Route (
    route_name VARCHAR(30) NOT NULL,
    starting_location VARCHAR(58) NULL DEFAULT NULL,
    ending_location VARCHAR(58) NULL DEFAULT NULL,
    starting_time TIME NULL DEFAULT NULL,
    ending_time TIME NULL DEFAULT NULL,
    stop_name VARCHAR(30) NULL DEFAULT NULL,
    PRIMARY KEY(route_name),
    CONSTRAINT  fk_route_stop_name FOREIGN KEY (stop_name)
        REFERENCES Stop(stop_name)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Driver_Work_State (
    employee_number VARCHAR(10) NOT NULL,
    vehicle_id VARCHAR(10) NOT NULL,
    route_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (employee_number, vehicle_id, route_name)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Product (
    product_id VARCHAR(20) NOT NULL,
    product_name VARCHAR(20) NULL DEFAULT NULL,
    product_description VARCHAR(100) NULL DEFAULT NULL,
    product_price DECIMAL(7, 2) NULL DEFAULT NULL,
    PRIMARY KEY(product_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Product_Order (
    order_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    PRIMARY KEY (order_id, product_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Product_Left (
    warehouse_id INTEGER NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    quantity_left MEDIUMINT NULL DEFAULT 0,
    PRIMARY KEY (warehouse_id, product_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Customer (
    customer_id INTEGER AUTO_INCREMENT,
    customer_name VARCHAR(30) NOT NULL,
    customer_postcode VARCHAR(10) NOT NULL,
    customer_email VARCHAR(64) NOT NULL,
    PRIMARY KEY (customer_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Order_Situation (
    order_id INTEGER NOT NULL,
    order_date DATETIME NOT NULL,
    customer_id INTEGER NOT NULL,
    PRIMARY KEY(order_id),
    CONSTRAINT fk_order_situation_customer FOREIGN KEY(customer_id)
        REFERENCES Customer(customer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

-- default department names
INSERT Department(department_name, amount_of_employee, department_leader, area_id)
    VALUES ('Driver', null, 0, null);
INSERT Department(department_name, amount_of_employee, department_leader, area_id)
    VALUES ('HR', null, 0, null);
INSERT Department(department_name, amount_of_employee, department_leader, area_id)
    VALUES ('Packager', null, 0, null);
INSERT Department(department_name, amount_of_employee, department_leader, area_id)
    VALUES ('Manager', null, 0, null);

SELECT @@AUTOCOMMIT;  -- 1 means commit automatically; 0 means commit by hand
SET @@AUTOCOMMIT = 0;

START TRANSACTION;

INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (223708071, 'Rab Feast', '9503 Buell Drive', 30397.56, '1986-4-1', 'rb499211c', 'HR', 992);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (492217652, 'Georas Divisek', '25 Moulton Lane', 87452.13, '1951-5-10', 'ht175666x', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (405288701, 'Ame Balser', '2282 Sutteridge Lane', 71557.8, '1998-1-22', 'dt545040m', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (786321379, 'Thea Bradborne', '3118 Lien Circle', 35665.99, '1967-9-27', 'vb943949c', 'Driver', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (413659990, 'Ruperta Stobie', '2825 Pepper Wood Center', 83681.2, '1976-9-17', 'qf137469l', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (438492699, 'Hortense Berecloth', '2 Barby Parkway', 38548, '1987-7-29', 'zt656754o', 'Driver', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (684171892, 'Yoshi Peakman', '641 Warner Point', 20293.38, '1953-3-6', 'to907441w', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (725913162, 'Rudolfo Norridge', '22 Golf Court', 37428.03, '1968-8-24', 'du615694i', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (74517183, 'Rochell ODoohaine', '1802 Hayes Court', 25471.21, '1973-11-8', 'rz111360g', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (550320348, 'Granville McKitterick', '04 Rieder Parkway', 83664.78, '1965-2-20', 'dr180938w', 'Driver', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (598314806, 'Scotty Keson', '14 Kipling Point', 67107.29, '1967-2-20', 'gx924268x', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (660739491, 'Latashia McGaugan', '1386 Artisan Parkway', 58941.46, '1992-7-8', 'nz662678p', 'Manager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (981678319, 'Lamar Chesters', '2234 Heffernan Place', 97090.47, '1952-2-1', 'wh660279o', 'Driver', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (301322103, 'Earl Wagerfield', '34 Lillian Center', 91770.28, '1998-4-5', 'zw251674d', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (317167962, 'Emanuele Strickland', '3772 Dawn Drive', 15549.15, '1967-4-14', 'qy726870d', 'HR', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (51945849, 'Cherilyn Jepps', '062 Nevada Parkway', 85550.33, '1971-10-30', 'xz796669h', 'Driver', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (367073092, 'Thelma Wilkie', '113 Badeau Plaza', 32280.23, '1984-10-1', 'bl221585z', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (862503827, 'Nikola Henbury', '8116 Erie Junction', 95300.54, '1974-4-7', 'cz046288u', 'Driver', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (297832408, 'Lexine Joney', '73817 Muir Court', 19232.41, '1978-4-1', 'pk696816m', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (358208617, 'Sayre Simnel', '761 Kennedy Lane', 72894, '1958-12-7', 'jr596419t', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (432037577, 'Leisha Mieville', '027 Clarendon Center', 68826.28, '1997-11-17', 'nj080641o', 'Driver', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (509092071, 'Jodie Busswell', '8 Pepper Wood Avenue', 14441.41, '1997-2-2', 'qz236393m', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (756520267, 'Truda Edleston', '37994 Green Ridge Drive', 23646.9, '1997-1-1', 'lp500272n', 'Driver', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (125128654, 'Hadlee Stealey', '0 4th Court', 52510.07, '1949-10-1', 'tf577069v', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (104168432, 'Robinetta Triswell', '5 Independence Trail', 74033.43, '2002-10-16', 'eu934314q', 'Packager', 223708071);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (857718619, 'Rhody Yaxley', '90344 Merrick Crossing', 98055.42, '1953-3-23', 'of102924m', 'HR', 992);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (619391449, 'Lester Carmo', '6 Buell Trail', 37061.26, '1947-1-9', 'mt812263o', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (596274425, 'Talbert Abbotts', '29565 Jenifer Court', 92884.08, '1958-9-11', 'ae100121f', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (537191465, 'Delila Folland', '5993 Warner Park', 32281.47, '1979-9-18', 'vk993165i', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (302374884, 'Felicdad Escala', '26 Holy Cross Place', 22260.8, '1967-8-23', 'ei636866y', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (400786243, 'Oswell Beddingham', '12989 Village Green Street', 97980.89, '1947-4-17', 'lh106861m', 'HR', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (500945563, 'Ashbey England', '3 Oneill Crossing', 66223.46, '1929-11-3', 'uj306006a', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (453951342, 'Chris Skittrell', '174 Namekagon Court', 80039.37, '1963-11-2', 'io334297g', 'HR', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (667576883, 'Dur Janodet', '91175 Northland Hill', 54589.37, '1969-5-31', 'jd412382q', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (69710935, 'Wileen Elwell', '82 Tennyson Alley', 78678.52, '1974-10-1', 'no969473z', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (141209073, 'Cheri Cancellieri', '97763 Anhalt Way', 62678.28, '1949-12-4', 'fj377449j', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (717374760, 'Alfie Dean', '15 Mccormick Point', 21930.1, '1993-8-10', 'lh444635g', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (675029558, 'Gianina Leppington', '1 Jenifer Park', 77499.37, '1992-4-2', 've628368y', 'HR', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (984762907, 'Nari Crawshaw', '40 Debra Center', 91733.92, '1950-4-19', 'kd444344u', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (690803348, 'Editha Anney', '271 Browning Plaza', 67023.77, '1955-9-17', 'mk604551h', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (33544565, 'Feodor Inge', '5 Knutson Plaza', 91614.47, '1950-5-29', 'en390360s', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (901403954, 'Jeffy Camel', '067 Columbus Street', 78815.19, '1950-12-12', 'ql321121l', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (763367992, 'Pammy Sterling', '466 Northfield Alley', 86046.49, '1950-3-11', 'sj533699h', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (202758343, 'Harrison Waller-Bridge', '73899 Sachtjen Alley', 39846.48, '1947-4-4', 'dw797814s', 'HR', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (51128789, 'Paulita Casewell', '18 Riverside Trail', 73099.76, '1965-8-3', 'ds948250k', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (337614004, 'Modesty Chicchelli', '74 Bashford Pass', 23376.55, '1966-3-1', 'zz664726s', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (416555988, 'Marwin Raybould', '925 Novick Lane', 51081.29, '1967-12-19', 'dp016938u', 'HR', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (160283796, 'Delphinia Skelhorn', '115 Cody Point', 91026.23, '1944-7-7', 'mx935884p', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (900686303, 'Ludovika Blucher', '0141 Forest Alley', 59728.01, '1957-7-8', 'sk016695u', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (727823438, 'Adrienne Myall', '9 Oneill Place', 31683.24, '1949-9-2', 'uv348158a', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (296571924, 'Arne Bosson', '77803 Messerschmidt Park', 73371.57, '1991-5-1', 'ux813250n', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (750958781, 'Velvet Carbine', '682 Kensington Drive', 31440.81, '1959-1-9', 'of014519k', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (834865660, 'Jase Fulk', '80 Pennsylvania Center', 76557.9,  '1970-1-23', 'ak984038n', 'Manager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (106127924, 'Joshuah Faircliffe', '8 Merry Center', 30666.21, '1970-2-2', 'ft026339d', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (639116461, 'Aylmer Gabbatiss', '8828 Blue Bill Park Avenue', 18526.9, '1970-3-2',  'qj799086z', 'HR', 992);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (520404205, 'Pierce Kemp', '63008 Raven Place', 82902.41, '1970-9-10', 'dd271029j', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (229529013, 'Reginauld Oak', '8 Pleasure Drive', 80693.8, '1970-8-23', 'ju954932e', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (588249246, 'Maggi Hamshar', '92344 Main Avenue', 34269.41, '1970-7-11', 'rb919501k', 'Driver', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (806524018, 'Ambur Challenor', '2 Morning Crossing', 47033.97, '1970-6-1', 'tn459758p', 'Packager', 857718619);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (303058947, 'Hettie Broadbent', '5 Rowland Road', 74439.57, '1970-5-5', 'an167975t', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (444915402, 'Phaidra Ivey', '46 Toban Lane', 61580.95, '1970-10-9', 'yg637206i', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (394788866, 'Phillida Musicka', '111 Twin Pines Center', 84543.42, '1970-11-14', 'pg674068r', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (609203590, 'Shoshana Downie', '8416 Carberry Crossing', 83867.01, '1970-12-20', 'ee740085i', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (601691051, 'Winnah Gillott', '40711 Dayton Plaza', 48040.51, '1971-1-20', 'qv299811c', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (677636850, 'Felice Plaide', '0617 Daystar Drive', 58909.33, '1971-1-18', 'vl606950t', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (155837614, 'Loren Kupper', '24 West Plaz', 92010.3, '1971-2-13', 'tx310999b', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (456995640, 'Sigfrid Mankor', '9773 Old Shore Way', 12758.05, '1971-3-18', 'fi299116a', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (979018441, 'Morganica Dracksford', '867 Pierstorff Hill', 91483.69, '1971-4-20', 'po115732f', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (21151200, 'Bax Di Gregorio', '34063 Fordem Way', 76631.69, '1971-5-26', 'kt775367m', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (626894804, 'Merrie Stayt', '0 Manufacturers Alley', 39159.86, '1971-6-21', 'cq847516d', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (990222188, 'Lonnie Niessen', '754 Lien Road', 95600.64, '1971-7-10', 'gb123108s', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (295105992, 'Borg Szymanzyk', '41 Amoth Crossing', 77828.8, '1971-8-11', 'hm134578n', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (119162644, 'Ninnette Reach', '018 2nd Parkway', 33411.86, '1971-9-30', 'qi586048l', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (737147493, 'Chelsea Robertucci', '94833 Northview Way', 78083.27, '1971-10-10', 'df426741g', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (161242322, 'Gris Elington', '12 School Way', 40776.94, '1971-11-12', 'sp696523t', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (94856118, 'Sofie Cavaney', '12677 Northridge Alley', 19096.73, '1971-12-13', 'hg982259y', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (244677621, 'Derril Scaife', '4 Tony Street', 82281.31, '1972-1-14', 'qb596623c', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (60280761, 'Odey Smeeth', '46584 Kedzie Point', 97871, '1972-2-15', 'rz638367h', 'HR', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (973138911, 'Alvina Paterno', '09 Golf Drive', 23002.76, '1972-3-16', 'ao592540g', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (364580826, 'Olivia MacPhee', '09 Saint Paul Point', 85391.76, '1972-4-17', 'dj312271a', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (935928498, 'Sukey Roddan', '5 Gulseth Center', 18304.57, '1972-4-18', 'ik578743b', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (758250680, 'Conney Ferras', '43048 American Ash Hill', 93389.4, '1972-5-20', 'us717372t', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (348601206, 'Dulcia Antonutti', '9 Kingsford Plaza', 61015.9, '1972-6-30', 'za364662q', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (591166943, 'Parker Filippov', '9 Granby Terrace', 65946.54, '1972-7-2', 'xp081647h', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (175831110, 'Viviana Dreschler', '3 Oak Terrace', 56587.83, '1972-8-3', 'vx435216w', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (191277494, 'Perice Abramovitz', '2354 Jenifer Place', 55612.48, '1972-9-4', 'bs437833j', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (556072477, 'Waring Durkin', '9597 Towne Center', 82140.98, '1972-10-5', 'mg195096h', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (420717807, 'Robin Bartkowiak', '5559 Shelley Circle', 89053.24, '972-11-6', 'mu698813c', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (574162757, 'Beulah Vala', '07601 Sunfield Hill', 37954.91, '1972-12-7', 'ro435900h', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (685871521, 'Bearnard Parysowna', '60052 Monument Alley', 85175.33, '1973-1-8', 'vg613456a', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (577596762, 'Joelie Bacchus', '0374 Pawling Hill', 14722.35, '1973-2-10', 'ok001999u', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (944705277, 'Orton Willmore', '4 Pine View Street', 14870.36, '1974-3-14', 'xh603239m', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (636111701, 'Fayre Tomney', '1506 Ryan Point', 58829.33, '1974-4-16', 'ia005234g', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (740303597, 'Bria Thomkins', '7 Homewood Road', 88871.61, '1974-5-18', 'tx085395s', 'Manager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (764036199, 'Noni Szymoni', '6 Kedzie Circle', 90864.71, '1974-6-20', 'yl605202h', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (413975053, 'Felipe Ferschke', '5508 Hauk Terrace', 63359.81, '1975-8-10', 'pu346240t', 'HR', 992);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (171342407, 'Mala Eyree', '6 Dorton Circle', 24532.92, '1976-9-11', 'kf326923s', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (521336694, 'Renaldo Fussey', '7 Northland Street', 46099.86, '1978-10-11', 'nz535691o', 'Driver', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (630638100, 'Edd Speere', '812 High Crossing Junction', 13662.8, '1988-11-12', 'au549358u', 'Packager', 639116461);
INSERT Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name, manager_id) VALUES (263324931, 'Nelle Thams', '04 Weeping Birch Junction', 12571.28, '1989-12-13', 'qj455525d', 'Driver', 639116461);

-- ROLLBACK;
COMMIT;

START TRANSACTION;

INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (223708071, 'Jereme Slayford', 'Girlfriend', '07721 065 357');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (492217652, 'Nessy Panting', 'Civil Partner', '07326 502 172');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (405288701, 'Kipp Lavens', 'Boyfriend', '07489 365 686');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (786321379, 'Theo Sheard', 'Mother', '07356 401 825');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (413659990, 'Joly Doram', 'Girlfriend', '07106 575 891');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (438492699, 'Baird Fingleton', 'Boyfriend', '07789 751 694');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (684171892, 'Patty Horsburgh', 'Husband', '07924 918 978');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (725913162, 'Frazier Snelman', 'Boyfriend', '07235 513 354');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (74517183, 'Regan Yarn', 'Mother', '07967 811 408');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (550320348, 'Zita Stanborough', 'Mother', '07532 693 273');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (598314806, 'Norrie Aggis', 'Husband', '07390 692 263');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (660739491, 'Eada Silmon', 'Wife', '07007 182 872');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (981678319, 'Maryjo Elgie', 'Wife', '07007 723 133');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (301322103, 'Bastian Walliker', 'Civil Partner', '07695 349 556');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (317167962, 'Winfred Moncey', 'Wife', '07510 608 683');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (51945849, 'Michaelina Brahms', 'Civil Partner', '07996 211 011');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (367073092, 'Tabbitha Shemmans', 'Wife', '07625 474 049');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (862503827, 'Jone Tatersale', 'Mother', '07761 255 990');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (297832408, 'Quinn Goodfellow', 'Husband', '07755 486 861');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (358208617, 'Flory Billham', 'Husband', '07184 248 686');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (432037577, 'Alyosha Halewood', 'Boyfriend', '07204 386 023');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (509092071, 'Simone Kitchenman', 'Father', '07958 325 944');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (756520267, 'Tyler Rowsell', 'Wife', '07753 973 466');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (125128654, 'Renee Kubatsch', 'Mother', '07643 213 336');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (104168432, 'Ivett Rapier', 'Boyfriend', '07016 239 710');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (857718619, 'Margot Santos', 'Girlfriend', '07915 649 295');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (619391449, 'Alis Plaster', 'Father', '07547 928 939');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (596274425, 'Jon McAlester', 'Husband', '07015 001 355');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (537191465, 'Cori Phillipps', 'Husband', '07572 306 041');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (302374884, 'Alonzo Whilder', 'Boyfriend', '07404 498 162');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (400786243, 'Leslie Keningham', 'Father', '07765 606 938');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (500945563, 'Tim Stiff', 'Girlfriend', '07764 772 037');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (453951342, 'Arthur Landsborough', 'Mother', '07679 670 222');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (667576883, 'Golda Preston', 'Father', '07636 377 875');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (69710935, 'Stevy Cestard', 'Husband', '07510 562 958');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (141209073, 'Leesa Bonhome', 'Wife', '07668 929 915');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (717374760, 'Godard Klimmek', 'Wife', '07219 099 770');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (675029558, 'Joycelin Mushet', 'Father', '07772 470 745');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (984762907, 'Ewart Benton', 'Civil Partner', '07888 475 034');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (690803348, 'Lloyd Pidon', 'Boyfriend', '07416 146 403');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (33544565, 'Nolie Turfitt', 'Boyfriend', '07872 652 134');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (901403954, 'Vinnie Parr', 'Father', '07792 234 252');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (763367992, 'Milty Corney', 'Husband', '07432 348 532');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (202758343, 'Alaine Gozney', 'Girlfriend', '07874 802 135');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (51128789, 'Bambie Bennell', 'Father', '07411 921 600');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (337614004, 'Antoine De Caville', 'Father', '07676 274 711');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (416555988, 'Margette Osman', 'Firlfriend', '07794 678 823');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (160283796, 'Zita Greasty', 'Father', '07672 610 977');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (900686303, 'Wain Savine', 'Civil Partner', '07473 391 474');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (727823438, 'Taylor Screach', 'Civil Partner', '07029 866 049');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (296571924, 'Haroun Izakovitz', 'Husband', '07369 136 446');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (750958781, 'Lorri Elkington', 'Girlfriend', '07692 074 959');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (834865660, 'Rosabella Howlin', 'Father', '07545 233 448');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (106127924, 'Freddie Lorie', 'Husband', '07975 207 662');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (639116461, 'Paxton Aspole', 'Boyfriend', '07789 380 331');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (520404205, 'Seumas Ivantsov', 'Husband', '07643 549 188');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (229529013, 'Hieronymus Eldon', 'Mother', '7315 598 289');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (588249246, 'Theresina Tring', 'Civil Partner', '07536 036 354');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (806524018, 'Eilis Domenici', 'Civil Partner', '07141 393 691');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (303058947, 'Paten Velten', 'Husband', '7747 283 371');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (444915402, 'Franz Barribal', 'Mother', '07304 601 591');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (394788866, 'Coleen McPhater', 'Father', '07695 675 287');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (609203590, 'Montague Giles', 'Girlfriend', '07602 582 994');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (601691051, 'Amabelle McFaell', 'Mother', '07406 136 450');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (677636850, 'Codee Hurndall', 'Boyfriend', '07296 394 678');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (155837614, 'Lazarus Pomeroy', 'Boyfriend', '07288 097 464');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (456995640, 'Troy Connock', 'Boyfriend', '07603 307 243');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (979018441, 'Rorie Silverton', 'Civil Partner', '07675 154 777');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (21151200, 'Eb Ludlem', 'Boyfriend', '07258 306 130');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (626894804, 'Sumner Armer', 'ivil Partner', '07124 699 528');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (990222188, 'Ashley Jeenes', 'Wife', '07512 219 266');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (295105992, 'Bobby Breslin', 'Boyfriend', '07156 132 741');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (119162644, 'Gerry Bastone', 'Boyfriend', '07831 515 385');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (737147493, 'Alysa Bonavia', 'Husband', '07998 104 368');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (161242322, 'Jon Guisby', 'Boyfriend', '07770 964 956');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (94856118, 'Krisha Mingasson', 'Mother', '07594 793 358');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (244677621, 'Inness Hendrick', 'Father', '07196 056 242');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (60280761, 'Troy Danielis', 'Boyfriend', '07543 372 808');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (973138911, 'Sal Bruckstein', 'Wife', '07113 310 488');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (364580826, 'Trey Shannon', 'Husband', '07275 260 538');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (935928498, 'Wanids Dunckley', 'Boyfriend', '07415 773 406');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (758250680, 'Dagmar Ranahan', 'Mother', '07367 105 969');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (348601206, 'Pandora Furnell', 'Husband', '07519 157 083');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (591166943, 'Rora Windross', 'Boyfriend', '07964 139 091');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (175831110, 'Hurley Nadin', 'Husband', '07141 801 105');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (191277494, 'Sella Ronca', 'Civil Partner', '07235 827 256');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (556072477, 'Paolina Rosenwasser', 'Wife', '7405 739 948');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (420717807, 'Rollo Olczak', 'Mother', '07268 021 034');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (574162757, 'Scarlet Maps', 'Girlfriend', '07959 819 817');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (685871521, 'Ernestine Syne', 'Father', '07699 779 427');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (577596762, 'Emmy Giraldo', 'Boyfriend', '07456 139 081');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (944705277, 'Timothy Reck', 'Civil Partner', '07149 504 735');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (636111701, 'Berty Brimblecomb', 'Girlfriend', '07765 565 720');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (740303597, 'Reed Easterfield', 'Civil Partner', '07523 340 134');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (764036199, 'Joyce Jaynes', 'Civil Partner', '07184 014 200');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (413975053, 'Sibyl Mabson', 'Civil Partner', '07924 859 819');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (171342407, 'Traci Hammersley', 'Wife', '07950 182 116');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (521336694, 'Gloriana McFade', 'Husband', '07061 354 829');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (630638100, 'Kristopher Pawfoot', 'Boyfriend', '07623 018 398');
INSERT INTO Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number) VALUES (263324931, 'Jaime Picford', 'Mother', '07745 996 565');

-- ROLLBACK;
COMMIT;

SELECT @@AUTOCOMMIT;  -- 1 means commit automatically; 0 means commit by hand
SET @@AUTOCOMMIT = 1;

-- function5.php
-- A PROCEDURE called month_show is created with an input parameter 'month' and SELECT statement could list all the employee name and
-- date of birth from the Employee table whose month value of 'date of birth' equals to the input month from the front end.
CREATE PROCEDURE month_show(
IN month TINYINT
)
BEGIN
    SELECT  employee_name, date_of_birth FROM Employee
        WHERE MONTH(date_of_birth) = month;
END;

-- test call PROCEDURE
CALL month_show(12);

-- function6.php
-- This table is created as the automatic auditing table to record every deleting request.
CREATE TABLE IF NOT EXISTS Senior_Delete_Record (
    employee_number INTEGER NOT NULL,
    delete_date DATE NULL DEFAULT NULL,
    delete_time TIME NULL DEFAULT NULL,
    senior_id INTEGER NOT NULL,
    PRIMARY KEY(employee_number)
);

-- Basic trigger is designed on the table "Senior_Delete_Record", different from the delete function in the function3.php.
-- We will record every insert command in the Table and delete corresponding record by the designed trigger.
DELIMITER  //
CREATE TRIGGER trigger_delete_emp_on_senior
AFTER INSERT ON senior_delete_record
FOR EACH ROW
BEGIN
    DELETE FROM employee
           WHERE employee.employee_number = NEW.employee_number;  -- NEW means new information in the Senior_Delete_Record
END //
DELIMITER ;