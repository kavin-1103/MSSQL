

--1
SELECT order_number, order_date, purchase_amount
FROM Orders
WHERE salesman_id = 5001;


--2
select *
from customers
where grade>100


--3
select *
from customers
where city='New York' and grade>100


--4
select * 
from customer
where city='New York' or grade>100


--5
select *
from customer
where city='New York' or not grade>100


--6
select salesman_id, name, city, commission
from salesman
where commission between 0.10 and 1.12


--7
SELECT *
FROM orders
WHERE purchase_amount < 200 OR (order_date <= '2012-02-10' AND customer_id >= 3009)


--8

select * 
from emp_details
where emp_lname in ('Donsi','Mardy')
