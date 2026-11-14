USE crownfield;

# First and Last Patient name
# ap date
# dr name
#clinic name
#sort by review date


Select pat_tbl.first_name, pat_tbl.last_name, ap_tbl.ap_date, dr_tbl.dr_name, clinic_tbl.clinic_name,
       review_date
FROM ap_tbl
JOIN pat_tbl
ON ap_tbl.pat_id= pat_tbl.pat_id
JOIN dr_tbl
on ap_tbl.dr_id = dr_tbl.dr_id
JOIN clinic_tbl
ON ap_tbl.clinic_id = clinic_tbl.clinic_id
LEFT JOIN follow_up
ON ap_tbl.ap_id = follow_up.ap_id
ORDER BY review_date ASC;


# FirstAndLast Patient name
# ap date
# dr name
#clinic name
#sort by review date
#patient diagnose

Select pat_tbl.first_name, pat_tbl.last_name, ap_tbl.ap_date, dr_tbl.dr_name, clinic_tbl.clinic_name,
       review_date, diag_tbl.diag
FROM ap_tbl
JOIN pat_tbl
ON ap_tbl.pat_id= pat_tbl.pat_id
JOIN dr_tbl
on ap_tbl.dr_id = dr_tbl.dr_id
JOIN clinic_tbl
ON ap_tbl.clinic_id = clinic_tbl.clinic_id
LEFT JOIN follow_up
ON ap_tbl.ap_id = follow_up.ap_id
LEFT JOIN diag_tbl
ON ap_tbl.ap_id = diag_tbl.ap_id
ORDER BY review_date ASC;

# Doctors with 2 or more appointments
SELECT dr_tbl.dr_name, COUNT(*) AS app
FROM ap_tbl
JOIN dr_tbl
ON ap_tbl.dr_id = dr_tbl.dr_id
GROUP BY dr_tbl.dr_id, dr_tbl.dr_name
HAVING COUNT(*) >= 2
ORDER BY app DESC;


# Patients have more than one appointment
SELECT pat_tbl.first_name, pat_tbl.last_name
FROM pat_tbl
WHERE pat_tbl.pat_id IN (
    SELECT pat_id
    FROM ap_tbl
    GROUP BY pat_id
    HAVING COUNT(*) > 1
)
ORDER BY pat_tbl.last_name ASC;
