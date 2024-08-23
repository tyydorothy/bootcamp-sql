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


 