-- Crownfield Hospital: read-only SELECT examples and data checks.
-- Select the intended database in Workbench before running these queries.
-- Nothing in this file changes data.

-- 01. Confirm the selected database.
SELECT DATABASE() AS selected_database;

-- 02. All prescriptions.
SELECT * FROM pre_tbl ORDER BY pre_id;

-- 03. All prescription items.
SELECT * FROM pre_detail ORDER BY pre_id, det_id;

-- 04. All medicines.
SELECT * FROM med_tbl ORDER BY med_name;

-- 05. Prescription, medicine, and dosage in one result.
SELECT p.pre_id, p.pre_date, d.det_id, m.med_id, m.med_name,
       d.route, d.dose, d.freq, d.duration
FROM pre_tbl AS p
JOIN pre_detail AS d ON d.pre_id = p.pre_id
JOIN med_tbl AS m ON m.med_id = d.med_id
ORDER BY p.pre_id, d.det_id;

-- 06. Prescription details with appointment, patient, and doctor.
SELECT p.pre_id, p.pre_date, a.ap_id, a.ap_date, a.ap_time,
       pat.pat_id, pat.first_name, pat.last_name, dr.dr_name,
       m.med_name, d.route, d.dose, d.freq, d.duration
FROM pre_tbl AS p
JOIN ap_tbl AS a ON a.ap_id = p.ap_id
JOIN pat_tbl AS pat ON pat.pat_id = a.pat_id
JOIN dr_tbl AS dr ON dr.dr_id = a.dr_id
LEFT JOIN pre_detail AS d ON d.pre_id = p.pre_id
LEFT JOIN med_tbl AS m ON m.med_id = d.med_id
ORDER BY a.ap_date, a.ap_time, p.pre_id, d.det_id;

-- 07. One prescription by ID: change 'pre1' as needed.
SELECT p.pre_id, p.ap_id, p.pre_date, m.med_name,
       d.route, d.dose, d.freq, d.duration
FROM pre_tbl AS p
LEFT JOIN pre_detail AS d ON d.pre_id = p.pre_id
LEFT JOIN med_tbl AS m ON m.med_id = d.med_id
WHERE p.pre_id = 'pre1'
ORDER BY d.det_id;

-- 08. All prescriptions for one patient: change 'OP001'.
SELECT pat.pat_id, pat.first_name, pat.last_name,
       a.ap_id, a.ap_date, p.pre_id, m.med_name, d.dose, d.freq
FROM pat_tbl AS pat
JOIN ap_tbl AS a ON a.pat_id = pat.pat_id
LEFT JOIN pre_tbl AS p ON p.ap_id = a.ap_id
LEFT JOIN pre_detail AS d ON d.pre_id = p.pre_id
LEFT JOIN med_tbl AS m ON m.med_id = d.med_id
WHERE pat.pat_id = 'OP001'
ORDER BY a.ap_date, p.pre_id, d.det_id;

-- 09. All prescription items for one medicine: change 'med1'.
SELECT m.med_id, m.med_name, p.pre_id, p.pre_date, a.ap_id,
       pat.first_name, pat.last_name, d.dose, d.route, d.freq
FROM med_tbl AS m
JOIN pre_detail AS d ON d.med_id = m.med_id
JOIN pre_tbl AS p ON p.pre_id = d.pre_id
JOIN ap_tbl AS a ON a.ap_id = p.ap_id
JOIN pat_tbl AS pat ON pat.pat_id = a.pat_id
WHERE m.med_id = 'med1'
ORDER BY p.pre_date, p.pre_id;

-- 10. Number of medicine items in each prescription; zero exposes empty prescriptions.
SELECT p.pre_id, p.ap_id, p.pre_date, COUNT(d.det_id) AS item_count
FROM pre_tbl AS p
LEFT JOIN pre_detail AS d ON d.pre_id = p.pre_id
GROUP BY p.pre_id, p.ap_id, p.pre_date
ORDER BY item_count, p.pre_id;

-- 11. Prescriptions with no medicine item. Review these: a prescription should contain medicine.
SELECT p.pre_id, p.ap_id, p.pre_date
FROM pre_tbl AS p
LEFT JOIN pre_detail AS d ON d.pre_id = p.pre_id
WHERE d.det_id IS NULL
ORDER BY p.pre_id;

-- 12. Prescriptions linked to a missing appointment. Expected: zero rows.
SELECT p.pre_id, p.ap_id
FROM pre_tbl AS p
LEFT JOIN ap_tbl AS a ON a.ap_id = p.ap_id
WHERE a.ap_id IS NULL;

-- 13. Prescription items linked to a missing prescription. Expected: zero rows.
SELECT d.det_id, d.pre_id, d.med_id
FROM pre_detail AS d
LEFT JOIN pre_tbl AS p ON p.pre_id = d.pre_id
WHERE p.pre_id IS NULL;

-- 14. Prescription items linked to a missing medicine. Expected: zero rows.
SELECT d.det_id, d.pre_id, d.med_id
FROM pre_detail AS d
LEFT JOIN med_tbl AS m ON m.med_id = d.med_id
WHERE m.med_id IS NULL;

-- 15. The same medicine entered more than once on one prescription. Review each result.
SELECT pre_id, med_id, COUNT(*) AS times_listed
FROM pre_detail
GROUP BY pre_id, med_id
HAVING COUNT(*) > 1
ORDER BY pre_id, med_id;

-- 16. Missing or blank dosage instructions. Expected: zero rows.
SELECT det_id, pre_id, med_id, route, dose, freq
FROM pre_detail
WHERE TRIM(route) = '' OR TRIM(dose) = '' OR TRIM(freq) = '';

-- 17. Missing or blank optional duration. Review according to your business rule.
SELECT det_id, pre_id, med_id, duration
FROM pre_detail
WHERE duration IS NULL OR TRIM(duration) = '';

-- 18. Prescription date missing. Review whether NULL is intentional.
SELECT pre_id, ap_id, pre_date
FROM pre_tbl
WHERE pre_date IS NULL;

-- 19. Prescription date before appointment date. Review each result.
SELECT p.pre_id, p.pre_date, a.ap_id, a.ap_date
FROM pre_tbl AS p
JOIN ap_tbl AS a ON a.ap_id = p.ap_id
WHERE p.pre_date < a.ap_date
ORDER BY p.pre_id;

-- 20. Appointments with no prescription. Optional relationship; may be correct.
SELECT a.ap_id, a.pat_id, a.ap_date, a.ap_time
FROM ap_tbl AS a
LEFT JOIN pre_tbl AS p ON p.ap_id = a.ap_id
WHERE p.pre_id IS NULL
ORDER BY a.ap_date, a.ap_time;

-- 21. Number of prescriptions per appointment.
SELECT a.ap_id, a.ap_date, COUNT(p.pre_id) AS prescription_count
FROM ap_tbl AS a
LEFT JOIN pre_tbl AS p ON p.ap_id = a.ap_id
GROUP BY a.ap_id, a.ap_date
ORDER BY prescription_count DESC, a.ap_id;

-- 22. Medicines never prescribed. May be correct.
SELECT m.med_id, m.med_name
FROM med_tbl AS m
LEFT JOIN pre_detail AS d ON d.med_id = m.med_id
WHERE d.det_id IS NULL
ORDER BY m.med_name;

-- 23. Usage count for each medicine.
SELECT m.med_id, m.med_name, COUNT(d.det_id) AS times_prescribed
FROM med_tbl AS m
LEFT JOIN pre_detail AS d ON d.med_id = m.med_id
GROUP BY m.med_id, m.med_name
ORDER BY times_prescribed DESC, m.med_name;

-- 24. Overview of appointments, patient, doctor, and clinic.
SELECT a.ap_id, a.ap_date, a.ap_time, pat.pat_id,
       pat.first_name, pat.last_name, dr.dr_name, c.clinic_name
FROM ap_tbl AS a
JOIN pat_tbl AS pat ON pat.pat_id = a.pat_id
JOIN dr_tbl AS dr ON dr.dr_id = a.dr_id
JOIN clinic_tbl AS c ON c.clinic_id = a.clinic_id
ORDER BY a.ap_date, a.ap_time, a.ap_id;

-- 25. Two appointments for the same doctor at exactly the same time. Expected: zero rows.
SELECT dr_id, ap_date, ap_time, COUNT(*) AS appointment_count,
       GROUP_CONCAT(ap_id ORDER BY ap_id) AS appointment_ids
FROM ap_tbl
GROUP BY dr_id, ap_date, ap_time
HAVING COUNT(*) > 1;

-- 26. Two appointments for the same patient at exactly the same time. Review each result.
SELECT pat_id, ap_date, ap_time, COUNT(*) AS appointment_count,
       GROUP_CONCAT(ap_id ORDER BY ap_id) AS appointment_ids
FROM ap_tbl
GROUP BY pat_id, ap_date, ap_time
HAVING COUNT(*) > 1;

-- 27. Appointments referencing a missing patient, doctor, or clinic. Expected: zero rows.
SELECT a.ap_id, a.pat_id, a.dr_id, a.clinic_id
FROM ap_tbl AS a
LEFT JOIN pat_tbl AS pat ON pat.pat_id = a.pat_id
LEFT JOIN dr_tbl AS dr ON dr.dr_id = a.dr_id
LEFT JOIN clinic_tbl AS c ON c.clinic_id = a.clinic_id
WHERE pat.pat_id IS NULL OR dr.dr_id IS NULL OR c.clinic_id IS NULL;

-- 28. Follow-up date versus appointment date plus weeks. Expected: zero rows if all are calculated.
SELECT f.follow_id, f.ap_id, a.ap_date, f.`next_ap(weeks)` AS weeks_until_review,
       f.review_date,
       DATE_ADD(a.ap_date, INTERVAL f.`next_ap(weeks)` WEEK) AS expected_review_date
FROM follow_up AS f
JOIN ap_tbl AS a ON a.ap_id = f.ap_id
WHERE NOT (f.review_date <=> DATE_ADD(a.ap_date, INTERVAL f.`next_ap(weeks)` WEEK))
ORDER BY f.follow_id;

-- 29. Follow-up weeks missing or not positive. Review each result.
SELECT follow_id, ap_id, `next_ap(weeks)`, review_date
FROM follow_up
WHERE `next_ap(weeks)` IS NULL OR `next_ap(weeks)` <= 0;

-- 30. Appointments without a follow-up. Optional relationship; may be correct.
SELECT a.ap_id, a.pat_id, a.ap_date
FROM ap_tbl AS a
LEFT JOIN follow_up AS f ON f.ap_id = a.ap_id
WHERE f.follow_id IS NULL
ORDER BY a.ap_date, a.ap_id;

-- 31. Appointments without a diagnosis. Optional relationship; may be correct.
SELECT a.ap_id, a.pat_id, a.ap_date
FROM ap_tbl AS a
LEFT JOIN diag_tbl AS d ON d.ap_id = a.ap_id
WHERE d.diag_id IS NULL
ORDER BY a.ap_date, a.ap_id;

-- 32. Diagnoses with no description. Review each result.
SELECT diag_id, ap_id, diag, notes
FROM diag_tbl
WHERE diag IS NULL OR TRIM(diag) = '';

-- 33. Patients with no appointment. May be correct.
SELECT pat.pat_id, pat.first_name, pat.last_name
FROM pat_tbl AS pat
LEFT JOIN ap_tbl AS a ON a.pat_id = pat.pat_id
WHERE a.ap_id IS NULL
ORDER BY pat.pat_id;

-- 34. Patient names or postcodes needing review. NULL postcode is allowed by the schema.
SELECT pat_id, first_name, last_name, post_code
FROM pat_tbl
WHERE TRIM(first_name) = '' OR TRIM(last_name) = ''
   OR post_code IS NULL OR TRIM(post_code) = ''
ORDER BY pat_id;

-- 35. Row counts across all nine tables.
SELECT 'pat_tbl' AS table_name, COUNT(*) AS row_count FROM pat_tbl
UNION ALL SELECT 'dr_tbl', COUNT(*) FROM dr_tbl
UNION ALL SELECT 'clinic_tbl', COUNT(*) FROM clinic_tbl
UNION ALL SELECT 'med_tbl', COUNT(*) FROM med_tbl
UNION ALL SELECT 'ap_tbl', COUNT(*) FROM ap_tbl
UNION ALL SELECT 'diag_tbl', COUNT(*) FROM diag_tbl
UNION ALL SELECT 'pre_tbl', COUNT(*) FROM pre_tbl
UNION ALL SELECT 'pre_detail', COUNT(*) FROM pre_detail
UNION ALL SELECT 'follow_up', COUNT(*) FROM follow_up;
