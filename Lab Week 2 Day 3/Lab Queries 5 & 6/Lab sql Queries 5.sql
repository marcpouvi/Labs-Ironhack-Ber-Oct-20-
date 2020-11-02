# 1. Drop column picture from staff
Alter table staff
drop picture

# 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

select*
from customer
where first_name IN ('TAMMY') and last_name IN ('SANDERS')

insert into sakila.staff(first_name, last_name, email, address_id, store_id, username)
values ('Tammy', 'Sanders', 'TAMMY.SANDERS@sakilacustomer.org', '79', '2', 'Tammy')

# 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1 today.

# First we select customer information Charlotte Hunter
select customer_id
from customer
Where first_name IN ('Charlotte') and last_name IN ('Hunter')

# Result: 130

#Second, staff worker Mike Hyllier
select staff_id
from staff
Where first_name IN ('Mike') and last_name IN ('Hillyer')

# Result: 1	

#Third, film id to obtain inventory_id

select film_id
from film
Where title IN ('Academy Dinosaur')

# Result: 1

select *
from inventory
Where film_id = 1;

select * from rental where customer_id=130

insert into sakila.rental(rental_date, inventory_id, customer_id, staff_id)
values (curdate(), '1', '130', '1')

#Rental id is generated authomatically and last update is linked to rental date so we don't complete it

# 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id
# email, and the date the user was deleted.

#First, we create the backup table

CREATE TABLE deleted_clients (
  `client_id` int(11) UNIQUE NOT NULL,    
  `email` text DEFAULT NULL,	  
  `date deleted user` date DEFAULT NULL,     
  CONSTRAINT PRIMARY KEY (client_id)
);

# Second, insert the information

INSERT INTO deleted_clients
select customer_id, email, curdate()
from customer
where active = 0

# Last, delete inactive users
SET SQL_SAFE_UPDATES = 0
DELETE FROM customer WHERE active = 0;



