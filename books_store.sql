create database books_store;
use books_store;
create table books(
Book_ID	serial primary key,
Title varchar(100),
Author varchar(100),	
Genre varchar(50),	
Published_Year int,
Price numeric(10,2),
Stock int );
describe books;
select * from books;

create table customers(
Customer_ID serial primary key,
 Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
);
describe customers;

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
describe Orders;
select * from books;
select * from customers;
select * from Orders;
-- BASIC QUERIES:-
-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books 
WHERE Genre='Fiction';
-- 2) Find books published after the year 1950:
SELECT Title,Published_Year FROM Books 
WHERE Published_year>1950;
-- 3) List all customers from the Canada:
SELECT * FROM Customers 
WHERE country='Canada';
-- 4) Show orders placed in November 2023:
SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) AS Total_Stock
From Books;
-- 6) Find the details of the most expensive book:
SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;
-- 7) Show all customers who ordered more than 1 quantity of a book:
select c.Name,c.Customer_ID,o.Quantity 
from customers c
inner join orders o
on c.Customer_ID=o.Customer_ID
where o.Quantity>1;
-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE total_amount>20;
-- 9) List all genres available in the Books table:
SELECT DISTINCT genre as Available_Genre
FROM Books;
-- 10) Find the book with the lowest stock:
SELECT * FROM Books 
ORDER BY stock
LIMIT 1;
-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders;

-- ADVANCE QUERIES:--
-- 1) Retrieve the total number of books sold for each genre:
SELECT  b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Books b
INNER JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT ROUND(AVG(price),2) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
SELECT c.Customer_ID, c.Name, COUNT(o.Order_ID) AS Number_of_Orders
FROM Customers c
INNER JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- 4) Find the most frequently ordered book:
SELECT b.Book_ID, b.Title, COUNT(o.Order_ID) AS ORDER_COUNT
FROM Books b
INNER JOIN Orders o
  ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY COUNT(o.Order_ID) DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Books b
INNER JOIN Orders o 
ON b.Book_ID = o.Book_ID
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.City 
FROM Customers c
INNER JOIN Orders o 
ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount > 30;

-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM customers c
INNER JOIN orders o 
ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc 
LIMIT 1;

-- 9)Calculate the stock remaining after fulfilling all orders:
