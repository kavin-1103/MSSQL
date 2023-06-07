

--VIEW

--1
CREATE VIEW vw_customer as
select customer_id, customer_name
FROM customer

select * from vw_customer

--2
select * from customer


ALTER VIEW vw_customer AS
SELECT customer_id,customer_name
FROM customer

