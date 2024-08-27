-- comment
-- database -> table -> rows and cols(fields/attritbutes)

create database db_bc2405p;

use db_bc2405p; 

create table customers ( -- table name with s
	id int,
    name varchar(50), -- (max character)
    email varchar(50)
);



-- add row to table
-- insert into table_name (col1_name,...) values (col1_value,...)
insert into customers (id,name,email) values (1,'John Lau', 'john@gmail.com'); -- string in sql use single quote
insert into customers (id,name,email) values (2,'Peter Wong', 'peter@gmail.com');


-- select 
-- * : all columns
-- where : conditions
select * from customers; 
select * from customers where id = 2;
select * from customers where id = 1 and id = 2; -- no data return
select * from customers where id = 1 or id = 2;

select name from customers where id = 1; 

-- order by
select * from customers order by id; -- default asc
select * from customers order by id asc;
select * from customers order by id desc;

-- where (filter), order by (sort)
select * from customers where id = 1 order by id desc;


use db_bc2405p;
create table students (
	id integer, -- int
    name varchar(50),
    weight numeric(5,2), -- decimal (max num, decimal place) max: 999.99
    height numeric(5,2) 
);

insert into students (id, name, weight, height) values (1, 'Alice Au',99.9,150);
insert into students (id, name, weight, height) values (2, 'Bobo Bun',40.8,152.23);
insert into students (id, name, weight, height) values (3, 'Ceci Cheung',50.54,164.02);
insert into students (id, name, weight, height) values (4, 'Doris Don',60.27,153.10);

insert into students (id, name, weight, height) values (5.2, 1234,65,170); -- id rounded off to 6 -- will be rejected in oracle
insert into students (id, name, weight, height) values (5.5, 'Eris Egg',65,170); -- id rounded off to 6 -- will be rejected in oracle

insert into students (id, name, weight) values (7, 'Gigi Green', 65);  -- can skip fields --> NULL
insert into students values (8, 'Hayley Hingleys', 65, 166.0);  -- if fields not specified

-- DDL (Data Definition Language): create/drop table, add/drop column, modify column definition [e.g. varchar(50) -> varchar(51)] 
-- DML (Data Manipulation Language): insert, update, delete, truncate table (remove all data)

select * from students;
select * from students where weight >= 60;

select weight + height as ABC, weight, height, id from students;
select weight/((height/100)^2) as BMI from students; -- do not support square

select s.weight + s.height as ABC, s.* from students s; -- s refer to student
select s.weight + s.height as ABC, s.* from students s 
	where s.weight > 45.0 
    order by name;

-- >, < , >=, <=, <>, =
select * from students where id <> 6 and id <> 8;

-- in, not in
select * from students where id not in (6, 8);
select * from students where id in (1,2,3);

-- like, not like
select * from students where name = 'Doris Don';
select * from students where name like '%heu%'; -- %: any name contain 'heu'
select * from students where name not like '%heu%';

-- null check
select * from students where height is null or weight is null;



-- functions ------------------------------------------------------------------------------------------------------------------------

-- char_length(), length()
insert into students (id, name, weight, height) values (9, '陳小明', 68.5, 157.7);
select char_length(s.name) as name_char_length, length(s.name) as name_legnth, s.* from students s; -- one chinese char = 3 length

-- upper(), lower()
select upper(s.name), lower(s.name), substring(s.name,1,3), trim(s.name), s.* from students s; -- index start from 1

-- substring(), trim(), instr()
select instr(s.name, 'g'), s.* from students s; -- return string position, 0 if not found



-- Add New Table ------------------------------------------------------------------------------------------------------------------------

create table orders(
	id integer,
    total_amount numeric(13, 2), -- JAVA: will not save calculated attributes, DB: record calculated attributes too, more convenient for processing
    customer_id integer
    
    
);

select * from orders;
insert into orders values(1, 2005.10, 2);
insert into orders values(2, 10005.10, 2);
insert into orders values(3, 99.9, 1);
insert into orders values(4, 249.5, 3);
insert into orders values(5, 120.9, 3);
insert into orders values(6, 333.3, 1);
insert into orders values(7, 777, 3);





-- front-end / Java / DB
-- 3ms is a lot! (without network consideration)
-- when to fetch data from DB when not to


-- AGGREGATE FUNCTIONS ------------------------------------------------------------------------------------------

-- sum()
select sum(o.total_amount) from orders o; -- 3ms JAVA: RAM, Heap memory DB: Hard Disc, 

-- avg()
select avg(o.total_amount) from orders o where customer_id = 2;

-- filter first, and the min(), max()
select min(o.total_amount), max(o.total_amount) from orders o where customer_id = 2;
select min(o.total_amount), max(o.total_amount) from orders o;

-- add columns
select o.*, 1 as number, 'hello' as string from orders o;

-- why we put all functions in one selected statement
-- ans: aggregate functions (each function only return one aggregated result) (kinda summary of the table)
select min(o.total_amount) as Min, max(o.total_amount) as Max, avg(o.total_amount) as avg, sum(o.total_amount) as sum, count(1) as count from orders o;

select o.total_amount, sum(o.total_amount) from orders o; -- -- error: NOT aggregation



-- group by
select sum(o.total_amount) from orders o where customer_id = 1;
select sum(o.total_amount) from orders o where customer_id = 2;

-- group by --> group key (unique values of column)
select o.customer_id, sum(o.total_amount) as sum from orders o group by o.customer_id order by o.customer_id;
select o.customer_id, sum(o.total_amount) as sum, o.id from orders o group by o.customer_id order by o.customer_id; -- error

select o.customer_id, min(o.total_amount) as Min, max(o.total_amount) as Max, avg(o.total_amount) as avg, sum(o.total_amount) as sum from orders o group by o.customer_id order by o.customer_id;



-- group by + having

select o.customer_id, avg(o.total_amount) as avg_amount
	from orders o 
	where o.customer_id in(2,3)  -- filter before group by
    group by o.customer_id -- shape: 2 rows x 2 cols
    having avg(o.total_amount > 1000); -- another filter after group by, shape: 1 rows x 2 cols



-- homework: create two tables (one to many)
-- with datetime, integer, numeric, varchar 
-- where, group by, having, order by

select * from customers where name = 'JOHN LAU'; -- case insensitive (mySQL)
select * from customers where UPPER(name) = 'JOHN LAU'; -- if case sensitive

select * from customers where name like '%HN%';
select * from customers where name like 'JO%LAU'; -- % can place in the middle

select * from customers where name like '_HN LAU'; -- _ refer to one character only
select * from customers where name like '_OHN LAU';

select ROUND(o.total_amount, -1), o.* from orders o;
select ROUND(o.total_amount, 1), o.* from orders o;
select CEIL(ROUND(o.total_amount, 0)), o.* from orders o;
select FLOOR(ROUND(o.total_amount, 0)), o.* from orders o;


select 1, ABS(-5) from dual; -- dual: blank/no table

select '2024-08-01' from dual; -- not a date

-- DATE formatting
select DATE_FORMAT('2023-08-31','%y-%m-%d') from dual;
select DATE_FORMAT('2023-08-31','%y-%m-%d') + INTERVAL 1 DAY from dual; -- mySQL
select STR_TO_DATE('2023-12-31','%y-%m-%d') + INTERVAL 1 DAY from dual; -- ???

select STR_TO_DATE('2023 December 31','%Y %M %d') + INTERVAL 1 DAY from dual; -- %Y -- 4 digit // %y -- 2 digit

select DATE_FORMAT('2023-12-31','%y-%m-%d') + INTERVAL 1 DAY from dual; -- work

select DATE_FORMAT('2023-08-31','%y-%m-%d') +1  from dual; -- Orcale ok! mySQL cannot run

-- Extract
select EXTRACT(YEAR FROM DATE_FORMAT('2023-08-15','%y-%m-%d')) from dual;
select EXTRACT(MONTH FROM DATE_FORMAT('2023-08-15','%y-%m-%d')) from dual;
select EXTRACT(DAY FROM DATE_FORMAT('2023-08-15','%y-%m-%d')) from dual;

-- alter table
select * from orders;
alter table orders add column tran_date date; -- DDL

update orders 
set tran_date = DATE_FORMAT('2023-08-31','%y-%m-%d')
where id = 1;

update orders 
set tran_date = DATE_FORMAT('2023-08-03','%y-%m-%d')
where id = 2;

update orders
set tran_date = DATE_FORMAT('2022-08-22','%y-%m-%d')
where id = 3;

update orders
set tran_date = DATE_FORMAT('2021-09-30','%y-%m-%d')
where id = 4;

update orders
set tran_date = DATE_FORMAT('2024-08-09','%y-%m-%d')
where id = 5;

update orders
set tran_date = DATE_FORMAT('2021-04-14','%y-%m-%d')
where id = 6;

update orders
set tran_date = DATE_FORMAT('2021-02-02','%y-%m-%d')
where id = 7;



SELECT EXTRACT(YEAR FROM DATE_FORMAT(o.tran_date,'%y,%m,%d')),COUNT(1) as NUMBER_OF_ORDERS 
	from orders o
    group by EXTRACT(YEAR FROM DATE_FORMAT(o.tran_date,'%y,%m,%d'))
    having COUNT(1) < 2;


select IFNULL(s.weight,'N/A'),IFNULL(s.height,'N/A'), s.* from students s;
select COALESCE(s.weight,'N/A'),COALESCE(s.height,'N/A'), s.* from students s;

-- < 2000 'S'
-- >= 2000 and < 1000 -> 'M'
-- >=10000 -> 'L'


select CASE
		WHEN total_amount < 2000 THEN 'S'
		WHEN total_amount >= 2000 AND o.total_amount < 10000 THEN 'M'
        -- WHEN total_amount between 2000 and 10000 THEN 'M'
		ELSE 'L'
    END AS category
    ,o.*
from orders o;

-- between (inclusive)
select * from orders 
	where tran_date between DATE_FORMAT('2022-08-31','%y-%m-%d')
    and DATE_FORMAT('2023-12-31','%y-%m-%d');
    
-- EXISTS (customers, orders)
-- Find the customer(s) who has orders

insert into customers values(3, 'Jenny Yu','jennyyu@gmail.com');
insert into customers values(4, 'Benny Kwok','bennykwok@gmail.com');



-- return all in customer without filter
select * from customers c
where exists(select 1 from orders);

-- return customer who have orders
select * from customers c
where exists(select 1 from orders o where o.customer_id = c.id);

-- return customer who do not have orders -- adding 'NOT'
select * from customers c
where not exists(select 1 from orders o where o.customer_id = c.id);



insert into orders value (8, 9999, 3,DATE_FORMAT('2024-08-24','%Y-%m-%d'));

-- extract 2024 august 
select CONCAT(extract(YEAR from tran_date),'-',extract(MONTH from tran_date)) from orders;

-- distinct 1 column -- ~UNIQUE() in excel
select distinct CONCAT(extract(YEAR from tran_date),'-',extract(MONTH from tran_date)) from orders;
-- distinct 2 column
select distinct CONCAT(extract(YEAR from tran_date),'-',extract(MONTH from tran_date)), total_amount from orders;



-- subquery: not a good practice
-- first SQL to execute is query in ()
-- then outside
-- slow performance: run two times
-- usually can be replaced by other methods 

select o.*, (select max(total_amount) from orders),1
from orders o;

select * from orders
where customer_id = (select id from customers where name like '%LAU');



-- ------------------------------- JOIN -----------------------------------

select * from customers c; -- 4 rows
select * from orders o; -- 8 rows

-- INNER JOIN --
select * from customers c inner join orders o; -- return 4 * 8 rows (all possible combinations of customers and orders)
select * from customers c inner join orders o on o.customer_id = c.id; -- return 8 rows


select * from customers c  join orders o on o.customer_id = c.id; -- return 8 rows

-- select all customer columns from c 
-- Approach 1
select c.* from customers c
where exists(select 1 from orders o where o.customer_id = c.id) order by c.id;

-- Approach 2
select distinct c.* from customers c inner join orders o on o.customer_id = c.id order by c.id; 
