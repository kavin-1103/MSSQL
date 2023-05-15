

--1
SELECT * 
FROM salesman 
WHERE city = 'Paris' OR city = 'Rome';


--2
SELECT *
FROM my_table
WHERE city NOT IN ('Paris', 'Rome');

--3

Select salesman_id, name, city, commission
from salesman
where city not in('Paris','Rome')


--4
SELECT *
FROM customers
WHERE ID IN (3007, 3008, 300)
ORDER BY ID;


--5

Select * 
from salesman
where commission between 0.12 and 0.14


--6

select * 
from orders
where purchase_amount between 500 and 400 
and purchase_amount not between 948.50 and 983.43


--7
select * 
from customer
where customer_name like '%n'
 
