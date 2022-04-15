SPOOL project.txt
SET ECHO ON
/*
--
CIS 353 - Database Design Project - Library Database
Kyle Casey (Team Coordinator)
Matthew Newhouse
Tu Nguyen
Alexis Webster
--
*/
--
--
--
--
-- ALL SQL/DDL CODE TO CREATE TABLES
--
CREATE TABLE Book (
ISBN	    CHAR(20),
publisher   CHAR(20)  NOT NULL,
title	    CHAR(40)  NOT NULL,
retail_cost FLOAT     NOT NULL,
--
--
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT bookIC1 PRIMARY KEY (ISBN),
-- RETAIL COST MUST BE GREATER THAN 0
CONSTRAINT bookIC2 CHECK(retail_cost > 0)
);
--
--
--
CREATE TABLE Librarian (
ssn	        INTEGER,
librarian_name	CHAR(20)   NOT NULL,
date_of_hire	DATE	   NOT NULL,
mentor_ssn	INTEGER,
--
--
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT lIC1 PRIMARY KEY (ssn),
-- MENTOR FOREIGN KEY CONSTRAINT
CONSTRAINT lIC2 FOREIGN KEY (mentor_ssn) REFERENCES Librarian(ssn),
-- HIRE DATE CONSTRAINT (Must be hired after 2000)
CONSTRAINT lIC3 CHECK((date_of_hire - TO_DATE( '01 Jan 2020', 'DD MON YYYY' )) > 0)
);
--
--
--
CREATE TABLE LibraryCard (
card_number	  INTEGER,
customer_name	  CHAR(40)  NOT NULL,
expiration_date   DATE      NOT NULL,
zip_code	  INTEGER   NOT NULL,
--
--
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT lcIC1 PRIMARY KEY (card_number),
-- ZIP CODE CONSTRAINT (All Michigan zip codes start with a 4, our library is in Michigan)
CONSTRAINT lcIC2 CHECK(zip_code >= 40000 AND zip_code < 50000)
);
--
--
--
CREATE TABLE ReadingGroup (
id	   INTEGER,
genre	   CHAR(40) NOT NULL,
group_name CHAR(40)  NOT NULL,
--
--
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT readIC1 PRIMARY KEY (id)
);
--
--
--
CREATE TABLE Transaction (
transaction_number   INTEGER,
order_date	     DATE   NOT NULL,
return_date	     DATE   NOT NULL,
due_date	     DATE   NOT NULL,
penalty	             INTEGER,
librarian_ssn	     INTEGER NOT NULL,
c_number	     INTEGER NOT NULL,
--
--
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT tIC1 PRIMARY KEY (transaction_number),
-- FOREIGN KEY CONSTRAINT FOR LIBRARIAN SSN
CONSTRAINT tIC2 FOREIGN KEY (librarian_ssn) REFERENCES Librarian(ssn),
-- FOREIGN KEY CONSTRIANT FOR CARD NUMBER
CONSTRAINT tIC3 FOREIGN KEY (c_number) REFERENCES LibraryCard(card_number) ,
-- THE BOOKS MUST BE DUE BACK WITHIN 1 MONTH OF THE ORDER
CONSTRAINT tIC4 CHECK(due_date - order_date <= 31)
);
--
--
--
CREATE TABLE BookCopy (
copy_number	INTEGER,
isbn	        CHAR(20),
condition	CHAR(20) NOT NULL,
date_received	DATE NOT NULL,
tnumber	        INTEGER,
--
--
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT bcIC1 PRIMARY KEY (copy_number, isbn),
-- TRANSACTION FOREIGN KEY
CONSTRAINT bcIC2 FOREIGN KEY (tnumber) REFERENCES Transaction(transaction_number),
-- BOOK CONDITION CONSTRAINT
CONSTRAINT bcIC3 CHECK (condition IN ('New', 'Good', 'Bad')),
-- NEWLY PUBLISHED CONSTRAINT, if bookcopy was received within this decade after 01/01/2020, must not have "bad" condition.
CONSTRAINT bcIC4 CHECK (condition NOT IN ('Bad') OR (condition IN ('Bad') AND date_received < TO_DATE( '01 Jan 2020', 'DD MON YYYY' )))
);
--
--
--
CREATE TABLE Authors (
a_isbn	CHAR(20),
author	CHAR(40) NOT NULL,
--
--
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT aIC1 PRIMARY KEY (a_isbn, author),
-- FOREIGN KEY CONSTRAINT
CONSTRAINT aIC2 FOREIGN KEY (a_isbn) REFERENCES Book(ISBN)
);
--
--
--
CREATE TABLE Joins (
groupid         INTEGER,
card_num        INTEGER,
date_of_join	DATE	 NOT NULL,
--
--
--
-- PRIMARY KEY CONSTRIANT
CONSTRAINT jIC1 PRIMARY KEY (groupid, card_num),
-- FOREIGN KEY CONSTRAINT FOR GROUP ID
CONSTRAINT jIC2 FOREIGN KEY (groupid) REFERENCES ReadingGroup(id),
-- FOREIGN KEY CONSTRAINT FOR CARD NUMBER
CONSTRAINT jIC3 FOREIGN KEY (card_num) REFERENCES LibraryCard(card_number),
-- DATE OF JOIN CONSTRAINT (MUST JOIN CLUB AFTER 01/01/2000)
CONSTRAINT jIC4 CHECK(date_of_join > TO_DATE( '01 Jan 2000', 'DD MON YYYY' ))
);
--
--
--
SET FEEDBACK OFF
COMMIT;
--
--
--
-- INSERT STATEMENTS (TEST DATA)
--
--
--
-- BOOKS(ISBN, PUBLISHER, TITLE, COST)
INSERT INTO Book VALUES ('1234567891234', 'George Allen', 'The Hobbit', 10.51);
INSERT INTO Book VALUES ('1234567891235', 'George Allen', 'The Lord of The Rings', 30.51);
INSERT INTO Book VALUES ('9876543212022', 'Scholastic', 'The Hunger Games', 15.99);
INSERT INTO Book VALUES ('9780316726610', 'Hyperion', 'The Five People You Meet in Heaven', 7.99);
INSERT INTO Book VALUES ('9874631221390', 'Disney', 'Percy Jackson', 5.99);
INSERT INTO Book VALUES ('3213123809191' , 'Bloomsbury', 'Harry Potter', 20.99);
INSERT INTO Book VALUES ('9780141321615', 'Puffin Books', 'Five Children and It', 5.99);
INSERT INTO Book VALUES ('9781423145844', 'Disney', 'Be Our Guest', 14.01);
INSERT INTO Book VALUES ('9781423145899', 'Disney', 'Frozen Adventure', 9.01);
INSERT INTO Book VALUES ('9781423145869', 'Disney', 'Frozen Adventure 2', 5.01);
-- LIBRARIANS(SSN,NAME,HIRE_DATE,MENTOR_SSN)
INSERT INTO Librarian VALUES (342090842, 'Julia', TO_DATE('01/05/22', 'MM/DD/YY'), NULL);
INSERT INTO Librarian VALUES (813291233, 'Bob', TO_DATE('05/05/20', 'MM/DD/YY'), NULL);
INSERT INTO Librarian VALUES (246710121, 'Leah', TO_DATE('3/22/20', 'MM/DD/YY'),  342090842);
INSERT INTO Librarian VALUES (123456789, 'Steven', TO_DATE('10/14/21', 'MM/DD/YY'), 246710121 );
INSERT INTO Librarian VALUES (748201099, 'Wean',TO_DATE('11/19/20', 'MM/DD/YY'), NULL);
-- LIBRARY CARDS(NUMBER,CUSTOMER_NAME,EXIPRATION_DATE,ZIP_CODE)
INSERT INTO LibraryCard VALUES (54321, 'Joseph', TO_DATE('10/25/25', 'MM/DD/YY'), 49221);
INSERT INTO LibraryCard VALUES (76543, 'Albert', TO_DATE('06/30/22', 'MM/DD/YY'), 49521);
INSERT INTO LibraryCard VALUES (76528, 'Sam',TO_DATE('12/24/23', 'MM/DD/YY'), 49420);
INSERT INTO LibraryCard VALUES (11111, 'Jay',TO_DATE('02/24/24', 'MM/DD/YY'), 45432);
INSERT INTO LibraryCard VALUES (22222, 'Mabel',TO_DATE('12/25/27', 'MM/DD/YY'), 45531);
INSERT INTO LibraryCard VALUES (33333, 'Jacob',TO_DATE('12/20/23', 'MM/DD/YY'), 42531);
INSERT INTO LibraryCard VALUES (99999, 'Phil',TO_DATE('12/20/28', 'MM/DD/YY'), 42111);
INSERT INTO LibraryCard VALUES (44444, 'Alex',TO_DATE('11/20/24', 'MM/DD/YY'), 42221);
INSERT INTO LibraryCard VALUES (55555, 'Leah',TO_DATE('10/14/23', 'MM/DD/YY'), 42331);
INSERT INTO LibraryCard VALUES (66666, 'Logan',TO_DATE('12/23/23', 'MM/DD/YY'), 42541);
-- READING GROUPS(ID,GENRE,Name)
INSERT INTO ReadingGroup VALUES (1001, 'Fantasy', 'Fans of Fantasy');
INSERT INTO ReadingGroup VALUES (1002, 'True Crime Non-Fiction', 'Literary Detectives');
INSERT INTO ReadingGroup VALUES (1003, 'Religious Fiction', 'Our Philosophy');
INSERT INTO ReadingGroup VALUES (1004, 'American Historical Fiction', 'Amateur Histrians');
INSERT INTO ReadingGroup VALUES (1005,'Young Adult', 'Authors of The Future');
INSERT INTO ReadingGroup VALUES (1006, 'Fantasy', 'Fantasy Fanatics');
-- TRANSACTION(TRANS_NUM, ORDER_DATE, RETURN_DATE,DUE_DATE,PENALTY,LIBRARIAN_SSN,CARD_NUM)
INSERT INTO Transaction VALUES (12344,
	TO_DATE('11/10/20', 'MM/DD/YY'), 
	TO_DATE('12/24/20', 'MM/DD/YY'),
	TO_DATE('11/24/20', 'MM/DD/YY'),
	20,123456789,54321);
INSERT INTO Transaction VALUES (12345,
	TO_DATE('02/02/22', 'MM/DD/YY'), 
	TO_DATE('02/16/22', 'MM/DD/YY'),
	TO_DATE('02/15/22', 'MM/DD/YY'),
	1,246710121,76543);
INSERT INTO Transaction VALUES (12347,
	TO_DATE('11/13/21', 'MM/DD/YY'), 
	TO_DATE('11/20/21', 'MM/DD/YY'),
	TO_DATE('11/27/21', 'MM/DD/YY'),
	0, 748201099, 76528);
INSERT INTO Transaction VALUES (12349,
	TO_DATE('10/12/21', 'MM/DD/YY'),
	TO_DATE('12/21/21', 'MM/DD/YY'),
	TO_DATE('10/31/21', 'MM/DD/YY'),
	20, 748201099, 22222);
INSERT INTO Transaction VALUES (12350,
	TO_DATE('09/12/21', 'MM/DD/YY'),
	TO_DATE('09/21/21', 'MM/DD/YY'),
	TO_DATE('09/28/21', 'MM/DD/YY'),
	10, 748201099, 33333);
INSERT INTO Transaction VALUES (12351,
	TO_DATE('10/12/21', 'MM/DD/YY'),
	TO_DATE('12/21/21', 'MM/DD/YY'),
	TO_DATE('10/31/21', 'MM/DD/YY'),
	0, 123456789, 44444);
-- BOOK COPIES(COPY_NUMBER, ISBN, CONDITION, DATE_RECEIVED, TRANSACTION NUMBER)
INSERT INTO BookCopy VALUES (10,'1234567891234','Good',TO_DATE('01/05/99', 'MM/DD/YY'),12344);
INSERT INTO BookCopy VALUES (1,'9876543212022','New',TO_DATE('10/22/12', 'MM/DD/YY'),12345);
INSERT INTO BookCopy VALUES (5,'9780316726610', 'Bad',TO_DATE('02/04/18', 'MM/DD/YY'),12347);
INSERT INTO BookCopy VALUES (6,'9780316726610', 'Good',TO_DATE('02/04/18', 'MM/DD/YY'),12351);
INSERT INTO BookCopy VALUES (7,'9780316726610', 'New',TO_DATE('02/04/18', 'MM/DD/YY'),12350);
INSERT INTO BookCopy VALUES (2,'9780316726610', 'Good',TO_DATE('07/07/99', 'MM/DD/YY'),NULL);
INSERT INTO BookCopy VALUES (6,'9780141321615', 'New',TO_DATE('08/08/19', 'MM/DD/YY'),NULL);
INSERT INTO BookCopy VALUES (1,'9781423145844', 'Bad',TO_DATE('02/08/01', 'MM/DD/YY'),12349);
-- AUTHORS(AUTHOR_ISBN, AUTHOR_NAME)
INSERT INTO Authors VALUES ('1234567891234', 'J. R. R. Tolkien');
INSERT INTO Authors VALUES ('1234567891235', 'J. R. R. Tolkien');
INSERT INTO Authors VALUES ('9876543212022', 'Suzanne Collins');
INSERT INTO Authors VALUES ('9780316726610', 'Mitch Albom');
INSERT INTO Authors VALUES ('9874631221390', 'Rick Riordan');
INSERT INTO Authors VALUES ('3213123809191', 'J. K. Rowling');
INSERT INTO Authors VALUES ('9780141321615', 'E. Nesbit');
INSERT INTO Authors VALUES ('9781423145844', 'Theodore B. Kinni');
INSERT INTO Authors VALUES ('9781423145899', 'Theodore B. Kinni');
INSERT INTO Authors VALUES ('9781423145869', 'Theodore B. Kinni');
-- JOINS(GROUP_ID, CARD_NUMBER, DATE_OF_JOIN)
INSERT INTO Joins VALUES (1001, 54321,TO_DATE('01/07/00', 'MM/DD/YY'));
INSERT INTO Joins VALUES (1002, 76543,TO_DATE('05/15/21', 'MM/DD/YY'));
INSERT INTO Joins VALUES (1003, 76528,TO_DATE('09/08/21', 'MM/DD/YY'));
INSERT INTO Joins VALUES (1004, 11111,TO_DATE('12/08/22', 'MM/DD/YY'));
INSERT INTO Joins VALUES (1005, 22222,TO_DATE('01/02/19', 'MM/DD/YY'));
--
--
--
SET FEEDBACK ON
COMMIT;
--
--
-- SHOW ALL TABLES
SELECT * FROM Book;
SELECT * FROM Librarian;
SELECT * FROM LibraryCard;
SELECT * FROM ReadingGroup;
SELECT * FROM Transaction;
SELECT * FROM BookCopy;
SELECT * FROM Authors;
SELECT * FROM Joins;
--
--
--
-- QUERIES
--
--
-- Q01 - JOIN W/ 4 RELATIONS
-- Get all card number, customer name, transaction number, group name, and date of joins.
-- Essentially shows all customers with a book checked out and the group they are in and when they joined.
SELECT LC.card_number, LC.customer_name, T.transaction_number, RG.group_name, J.date_of_join
FROM LibraryCard LC, ReadingGroup RG, Joins J, Transaction T
WHERE LC.card_number = T.c_number and LC.card_number = J.card_num and J.groupid = RG.id
ORDER BY LC.card_number;
--
--
-- Q02 - SELF JOIN QUERY
-- Find the ssn's of the mentor and mentee Librarians.
SELECT L1.ssn, L1.librarian_name,  L2.ssn, L2.librarian_name
FROM Librarian L1, Librarian L2
WHERE L1.ssn = L2.mentor_ssn;
--
--
-- Q03 - MINUS QUERY
-- Find the card number and name of any customers without any checked out books.
SELECT LC.card_number, LC.customer_name
FROM LibraryCard LC, Transaction T
MINUS
SELECT LC.card_number, LC.customer_name
FROM LibraryCard LC, Transaction T
WHERE LC.card_number = T.c_number;
--
--
--
-- Q04 - MAX QUERY
-- Find the book with the highest retail price.
SELECT B.title, B.isbn, B.retail_cost
FROM Book B
WHERE B.retail_cost = 
	(SELECT MAX(B.retail_cost)
	FROM Book B
);
--
--
--
-- Q05 - GROUP BY / HAVING / ORDER BY QUERY
-- Find all customers that have checked out a book with a 'bad' condition.
SELECT LC.card_number, LC.customer_name
FROM LibraryCard LC, Transaction T, BookCopy BC
WHERE LC.card_number = T.c_number AND T.transaction_number = BC.tnumber
GROUP BY LC.card_number, LC.customer_name, BC.condition
HAVING BC.condition = 'Bad'
ORDER BY LC.card_number;
--
--
-- Q06 - CORRELATED SUBQUERY
-- Find all librarians not involved in any current transactions that were also hired before 01/01/2020.
SELECT L.ssn, L.librarian_name
FROM Librarian L
WHERE L.date_of_hire > TO_DATE( '01 Jan 2020', 'DD MON YYYY' ) AND NOT EXISTS
	(SELECT * FROM Transaction T WHERE T.librarian_ssn = L.ssn);
--
--
--
-- Q07 - NON-CORRELATED SUBQUERY
-- Find all books that don't have any copies and are published by Disney.
SELECT B.ISBN, B.title
FROM Book B
WHERE B.publisher = 'Disney'
AND B.ISBN NOT IN (SELECT BC.isbn FROM BookCopy BC);
--
--
--
-- Q08 - RELATIONAL DIVISION QUERY
-- Find all card numbers and names of every customer that has joined a reading group with a fantasy genre.
SELECT LC.card_number, LC.customer_name
FROM LibraryCard LC
WHERE NOT EXISTS(
(SELECT RG.genre FROM ReadingGroup RG WHERE RG.genre = 'Fantasy')
MINUS
(SELECT RG.genre FROM ReadingGroup RG, Joins J WHERE RG.id = J.groupid 
	and J.card_num = LC.card_number and RG.genre = 'Fantasy' ));
--
--
-- Q09 - OUTER JOIN QUERY
-- Show all transactions of customers for those that have them.
SELECT LC.card_number, LC.customer_name, T.transaction_number, T.due_date
FROM LibraryCard LC LEFT OUTER JOIN Transaction T ON LC.card_number = T.c_number;
--
--
--
-- TESTING INTEGRITY CONSTRAINTS
--
--
-- TESTING bookIC1 - PRIMARY KEY ISBN
INSERT INTO Book VALUES ('9999987654321', 'TEST PUBLISHER', 'TEST BOOK', 99.00);
INSERT INTO Book VALUES ('9999987654321', 'TEST PUBLISHER', 'TEST BOOK', 99.00);
--
-- TESTING bookIC2 - RETAIL COST MUST BE GREATER THAN 0
INSERT INTO Book VALUES ('9999987654322', 'TEST PUBLISHER', 'TEST BOOK', 0); 
INSERT INTO Book VALUES ('9999987654323', 'TEST PUBLISHER', 'TEST BOOK', -1);
INSERT INTO Book VALUES ('9999987654324', 'TEST PUBLISHER', 'TEST BOOK', 1);
--
--
-- TESTING lIC1 - PRIMARY KEY SSN
INSERT INTO Librarian VALUES (000000000, 'TEST', TO_DATE('07/01/20', 'MM/DD/YY'), NULL );
INSERT INTO Librarian VALUES (000000000, 'TEST', TO_DATE('07/01/20', 'MM/DD/YY'), NULL );
--
--
-- TESTING lIC2 - FOREIGN KEY MENTOR SSN REFERENCES LIBRARIAN SSN ON DELETE SET NULL
INSERT INTO Librarian VALUES (000000001, 'TEST', TO_DATE('05/01/20', 'MM/DD/YY'), NULL);
INSERT INTO Librarian VALUES (000000002, 'TEST', TO_DATE('06/01/20', 'MM/DD/YY'), 000000001);
DELETE FROM Librarian L  WHERE L.ssn = 000000001;
--
--
-- TESTING lIC3 - DATE OF HIRE MUST BE AFTER 01/01/2000
INSERT INTO Librarian VALUES (000000003, 'TEST', TO_DATE('02/01/1999', 'MM/DD/YYYY'), NULL );
INSERT INTO Librarian VALUES (000000005, 'TEST', TO_DATE('04/01/2020', 'MM/DD/YYYY'), NULL );
--
--
-- TESTING lcIC1 - PRIMARY KEY CARD_NUMBER
INSERT INTO LibraryCard VALUES (00000, 'TEST', TO_DATE('05/05/05', 'MM/DD/YY'), 44444);
INSERT INTO LibraryCard VALUES (00000, 'TEST', TO_DATE('05/05/05', 'MM/DD/YY'), 44444);
--
--
-- TESTING lcIC2 - ZIP CODE BETWEEN 40000 and 50000 (ZIP CODE IN MICHIGAN)
INSERT INTO LibraryCard VALUES (00001, 'TEST', TO_DATE('05/05/05', 'MM/DD/YY'), 34444);
INSERT INTO LibraryCard VALUES (00002, 'TEST', TO_DATE('05/05/05', 'MM/DD/YY'), 64444);
INSERT INTO LibraryCard VALUES (00003, 'TEST', TO_DATE('05/05/05', 'MM/DD/YY'), 40001);
--
--
-- TESTING readIC1 - PRIMARY KEY ID
INSERT INTO ReadingGroup VALUES (0000, 'TEST', 'TEST');
INSERT INTO ReadingGroup VALUES (0000, 'TEST', 'TEST');
--
--
-- TESTING tIC1 - PRIMARY KEY TRANSACTION_NUMBER
INSERT INTO Transaction VALUES (00000,
	TO_DATE('10/10/10', 'MM/DD/YY'),
	TO_DATE('11/10/10', 'MM/DD/YY'),
	TO_DATE('10/30/10', 'MM/DD/YY'),
	0,123456789,54321);
INSERT INTO Transaction VALUES (00000,
	TO_DATE('10/10/10', 'MM/DD/YY'),
	TO_DATE('11/10/10', 'MM/DD/YY'),
	TO_DATE('10/30/10', 'MM/DD/YY'),
	0,123456789,54321);
--
--
-- TESTING tIC2 - FOREIGN KEY LIBRARIAN_SSN REFERENCES LIBARIAN SSN
INSERT INTO Transaction VALUES (00001,
	TO_DATE('10/10/10', 'MM/DD/YY'),
	TO_DATE('11/10/10', 'MM/DD/YY'),
	TO_DATE('10/30/10', 'MM/DD/YY'),
	0,123456789,54321);
INSERT INTO Transaction VALUES (00002,
	TO_DATE('10/10/10', 'MM/DD/YY'),
	TO_DATE('11/10/10', 'MM/DD/YY'),
	TO_DATE('10/30/10', 'MM/DD/YY'),
	0,040404040,54321);
--
--
-- TESTING tIC3 - FOREIGN KEY C_NUMBER REFERENCES LIBRARY CARD CARD_NUMBER ON DELETE SET NULL
INSERT INTO Transaction VALUES (00003,
	TO_DATE('10/10/10', 'MM/DD/YY'),
	TO_DATE('11/10/10', 'MM/DD/YY'),
	TO_DATE('10/30/10', 'MM/DD/YY'),
	0,123456789,54321);
INSERT INTO Transaction VALUES (00004,
	TO_DATE('10/10/10', 'MM/DD/YY'),
	TO_DATE('11/10/10', 'MM/DD/YY'),
	TO_DATE('10/30/10', 'MM/DD/YY'),
	0,123456789,12121);
--
--
-- TESTING tIC4 - CHECK THAT DUE DATE IS WITHIN 1 MONTH OF ORDER DATE
INSERT INTO Transaction VALUES (00005,
	TO_DATE('10/10/10', 'MM/DD/YY'),
	TO_DATE('11/10/10', 'MM/DD/YY'),
	TO_DATE('12/30/10', 'MM/DD/YY'),
	0,123456789,54321);
INSERT INTO Transaction VALUES (00006,
	TO_DATE('10/10/10', 'MM/DD/YY'),
	TO_DATE('11/10/10', 'MM/DD/YY'),
	TO_DATE('10/30/10', 'MM/DD/YY'),
	0,123456789,54321);
--
--
-- TESTING bcIC1 - PRIMARY KEY COPY_NUMBER and ISBN
INSERT INTO BookCopy VALUES (100,'1234567891234','New',TO_DATE('01/05/99', 'MM/DD/YY'),NULL);
INSERT INTO BookCopy VALUES (100,'1234567891234','New',TO_DATE('01/05/99', 'MM/DD/YY'),NULL);
--
--
-- TESTING bcIC2 - FORIEGN KEY REFERENCES TRANSACTION TRANSACTION_NUMBER
INSERT INTO BookCopy VALUES (11,'1234567891234','New',TO_DATE('01/05/99', 'MM/DD/YY'),00006);
INSERT INTO BookCopy VALUES (12,'1234567891234','New',TO_DATE('01/05/99', 'MM/DD/YY'),66666);
--
--
-- TESTING bcIC3 - CHECK CONDTION IN NEW, GOOD, OR BAD
INSERT INTO BookCopy VALUES (13,'1234567891234','New',TO_DATE('01/05/99', 'MM/DD/YY'),NULL);
INSERT INTO BookCopy VALUES (14,'1234567891234','Good',TO_DATE('01/05/99', 'MM/DD/YY'),NULL);
INSERT INTO BookCopy VALUES (15,'1234567891234','Bad',TO_DATE('10/10/18', 'MM/DD/YY'),NULL);
INSERT INTO BookCopy VALUES (16,'1234567891234','Amazing',TO_DATE('01/05/99', 'MM/DD/YY'),NULL);
--
--
-- TESTING bcIC4 - CHECK THAT BOOK'S IN BAD CONDITION AREN'T RECEIVED AFTER 01/01/2020
INSERT INTO BookCopy VALUES (17,'1234567891234','Bad',TO_DATE('10/10/19', 'MM/DD/YY'),NULL);
INSERT INTO BookCopy VALUES (18,'1234567891234','Bad',TO_DATE('01/01/20', 'MM/DD/YY'),NULL);
INSERT INTO BookCopy VALUES (19,'1234567891234','Bad',TO_DATE('10/10/22', 'MM/DD/YY'),NULL);
--
--
-- TESTING aIC1 - PRIMARY KEY A_ISBN, AUTHOR
INSERT INTO Authors VALUES ('1234567891234', 'Test');
INSERT INTO Authors VALUES ('1234567891234', 'Test');
--
--
-- TESTING aIC2 - FOREIGN KEY A_ISBN REFERENCES BOOK ISBN
INSERT INTO Authors VALUES ('1234567891234', 'Test2');
INSERT INTO Authors VALUES ('8780123891232', 'Test2');
--
--
-- TESTING jIC1 - PRIMARY KEY GROUPID CARD_NUM
INSERT INTO Joins VALUES (1001, 11111,TO_DATE('01/02/19', 'MM/DD/YY'));
INSERT INTO Joins VALUES (1001, 11111,TO_DATE('01/02/19', 'MM/DD/YY'));
--
--
-- TESTING jIC2 - FOREIGN KEY GROUPID REFERENCES READGROUP ID
INSERT INTO Joins VALUES (1561, 22222,TO_DATE('01/02/19', 'MM/DD/YY'));
--
-- TESTING jIC3 - FOREIGN KEY CARD_NUM REFERENCES LIBRARYCARD CARD_NUMBER
INSERT INTO Joins VALUES (1001, 13231,TO_DATE('01/02/19', 'MM/DD/YY'));
--
--
-- TESTING jIC4 - CHECK DATE_OF_JOIN AFTER 01/01/2000
INSERT INTO Joins VALUES (1002, 11111,TO_DATE('01/01/00', 'MM/DD/YY'));
INSERT INTO Joins VALUES (1002, 22222,TO_DATE('10/10/19', 'MM/DD/YY'));
--
--
--
COMMIT;
--
--
--
SPOOL OFF
