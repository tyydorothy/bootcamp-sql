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
where not exists(select * from orders o where o.customer_id = c.id);



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





-- ----------------------------------------------- JOIN -----------------------------------------------------

select * from customers c; -- 4 rows
select * from orders o; -- 8 rows

-- INNER JOIN --
-- contain all required records

select * from customers c inner join orders o; -- return 4 * 8 rows (all possible combinations of customers and orders)
select * from customers c inner join orders o on o.customer_id = c.id; -- return 8 rows


select * from customers c  join orders o on o.customer_id = c.id; -- return 8 rows

-- select all customer columns from c 
-- Approach 1
select c.* from customers c
where exists(select 1 from orders o where o.customer_id = c.id) order by c.id;

-- Approach 2
select distinct c.* from customers c inner join orders o on o.customer_id = c.id order by c.id; 



insert into orders values(9, 400.00, null, DATE_FORMAT('2023-03-23','%Y-%m-%d'));

-- LEFT JOIN --
-- for reporting
select o.*, c.* from customers c left join orders o on o.customer_id = c.id order by c.id;

-- RIGHT JOIN -- (same as left join, usually people use left join)
select o.*, c.* from customers c right join orders o on o.customer_id = c.id order by o.id;
select o.*, c.* from orders o right join customers c on o.customer_id = c.id order by c.id;

-- JOIN & GROUP BY
-- count which column **
-- count(1) --> count the row each c.id having --> benny have one null order row --> benny have 1 order
SELECT c.id ,c.name, count(o.id) number_of_orders, ifnull(max(total_amount),0) as max_amount_of_orders
FROM customers c LEFT JOIN orders o on c.id = o.customer_id and o.total_amount > 1000
WHERE total_amount > 1000 or o.total_amount is null
GROUP BY c.id, c.name
ORDER BY c.name asc;

-- STEP: join > where > group by > order by > select (which data to present)

-- FULL OUTER JOIN -- (seldom use)


-- ---------------------------------------------- PRIMARY KEY -------------------------------------------------
-- UNIQUE
-- INDEXING
-- NOT NULL
-- Searching: must return only one result or null



insert into customers values (4, "Mary Chan", "marychan@gmail.com"); -- allow duplicated id without setting id as primary key
DELETE FROM customers WHERE name = "Mary Chan";

ALTER TABLE customers ADD CONSTRAINT pk_customer_id PRIMARY KEY (id);

INSERT INTO customers values(4, "Mary Chan", "marychan@gmail.com"); -- error
INSERT INTO customers values (5, "Mary Chan", "marychan@gmail.com"); -- OK!

-- ---------------------------------------------- FOREIGN KEY -------------------------------------------------
-- ensure integrity
-- the foreign key of one tables exists in another table as primary key
-- safeguard the relationship/ record exists in another table
-- a way to link table together
-- the two key should be equivalent

ALTER TABLE orders ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(id); 

-- should not allow NULL key or key does not exist in the original table (customer_id)
insert into orders values(10, 400.00, 10, DATE_FORMAT('2023-03-23','%Y-%m-%d')); -- error
insert into orders values(10, 400.00, NULL, DATE_FORMAT('2023-03-23','%Y-%m-%d')); -- should be error in oracle but allowed in mySQL
insert into orders values(10, 400.00, 5, DATE_FORMAT('2023-03-23','%Y-%m-%d')); -- OK!

delete from orders where total_amount = 400.00;

select * from customers;
select * from orders;



-- TABLE DESIGN: PK AND FK ensure data integrity during insert/update
-- Primary Key and Foreign key are also a type of constraints
-- Every table has one pk only



-- ---------------------------------------------- UNIQUE -------------------------------------------------
-- Other constraints: Unique constraints
-- should not use HKID as primary key 
-- no guarantee HKID is unique all the time
-- set id as primary key

select * from customers;
alter table customers add constraint unique_email unique (email);
insert into customers values (6, "John Chan", "johnchan@gmail.com"); -- error



-- ---------------------------------------------- NOT NULL -------------------------------------------------
ALTER TABLE customers MODIFY name varchar(50) not null;





-- ---------------------------------------------- DATABASE DESIGN -------------------------------------------------
-- ONE-to-ONE table
-- one table contains information that frequently used but another conatiains info that seldom used

-- MANY-to-MANY table
-- to store the relationship of two tables
-- create one new table: PK = table1_PK + table2_PK, FK1 = table1_PK, FK2 = table2_PK

-- Primary Key
-- Foreign Key

-- INNER JOIN
-- frequently use
-- return all relatable data (data with relationship with another table)
-- 

-- LEFT/RIGHT JOIN
-- return 
-- can be replaced by NOT EXISTS (most likely, better performance)

-- java will not ensure data integrity
-- database is where to ensure data integrity

-- Database Normalisation
-- notes Week 20-21
-- 1NF: atomic values (data in a cell is indivisible, not using separator (, ; tab) to separate
-- 2NF: divide database into different tables
-- 3NF: Key table is important (key can be easily updated, can easily add key, or change the key to another form [there are different abbr for one thing])

-- should always be fully normalised
-- not fully normalised always have its cost
-- more joins --> slower (only if the db is not well-designed, shd not be a big concern coz hardware is more advanced now)
-- if well normalised --> no redunduncy --> less storage

-- --------------------------------------------- UNION --------------------------------------------- 
select name, email 
from customers
union all
select id, total_amount -- must select same no. of column
from orders;

select 1 
from customers 
union all
select 1 
from orders; -- return (no. of rows in customer + no. of rows in orders) rows 

select 1 
from customers 
union 
select 1 
from orders; -- return 1 without duplicate value/ distinct value only

-- DO NOT drop column 


-- =========================================== VIEW =============================================
-- select real time data (not the moment when the view is created)
-- select * will slow down performance

create view orders_202408
as
select * from orders -- SELECT * 
where tran_date between DATE_FORMAT('2024-07-31','%Y-%m-%d') and DATE_FORMAT('2024-09-01','%Y-%m-%d');

select * from orders_202408; -- 

drop view orders_202408;


-- sample procedure -- pseudo code -- copy from git
P_ID INT;
P_TOTAL_AMOUNT NUMERIC (13,2);
P_CUSTOMER INT;
P_TRAN_DATE DATE;

CURSOR C_ORDERS
IS
SELECT ID, TOTAL_AMOUNT, CUSTOMER_ID, TRAN_DATE
FROM orders_202408;

FOR rec 

-- 

select *
INTO P_ID, P_TOTAL_AMOUNT,P_CUSTOMER_ID,P_TRAN_DATE
FROM orders_202408

select * from customers; -- SELECT * --> slow performance
select * from orders;



-- Materialized View
-- not available in MySQL
-- not real time
-- capture of sales per month?
-- data cannot be modified



-- stored procedure
-- monthly eStatement
-- regular notice of fee/payment
-- no need real-time interaction
-- less overhead: if by java: java-> db -> java -> out

-- table trigger
-- certain act/event (e.g. insert/update/delete) trigger certain procedure
-- not manually trigger
-- JAVA (OOP) easier to follow and higher readability
-- table trigger is a kind of functional programme (linkage between procedures not clear, hard to avoid crash)
-- limited use only