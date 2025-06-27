create database pizzahut;
use pizzahut;


create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id) );


create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id) );


SELECT COUNT(DISTINCT order_id) AS total_orders FROM orders;


SELECT pizza_id, SUM(quantity) AS total_quantity
FROM order_details
GROUP BY pizza_id
ORDER BY total_quantity DESC
LIMIT 5;


SELECT pizza_id, SUM(quantity * price) AS revenue
FROM order_details
JOIN pizza USING(pizza_id)
GROUP BY pizza_id
ORDER BY revenue DESC;


SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(quantity * price) AS monthly_revenue
FROM orders
JOIN order_details USING(order_id)
JOIN pizza USING(pizza_id)
GROUP BY month
ORDER BY month;


SELECT pizza_type.category, SUM(quantity * price) AS total_revenue
FROM order_details
JOIN pizza USING(pizza_id)
JOIN pizza_type ON pizza.pizza_type_id = pizza_type.pizza_type_id
GROUP BY pizza_type.category;



SELECT category, AVG(price) AS avg_price
FROM pizza
JOIN pizza_type USING(pizza_type_id)
GROUP BY category;



SELECT pizza_id, SUM(quantity * price) AS total_revenue
FROM order_details
JOIN pizza USING(pizza_id)
GROUP BY pizza_id
HAVING total_revenue = (
  SELECT MAX(total_rev) FROM (
    SELECT SUM(quantity * price) AS total_rev
    FROM order_details
    JOIN pizza USING(pizza_id)
    GROUP BY pizza_id
  ) AS temp
);