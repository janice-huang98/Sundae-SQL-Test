with base_pop as
  (select extract('day' from r.rental_ts) as day, avg(f.rental_rate) as avg_rental_rate
  from rental r
  inner join inventory i
  using (inventory_id)
  inner join film f
  using (film_id)
  where rental_ts between '2020-08-01' and '2020-08-31'
  group by day
  order by day asc),

date as
  (select distinct extract('day' from date) as day_proxy
  from dates
  where year = 2020
  and month = 8
  order by day_proxy asc),

final_agg as
  (select date.day_proxy, case when avg_rental_rate is null then 0 else avg_rental_rate end as avg_rental_rate --coalesce(avg_rental_rate,0) created an error, using case statement as workaround
  from base_pop
  right join date
  on base_pop.day = date.day_proxy
  order by date.day_proxy asc)

select final_agg.*,
round(avg(avg_rental_rate) over (order by day_proxy rows between 6 preceding and current row),2) as rolling_avg_rental_rate
from final_agg

--I used the daily average rental rate tied to the rental_ts date in rental table as the base for the rolling avg.
