#1. Write a query to display for each store its store ID, city, and country.
SELECT store.store_id, city.city, country.country
FROM store
JOIN address using (address_id)
JOIN city using (city_id)
JOIN country using (country_id);


#2. Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, sum(payment.amount) as 'brought in'
FROM store
JOIN staff using (store_id)
JOIN payment using (staff_id)
GROUP BY store.store_id;


#3. What is the average running time(length) of films by category?
SELECT 
	category.`name` as 'name', 
    round(avg(film.length), 2) as 'avg length'
FROM category
JOIN film_category using (category_id)
JOIN film using (film_id)
GROUP BY category.`name`;


#4. Which film categories are longest(length) (find Top 5)? (Hint: You can rely on question 3 output.)
SELECT 
	category.`name` as 'name', 
    round(avg(film.length), 2) as avglength
FROM category
JOIN film_category using (category_id)
JOIN film using (film_id)
GROUP BY category.`name`
ORDER BY avglength DESC
LIMIT 5;


#5. Display the top 5 most frequently(number of times) rented movies in descending order.
SELECT film.title
FROM film
JOIN inventory using (film_id)
JOIN rental using (inventory_id)
GROUP BY film.title
HAVING count(rental.rental_id)
ORDER BY count(rental.rental_id) DESC
LIMIT 5;


#6. List the top five genres in gross revenue in descending order.
SELECT category.`name`, sum(payment.amount) as revenue
FROM category
JOIN film_category using (category_id)
JOIN inventory using (film_id)
JOIN rental using (inventory_id)
JOIN payment using (rental_id)
GROUP BY category.`name`
ORDER BY revenue DESC
LIMIT 5;


#7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT film.title, rental.rental_date, rental.return_date
FROM film
JOIN inventory using (film_id)
JOIN rental using (inventory_id)
WHERE film.title = 'Academy Dinosaur'
ORDER BY rental.rental_date DESC
LIMIT 1;