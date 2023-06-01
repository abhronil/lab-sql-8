select * from film;
-- 1) Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, rank() over(order by length desc) from film
where length is not null and length > 0;

-- 2) Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select title,rating, rank () over(partition by rating order by length desc) from film
where length is not null and length > 0;

-- 3) How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

select count(fc.film_id),c.name 
from film_category fc
left join category c on fc.category_id=c.category_id
group by fc.category_id;

-- 4) Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select count(fa.film_id), a.first_name, a.last_name from film_actor fa
left join actor a on fa.actor_id = a.actor_id
group by fa.actor_id order by count(fa.film_id) desc
limit 1;

-- 5) Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select count(r.rental_id), c.first_name, c.last_name from rental r
left join customer c on r.customer_id = c.customer_id
group by r.customer_id order by count(r.rental_id) desc
limit 1;

-- Bonus) Which is the most rented film? (The answer is Bucket Brotherhood).
select count(r.customer_id),f.title from film f
left join inventory i on f.film_id=i.film_id
left join rental r on i.inventory_id=r.inventory_id
group by f.film_id
order by count(r.customer_id) desc
limit 1;
