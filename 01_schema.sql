#Creating schema_
CREATE DATABASE crownfield;
USE crownfield;

#CREATE TABLES

#Step 1 
#PatientRegistrationDetails

create table pat_tbl
(
    pat_id     int auto_increment not null
        primary key,
    first_name varchar(20) not null,
    last_name  varchar(20) not null,
    post_code  varchar(8)  null
);


#MedicinesTable

create table med_tbl
(
    med_id   int auto_increment not null
        primary key,
    med_name varchar(50) not null,
	strength VARCHAR(20) NOT null,
	
	CONSTRAINT med_variant
		UNIQUE (med_name, strength)
	
);

#DoctorsEmployeeTable

create table dr_tbl
(
    dr_id     int auto_increment  not null
        primary key,
    dr_name   varchar(25) not null,
    specialty varchar(25) null
);

#ClinicsLocationTable

create table clinic_tbl
(
    clinic_id   int auto_increment not null
        primary key,
    clinic_name varchar(30) not null
);

#STEP2 - ap_tbl:

create table ap_tbl
(
    ap_id     int auto_increment
        primary key,
    dr_id     int  not null,
    pat_id    int not null,
    clinic_id int  not null,
    ap_date   date        not null,
    ap_time   time        not null,
    constraint fk_clinic
        foreign key (clinic_id) references clinic_tbl (clinic_id)
            on update cascade,
    constraint fk_dr
        foreign key (dr_id) references dr_tbl (dr_id)
            on update cascade,
    constraint fk_pat
        foreign key (pat_id) references pat_tbl (pat_id)
            on update cascade
);

#STEP3 
create table diag_tbl
(
    diag_id int auto_increment
        primary key,
    ap_id   int          not null,
    diag    varchar(255)  null,
    notes   varchar(255) null,
    constraint fk_ap
        foreign key (ap_id) references ap_tbl (ap_id)
            on update cascade
);

#STEP4 

create table follow_up
(
    follow_id        int auto_increment
        primary key,
    ap_id            int                                           not null,
    sta              enum ('complete', 'in progress', 'cancelled') not null,
    priority         enum ('H', 'U', 'R')                          not null,
    `next_ap(weeks)` int                                           null,
    review_date      date                                          null,
    constraint ap_id
        unique (ap_id),
    constraint fk_appp
        foreign key (ap_id) references ap_tbl (ap_id)
            on update cascade,
    constraint chk_followup_weeks
        check (`next_ap(weeks)` >= 0)
);

create table pre_tbl
(
    pre_id   int auto_increment not null
        primary key,
    ap_id    int         not null,
    constraint fk_appoitment
        foreign key (ap_id) references ap_tbl (ap_id)
            on update cascade
);

#STEP5

create table pre_detail
(
    det_id   int auto_increment
        primary key,
    pre_id   int not null,
    med_id   int not null,
    route    	VARCHAR(25) not null,
    dose     	varchar(25) not null,
    freq     	varchar(25) not null,
    duration	INT NULL,
	dur_unit	ENUM('days', 'weeks', 'months') NULL,	
	
    constraint fk_med
        foreign key (med_id) references med_tbl (med_id)
            on update cascade,
    constraint fk_prescription
        foreign key (pre_id) references pre_tbl (pre_id)
            on update cascade
);
