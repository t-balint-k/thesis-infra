create table instrument
(
	id serial primary key,
	-- historization and validity
	valid_from date default now() not null,
	valid_to date default null null,
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

CREATE UNIQUE INDEX uix1 ON instrument (symbol, exchange, country) WHERE instrument_type in ('stocks', 'forex_pairs', 'funds', 'bonds', 'indices', 'etfs', 'commodities');
CREATE UNIQUE INDEX uix2 ON instrument (symbol, exchange, currency_base, currency_quote) WHERE instrument_type = 'cryptocurrencies';
