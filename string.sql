
--1
SELECT owner_name, len(owner_name) AS name_length
FROM building
ORDER BY owner_name ASC;


--2
SELECT owner_name, contact_number
FROM building
WHERE len(owner_name) = (SELECT MIN(LEN(owner_name)) FROM building)
ORDER BY owner_name ASC;


--3

SELECT owner_name, CONCAT(contact_number, ' - ', email_address) AS Contact_details
FROM building
ORDER BY owner_name DESC;


--4

SELECT *
FROM building
WHERE owner_name LIKE '%ad%'
ORDER BY owner_name ASC;


--5

SELECT LEFT(owner_name, 3) AS name_code, contact_number
FROM building
ORDER BY owner_name ASC;
