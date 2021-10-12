/*Sports, actions, scifi, family, drama, animation has the most rentals, revenue, and
distinct customers renting movies all time. Stores should focus on selling/renting
films in these genres to grow and scale their business.
*/
with base_pop as
(select distinct r.rental_id, r.rental_ts, r.customer_id, f.rating, c.name as genre, p.amount,
  	extract('year' from rental_ts) as year,
  	extract('month' from rental_ts) as month,
  	extract('day' from rental_ts) as day
  	from rental r
  	inner join inventory i
  	using (inventory_id)
  	inner join film f
  	using (film_id)
  	inner join film_category fc
  	using (film_id)
  	inner join category c
  	using (category_id)
  	inner join payment p
    using (rental_id))

select genre,
count(rental_id) as total_rentals,
coalesce(sum(amount),0) as total_revenue,
count(distinct customer_id) as number_of_individuals
from base_pop
group by 1
order by
--total_rentals desc
--total_revenue desc
number_of_individuals desc
limit 10;

/* If you look at when the movie rental industry receives the most revenue,
rentals, and distinct customers, June, July and August seems to be the peak months
*/

with base_pop as
(select distinct r.rental_id, r.rental_ts, r.customer_id, f.rating, c.name as genre, p.amount,
  	extract('year' from rental_ts) as year,
  	extract('month' from rental_ts) as month,
  	extract('day' from rental_ts) as day
  	from rental r
  	inner join inventory i
  	using (inventory_id)
  	inner join film f
  	using (film_id)
  	inner join film_category fc
  	using (film_id)
  	inner join category c
  	using (category_id)
  	inner join payment p
    using (rental_id))

select month,
count(rental_id) as total_rentals,
coalesce(sum(amount),0) as total_revenue,
count(distinct customer_id) as number_of_individuals
from base_pop
where year = 2020
group by 1
order by
total_rentals desc,
total_revenue desc,
number_of_individuals desc


/* When you look at the monthly data for total rentals, revenue, and distinct customers
for each genre, you'll notice that sports is highly seasonal as it generates the most revenue
in the movie rental industry during peak months July and August.

My recommendation to promote sales is to promote other genres during the peak season, such as actions,
scifi, family, drama and animation. Since most customers are already at the stores in peak seasons
beginning in May, stores can upsell or cross sell other movies to retain and extend customer lifetime.
*/
with base_pop as
(select distinct r.rental_id, r.rental_ts, r.customer_id, f.rating, c.name as genre, p.amount,
  	extract('year' from rental_ts) as year,
  	extract('month' from rental_ts) as month,
  	extract('day' from rental_ts) as day
  	from rental r
  	inner join inventory i
  	using (inventory_id)
  	inner join film f
  	using (film_id)
  	inner join film_category fc
  	using (film_id)
  	inner join category c
  	using (category_id)
  	inner join payment p
    using (rental_id))

select genre, month,
count(rental_id) as total_rentals,
coalesce(sum(amount),0) as total_revenue,
count(distinct customer_id) as number_of_individuals
from base_pop
where year = 2020
group by 1,2
order by
--total_rentals desc
--total_revenue desc
month asc,
number_of_individuals desc
