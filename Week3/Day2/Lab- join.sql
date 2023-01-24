#1. Which actor has appeared in the most films?
SELECT a.actor_id, a.first_name, a.last_name, count(b.actor_id)
FROM actor as a 
JOIN film_actor as b
ON a.actor_id = b.actor_id
GROUP BY actor_id
ORDER BY count(b.actor_id) DESC
LIMIT 1;


#2. Most active customer (the customer that has rented the most number of films)
SELECT a.customer_id, a.first_name, a.last_name, count(b.rental_id)
FROM customer as a
JOIN rental as b
ON a.customer_id = b.customer_id
GROUP BY customer_id
ORDER BY count(b.rental_id) DESC
LIMIT 1;


#3. List number of films per category.
SELECT a.`name`, count(b.category_id)
FROM category as a
JOIN film_category as b
ON a.category_id = b.category_id
GROUP BY a.`name`
ORDER BY a.`name`;


#4. Display the first and last names, as well as the address, of each staff member.
SELECT a.first_name, a.last_name, b.address
FROM staff as a
JOIN address as b
ON a.address_id = b.address_id;


#5. Get films titles where the film language is either English or italian, 
#and whose titles starts with letter "M" , sorted by title descending.
SELECT a.title, b.`name`
FROM film as a
JOIN `language` as b
ON a.language_id = b.language_id
WHERE
	left(a.title, 1) in ('M','m') and b.`name` in ('Italian', 'English')
ORDER BY a.title DESC;


#6. Display the total amount rung up by each staff member in August of 2005.
SELECT a.first_name, a.last_name, sum(b.amount) as total
FROM staff as a
JOIN payment as b
ON a.staff_id = b.staff_id
WHERE left(b.payment_date, 7) = '2005-08'
GROUP BY a.staff_id
ORDER BY total DESC;


#7. List each film and the number of actors who are listed for that film.
SELECT a.title, count(b.actor_id) as num
FROM film as a
JOIN film_actor as b
ON a.film_id = b.film_id
GROUP BY a.title
ORDER BY num DESC;


#8. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
#List the customers alphabetically by last name.
SELECT a.first_name, a.last_name, sum(b.amount) as total
FROM customer as a
JOIN payment as b
ON a.customer_id = b.customer_id
GROUP BY a.customer_id
ORDER BY a.last_name;


#9. Write sql statement to check if you can find any actor who never particiapted in any film.
SELECT actor_id
FROM film_actor
WHERE film_id <= 0 or film_id = null;


#10. Get the addresses that have NO customers, and ends with the letter "e"
SELECT 
	a.address,
    sum(CASE WHEN b.customer_id is null then 1 else 0 end) as customers
FROM address as a
JOIN customer as b
WHERE right(a.address, 1) = 'e'
GROUP BY a.address
ORDER BY sum(CASE WHEN b.customer_id is null then 1 else 0 end) DESC;


#Optional: what is the most rented film?
SELECT f.title, count(r.rental_id) as rentals
FROM film as f
JOIN inventory as i ON f.film_id = i.film_id
JOIN rental as r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rentals DESC
LIMIT 1;