create or replace procedure consolidate_instruments()
language plpgsql as $$
begin

-- INSERT
insert into instrument
(
	instrument_type,
	symbol,
	name,
	exchange,
	currency,
	country,
	type,
	currency_base,
	currency_quote
)
select
	instrument_type,
	symbol,
	name,
	exchange,
	currency,
	country,
	type,
	currency_base,
	currency_quote
from
	instrument_input
EXCEPT
select
	instrument_type,
	symbol,
	name,
	exchange,
	currency,
	country,
	type,
	currency_base,
	currency_quote
from
	instrument
;

-- DELETE
update instrument set
	valid_to = now()
where
	valid_to is null and
	id not in
	(
		select
			t0.id
		from
			instrument t0
		inner join instrument_input t1	on
			t0.symbol = t1.symbol		and
			t0.exchange = t1.exchange	and
			coalesce(t0.name, 'NULL')			= coalesce(t1.name, 'NULL')				and
			coalesce(t0.currency, 'NULL')		= coalesce(t1.currency, 'NULL')			and
			coalesce(t0.type, 'NULL')			= coalesce(t1.type, 'NULL')				and
			coalesce(t0.currency_base, 'NULL')	= coalesce(t1.currency_base, 'NULL')	and
			coalesce(t0.currency_quote, 'NULL')	= coalesce(t1.currency_quote, 'NULL')
		where
			t0.valid_to is null
	)
;

end $$;
