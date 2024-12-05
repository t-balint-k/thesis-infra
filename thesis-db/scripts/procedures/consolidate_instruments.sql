create or replace procedure consolidate_instruments()
/*
	A pénzügyi eszközök konszolidációjára azért van szükség, hogy amennyiben
	a külső szolgáltató egy rekordot eltávolít a saját adatbázisából, például
	azért, mert az adott eszközt kivezették a tőzsdéről, úgy a webszerver
	adatbázisából az ne tűnjön el nyomtalanul, hiszen szerepelhet megannyi
	portfolióban, mert idegen kulcs.

	A webszerver által lekérdezett adatok az "_input" utótaggal ellátott táblába
	érkeznek meg. Onnan kerülnek bedolgozásra a valós paraméter táblába. Ennek
	során a két tábla rekordjai összevetésre kerülnek. Amennyiben egy rekord
	törlésre került, vagy módosult valamely mezője, úgy a rekord lezárásra
	(logikai törlésre) kerül a törzsadat táblában. Ezt követően az alkalmazásban
	már nem kereshető. Amennyiben egy instrumentum újonnan jelenik meg, vagy
	újabb módosulata érkezett az input táblába, úgy a törzsadat táblában új
	rekord képződik.

	Ez a folyamat ütemezetten, az input tábla töltését követően indul el.
*/
language plpgsql as $$
begin

/*
	1.	Új instrumentumok, illetve új módosulatok új rekordokat képeznek a
		táblában.
*/

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

/*
	2.	Törölt instrumentumok, illetve elavult módosulatok lezárásra, azaz
		logikai törlésre kerülnek.
*/

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
			t0.symbol = t1.symbol and
			t0.instrument_type = t1.instrument_type and
			coalesce(t0.name, 'NULL')			= coalesce(t1.name, 'NULL')				and
			coalesce(t0.exchange, 'NULL')		= coalesce(t1.exchange, 'NULL')			and
			coalesce(t0.currency, 'NULL')		= coalesce(t1.currency, 'NULL')			and
			coalesce(t0.country, 'NULL')		= coalesce(t1.country, 'NULL')			and
			coalesce(t0.type, 'NULL')			= coalesce(t1.type, 'NULL')				and
			coalesce(t0.currency_base, 'NULL')	= coalesce(t1.currency_base, 'NULL')	and
			coalesce(t0.currency_quote, 'NULL')	= coalesce(t1.currency_quote, 'NULL')
		where
			t0.valid_to is null
	)
;

end $$;
