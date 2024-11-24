create table tranzactions
(
	id serial primary key,
	portfolio_fk int not null,
	security_fk int not null,
	creation_time timestamp default now() not null,
	amount numeric(14, 4) not null,
	price numeric(14, 4) not null
);
