# Lab | Aggregation Revisited


# 1. Select the first name, last name, and email address of all the customers who have rented a movie.

SELECT distinct(CONCAT(c.first_name, " ", c.last_name)) as Full_Name, c.email
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
WHERE c.customer_id = r.customer_id;

# 2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

Select c.customer_id, CONCAT(c.first_name, " ", c.last_name) as Full_Name, round(avg(p.amount),2) as Average_Amount
from customer c
join payment p
on c.customer_id = p.customer_id
group by 1
order by 3 desc;


# Select the name and email address of all the customers who have rented the "Action" movies.
# Write the query using multiple join statements

select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;

# Write the query using sub queries with multiple WHERE clause and IN condition

SELECT DISTINCT(CONCAT(first_name, ' ', last_name)) AS customer_name, email
FROM sakila.customer
WHERE customer_id IN
(
	SELECT customer_id
    FROM sakila.rental
    WHERE inventory_id IN
	(
		SELECT inventory_id
		FROM sakila.inventory
		WHERE film_id IN
		(
			SELECT film_id
			FROM sakila.film_category
			WHERE category_id = 1
        )
	)
);

# Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

SELECT * ,
CASE
WHEN amount > 0 AND amount < 2 THEN 'Low'
WHEN amount > 2 AND amount < 4 THEN 'Medium'
ELSE 'High'
END as Value_Transactions
FROM payment;