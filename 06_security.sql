
USE crownfield;

-- CREATE ROLES

CREATE ROLE IF NOT EXISTS 'admin';
CREATE ROLE IF NOT EXISTS 'doctor';
CREATE ROLE IF NOT EXISTS 'receptionist';
CREATE ROLE IF NOT EXISTS 'nurse';


-- ADMIN

GRANT SELECT, INSERT, UPDATE, DELETE,
      EXECUTE, CREATE ROUTINE, ALTER ROUTINE
ON crownfield.*
TO 'admin';


-- DOCTOR

GRANT SELECT
ON crownfield.pat_tbl TO 'doctor';

GRANT SELECT, UPDATE
ON crownfield.ap_tbl TO 'doctor';

GRANT SELECT
ON crownfield.dr_tbl TO 'doctor';

GRANT SELECT
ON crownfield.clinic_tbl TO 'doctor';

GRANT SELECT, INSERT, UPDATE
ON crownfield.follow_up TO 'doctor';

GRANT SELECT, INSERT, UPDATE
ON crownfield.diag_tbl TO 'doctor';

GRANT SELECT, INSERT, UPDATE
ON crownfield.pre_tbl TO 'doctor';

GRANT SELECT, INSERT, UPDATE
ON crownfield.pre_detail TO 'doctor';

GRANT SELECT
ON crownfield.med_tbl TO 'doctor';


-- RECEPTIONIST

GRANT SELECT, INSERT, UPDATE
ON crownfield.pat_tbl TO 'receptionist';

GRANT SELECT, INSERT, UPDATE
ON crownfield.ap_tbl TO 'receptionist';

GRANT SELECT
ON crownfield.dr_tbl TO 'receptionist';

GRANT SELECT
ON crownfield.clinic_tbl TO 'receptionist';

GRANT SELECT
ON crownfield.follow_up TO 'receptionist';

GRANT SELECT
ON crownfield.pre_tbl TO 'receptionist';

GRANT SELECT
ON crownfield.pre_detail TO 'receptionist';

GRANT SELECT
ON crownfield.med_tbl TO 'receptionist';


# NURSE

GRANT SELECT
ON crownfield.pat_tbl TO 'nurse';

GRANT SELECT
ON crownfield.ap_tbl TO 'nurse';

GRANT SELECT
ON crownfield.dr_tbl TO 'nurse';

GRANT SELECT
ON crownfield.clinic_tbl TO 'nurse';

GRANT SELECT, INSERT, UPDATE
ON crownfield.follow_up TO 'nurse';

GRANT SELECT
ON crownfield.diag_tbl TO 'nurse';

GRANT SELECT
ON crownfield.pre_tbl TO 'nurse';

GRANT SELECT
ON crownfield.pre_detail TO 'nurse';

GRANT SELECT
ON crownfield.med_tbl TO 'nurse';



-- GRANT EXECUTE ON PROCEDURE crownfield.xxx TO 'doctor';
GRANT EXECUTE ON PROCEDURE crownfield.NewAp TO 'receptionist';
-- GRANT EXECUTE ON PROCEDURE crownfield.xxx TO 'nurse';



CREATE USER IF NOT EXISTS 'test_admin'@'%'
IDENTIFIED BY '1234';

CREATE USER IF NOT EXISTS 'test_doctor'@'%'
IDENTIFIED BY '1234';

CREATE USER IF NOT EXISTS 'test_recept'@'%'
IDENTIFIED BY '1234';

CREATE USER IF NOT EXISTS 'test_nurse'@'%'
IDENTIFIED BY '1234';


-- ASSIGN ROLES TO USERS

GRANT 'admin' TO 'test_admin'@'%';

GRANT 'doctor' TO 'test_doctor'@'%';

GRANT 'receptionist' TO 'test_recept'@'%';

GRANT 'nurse' TO 'test_nurse'@'%';


-- ACTIVATE ROLES BY DEFAULT

SET DEFAULT ROLE 'admin' TO 'test_admin'@'%';

SET DEFAULT ROLE 'doctor' TO 'test_doctor'@'%';

SET DEFAULT ROLE 'receptionist' TO 'test_recept'@'%';

SET DEFAULT ROLE 'nurse' TO 'test_nurse'@'%';
