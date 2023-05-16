
--1
select * from bill
select count(*) as bills_paid_withoutFine
from bill b
WHERE MONTH(payment_date) = 10 AND YEAR(payment_date) = 2017 AND fine_amount is not null
insert into bill values(103,54,10,2017,'2017-10-01',300,600,0,'2017-10-11',10)


--2
select count(*) as total_fine
from bill
where due_date between '2017-10-01' and '2017-11-01'


--3
select * from meter
select * from electricity_reading
EXEC sp_columns meter;
insert into electricity_reading values(201,53,'2018-05-07',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,24)
select distinct day , total_units as total_unit_perday
from electricity_reading
where day between '2018-05-06' and '2018-05-07'


--4
SELECT due_date, payment_date,  abs(DATEDIFF(day, due_date, payment_date)) AS date_difference, payable_amount
FROM bill
WHERE payment_date <= due_date;



--5
SELECT 
    DATEPART(WEEKDAY, day) AS day, 
    DATENAME(WEEKDAY, day) AS day_name, 
    AVG(total_units) AS average_consumption_daywise
FROM 
    electricity_reading
GROUP BY 
    DATEPART(WEEKDAY, day),
    DATENAME(WEEKDAY, day)
ORDER BY 
    day


--6
SELECT COUNT(*) AS bill_count
FROM bill
WHERE payment_date = '2017-09-23'

