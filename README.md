# Crownfield Eye Hospital

My database project for CPU4:103 Introduction to Database.

We created a MySQL database for a fictional eye hospital. It has 9 tables covering patients, doctors, clinics, appointments, diagnoses, medicines, prescriptions and follow-ups.

We worked together on the database design and normalisation. My work included planning the structure, SQL queries, the NewAp procedure, triggers and testing.

## Files

- `01_schema.sql` - creates the database and tables
- `02_insert_data.sql` - inserts the test records
- `03_individual_queries.sql` - SQL queries with JOIN, LEFT JOIN, GROUP BY and subquery
- `04_procedure.sql` - NewAp procedure
- `05_triggers.sql` - checks appointments and calculates follow-up dates
- `06_security.sql` - roles, permissions and test accounts
- `07_hashing.sql` - simple hashing example
- `08_tests.sql` - UPDATE, DELETE and ROLLBACK tests
- `ERD.png` - database diagram

## How to run

1. Open MySQL Workbench with MySQL 8.
2. Start with a new database. Run `01_schema.sql` first.
3. Run `02_insert_data.sql` to add the records.
4. PRIMARY KEY 's are auto generated - Check are them in correct order before proceed. RISK OF DATA MIXED 
4. Run the other files in number order.

The security file needs an account that can create users and grant permissions. Procedures and triggers use DELIMITER so the full scripts can be run in Workbench.
SECURITY FILES creating users using password = '1234' - change before proceed

## Notes

- All the patient details are fictional.
- Some records are missing related appointments, diagnoses or follow-ups. This is imitating real-life example, and is useful for LEFT JOIN tests. 
- The database uses primary keys, foreign keys, UNIQUE and CHECK constraints.
			TABLES ARE USING AUTO- INCREMENT PRIMARY KEY's REFERENCING TO FOREIGN TABLES - make sure that data is generated in correct order
- There are four roles: admin, doctor, receptionist and nurse.
- The hashing example uses a temporary table. It does not replace the actual postcode data.
- The transaction test uses ROLLBACK so changes are not saved.
- Role names are shared across a MySQL server. If the roles already exist, they may have older permissions from another database.
