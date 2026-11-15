
CREATE PROCEDURE NewPatient(
IN p_pat_id VARCHAR(10),
IN p_first_name VARCHAR(20),
IN p_last_name VARCHAR(20),
IN p_post_code VARCHAR(8)
)
INSERT INTO pat_tbl (pat_id, first_name, last_name, post_code)
VALUES (p_pat_id, p_first_name, p_last_name, p_post_code);

CALL NewPatient('OP005', 'Adam', 'Pascal', 'NN11 2CC');	
SELECT * FROM pat_tbl;



CREATE PROCEDURE NewDoctor(
    IN p_dr_id VARCHAR(5),
    IN p_dr_name VARCHAR(20),
    IN p_specialty VARCHAR(25)
)
INSERT INTO dr_tbl (dr_id, dr_name, specialty)
VALUES (p_dr_id, p_dr_name, p_specialty);
CALL NewDoctor('dr7', 'Dr Olivia Morgan', 'Retina');
SELECT * FROM dr_tbl;



CREATE PROCEDURE NewDiagnosis(
    IN p_ap_id INT,
    IN p_diag VARCHAR(50),
    IN p_notes VARCHAR(100)
)
INSERT INTO diag_tbl (ap_id, diag, notes)
VALUES (p_ap_id, p_diag, p_notes);


CREATE PROCEDURE NewPrescription(
    IN p_pre_id VARCHAR(10),
    IN p_ap_id INT,
    IN p_pre_date DATE
)
INSERT INTO pre_tbl (pre_id, ap_id, pre_date)
VALUES (p_pre_id, p_ap_id, p_pre_date);
CALL NewPrescription('pre6', 7, '2026-11-26');
SELECT * FROM pre_tbl;


CREATE PROCEDURE NewPrescriptionDetail(
    IN p_pre_id VARCHAR(10),
    IN p_med_id VARCHAR(10),
    IN p_route VARCHAR(25),
    IN p_dose VARCHAR(25),
    IN p_freq VARCHAR(25),
    IN p_duration VARCHAR(25)
)
INSERT INTO pre_detail
(pre_id, med_id, route, dose, freq, duration)
VALUES
(p_pre_id, p_med_id, p_route, p_dose, p_freq, p_duration);
CALL NewPrescriptionDetail('pre5', 'med1', 'eye drops', '1 drop', 'once daily', '30 days');
SELECT * FROM pre_detail;


CREATE PROCEDURE NewFollowUp(
    IN p_ap_id INT,
    IN p_sta VARCHAR(20),
    IN p_priority VARCHAR(1),
    IN p_weeks INT,
    IN p_review_date DATE
)
INSERT INTO follow_up
(ap_id, sta, priority, `next_ap(weeks)`, review_date)
VALUES
(p_ap_id, p_sta, p_priority, p_weeks, p_review_date);
CALL NewFollowUp(7, 'in progress', 'R', 4, '2026-12-24');
SELECT * FROM follow_up;


CREATE PROCEDURE `NewAp`(
    IN p_dr_id VARCHAR(5),
    IN p_pat_id VARCHAR(10),
    IN p_clinic_id VARCHAR(5),
    IN p_ap_date DATE,
    IN p_ap_time TIME
)
INSERT INTO `ap_tbl` (`dr_id`, `pat_id`, `clinic_id`, `ap_date`, `ap_time`)
    VALUES (p_dr_id, p_pat_id, p_clinic_id, p_ap_date, p_ap_time);
	
CREATE PROCEDURE ApUpd
(
IN p_ap_id INT,
IN p_dr_id VARCHAR(5),
IN p_pat_id VARCHAR(10),
IN p_clinic_id VARCHAR(5),
IN p_ap_date DATE,
IN p_ap_time TIME
)
UPDATE ap_tbl
SET dr_id = p_dr_id, 
	pat_id = p_pat_id, 
    clinic_id = p_clinic_id, 
    ap_date = p_ap_date, 
    ap_time = p_ap_time
WHERE ap_id = p_ap_id ;