-- Display all contents of the Clients table
SELECT * FROM client;

-- First names, last names, ages and occupations of all clients
SELECT ClientFirstName, ClientLastName, YEAR(CURDATE()) - ClientDob AS Age, Occupation FROM client; 

-- First and last names of clients that borrowed books in March 2018
SELECT ClientFirstName, ClientLastName FROM client WHERE ClientId IN (
    SELECT ClientId FROM borrower WHERE BorrowDate >= Date('2018-03-01') AND BorrowDate <= Date('2018-03-31'));

-- First and last names of the top 5 authors clients borrowed in 2017
SELECT author.AuthorFirstName, author.AuthorLastName FROM author 
INNER JOIN book ON author.AuthorId = book.BookAuthor
INNER JOIN borrower ON book.BookID = borrower.BookId
WHERE BorrowDate >= Date('2017-01-01') AND BorrowDate <= Date('2017-12-31')
GROUP BY author.AuthorId
ORDER BY COUNT(author.AuthorId) DESC
LIMIT 5;

-- Least 5 author nationalities clients borrowed during the years 2015-2017
SELECT author.AuthorNationality FROM author 
INNER JOIN book ON author.AuthorId = book.BookAuthor
INNER JOIN borrower ON book.BookID = borrower.BookId
WHERE BorrowDate >= Date('2015-01-01') AND BorrowDate <= Date('2017-12-31')
GROUP BY author.AuthorNationality
ORDER BY COUNT(author.AuthorNationality) ASC
LIMIT 5;

-- The book that was most borrowed during the years 2015-2017
SELECT book.BookTitle FROM book 
INNER JOIN borrower ON book.BookID = borrower.BookId
WHERE BorrowDate >= Date('2015-01-01') AND BorrowDate <= Date('2017-12-31')
GROUP BY book.BookID
ORDER BY COUNT(borrower.BookId) DESC
LIMIT 1;

-- Top borrowed genres for client born in years 1970-1980
SELECT book.Genre FROM book 
INNER JOIN borrower ON book.BookID = borrower.BookId
INNER JOIN client ON borrower.ClientId = client.ClientId
WHERE client.ClientDoB >= 1970 AND client.ClientDoB <= 1980
GROUP BY book.Genre
ORDER BY COUNT(book.Genre) DESC
LIMIT 5;

-- Top 5 occupations that borrowed the most in 2016
SELECT client.Occupation FROM client
INNER JOIN borrower ON borrower.ClientId = client.ClientId
WHERE borrower.BorrowDate >= Date('2016-01-01') AND borrower.BorrowDate <= Date('2016-12-31')
GROUP BY client.Occupation
ORDER BY COUNT(client.Occupation) DESC
LIMIT 5;

-- Average number of borrowed books by job title
SELECT c.Occupation, 
COUNT(c.Occupation) / 
(SELECT COUNT(Occupation) FROM client WHERE Occupation = c.Occupation GROUP BY Occupation) AS Average
FROM client c
INNER JOIN borrower ON borrower.ClientId = c.ClientId
GROUP BY c.Occupation;

-- Create a VIEW and display the titles that were borrowed by at least 20% of clients
CREATE VIEW titles_borrowed AS
SELECT book.BookTitle FROM book
INNER JOIN borrower ON borrower.BookId = book.BookId
INNER JOIN client ON client.ClientId = borrower.ClientId
GROUP BY book.BookId
HAVING COUNT(book.BookId)/(SELECT COUNT(ClientId) FROM client) >= .2;

-- The top month of borrows in 2017
SELECT MONTH(BorrowDate) FROM borrower 
WHERE BorrowDate >= Date('2017-01-01') AND BorrowDate <= Date('2017-12-31')
GROUP BY MONTH(BorrowDate)
ORDER BY COUNT(MONTH(BorrowDate)) DESC
LIMIT 1;
