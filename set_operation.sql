
--1

select * 
from salesman
where city='London'
union
select *
from customer
where city='London'


--2

select distinct salesman_name,cities 
from salesman
union
select distinct salesman_name,cities 
from customer


--3

SELECT *
FROM Salesman
UNION
SELECT *
FROM Customer;


--4

SELECT order_date, salesman_id, MAX(order_amount) AS largest_order
FROM orders 
GROUP BY order_date, salesman_id

UNION

SELECT order_date, salesman_id, MIN(order_amount) AS smallest_order
FROM orders 
GROUP BY order_date, salesman_id


--5
SELECT s.salesman_name, s.city, 'Has Customers' AS status
FROM Salesman s
INNER JOIN Customer c ON s.city = c.city
UNION
SELECT s.salesman_name, s.city, 'No Customers' AS status
FROM Salesman s
WHERE s.city NOT IN (SELECT DISTINCT city FROM Customer)

