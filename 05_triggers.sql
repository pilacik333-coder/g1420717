
USE crownfield;

DELIMITER $$

-- CHECK doctor availability-INSERT IF dr1 exist at ap_tbl WHERE ap_time and ap_date
CREATE TRIGGER CheckDoctorAvailability
    BEFORE INSERT ON ap_tbl
    FOR EACH ROW
BEGIN
IF EXISTS (
	SELECT *
    FROM ap_tbl
    WHERE dr_id = NEW.dr_id
		AND ap_date = NEW.ap_date
        AND ap_time = NEW.ap_time
        ) THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Doctor already has an appointment';
        END IF;
        END$$

-- CHECK WHEN UPDATING- doctor availability IF dr1 exist at ap_tbl WHERE ap_time and ap_date
CREATE TRIGGER CheckDoctorAvailabilityUpdate
    BEFORE UPDATE ON ap_tbl
    FOR EACH ROW
BEGIN
IF EXISTS (
	SELECT *
    FROM ap_tbl
    WHERE dr_id = NEW.dr_id
		AND ap_date = NEW.ap_date
		AND ap_id <> OLD.ap_id
        AND ap_time = NEW.ap_time
        ) THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Doctor already has an appointment' ;
		END IF;
        END$$

##TRIGGER calculating date of next ap WHEN INSERT -ing based on weeks in follow_up
CREATE TRIGGER CalculateNextAp
BEFORE INSERT ON follow_up
FOR EACH ROW
SET NEW.review_date = (
    SELECT DATE_ADD(
        ap_date,
        INTERVAL NEW.`next_ap(weeks)` WEEK
    )
    FROM ap_tbl
    WHERE ap_id = NEW.ap_id
)$$

##TRIGGER calculating date ap date WHEN UPDATING based on weeks in follow_up

CREATE TRIGGER UpdateNextAp
BEFORE UPDATE ON follow_up
FOR EACH ROW
SET NEW.review_date = (
    SELECT DATE_ADD(
        ap_date,
        INTERVAL NEW.`next_ap(weeks)` WEEK
    )
    FROM ap_tbl
    WHERE ap_id = NEW.ap_id
)$$

DELIMITER ;