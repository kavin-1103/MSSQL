
--DML excercise

create database Electricity_Bill

use Electricity_Bill 

create table electricity_connection_type (id int primary key, connection_name varchar(20))

create table slab (id int primary key, connection_type_id int,from_unit int not null,to_unit int not null, rate double precision)

alter table slab alter column connection_type_id int not null

alter table slab add constraint connection_type_id foreign key (connection_type_id) references electricity_connection_type(id)

create table building_type (id int primary key,s_name varchar(100) not null,connection_type_id int foreign key(connection_type_id) references electricity_connection_type(id) not null)

create table building (id int primary key,owner_name varchar(100) not null, s_address varchar(100) not null, building_type_id int foreign key(building_type_id) references building_type(id) not null, contact_number varchar(100) not null, email_address varchar(100))

select * from building_type
--alter table building rename column owner_name to building_owner_name

EXEC sp_rename 'building.owner_name', 'buidling_owner_name'

alter table building alter column s_address varchar(255)

alter table electricity_connection_type ADD CONSTRAINT check_connection_name CHECK (connection_name IN ('commercial', 'home'))

EXEC sp_rename 'building','building_details'

drop table slab

drop table building_details

select * from building_type

insert into electricity_connection_type values(1,'commercial')
insert into electricity_connection_type values(2,'home')

--select * from electricity_connection_type

--drop table slab

insert into slab values(11,1,100,200,350.80)
insert into slab values(12,2,200,300,650.80)
insert into slab values(13,2,300,400,780.80)


select * from slab

select * from building_type

insert into building_type values(21,'Apartment',1)
insert into building_type values(22,'Apartment',2)
insert into building_type values(23,'House',1)
insert into building_type values(24,'Villa',2)
insert into building_type values(25,'House',1)

update slab set from_unit = 1

update building_type set s_name = 'Mall' where s_name='Villa' 

truncate table slab

delete building_type where connection_type_id = 2

select * from building_type order by s_name asc

select * from building order by owner_name asc



insert into building values(31,'Kavin','14/211,Gandhi Nagar',21,'9876543214','kavin.s2020cse@sece.ac.in')
insert into building values(32,'Dharshu','19/41,Sri Nagar',25,'7896754879','dharshu.s2020cse@sece.ac.in')
insert into building values(33,'Madhu','99/100,Dindugul',23,'8786787894','madhu.s2020cse@sece.ac.in')

select * from building

create table meter(id int,meter_number varchar(100)not null, building_id int)

alter table meter add constraint meter_id primary key(id)

alter table meter alter column id int not null

create table electricity_reading (id int primary key, meter_id int foreign key (id) references meter(id), day date, h1 int not null, h2 int not null, h3 int not null, h4 int not null,h5 int not null,h6 int not null,h7 int not null,h8 int not null,h9 int not null,h10 int not null,h11 int not null,h12 int not null,h13 int not null,h14 int not null,h15 int not null,h16 int  not null,h17 int not null,h18 int not null,h19 int not null,h20 int  not null, h21 int not null, h22 int not null , h23 int not null, h24 int  not null, total_units int  not null)

drop  table electricity_reading

select * from electricity_reading

select meter_number from meter 

select owner_name , contact_number from building order by owner_name asc


select * from building


create table bill (id int primary key, meter_id int foreign key (meter_id) references meter(id), month int not null, year int not null, due_date date, total_units int not null, payable_amount float not null, is_payed tinyint, payment_date date, fine_amount float)

select total_units, payable_amount, fine_amount from bills order by total_units asc


select * from building where owner_name= 'Nicholas'


select * from bills where due_date = '2017-10-01' order by payable_amount


select owner_name, s_address, contact_number from building where email_address is null

select * from building where owner_name like 'M%' order by owner_name

select * from building where building_type_id = 2 order by owner_name

select * from electricity_reading where total_units between 500 and 1000 order by total_units

select meter_id , total_units from electricity_reading where h13<h14 order by total_units desc


--end of DML excercise




--Joins task



--1
select m.meter_number, b.owner_name,b.contact_number, bt.s_name ,ec.connection_name
from building_type bt , 
	 meter m,
	 building b
	 join building on b.building_type_id = m.id,
	 electricity_connection_type ec order by owner_name, meter_number

	 --select * from meter

--2
--select * from bill

select * from bill
left join meter on bill.id = meter.id


--3

SELECT  m.meter_number, b.owner_name, b.s_address, b.contact_number
FROM building b , meter m
left JOIN building o ON o.id = m.id
ORDER BY b.owner_name ASC, m.meter_number ASC;


--4

select ec.connection_name, s.from_unit, s.to_unit, s.rate 
from electricity_connection_type ec, slab s
join electricity_connection_type c on c.id = s.connection_type_id
order by s.rate


--5

select owner_name,s_address,count(building_type.connection_type_id)as connection_count from building 
join building_type on building_type.id = building.building_type_id
group by owner_name,s_address
order by owner_name



--6
SELECT o.owner_name, o.s_address, m.meter_number, b.payable_amount
FROM building o
JOIN meter m ON o.id = m.id
JOIN bill b ON m.id = b.meter_id
WHERE b.fine_amount = (SELECT MAX(fine_amount) FROM bill)
ORDER BY o.owner_name ASC;


--7
SELECT o.owner_name, o.s_address, m.meter_number, SUM(r.total_units) AS total_units
FROM building o
JOIN meter m ON o.id = m.id
JOIN bill r ON m.id = r.meter_id
WHERE r.payment_date BETWEEN '2017-12-01' AND '2017-12-31'
GROUP BY o.owner_name, o.s_address, m.meter_number
ORDER BY total_units DESC;


--8

SELECT b.owner_name, bt.s_name, m.meter_number , 
COALESCE(bi.payment_date, 'Not Paid Yet') AS Payment_Status
from building b
join building_type bt ON b.building_type_id = b.id
join meter m on m.id = b.building_type_id
join bill bi on bi.meter_id = m.id
order by b.owner_name


--9
select c.connection_name , count(connection_type_id) as connection_count
from electricity_connection_type c
join building_type b on b.connection_type_id = c.id
group by c.connection_name
order by connection_count


--10
SELECT m.meter_number, b.owner_name , b.s_address
from meter m
join building b on b.id=m.building_id
join bill bi on bi.meter_id = m.id
where bi.fine_amount = (SELECT MAX(fine_amount) FROM bill)
order by owner_name asc

