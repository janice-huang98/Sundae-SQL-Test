with base_pop as
  (with pg_rentals as
  	(select distinct r.rental_id, r.rental_ts, r.customer_id, f.rating,
  	extract('year' from rental_ts) as year,
  	extract('month' from rental_ts) as month,
  	extract('day' from rental_ts) as day
  	from rental r
  	inner join inventory i
  	using (inventory_id)
  	inner join film f
  	using (film_id)
  	where rating in ('PG-13', 'PG')) --captures all PG rated, if we only want PG then where rating = 'PG'

  select pg_rentals.*, row_number() over (partition by customer_id order by rental_id asc) as rn
  from pg_rentals
  where year = 2020
  and month in (7,8)
  and day > 16
  order by customer_id asc),

active_us as
  (select distinct r.customer_id
   from rental r
   inner join customer c
   using (customer_id)
   inner join address a
   using (address_id)
   inner join city ct
   using (city_id)
-- inner join country ctry 	 	 --country schema was not available
-- using (country_id)
   where activebool)			 --is equivalent to activebook = 'true'
-- and ctry.country like '%us%') --assuming country schema is available

select count(distinct base_pop.customer_id)
from base_pop
inner join active_us
using (customer_id)
where rn >= 2
