use db_bc2405p; 

create table prac_authors(
	id integer,
    first_name varchar(50),
    last_name varchar(50),
    birth_year integer,
    nationality varchar(50)
);

create table prac_books(
	id integer,
    author_id integer,
    book_name varchar(50),
    publication_date date,
    lang varchar(50)
);

