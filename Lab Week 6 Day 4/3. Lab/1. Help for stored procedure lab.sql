# simple query 

use sakila; 

 select first_name, last_name, email
  from customer
  where active= 0
;

#convert to stored procedure 

drop procedure if exists customer_info_inactive;
delimiter //
create procedure customer_info_inactive ()
begin
 select first_name, last_name, email
  from customer
  where active= 0; 
end; 
// delimiter ; 

call customer_info_inactive();

#make it more dynamic - replace inactive with either active or inactive 


drop procedure if exists customer_info_status;
delimiter //
create procedure customer_info_status (IN param1 tinyint(1))
begin
 select first_name, last_name, email
  from customer
  where active= param1; 
end; 
// delimiter ; 

#try running this with status 1 (ie active)
call customer_info_status(1);

# create a query with a count of films per category - we will later use this with a quantifiable parameter

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