CREATE DATABASE db_bc_exercise1;
USE db_bc_exercise1;

CREATE TABLE regions(
	region_id int PRIMARY KEY,
    region_name varchar(25) NOT NULL
);

CREATE TABLE countries(
	country_id char(2) PRIMARY KEY,
    country_name varchar(40) NOT NULL,
    region_id int NOT NULL,
    FOREIGN KEY(region_id) REFERENCES regions(region_id)
);

CREATE TABLE locations(
	location_id int PRIMARY KEY,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12),
    country_id char(2),
    FOREIGN KEY(country_id) REFERENCES countries(country_id)
);

CREATE TABLE departments(
	department_id int PRIMARY KEY,
    department_name varchar(30),
    manager_id int,
    location_id int,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);


CREATE TABLE jobs(
	job_id varchar(10) PRIMARY KEY,
    job_title varchar(35) NOT NULL,
    min_salary decimal(13,2),
    max_salary decimal(13,2)
);

CREATE TABLE employees(
	employee_id int PRIMARY KEY,
    first_name varchar(20) NOT NULL,
    last_name varchar(25) NOT NULL,
    email varchar(25),
    phone_number varchar(20),
    hire_date date NOT NULL,
    job_id varchar(10),
    salary decimal(13,2),
    comission_pct decimal(13,2),
    manager_id int,
    department_id int,
    FOREIGN KEY(job_id) REFERENCES jobs(job_id),
    FOREIGN KEY(department_id) REFERENCES departments(department_id)
);

CREATE TABLE job_history(
	employee_id int,
    start_date date,
    end_date date,
    job_id varchar(10),
    department_id int,
    PRIMARY KEY(employee_id,start_date),
	FOREIGN KEY(employee_id) REFERENCES employees(employee_id),
	FOREIGN KEY(job_id) REFERENCES jobs(job_id),
    FOREIGN KEY(department_id) REFERENCES departments(department_id)
);



-- ===================================== insert data ==================================================
insert into regions values(0, 'Sample Country');
insert into regions values(1, 'Europe');
insert into regions values(2, 'North America');
insert into regions values(3, 'Latin America');
insert into regions values(4, 'Asia-Pacific');
insert into regions values(5, 'the Middle East, Africa');
select * from regions;

insert into countries values('ZZ', 'Sample',0);
insert into countries values('US', 'United States of America',2);
insert into countries values('CA', 'Canada',2);
insert into countries values('DE', 'Germany',1);
insert into countries values('FR', 'France',1);
insert into countries values('JP', 'Japan',4);
insert into countries values('CN', 'China',4);
select * from countries;

insert into locations values(0000, '000 Sample Road',00000,'Not HK',null,'ZZ');
insert into locations values(1000, '15205 North Kierland Blvd',85254,'Scottsdale','Arizona','US');
insert into locations values(1001, '123 Rainbow Rainbow',02465,'city1','Berkeley','US');
insert into locations values(1002, '235 York Somewhere',23567,'New York','New York','US');
insert into locations values(1003, '311 Tokyo Somewherewhere',12345,'Tokyo','Tokyo','JP');
insert into locations values(1004, '444 Hakata Eki',12345,'Hakata','Kyushyu','JP');
select * from locations;


insert into departments values (000,'Sample Department',0000001,0000);
insert into departments values (101,'Human Resources',1000001,1000);
insert into departments values (102,'Operations',null,1000);
insert into departments values (103,'Sales',null,1000);
insert into departments values (401,'Human Resources',null,1004);
insert into departments values (402,'Operations',4020011,1004);
insert into departments values (403,'Sales',null,1004);
select * from departments;

insert into jobs values ('BB001','BOSS',null,null);

insert into jobs values ('HR001','Human Resources Manager',100000,1000);
insert into jobs values ('HR002','Human Resources Assistant',90000,9000);
insert into jobs values ('HR999','Human Resources Internship',10000,null);

insert into jobs values ('OP001','Operations Manager',80000,8000);
insert into jobs values ('OP002','Operations Associate',70000,7000);
insert into jobs values ('OP003','Operations Assistant',6000.01,6000);
select * from jobs;

insert into employees values (0000001,'Lex','De Haan','sample1@email.com','0000000000',DATE_FORMAT('2000-01-01','%Y-%m-%d'),'BB001',100000000,null,null,000);
insert into employees values (1000001,'Apple','Fruit1','appleisfruit@email.com','1234567890',DATE_FORMAT('1990-01-01','%Y-%m-%d'),'HR001',12345.67,10.00,null,101);
insert into employees values (1000002,'Orange','Fruit2','orangeisfruit@email.com','2348395435',DATE_FORMAT('1994-05-01','%Y-%m-%d'),'HR002',12000.45,0.00,1000001,101);
insert into employees values (1000003,'Banana','Fruit3','bananaisfruit@email.com','99999995435',DATE_FORMAT('1997-03-01','%Y-%m-%d'),'HR002',18000.45,0.00,1000001,101);
insert into employees values (4020009,'Joey','Friends1','JoeyisFriend@email.com','8888888',DATE_FORMAT('2021-07-01','%Y-%m-%d'),'OP003',18000.45,12.2,4020011,402);
insert into employees values (4020010,'Monica','Friends2','MonicaisFriend@email.com','777777#7',DATE_FORMAT('2020-01-31','%Y-%m-%d'),'OP002',21000.56,0,4020011,402);
insert into employees values (4020011,'Chandler','Friends3','ChandisFriend@email.com','22446688*',DATE_FORMAT('2020-01-31','%Y-%m-%d'),'OP001',21000.56,0,null,402);

select * from employees;

insert into job_history values (0000001,DATE_FORMAT('2000-01-01','%Y-%m-%d'),null,'BB001',000);
insert into job_history values (1000001,DATE_FORMAT('1990-01-01','%Y-%m-%d'),DATE_FORMAT('2000-01-01','%Y-%m-%d'),'HR001',101);
insert into job_history values (1000002,DATE_FORMAT('1992-01-01','%Y-%m-%d'),DATE_FORMAT('1992-12-31','%Y-%m-%d'),'HR999',101);
insert into job_history values (1000002,DATE_FORMAT('1994-05-01','%Y-%m-%d'),DATE_FORMAT('1998-07-07','%Y-%m-%d'),'HR002',101);
insert into job_history values (4020009,DATE_FORMAT('2018-07-01','%Y-%m-%d'),null,'HR002',401);
insert into job_history values (4020009,DATE_FORMAT('2021-07-01','%Y-%m-%d'),null,'OP003',401);
insert into job_history values (4020010,DATE_FORMAT('2017-04-01','%Y-%m-%d'),DATE_FORMAT('2020-01-30','%Y-%m-%d'),'OP003',401);
insert into job_history values (4020010,DATE_FORMAT('2020-01-31','%Y-%m-%d'),null,'OP002',401);
insert into job_history values (4020011,DATE_FORMAT('2020-01-31','%Y-%m-%d'),null,'OP001',401);



-- ===================================== 3 ==================================================
SELECT l.location_id, l.street_address, l.city, l.state_province, c.country_name 
FROM locations l LEFT JOIN countries c ON l.country_id = c.country_id;



-- ===================================== 4 ==================================================
SELECT e.first_name, e.last_name, e.department_id
FROM Employees e;



-- ===================================== 5 ==================================================
SELECT e.first_name, e.last_name,e.job_id, e.department_id
FROM Employees e
WHERE EXISTS(
	SELECT d.department_id
    FROM departments d LEFT JOIN locations l on d.location_id = l.location_id
    WHERE l.country_id = 'JP' and d.department_id = e.department_id
);



-- ===================================== 6 ==================================================
SELECT e.employee_id, e.last_name,e.manager_id, e2.last_name
FROM employees e LEFT JOIN employees e2 on e.manager_id = e2.employee_id;



-- ===================================== 7 ==================================================
SELECT e.first_name, e.last_name, e.hire_date 
FROM employees e 
WHERE e.hire_date < (SELECT e2.hire_date FROM employees e2 WHERE CONCAT(e2.first_name,' ',e2.last_name) = 'Lex De Haan');



-- ===================================== 8 ==================================================
SELECT d.department_name, COUNT(e.employee_id) as number_of_employees
FROM departments d LEFT JOIN employees e on d.department_id = e.department_id
GROUP BY d.department_id;



-- ===================================== 9 ==================================================
-- Department ID: 401
SELECT h.employee_id,j.job_title, DATEDIFF(IFNULL(h.end_date,CURDATE()),h.start_date)+1 as num_of_days
FROM job_history h LEFT JOIN jobs j on h.job_id = j.job_id
WHERE h.department_id = 401;



-- ===================================== 10 ==================================================
-- department name, manager name, city name, country name
WITH dpt_loc AS(
	SELECT d.department_name,d.manager_id, l2.city as city_name, l2.country_name
    FROM departments d LEFT JOIN (
		SELECT l.location_id, l.city, c.country_name 
        FROM locations l LEFT JOIN countries c on l.country_id = c.country_id
	) l2
    on d.location_id = l2.location_id
)

SELECT dl.department_name, CONCAT(e.first_name,' ', e.last_name) as manager_name, dl.city_name, dl.country_name
FROM dpt_loc dl LEFT JOIN employees e on dl.manager_id = e.employee_id;



-- ===================================== 10 ==================================================
SELECT d.department_id, d.department_name, ROUND(avg(e.salary),2) as avg_salary
FROM departments d INNER JOIN employees e on d.department_id = e.department_id
GROUP BY d.department_id;



-- ===================================== 11 ==================================================
CREATE TABLE job_grades(
	grade_level varchar(2) PRIMARY KEY,
    lowest_sal decimal(13,2),
    highest_sal decimal(13,2)
);

ALTER TABLE jobs
ADD grade_level varchar(2);

ALTER TABLE jobs
ADD CONSTRAINT FK_jobs_grade_levels
FOREIGN KEY (grade_level) REFERENCES job_grades(grade_level);