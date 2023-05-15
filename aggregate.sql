
--1

SELECT SUM(purchase_amount) as total_purchase_amount 
FROM orders;


--2
SELECT AVG(purchase_amount) AS avg_purchase_amount
FROM orders;


--3

SELECT salesman_id, COUNT(*) AS num_customers
FROM customer
GROUP BY salesman_id;


--4

SELECT COUNT(cust_name) AS total_customers FROM customer


--5

SELECT COUNT(*) as num_customers
FROM customer
WHERE gradation IS NOT NULL;


--6
select max(purchase_amount) as Maximum_Amount from customers


--7
select min(purchase_amount) as Minimum_Amount from customers


--8

SELECT distinct city, MAX(grade) AS highest_grade
FROM customer
GROUP BY city;


--9
SELECT 
    customer_id, 
    order_date, 
    MAX(purchase_amount) AS highest_purchase_amount
FROM 
    orders 
WHERE 
    purchase_amount BETWEEN 2000 AND 6000
GROUP BY 
    customer_id, order_date



--10

select avg(pro_price) as Average_Amount 
from item_mast


--11

SELECT dept_code, SUM(allotment_amount) as total_allotment
FROM emp_department
GROUP BY dept_code


--12
SELECT d.department_code, COUNT(emp_id) AS num_employees
FROM emp_details, emp_department d
GROUP BY department_code;

