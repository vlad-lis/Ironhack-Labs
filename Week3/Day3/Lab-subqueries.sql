USE sakila;

#1. List all films whose length is longer than the average of all the films.
SELECT title FROM film
WHERE
	length > (SELECT avg(length) FROM film);
    
    
#2. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT count(film_id) FROM inventory
WHERE
	film_id = (SELECT film_id FROM film
			   WHERE title = 'Hunchback Impossible');
    
    
#3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name FROM actor
WHERE
	actor_id in (SELECT actor_id FROM film_actor
				 WHERE film_id = (SELECT film_id FROM film
								  WHERE title = 'Alone Trip'));
                                 

#4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
#Identify all movies categorized as family films.
SELECT title FROM film
WHERE
	film_id in (SELECT film_id FROM film_category
				WHERE category_id = (SELECT category_id FROM category
									 WHERE `name` = 'Family'));
                                     

#5. Get name and email from customers from Canada using subqueries. 
#Do the same with joins. Note that to create a join,
#you will have to identify the correct tables with their primary keys and foreign keys, 
#that will help you get the relevant information.

SELECT first_name, last_name, email FROM customer
WHERE
	address_id in (SELECT address_id FROM address
				   WHERE city_id in (SELECT city_id FROM city
									 WHERE country_id = (SELECT country_id FROM country
														 WHERE country = 'Canada')));
                                                         
SELECT first_name, last_name, email FROM customer
JOIN address using (address_id)
JOIN city using (city_id)
JOIN country using (country_id)
WHERE country = 'Canada';


-- Optional --
#6. Which are films starred by the most prolific actor? 
#Most prolific actor is defined as the actor that has acted in the most number of films. 
#First you will have to find the most prolific actor and then use that actor_id
#to find the different films that he/she starred.														
																
SELECT actor_id, count(film_id) as num FROM actor
JOIN film_actor using (actor_id)
JOIN film using (film_id)
GROUP BY actor_id
ORDER BY num DESC;  #most prolific actor's id = 107

SELECT title FROM film
WHERE film_id in (SELECT film_id FROM film_actor
				  WHERE actor_id = 107);
                 

#7. Films rented by most profitable customer. 
#You can use the customer table and payment table to find the most profitable customer,
#ie the customer that has made the largest sum of payments

SELECT customer_id, sum(amount) as total FROM customer
JOIN payment using (customer_id)
GROUP BY customer_id
ORDER BY total DESC; #most profitable customer's id = 526

SELECT title FROM film
WHERE film_id in (SELECT film_id FROM inventory
				  WHERE inventory_id in (SELECT inventory_id FROM rental
										WHERE customer_id = 526));


#8. Customers who spent more than the average payments
#(this refers to the average of all amount spent per each customer).

SELECT round(avg(spent),1) FROM 
					(SELECT sum(amount) as spent FROM payment
					 GROUP BY customer_id) as a;  #average payments = 112.5
                     

WITH spent_amounts as (SELECT customer_id, sum(amount) as spent FROM payment
					   GROUP BY customer_id
					   HAVING sum(amount) > 112.5)
                       
SELECT first_name, last_name FROM customer
WHERE customer_id in (SELECT customer_id FROM spent_amounts)
ORDER BY first_name;