create database db_bc_exercise2;
use db_bc_exercise2;

CREATE TABLE worker (
	worker_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name char(25),
    last_name char(25),
    salary numeric(15),
    joining_date datetime,
    department char(25)
);

INSERT INTO worker
	(first_name, last_name, salary, joining_date, department) VALUES
		('Monika','Arora',100000, '21-02-20 09:00:00', 'HR'),
        ('Niharika', 'Verma', 80000, '21-06-11 09:00:00', 'Admin'),
        ('Vishal', 'Singhal', 300000, '21-02-20 09:00:00', 'HR'),
		('Mohan','Sarah',300000,'21-02-20 09:00:00','Admin'),
        ('Amitabh','Singh',500000,'21-02-20 09:00:00', 'Admin'),
        ('Vivek', 'Bhati', 490000, '21-06-11 09:00:00', 'Admin'),
        ('Vipik', 'Diwan',20000, '21-06-11 09:00:00', 'Account'),
        ('Satish', 'Kumar',75000, '21-01-20 09:00:00', 'Account'),
        ('Geetika', 'Chauhan',90000, '21-04-11 09:00:00', 'Admin');

CREATE TABLE bonus(
	worker_ref_id INTEGER,
    bonus_amount numeric(10),
    bonus_date date,
    FOREIGN KEY(worker_ref_id) REFERENCES worker(worker_id)
);

INSERT INTO bonus
	(worker_ref_id, bonus_amount, bonus_date) VALUES
		(6,32000,'2021-11-02'),
        (6,20000,'2022-11-02'),
        (5,21000,'2021-11-02'),
        (9,30000,'2021-11-02'),
        (8,4500,'2022-11-02');

SELECT w.salary FROM worker w
ORDER BY salary DESC
LIMIT 1,1;

SELECT CONCAT(w.first_name,' ',w.last_name) as worker_name
FROM worker w INNER JOIN (
	SELECT MAX(x.salary) as salary, x.department
    FROM worker x
	GROUP BY x.department
    ) y 
    on w.salary = y.salary and w.department = y.department;

SELECT * from worker order by department,salary desc;

SELECT w.*
FROM worker w JOIN worker x
WHERE w.worker_id <> x.worker_id and w.salary = x.salary;

SELECT CONCAT(w.first_name,' ',w.last_name) as worker_name
FROM worker w INNER JOIN bonus b ON w.worker_id = b.worker_ref_id
WHERE YEAR(bonus_date) = 2021;

DELETE from worker;
-- cannot delete records from table'worker' because it is a parent table of bonus. A field in 'bonus' is referencing the field from 'worker'

DROP TABLE worker;
-- cannot be dropped. same reason
