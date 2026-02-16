# Pharmacy & Healthcare Management Database System (Oracle SQL)

## Overview

This project implements a **Healthcare and Pharmacy Management Database System** using **Oracle SQL**.  

The database models real-world relationships between:

- Doctors  
- Patients  
- Pharmaceutical Companies  
- Drugs  
- Pharmacies  
- Prescriptions  
- Contracts  

The schema is fully normalized and includes:

- Primary Keys  
- Foreign Keys  
- Composite Keys  
- Constraints  
- Cascading Deletes  
- Stored Procedures  

This project demonstrates strong understanding of **Relational Database Design, ER Modeling, Normalization, and PL/SQL Programming**.

---

## Database Design

The system captures the following relationships:

- A **Doctor** treats multiple Patients  
- A **Patient** has one Primary Doctor  
- A **Pharmaceutical Company** manufactures multiple Drugs  
- A **Pharmacy** sells Drugs  
- A **Doctor** writes Prescriptions for Patients  
- A Prescription contains multiple Drugs  
- Pharmacies enter Contracts with Pharmaceutical Companies  

---

## Tables Implemented

### 1. Doctor

Stores doctor information.

Attributes:
- `AadharID` (Primary Key)
- Name
- Specialty
- Experience

---

### 2. Patient

Stores patient details.

Attributes:
- `AadharID` (Primary Key)
- Name
- Address
- Age
- PrimaryDoctorID (Foreign Key → Doctor)

---

### 3. PharmaceuticalCompany

Stores company details.

Attributes:
- Name (Primary Key)
- Phone

---

### 4. Drug

Represents medicines manufactured by companies.

Composite Primary Key:
- TradeName
- CompanyName

Foreign Key:
- CompanyName → PharmaceuticalCompany

`ON DELETE CASCADE` ensures drugs are deleted if the company is removed.

---

### 5. Pharmacy

Stores pharmacy details.

Attributes:
- PharmacyID (Primary Key)
- Name
- Address
- Phone

---

### 6. Sells

Represents which pharmacy sells which drug.

Composite Primary Key:
- PharmacyID
- TradeName
- CompanyName

Foreign Keys:
- PharmacyID → Pharmacy
- (TradeName, CompanyName) → Drug

Includes:
- Price

---

### 7. Prescription

Stores prescriptions written by doctors.

Attributes:
- PrescriptionID (Primary Key)
- DoctorID (Foreign Key → Doctor)
- PatientID (Foreign Key → Patient)
- Date

Constraint:
- UNIQUE (DoctorID, PatientID, Date)

---

### 8. PrescriptionDetail

Stores drugs included in each prescription.

Composite Primary Key:
- PrescriptionID
- TradeName
- CompanyName

Foreign Keys:
- PrescriptionID → Prescription
- (TradeName, CompanyName) → Drug

Includes:
- Quantity

---

### 9. Contract

Stores contracts between pharmacies and pharmaceutical companies.

Attributes:
- ContractID (Primary Key)
- PharmacyID (Foreign Key → Pharmacy)
- CompanyName (Foreign Key → PharmaceuticalCompany)
- StartDate
- EndDate
- Content
- SupervisorName

---

## Sample Data Inserted

The project includes sample data for:

- 2 Doctors  
- 2 Patients  
- 2 Pharmaceutical Companies  
- 2 Drugs  
- 2 Pharmacies  
- Sales data  
- Prescriptions and Prescription Details  
- Contracts  

This allows immediate testing of queries and procedures.

---

## Stored Procedure Implemented

### GetDrugsByCompany

Retrieves all drugs manufactured by a specific company.

```sql
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
```

### How to Execute Procedure

```sql
SET SERVEROUTPUT ON;
EXEC GetDrugsByCompany('Cipla');
```

---

## Key SQL Concepts Used

- Primary Keys  
- Composite Keys  
- Foreign Keys  
- ON DELETE CASCADE  
- UNIQUE Constraints  
- Relational Integrity  
- PL/SQL Stored Procedures  
- Date Handling using `TO_DATE()`  
- DBMS_OUTPUT for procedure output  

---

## Execution Instructions

### Prerequisites

- Oracle SQL / SQL Developer  
- PL/SQL enabled environment  

---

### Step 1: Create Tables

Run all `CREATE TABLE` statements.

---

### Step 2: Insert Data

Execute all `INSERT INTO` statements.

---

### Step 3: Create Stored Procedure

Run the `CREATE OR REPLACE PROCEDURE` block.

---

### Step 4: Enable Output

```sql
SET SERVEROUTPUT ON;
```

---

### Step 5: Test Procedure

```sql
EXEC GetDrugsByCompany('SunPharma');
```

---

## Project Structure

```
/Healthcare-Pharmacy-DB
├── create_tables.sql
├── insert_data.sql
├── procedures.sql
└── README.md
```

---


## Conclusion

This project demonstrates strong understanding of **database modeling, normalization, relational integrity, and PL/SQL programming** through implementation of a real-world healthcare and pharmacy management system.
