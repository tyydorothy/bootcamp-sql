-- create two tables

use db_bc2405p; 

create table prac_users(
	id integer,
    first_name varchar(50),
    last_name varchar(50),
    birth_year integer,
    race varchar(50)
);

create table prac_sleepRecords(
	id int,
    user_id int,
    sleep_start_datetime datetime,    
    sleep_end_datetime datetime,
    sleep_quality varchar(10)
);

insert into prac_users(id, first_name,last_name,birth_year,race) values (1, "Apple","Chan",1984,"Asian");
insert into prac_users(id, first_name,last_name,birth_year,race) values (2, "Berry","Cheung",1975,"Asian");
insert into prac_users(id, first_name,last_name,birth_year,race) values (3, "Cherry","Don",1969,"American Indian");
insert into prac_users(id, first_name,last_name,birth_year,race) values (4, "Donald","Cheung",1998,"American Indian");
insert into prac_users(id, first_name,last_name,birth_year,race) values (5, "Eris","Chan",2003,"African American");

insert into prac_sleepRecords values (1,1,'2023-12-31 22:00:30','2024-01-01 08:06:24','GOOD');
insert into prac_sleepRecords values (2,1,'2023-01-05 03:40:30','2024-01-05 11:12:24','BAD');
insert into prac_sleepRecords values (3,1,'2023-01-07 00:26:30','2024-01-07 07:05:59','BAD');
insert into prac_sleepRecords values (4,2,'2023-01-07 00:24:31','2024-01-07 09:59:59','GOOD');
insert into prac_sleepRecords values (5,2,'2023-01-08 00:00:31','2024-01-08 08:49:59','GOOD');
insert into prac_sleepRecords values (6,2,'2023-01-08 21:00:31','2024-01-09 06:29:56','GOOD');
insert into prac_sleepRecords values (7,2,'2023-01-09 21:06:31','2024-01-09 06:29:56','GOOD');

ALTER TABLE prac_users ADD CONSTRAINT pk_user_id PRIMARY KEY (id);
ALTER TABLE prac_sleepRecords ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES prac_users(id);
ALTER TABLE prac_sleepRecords ADD CONSTRAINT pk_sleepRecords_id PRIMARY KEY (id);



select * from prac_users;
select * from prac_sleepRecords;