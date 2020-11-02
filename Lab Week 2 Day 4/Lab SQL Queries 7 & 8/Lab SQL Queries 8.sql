# Activity 8
# 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, 
#length, and the rank.

select title, length, dense_rank() over (order by length asc) as 'Rank'
from film



#Selecciona el título y la durada de las películas, ponlos en un ranking según durada 

# 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
# In your output, only select the columns title, length, rating and the rank.

select title, length, rating, dense_rank() over (partition by rating order by length asc) as 'Rank'
from film


