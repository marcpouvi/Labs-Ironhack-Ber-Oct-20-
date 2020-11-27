# In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. Convert the query into a simple stored procedure. Use the following query:	


delimiter //
create procedure proc_is_action_movie
#give a logical name to you
(out param1 varchar(50), out param3 varchar(100))
#outcome and then in what form
begin
select first_name, last_name, email
from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = 'Action'
  group by first_name, last_name, email;
  end;
//
delimiter ;


# Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.

drop procedure if exists proc_is_action_movie;
delimiter //
create procedure proc_is_action_movie (IN param1 tinyint(1))
begin
 select first_name, last_name, email
  from customer
  where active= param1; 
end; 
// delimiter ;

call proc_is_action_movie(1);


# Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. Pass that number as an argument in the stored procedure.

select category.name, count(count_of_category) as category_counts
from film
join film_category using (film_id)
join category using (category_id)
join (select count(*) as count_of_category, category_id
from film_category fc
group by category_id)sub using (category_id)
group by category.name;

# convert to a stored proc with a param value 
 #HINT : insert an IN param2 int into your initial definition of the stored procedure, and a clause into the query 
 #where category_counts > param2
 # before calling the procedure with that param 
