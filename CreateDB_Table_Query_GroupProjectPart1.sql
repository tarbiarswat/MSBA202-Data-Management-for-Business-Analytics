/* Enable foreign key checks */
create database PMS;
use PMS;
SET FOREIGN_KEY_CHECKS = 0;

/* Manager and Building Tables */
CREATE TABLE MANAGER (
    Manager_ID INT PRIMARY KEY,
    MFull_Name CHAR(25) NOT NULL,
    Salary INT NOT NULL,
    M_Contact VARCHAR(15) NOT NULL,
    MEmail VARCHAR(50) NOT NULL UNIQUE,
    Building_ID INT NOT NULL,
    FOREIGN KEY (Building_ID) REFERENCES BUILDING(Building_ID)
);

CREATE TABLE BUILDING (
    Building_ID INT PRIMARY KEY,
    Street VARCHAR(30),
    City VARCHAR(20),
    State VARCHAR(20),
    ZipCode INT,
    Manager_ID INT NOT NULL UNIQUE,
    FOREIGN KEY (Manager_ID) REFERENCES MANAGER(Manager_ID)
);

/* Manager Phone Table */
CREATE TABLE MANAGER_PHONE (
    Mphone VARCHAR(15) NOT NULL,
    Manager_ID INT NOT NULL,
    FOREIGN KEY (Manager_ID) REFERENCES MANAGER(Manager_ID)
);

/* Apartment Table */
CREATE TABLE APARTMENT (
    Apartment_ID INT,
    Building_ID INT,
    No_of_Bedrooms INT NOT NULL CHECK (No_of_Bedrooms BETWEEN 1 AND 5),
    Rental_status VARCHAR(10) DEFAULT 'Vacant' NOT NULL,
    Client_ID INT,
    PRIMARY KEY (Apartment_ID, Building_ID),
    FOREIGN KEY (Building_ID) REFERENCES BUILDING(Building_ID),
    FOREIGN KEY (Client_ID) REFERENCES CORPCLIENT(Client_ID)
);

/* Corporate Client Tables */
CREATE TABLE CORPCLIENT (
    Client_ID INT PRIMARY KEY,
    Client_Name VARCHAR(30) NOT NULL,
    CEmail VARCHAR(20) NOT NULL UNIQUE,
    Refer_Client_ID INT,
    FOREIGN KEY (Refer_Client_ID) REFERENCES CORPCLIENT(Client_ID)
);

CREATE TABLE CORPCLIENT_PHONE (
    CPhone VARCHAR(15) NOT NULL,
    Client_ID INT NOT NULL,
    FOREIGN KEY (Client_ID) REFERENCES CORPCLIENT(Client_ID)
);

/*  Lease Table */
CREATE TABLE LEASE (
    Lease_ID INT(10) PRIMARY KEY,
    Apartment_ID INT(10) NOT NULL,
    Building_ID INT(10) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    monthly_rent DECIMAL(10,2) NOT NULL,
    security_deposit DECIMAL(10,2) NOT NULL,
    Client_ID INT(10) NOT NULL,
    FOREIGN KEY (Apartment_ID, Building_ID) REFERENCES APARTMENT(Apartment_ID, Building_ID),
    FOREIGN KEY (Client_ID) REFERENCES CORPCLIENT(Client_ID)
);

-- Staff Tables
CREATE TABLE STAFF (
    Staff_ID INT PRIMARY KEY,
    Staff_Name VARCHAR(30) NOT NULL,
    SEmail VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE STAFF_PHONE (
    SPhone VARCHAR(15) NOT NULL,
    Staff_ID INT NOT NULL,
    FOREIGN KEY (Staff_ID) REFERENCES STAFF(Staff_ID)
);

/* Inspector Tables */
CREATE TABLE INSPECTOR (
    Inspector_ID INT PRIMARY KEY,
    InspectorName VARCHAR(30) NOT NULL,
    IEmail VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE INSPECTOR_PHONE (
    IPhone VARCHAR(15) NOT NULL,
    Inspector_ID INT NOT NULL,
    FOREIGN KEY (Inspector_ID) REFERENCES INSPECTOR(Inspector_ID)
);

/* Inspection Table */
CREATE TABLE INSPECTS (
    Inspector_ID INT,
    Building_ID INT,
    Insp_date DATE NOT NULL,
    next_insp DATE NOT NULL,
    PRIMARY KEY (Inspector_ID, Building_ID, Insp_date),
    FOREIGN KEY (Inspector_ID) REFERENCES INSPECTOR(Inspector_ID),
    FOREIGN KEY (Building_ID) REFERENCES BUILDING(Building_ID)
);

/* Cleans Table */
CREATE TABLE CLEANS (
    Staff_ID INT NOT NULL,
    Apartment_ID INT NOT NULL,
    Building_ID INT NOT NULL,
    FOREIGN KEY (Staff_ID) REFERENCES STAFF(Staff_ID),
    FOREIGN KEY (Apartment_ID, Building_ID) REFERENCES APARTMENT(Apartment_ID, Building_ID)
);

/* Maintenance Request Table */
CREATE TABLE MAINTENANCE_REQUEST (
    Request_ID INT PRIMARY KEY,
    Building_ID INT NOT NULL,
    Apartment_ID INT NOT NULL,
    Request_Date DATE NOT NULL,
    Completion_date DATE,
    Status VARCHAR(20) NOT NULL,
    Assigned_Staff INT NOT NULL,
    FOREIGN KEY (Apartment_ID, Building_ID) REFERENCES APARTMENT(Apartment_ID, Building_ID),
    FOREIGN KEY (Assigned_Staff) REFERENCES STAFF(Staff_ID)
);

/* Resident Feedback Table */
CREATE TABLE RESIDENT_FEEDBACK (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    Building_ID INT NOT NULL,
    Apartment_ID INT NOT NULL,
    FeedbackDate DATE NOT NULL,
    Category ENUM('Maintenance', 'Noise', 'Facility') NOT NULL,
    Description TEXT NOT NULL,
    Status VARCHAR(10) NOT NULL CHECK (Status IN ('Open', 'Resolved')),
    FOREIGN KEY (Apartment_ID, Building_ID) REFERENCES APARTMENT(Apartment_ID, Building_ID)
);

/* Utility Billing Table */
CREATE TABLE UTILITY_BILLING (
    UtilityID INT AUTO_INCREMENT PRIMARY KEY,
    Building_ID INT NOT NULL,
    Apartment_ID INT NOT NULL,
    UtilityType ENUM('Electricity', 'Water', 'Gas') NOT NULL,
    MonthlyCost DECIMAL(10,2) NOT NULL CHECK (MonthlyCost > 0),
    DueDate DATE NOT NULL,
    FOREIGN KEY (Apartment_ID, Building_ID) REFERENCES APARTMENT(Apartment_ID, Building_ID)
);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;


































