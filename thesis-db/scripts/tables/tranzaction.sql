create table tranzaction
(
	id serial primary key,
	creation_time timestamp default now() not null,
	portfolio_fk int not null,
	instrument_fk int not null,
	amount numeric(14, 4) not null,
	price numeric(14, 4) not null,
	rate numeric(14, 4) not null,
	
	constraint fk1 foreign key (portfolio_fk) references portfolio (id) ON DELETE CASCADE,
	constraint fk2 foreign key (instrument_fk)  references instrument (id)
);
