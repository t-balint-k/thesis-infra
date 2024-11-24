create table countries
(
	id serial primary key,
	name character varying (100) not null,
	iso3 character varying (3) not null,
	currency character varying (3) not null
);
