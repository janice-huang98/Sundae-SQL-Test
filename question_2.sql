select c.name, count(f.title) as total_films
from film f
inner join film_category fc
using (film_id)
inner join category c
using (category_id)
where c.name not in ('Sports', 'Games')
group by c.name --group by category_id would work too
order by total_films desc;
