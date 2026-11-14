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


