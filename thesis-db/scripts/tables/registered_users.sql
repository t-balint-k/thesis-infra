create table registered_users
(
	id serial primary key,
	creation_time timestamp default now() not null,
	email character varying (50) not null,
	password character varying (256) not null,
	api_key character varying (32) not null
);
