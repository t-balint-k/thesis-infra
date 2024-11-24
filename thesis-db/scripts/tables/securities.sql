create table securities
(
	id serial,
	-- historization and validity
	valid_from date default now() not null,
	valid_to date default null null,
	available boolean default true not null,
	-- type
	security_type character varying (16) not null,
	-- meta
	symbol character varying (50) not null,
	name character varying (200) null,
	exchange character varying (50) null,
	currency character varying (3) null,
	country character varying (100) null,
	type character varying (50) null,
	currency_base character varying (50) null,
	currency_quote character varying (50) null,

	primary key (id, available)
)
partition by list (available);

CREATE TABLE securities_alive PARTITION OF securities FOR VALUES IN (true);
CREATE TABLE securities_dead PARTITION OF securities FOR VALUES IN (false);

CREATE UNIQUE INDEX uix1 ON securities_alive (symbol, exchange, country) WHERE security_type in ('stocks', 'forex_pairs', 'funds', 'bonds', 'indices', 'etfs', 'commodities');
CREATE UNIQUE INDEX uix2 ON securities_alive (symbol, exchange, currency_base, currency_quote) WHERE security_type = 'cryptocurrencies';
