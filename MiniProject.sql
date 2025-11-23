-- Phase 1: Foundation & Inspection
-- List all unique pizza categories (DISTINCT).
select DISTINCT category from pizza_types;
-- Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". Show first 5 rows.
select pizza_type_id,name,COALESCE(ingredients,'Missing Data') as ingredients from pizza_types LIMIT 5;
-- Check for pizzas missing a price (IS NULL).
select pizza_type_id,size,price from pizzas WHERE price IS NULL; 
-- answer: No pizza with empty price


-- Phase 2: Filtering & Exploration
-- Orders placed on '2015-01-01' (SELECT + WHERE).
select * from orders where date='2015-01-01';
-- 2. List pizzas with `price` descending.
select * from pizzas ORDER BY price DESC;
-- 3. Pizzas sold in sizes `'L'` or `'XL'`.
select * from pizzas WHERE size IN ('L','XL');
-- 4. Pizzas priced between $15.00 and $17.00.
select * from pizzas WHERE price>15.00 and price <17.00;
select * from pizzas WHERE price between 15.00 and 17.00;
-- 5. Pizzas with `"Chicken"` in the name.
select * from pizza_types WHERE name like '%Chicken%';
-- 6. Orders on `'2015-02-15'` or placed after 8 PM.
select * from orders WHERE date='2015-02-15' OR time > '20:0:0';


-- **Phase 3: Sales Performance**

-- 1. Total quantity of pizzas sold (`SUM`).
select sum(quantity) as Total_pizzas_sold from order_details ;
-- 2. Average pizza price (`AVG`).
select AVG(price) as AVG_pizza_price from pizzas;
-- 3. Total order value per order (`JOIN`, `SUM`, `GROUP BY`).
select od.order_id ,SUM(od.quantity * p.price) as total_oder_value_per_order 
from order_details od left join pizzas p ON od.pizza_id = p.pizza_id 
GROUP BY od.quantity,od.order_id ORDER BY od.order_id ASC;

-- 4. Total quantity sold per pizza category (`JOIN`, `GROUP BY`).
select SUM(od.quantity)as total_quantity_sold ,pt.category as pizza_category 
from order_details od 
left join pizzas p ON od.pizza_id = p.pizza_id  
left join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by pt.category

-- 5. Categories with more than 5,000 pizzas sold (`HAVING`).
select SUM(od.quantity)as total_quantity_sold ,pt.category as pizza_category 
from order_details od 
left join pizzas p ON od.pizza_id = p.pizza_id  
left join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by pt.category
Having  SUM(od.quantity)>5000;

-- 6. Pizzas never ordered (`LEFT/RIGHT JOIN`).
SELECT p.pizza_id
FROM order_details od
LEFT JOIN pizzas p ON p.pizza_id = od.pizza_id
WHERE p.pizza_id is NULL

-- 7. Price differences between different sizes of the same pizza (`SELF JOIN`).
SELECT 
    p1.pizza_type_id,
    p1.size AS size_1,
    p1.price AS price_1,
    p2.size AS size_2,
    p2.price AS price_2,
    ABS((p2.price - p1.price)) AS price_difference1,
	p3.size as size_3,
	p3.price as prize_3,
	ABS((p2.price - p3.price)) AS price_difference2
FROM pizzas p1
JOIN pizzas p2 ON p1.pizza_type_id = p2.pizza_type_id AND p1.size < p2.size
JOIN pizzas p3 ON p1.pizza_type_id = p3.pizza_type_id AND p2.size < p3.size
