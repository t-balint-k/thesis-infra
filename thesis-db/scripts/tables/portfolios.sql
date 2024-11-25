create table portfolios
(
	id serial primary key,
	user_fk int not null,
	creation_time timestamp default now() not null,
	name character varying (50) not null,
	pool numeric(14, 4) not null,
	currency character varying (3) not null,
	
	constraint fk1 foreign key (user_fk) references registered_users (id)
);
