-- 1. We need a complete list of our suppliers to update our contact records. Can you pull all the information from the suppliers' table?(done)
select * from suppliers;
SELECT supplierId, supplierName, contactName, phone,Address
FROM suppliers
ORDER BY supplierName;
show tables;
-- 2. Our London sales team wants to run a local promotion. Could you get a list of all customers based in London?(done)
 select * from customers;
select CustomerID, CustomerName,  ContactName,City,PostalCode
from customers
where city='london'
order by CustomerName asc;

-- 3. For our new 'Luxury Items' marketing campaign, I need to know our top 5 most expensive products.(done)
select * from products;
SELECT productName, price
FROM products
ORDER BY price DESC
LIMIT 5;
-- 4. HR is planning a professional development program for our younger employees. Can you provide a list of all employees born after 1965?(done)
select * from employees;
select EmployeeId, firstName ,birthDate
from employees
where birthDate >='1966-01-01';


-- 5. A customer is asking about our 'Chef' products but can't remember the full name. Can you search for all products that have 'Chef' in their title?(done)
select * from products;
select productID, ProductName 
from products
where productName like 'Chef%';
-- 6. We need a report that shows every order and which customer placed it. Can you combine the order information with the customer's name?(done)
select * from customers;
select * from orders;
SELECT o.orderID,o.orderDate,c.CustomerID,c.CustomerName,c.ContactName, Address
FROM orders o
INNER JOIN customers c
ON 
o.customerId = c.customerID
ORDER BY o.orderID DESC;


-- 7. To organize our inventory, please create a list that shows each product and the name of the category it belongs to.(done)
select * from categories;
select * from products;
select p.productName,p.CategoryID,CategoryName
from products p 
join categories c 
on
c. CategoryID=p.CategoryID; 

-- 8. We want to promote products sourced from the USA. Can you list all products provided by suppliers located in the USA?(done)
select * from products;
select * from suppliers;
select p.productName,s.Country
from products p 
join suppliers s 
on 
 p.SupplierID=s.SupplierID
 where s.country= 'USA';



-- 9. A customer has a query about their order. We need to know which employee was responsible for it.
-- Can you create a list of orders with the corresponding employee's first and last name?(done)
select * from employees;
select * from orders;
select  o. orderID, e. firstName, e. lastName
from employees e 
join orders o 
on  
o.EmployeeId= e.EmployeeID;

-- 10. To help with our international marketing strategy, I need a count of how many customers we have in each country, sorted from most to least.(done)
select * from customers;
select count(customerID) as total_customers
from customers
order by total_customers asc;

-- 11. Let's analyze our pricing. What is the average product price within each product category?(done)
select * from products;
select * from categories;
SELECT c. categoryName,
    AVG(p.price) AS average_price
FROM products p
join  categories c 
on 
c.CategoryID= p.CategoryID
GROUP BY c.CategoryName
ORDER BY c.CategoryName;

-- 12. For our annual performance review, can you show the total number of orders handled by each employee?(done)
select * from employees;
select * from orders;
select e.FirstName,count(o.orderID)as total_orders
from employees e 
 left join  orders o
on 
o.employeeID = e.employeeID 
group by e.FirstName;

-- 13. We want to identify our key suppliers. Can you list the suppliers who provide us with more than three products?(done)
select* from suppliers;
select * from products;

select s.supplierID, count(p.productID) as p_count
from suppliers s
join products p 
on 
 p.SupplierID= s.SupplierID
 group by s.supplierID
 having count(p.productID)>3
 order by p_count desc;

-- 14. Finance team needs to know the total revenue for order 10250.(done)
select * from orders;
select * from orderdetails;
select * from product;
 select od. orderId, sum(od. quantity*p.Price) as total_price
 from orderdetails od
 join products p 
 on 
 od. productID=p.productID
 where od. orderID = 10250
 group by od.orderID;

-- 15. What are our most popular products? I need a list of the top 5 products based on the total quantity sold across all orders.(done)
select * from products;
select * from orderdetails;
select p. productID, p. productName ,od.quantity
from products p 
join orderdetails od
on od.productID= p.productID
order by quantity desc
limit 5;



-- 16. To negotiate our shipping contracts, we need to know which shipping company we use the most. Can you count the number of orders handled by each shipper?(done)
select* from shippers;
select * from orders;
select s.shipperName , count(o.orderID) as total_order_shipped
from shippers s
join orders o 
on 
s.shipperID=o.shipperID
group by s.shipperName
order by total_order_shipped desc;


-- 17. Who are our top-performing salespeople in terms of revenue? Please calculate the total sales amount for each employee.(done)
SELECT 
    CONCAT(e.firstname, ' ', e.lastname) AS full_emp_name,
    SUM(od.quantity * p.price) AS total_revenue
FROM products p
JOIN orderdetails od ON p.ProductID = od.ProductID
JOIN orders o ON o.orderid = od.orderid
JOIN employees e ON e.employeeid = o.employeeid
GROUP BY full_emp_name
ORDER BY total_revenue DESC;

-- 18. We are running a promotion on our 'Chais' tea. I need a list of all customers who have purchased this product before so we can send them a notification.(done)
select*from products;
select*from customers;
select* from orders;
select * from orderdetails;
SELECT DISTINCT
    c.customerid, c.customername, p.productname
FROM products p
JOIN orderdetails od ON od.productid = p.productid
JOIN orders o ON o.orderid = od.orderid
JOIN customers c ON c.customerid = o.customerid
WHERE p.productname = 'chais';

-- 19. Which product categories are the most profitable? I need a report showing the total revenue generated by each category.(done)
select* from categories;
select* from products;
select* from orderdetails;
SELECT ct.categoryid,ct.categoryname,
    SUM(od.quantity * p.price) AS total_revenue
FROM products p
JOIN orderdetails od ON p.productid = od.productid
JOIN categories ct ON ct.categoryid = p.categoryid
GROUP BY categoryname , categoryid
ORDER BY total_revenue DESC;

-- 20. We want to start a loyalty program for our most frequent customers. Can you find all customers who have placed more than 5 orders?(done)
select * from orders;
select * from customers;
select c.customerId,c.customerName,
 count(o.orderid)as total_order
 from customers c 
 join orders o 
 on c.customerID= o.customerID
 group by customerName, customerId
 having total_order>5
 order by total_order desc;
