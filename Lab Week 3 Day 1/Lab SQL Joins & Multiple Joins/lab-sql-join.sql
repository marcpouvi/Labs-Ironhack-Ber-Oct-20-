# Lab | SQL Join
# 1. List number of films per category.
Select c.name as category, count(fc.film_id) as number_of_films
from film_category fc left join category c
on fc.category_id = c.category_id
group by category

# 2. Display the first and last names, as well as the address, of each staff member.

select s.first_name as name, s.last_name, s.email, a.address
from staff s left join address a
on s.address_id = a.address_id

# 3. Display the total amount rung up by each staff member in August of 2005.

select s.first_name as name, s.last_name, count(r.rental_id) as amount_sold
from staff s left join rental r
on s.staff_id = r.staff_id
group by name, last_name

# 4. List each film and the number of actors who are listed for that film.

select f.title, count(fa.actor_id) as actors
from film f
left join film_actor fa
on f.film_id = fa.film_id
group by title

# 5. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers 
# alphabetically by last name.

select c.first_name, c.last_name, round(sum(p.amount),2) as amount_paid
from customer c
join payment p
on c.customer_id = p.customer_id
group by c.first_name, c.last_name
order by last_name




