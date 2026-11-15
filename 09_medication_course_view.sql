USE crownfield;

CREATE VIEW medication_course_end AS

SELECT
pat_tbl.pat_id,
pat_tbl.first_name,
pat_tbl.last_name,
ap_tbl.ap_id,
ap_tbl.ap_date,
med_tbl.med_name,
med_tbl.strength,
pre_detail.duration,
pre_detail.dur_unit,

CASE
WHEN pre_detail.dur_unit = 'days'
THEN DATE_ADD(ap_tbl.ap_date,
INTERVAL pre_detail.duration DAY)

WHEN pre_detail.dur_unit = 'weeks'
THEN DATE_ADD(ap_tbl.ap_date,
INTERVAL pre_detail.duration WEEK)

WHEN pre_detail.dur_unit = 'months'
THEN DATE_ADD(ap_tbl.ap_date,
INTERVAL pre_detail.duration MONTH)

ELSE NULL
END AS estimated_end_date

FROM pre_detail

JOIN pre_tbl
ON pre_detail.pre_id = pre_tbl.pre_id

JOIN ap_tbl
ON pre_tbl.ap_id = ap_tbl.ap_id

JOIN pat_tbl
ON ap_tbl.pat_id = pat_tbl.pat_id

JOIN med_tbl
ON pre_detail.med_id = med_tbl.med_id;