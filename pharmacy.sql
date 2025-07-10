CREATE TABLE Doctor (
    AadharID VARCHAR2(12) PRIMARY KEY,
    Name VARCHAR2(50),
    Specialty VARCHAR2(50),
    Experience NUMBER(2)
);

CREATE TABLE Patient (
    AadharID VARCHAR2(12) PRIMARY KEY,
    Name VARCHAR2(50),
    Address VARCHAR2(100),
    Age NUMBER(3),
    PrimaryDoctorID VARCHAR2(12),
    CONSTRAINT fk_primarydoc FOREIGN KEY (PrimaryDoctorID) REFERENCES Doctor(AadharID)
);

CREATE TABLE PharmaceuticalCompany (
    Name VARCHAR2(50) PRIMARY KEY,
    Phone VARCHAR2(15)
);

CREATE TABLE Drug (
    TradeName VARCHAR2(50),
    Formula VARCHAR2(100),
    CompanyName VARCHAR2(50),
    PRIMARY KEY (TradeName, CompanyName),
    FOREIGN KEY (CompanyName) REFERENCES PharmaceuticalCompany(Name) ON DELETE CASCADE
);

CREATE TABLE Pharmacy (
    PharmacyID NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    Address VARCHAR2(100),
    Phone VARCHAR2(15)
);

CREATE TABLE Sells (
    PharmacyID NUMBER,
    TradeName VARCHAR2(50),
    CompanyName VARCHAR2(50),
    Price NUMBER(8,2),
    PRIMARY KEY (PharmacyID, TradeName, CompanyName),
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID),
    FOREIGN KEY (TradeName, CompanyName) REFERENCES Drug(TradeName, CompanyName)
);

CREATE TABLE Prescription (
    PrescriptionID NUMBER PRIMARY KEY,
    DoctorID VARCHAR2(12),
    PatientID VARCHAR2(12),
    Date DATE,
    UNIQUE (DoctorID, PatientID, Date),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(AadharID),
    FOREIGN KEY (PatientID) REFERENCES Patient(AadharID)
);

CREATE TABLE PrescriptionDetail (
    PrescriptionID NUMBER,
    TradeName VARCHAR2(50),
    CompanyName VARCHAR2(50),
    Quantity NUMBER,
    PRIMARY KEY (PrescriptionID, TradeName, CompanyName),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID),
    FOREIGN KEY (TradeName, CompanyName) REFERENCES Drug(TradeName, CompanyName)
);

CREATE TABLE Contract (
    ContractID NUMBER PRIMARY KEY,
    PharmacyID NUMBER,
    CompanyName VARCHAR2(50),
    StartDate DATE,
    EndDate DATE,
    Content VARCHAR2(200),
    SupervisorName VARCHAR2(50),
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID),
    FOREIGN KEY (CompanyName) REFERENCES PharmaceuticalCompany(Name)
);


INSERT INTO Doctor VALUES ('D123', 'Dr. Sharma', 'Cardiologist', 12);
INSERT INTO Doctor VALUES ('D124', 'Dr. Meena', 'General Physician', 5);

INSERT INTO Patient VALUES ('P101', 'Rahul Mehra', 'Delhi', 30, 'D123');
INSERT INTO Patient VALUES ('P102', 'Anjali Singh', 'Mumbai', 26, 'D124');

INSERT INTO PharmaceuticalCompany VALUES ('Cipla', '1800-123-456');
INSERT INTO PharmaceuticalCompany VALUES ('SunPharma', '1800-222-789');

INSERT INTO Drug VALUES ('Paracetamol', 'C8H9NO2', 'Cipla');
INSERT INTO Drug VALUES ('Aspirin', 'C9H8O4', 'SunPharma');

INSERT INTO Pharmacy VALUES (1, 'Nova Medico A', 'Delhi', '011-22334455');
INSERT INTO Pharmacy VALUES (2, 'Nova Medico B', 'Mumbai', '022-55667788');

INSERT INTO Sells VALUES (1, 'Paracetamol', 'Cipla', 20.00);
INSERT INTO Sells VALUES (1, 'Aspirin', 'SunPharma', 15.00);
INSERT INTO Sells VALUES (2, 'Paracetamol', 'Cipla', 18.00);

INSERT INTO Prescription VALUES (1001, 'D123', 'P101', TO_DATE('2024-03-20', 'YYYY-MM-DD'));
INSERT INTO Prescription VALUES (1002, 'D124', 'P102', TO_DATE('2024-03-21', 'YYYY-MM-DD'));

INSERT INTO PrescriptionDetail VALUES (1001, 'Paracetamol', 'Cipla', 2);
INSERT INTO PrescriptionDetail VALUES (1001, 'Aspirin', 'SunPharma', 1);
INSERT INTO PrescriptionDetail VALUES (1002, 'Paracetamol', 'Cipla', 3);

INSERT INTO Contract VALUES (5001, 1, 'Cipla', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'Monthly delivery', 'Mr. Roy');
INSERT INTO Contract VALUES (5002, 2, 'SunPharma', TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'Quarterly supply', 'Mrs. Kapoor');

--EXAMPLE

CREATE OR REPLACE PROCEDURE GetDrugsByCompany (
    p_CompanyName IN VARCHAR2
) AS
BEGIN
    FOR rec IN (
        SELECT TradeName, Formula FROM Drug
        WHERE CompanyName = p_CompanyName
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Drug: ' || rec.TradeName || ', Formula: ' || rec.Formula);
    END LOOP;
END;
