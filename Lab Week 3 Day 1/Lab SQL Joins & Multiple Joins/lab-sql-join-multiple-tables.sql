#lab sql join multiple tables

# 1. Write a query to display for each store its store ID, city, and country.

select store.store_id, city.city, country.country
from store 
join address
on store.address_id = address.address_id
join city
on address.city_id = city.city_id
join country
on city.country_id = country.country_id

# 2. Write a query to display how much business, in dollars, each store brought in

# store id --- store
# business -- amount 
# connection--- store_id linked with payment by manager_staff_id

select s.store_id, round(sum(p.amount),2) as business
from store s
left join payment p
on s.manager_staff_id = p.staff_id
group by s.store_id

# 3. What is the average running time of films by category?

select c.name, round(avg(f.length),2) as average_length
from category c
join film_category fc
on c.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
group by name

# 4. Which film categories are longest?

select c.name, round(avg(f.length),2) as average_length
from category c
join film_category fc
on c.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
group by name
order by average_length desc

# 5. Display the most frequently rented movies in descending order.

select title, count(*) as 'rental frequency'
from sakila.film
join (sakila.inventory join sakila.rental using (inventory_id))
using (film_id)
group by title
order by 'rental frequency' desc;

# 6. List the top five genres in gross revenue in descending order.

select name, category_id, sum(amount) as 'gross revenue'
from sakila.payment
join (sakila.rental join (sakila.inventory join (sakila.film_category join sakila.category using (category_id)) using (film_id)) using (inventory_id)) using (rental_id)
group by category_id
order by 'gross revenue' desc
limit 5;

# 7. Is "Academy Dinosaur" available for rent from Store 1?

select film.film_id, film.title, store.store_id, inventory.inventory_id
from sakila.inventory
join sakila.store using (store_id)
join sakila.film using (film_id)
where film.title = 'Academy Dinosaur' and store.store_id = 1;

select inventory.inventory_id
from sakila.inventory join sakila.store using (store_id)
     join sakila.film using (film_id)
     join sakila.rental using (inventory_id)
where film.title = 'Academy Dinosaur'
      and store.store_id = 1
      and not exists (select * from sakila.rental
                      where rental.inventory_id = inventory.inventory_id
                      and rental.return_date is null);