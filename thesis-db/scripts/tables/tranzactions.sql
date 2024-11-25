create table tranzactions
(
	id serial primary key,
	portfolio_fk int not null,
	security_fk int not null,
	creation_time timestamp default now() not null,
	amount numeric(14, 4) not null,
	price numeric(14, 4) not null,
	
	constraint fk2 foreign key (portfolio_fk) references portfolios (id),
	constraint fk1 foreign key (security_fk)  references securities (id)
);
