#clinic_management

CREATE TABLE clinics (
    cid VARCHAR(50),
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE customer (
    uid VARCHAR(50),
    name VARCHAR(100),
    mobile VARCHAR(15)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50),
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50)
);

CREATE TABLE expenses (
    eid VARCHAR(50),
    cid VARCHAR(50),
    description TEXT,
    amount DECIMAL(10,2),
    datetime DATETIME
);

INSERT INTO clinics VALUES
('cnc-0100001','XYZ Clinic','Chennai','TN','India'),
('cnc-0100002','ABC Clinic','Hyderabad','TS','India');

INSERT INTO customer VALUES
('bk-09f3e-95hj','John Doe','97XXXXXXXX'),
('bk-12ab3-77kl','Alice','97XXXXXXXX');

INSERT INTO clinic_sales VALUES
('ord-1','bk-09f3e-95hj','cnc-0100001',25000,'2021-09-23','online'),
('ord-2','bk-12ab3-77kl','cnc-0100001',15000,'2021-09-24','offline'),
('ord-3','bk-09f3e-95hj','cnc-0100002',20000,'2021-09-25','online');

INSERT INTO expenses VALUES
('exp-1','cnc-0100001','Supplies',5000,'2021-09-23'),
('exp-2','cnc-0100002','Maintenance',7000,'2021-09-25');