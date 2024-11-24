create or replace procedure consolidate_securities()
language plpgsql as $$
begin

-- INSERT
insert into securities
(
	security_type,
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
	security_type,
	symbol,
	name,
	exchange,
	currency,
	country,
	type,
	currency_base,
	currency_quote
from
	securities_input
EXCEPT
select
	security_type,
	symbol,
	name,
	exchange,
	currency,
	country,
	type,
	currency_base,
	currency_quote
from
	securities
;

-- DELETE
update securities set
	valid_to = now(),
	available = false
where
	id in
	(
		select s.id
		from securities s
		left join securities_input i on
			s.symbol = i.symbol and
			s.exchange = i.exchange and
			coalesce(s.name, 'NULL') 			= coalesce(i.name, 'NULL') 			and
			coalesce(s.currency, 'NULL') 		= coalesce(i.currency, 'NULL') 	and
			coalesce(s.type, 'NULL') 			= coalesce(i.type, 'NULL') 			and
			coalesce(s.currency_base, 'NULL')	= coalesce(i.currency_base, 'NULL') and
			coalesce(s.currency_quote, 'NULL')	= coalesce(i.currency_quote, 'NULL')
		where
			s.available = true and
			i.id is null
	)
;

end $$;
