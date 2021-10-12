with base_pop as
  (select distinct r.rental_id, r.rental_ts, extract('week' from rental_ts) as week, r.customer_id, a.address, p.amount, p.payment_ts
  from rental r
  inner join inventory i
  using (inventory_id)
  inner join store s
  using (store_id)
  inner join address a
  using (address_id)
  inner join payment p
  using (rental_id)
  where address = '47 MySakila Drive'
  order by rental_id asc),

date as
  (select distinct extract('week' from date) as week_proxy
  from dates
  where year = 2020
  order by week_proxy asc),

final_agg as
  (select date.week_proxy, base_pop.week, count(rental_id) as total_rentals, coalesce(sum(amount),0) as total_revenue, count(distinct customer_id) as number_of_individuals
  from base_pop
  right join date
  on base_pop.week = date.week_proxy
  where week_proxy between 24 and 35
  group by date.week_proxy, base_pop.week
  order by date.week_proxy, base_pop.week asc)

select row_number() over (order by week_proxy asc) as week_number, total_rentals, total_revenue, number_of_individuals
from final_agg
