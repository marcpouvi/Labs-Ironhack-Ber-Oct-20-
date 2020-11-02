#Lab sql queries 3
# 1.How many distinct (different) actors' last names are there?

select count(distinct(last_name))
from actor

# 2.In how many different languages where the films originally produced? (Use the column language_id from the film table)

select count(distinct(language_id))
from film

# 3.How many movies were released with "PG-13" rating?

select count(rating)
from film
where rating IN ('PG-13')

# 4.Get 10 the longest movies from 2006.

select title, length
from film
order by length desc
limit 10

# 5.How many days has been the company operating (check DATEDIFF() function)?

select DATEDIFF( max(rental_date), min(rental_date))
from rental


# 6.Show rental info with additional columns month and weekday. Get 20.

select*, date_format(convert(rental_date,date), '%M') as month, date_format(convert(rental_date,date), '%W') as weekday
from rental

# 7.Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

select *,
case
when date_format(convert(rental_date,date), '%W') IN ('Monday','Tuesday','Wednesday','Thursday','Friday') then 'weekday'
else 'weekend'
end 
as day_type
from rental;

# 8.How many rentals were in the last month of activity?

select max(rental_date) from rental  #2006-02-14

select count(rental_date)
from rental
where rental_date like '2006-02%'

# s/Corrections

select date(max(rental_date))- INTERVAL 30 DAY, date(max(rental_date))
from rental;

select count(*)
from rental
where date(rental_date) between date('2006-01-15') and date('2006-02-14')

# Last rental date - 30 days -- it gives you the first day of the month
# Last rental date

#Then count the rental dates between this 2 days 