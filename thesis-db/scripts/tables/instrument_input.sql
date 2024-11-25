create table instrument_input
(
	id serial primary key,
	-- type
	instrument_type character varying (16) not null,
	-- meta
	symbol character varying (50) not null,
	name character varying (200) null, 
	exchange character varying (50) null,
	currency character varying (3) null,
	country character varying (100) null,
	type character varying (50) null,
	currency_base character varying (50) null,
	currency_quote character varying (50) null
);
