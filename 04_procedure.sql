USE crownfield;


CREATE procedure NewAp (
    IN n_dr_id INT,
    IN n_pat_id INT,
    IN n_clinic_id INT,
    IN n_ap_date DATE,
    IN n_ap_time TIME
)
BEGIN
    INSERT INTO ap_tbl
    (dr_id, pat_id, clinic_id, ap_date, ap_time)
    VALUES
    (n_dr_id, n_pat_id, n_clinic_id, n_ap_date, n_ap_time);
END;


CREATE PROCEDURE NewPatient(
IN p_first_name VARCHAR(20),
IN p_last_name VARCHAR(20),
IN p_post_code VARCHAR(8)
)
BEGIN
INSERT INTO pat_tbl
(first_name, last_name, post_code)
VALUES
(p_first_name, p_last_name, p_post_code);
END;


CREATE PROCEDURE GetDoctorDiagnoses(
IN p_dr_id INT
)
BEGIN
SELECT *
FROM ap_tbl
LEFT JOIN diag_tbl
ON ap_tbl.ap_id = diag_tbl.ap_id
WHERE ap_tbl.dr_id = p_dr_id
ORDER BY ap_tbl.ap_date ASC;
END;

CREATE PROCEDURE ap_upd(
IN p_ap_id INT,
IN p_dr_id INT,
IN p_pat_id INT,
IN p_clinic_id INT,
IN p_ap_date DATE,
IN p_ap_time TIME
)
BEGIN
UPDATE ap_tbl
SET dr_id = p_dr_id,
pat_id = p_pat_id,
clinic_id = p_clinic_id,
ap_date = p_ap_date,
ap_time = p_ap_time
WHERE ap_id = p_ap_id;
END;

