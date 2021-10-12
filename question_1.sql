select a.first_name, a.last_name, count(f.title) as total_films
from film f
inner join film_actor fa
using (film_id)
inner join actor a
using (actor_id)
group by a.actor_id
order by total_films desc
limit 100;
