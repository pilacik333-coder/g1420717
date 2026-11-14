USE crownfield;

# UPDATE and DELETE test
# All changes undone with ROLLBACK

START TRANSACTION;

SELECT pat_id, first_name, last_name, post_code
FROM pat_tbl
WHERE pat_id = 5;

UPDATE pat_tbl
SET post_code = 'NN11 5AB'
WHERE pat_id = 5;

SELECT pat_id, post_code
FROM pat_tbl
WHERE pat_id = 5;

# New test appointment, so no related records to delete
INSERT INTO ap_tbl (dr_id, pat_id, clinic_id, ap_date, ap_time)
VALUES (1, 5, 1, '2028-01-12', '15:45:00');

SET @test_ap_id = LAST_INSERT_ID();

SELECT * FROM ap_tbl
WHERE ap_id = @test_ap_id;

DELETE FROM ap_tbl
WHERE ap_id = @test_ap_id;

SELECT * FROM ap_tbl
WHERE ap_id = @test_ap_id;

ROLLBACK;

# Check original data
SELECT pat_id, first_name, last_name, post_code
FROM pat_tbl
WHERE pat_id = 5;

# Other tests - run separately if needed

# Doctor cannot have 2 appointments at the same date and time
# INSERT INTO ap_tbl (dr_id, pat_id, clinic_id, ap_date, ap_time)
# VALUES (1, 5, 1, '2026-10-05', '09:00:00');

# Negative weeks should fail the CHECK
# INSERT INTO follow_up (ap_id, sta, priority, `next_ap(weeks)`)
# VALUES (22, 'in progress', 'R', -1);
