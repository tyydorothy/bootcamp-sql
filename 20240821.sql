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

insert into students (id, name, weight,height) values (1, 'Alice Au',99.9,150);
insert into students (id, name, weight,height) values (2, 'Bobo Bun',40.8,152.23);
insert into students (id, name, weight,height) values (3, 'Ceci Cheung',50.54,164.02);
insert into students (id, name, weight,height) values (4, 'Doris Don',60.27,153.10);
insert into students (id, name, weight,height) values (5.2, 1234,65,170); -- id rounded off to 6 -- will be rejected in oracle
insert into students (id, name, weight,height) values (5.5, 'Eris Egg',65,170); -- id rounded off to 6 -- will be rejected in oracle



select * from students;
select * from students where weight >= 60;




-- create table with datetime, integer, numeric, varchar

 