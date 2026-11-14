
USE crownfield;

#Patients details
INSERT INTO crownfield.pat_tbl (first_name, last_name, post_code)
VALUES
('Amina', 'Yusuf', 'NE1 4AB'),
('Daniel', 'Reed', 'N16 7QP'),
('Sofia', 'Bennett', 'E8 2LD'),
('Michael', 'Okoro', 'SE6 3RT'),
('Adam', 'Pascal', 'NN11 2CC'),
('Cat', 'Alin', 'B1 2LL'),
('Nomman', 'Nomman', 'SE11 2AA'),
('Sahiba', 'Sahiba', 'B22 7AA'),
('Dennis ', 'First', 'B2 2CA'),
('Nicole', 'Amasing', 'B16 1HS'),
('Grace', 'Taylor', 'NE1 3CD'),
('Omar', 'Lewis', 'SE16 8QP'),
('Diana', 'Brooks', 'E6 8QP');

#doctor details
INSERT INTO crownfield.dr_tbl (dr_name, specialty)
VALUES
('Dr Maya Shah', 'Glaucoma'),
('Dr Leo Grant', 'Retina'),
('Dr Priya Nair', 'Cornea'),
('Dr Djamal', null),
('Dr M W', 'Oculoplastic'),
('Dr Elon Must', 'Pediatric Ophthalmology'),
('Dr Olivia Morgan', 'Retina'),
('Dr Sarah Patel', 'Cataract'),
('Dr Hannah Cole', 'Glaucoma'),
('Katarina Cute-eye', 'receptionist'),
('Nicole Cage', 'receptionist');

#clinics

INSERT INTO crownfield.clinic_tbl (clinic_name)
VALUES
('City Road'),
('Sheep Hole'),
('Westgate Clinic'),
('Bedford'),
('Croydon'),
('Corby'),
('Peterborough'),
('Tamworth'),
('Telford'),
('Birmingham'),
('Bristol');


# Medicines - example strengths added
INSERT INTO med_tbl (med_name, strength)
VALUES
('Latanoprost', '0.005%'),
('Timolol', '0.5%'),
('Aflibercept', '40 mg/mL'),
('Sodium Chloride', '5%'),
('Natamycin', '5%'),
('Phenylephrine', '2.5%'),
('Tropicamide', '1%'),
('Co-codamol', '8 mg/500 mg'),
('Ketorolac', '0.5%'),
('Visine drops', '0.05%'),
('Dorzolamide', '2%'),
('Brimonidine', '0.2%'),
('Timolol', '0.25%'); # Additional strength variant


# STEP 2 - APPOINTMENTS
# Original IDs preserved

INSERT INTO ap_tbl
(ap_id, dr_id, pat_id, clinic_id, ap_date, ap_time)
VALUES
(1, 1, 1, 1, '2026-10-05', '09:00:00'),
(2, 2, 2, 1, '2026-10-05', '09:30:00'),
(3, 1, 3, 1, '2026-10-06', '11:00:00'),
(4, 3, 4, 5, '2026-10-07', '14:00:00'),
(5, 1, 1, 4, '2026-11-16', '10:15:00'),
(7, 3, 5, 4, '2026-11-26', '16:30:00'),
(11, 1, 6, 1, '2026-12-30', '16:30:00'),
(12, 2, 9, 4, '2026-12-15', '11:45:00'),
(13, 7, 7, 6, '2027-01-13', '10:00:00'),
(16, 5, 6, 7, '2027-01-20', '11:30:00'),
(18, 5, 10, 8, '2027-01-25', '12:00:00'),
(19, 1, 8, 8, '2026-12-12', '11:30:00'),
(20, 9, 12, 3, '2026-12-12', '13:00:00'),
(21, 9, 11, 3, '2026-12-12', '13:30:00'),
(22, 1, 11, 1, '2026-12-21', '10:00:00');


# STEP 3 - DIAGNOSES

INSERT INTO diag_tbl (diag_id, ap_id, diag, notes)
VALUES
(1, 1, 'Ocular hypertension', 'Review IOP'),
(2, 2, 'Diabetic macular oedema', 'OCT before review'),
(3, 3, 'Glaucoma suspect', 'Monitor'),
(4, 4, 'Keratoconus', 'Corneal topography'),
(5, 5, 'Ocular hypertension', 'Visual test'),
(6, 7, 'Laser eye correction', 'Long sightedness (hyperopia) needed correction'),
(7, 11, 'Lens disorders and refractive errors', 'Cataract extraction, premium IOLs, LASIK/PRK'),
(8, 12, 'Nerve disorders', 'Neuro-Optic nerve disorders, visual pathway lesions'),
(9, 16, 'Glaucoma suspect', 'IOP monitoring required'),
(10, 13, 'Dry eye syndrome', 'Mild irritation and blurred vision. Artificial tears recommended'),
(11, 18, 'new_patient', 'Patient complain on double vision'),
(13, 19, 'eye check', 'routine vision check'),
(14, 21, 'Primary open-angle glaucoma in the right eye', 'Eye pressure remains above target despite timolol'),
(15, 21, 'Age-related cataract in the right eye', 'Cataract to be monitored'),
(16, 20, 'Ocular hypertension', 'Raised pressure in left eye; topical beta-blocker unsuitable.');


# STEP 4 - FOLLOW UP

INSERT INTO follow_up
(follow_id, ap_id, sta, priority, `next_ap(weeks)`, review_date)
VALUES
(1, 1, 'complete', 'H', 6, '2026-11-16'),
(2, 2, 'complete', 'U', 4, '2026-11-02'),
(3, 3, 'in progress', 'R', 26, '2027-04-06'),
(4, 4, 'in progress', 'R', 8, '2026-12-02'),
(5, 5, 'in progress', 'R', 12, '2027-02-08'),
(7, 7, 'in progress', 'R', 4, '2026-12-24'),
(8, 11, 'in progress', 'H', 6, '2027-02-10'),
(9, 12, 'in progress', 'U', 8, '2027-02-09'),
(10, 13, 'in progress', 'R', 4, '2027-02-10'),
(12, 16, 'in progress', 'R', 4, '2027-02-17'),
(13, 21, 'in progress', 'H', 4, '2027-01-09'),
(14, 20, 'in progress', 'R', 6, '2027-01-23'),
(15, 19, 'complete', 'R', NULL, NULL);


# STEP 5 - PRESCRIPTIONS

INSERT INTO pre_tbl (pre_id, ap_id)
VALUES
(1, 1),
(2, 2),
(4, 4),
(5, 5),
(6, 7),
(7, 11),
(8, 12),
(9, 13),
(10, 16),
(11, 18),
(12, 21),
(14, 20);


# STEP 6 - PRESCRIPTION DETAILS

INSERT INTO pre_detail
(det_id, pre_id, med_id, route, dose, freq, duration, dur_unit)
VALUES
(1, 1, 1, 'eye drops', '1 drops', '2 x day', 5, 'days'),
(2, 1, 2, 'eye drops', '1 drop', '3 x day', 5, 'days'),
(3, 2, 3, 'Intravitreal injection', '2 mg', '1 x monthly', 3, 'months'),
(5, 4, 4, 'eye drops', '1 drop', '2 x day', 5, 'days'),
(6, 5, 1, 'eye drops', '1 drop', 'once daily', 30, 'days'),
(7, 6, 2, 'eye drops', '1 drop', 'twice daily', 30, 'days'),
(8, 7, 4, 'eye drops', '1 drop', 'four times daily', 7, 'days'),
(9, 8, 9, 'eye drops', '1 drop', 'four times daily', 7, 'days'),
(10, 9, 1, 'eye drops', '1 drop', 'once daily', 30, 'days'),
(12, 10, 1, 'eye drops', '1 drop', 'once daily', 7, 'days'),

# Estimated duration until planned review
(15, 12, 2, 'Ophthalmic', '1 drop in right eye', 'Twice daily', 4, 'weeks'),
(16, 12, 11, 'Ophthalmic', '1 drop in right eye', 'Twice daily', 4, 'weeks'),
(17, 14, 12, 'Ophthalmic', '1 drop', 'Twice daily', 6, 'weeks'),

# New fictional example for prescription 11
(18, 11, 7, 'eye drops', '1 drop each eye', 'Once before examination', 1, 'days');
