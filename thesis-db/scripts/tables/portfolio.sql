create table portfolio
(
	id serial primary key,
	creation_time timestamp default now() not null,
	user_fk int not null,
	name character varying (50) not null,
	pool numeric(14, 4) not null,
	currency character varying (3) not null,
	
	constraint fk1 foreign key (user_fk) references registered_user (id)
);
