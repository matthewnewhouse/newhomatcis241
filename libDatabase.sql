SPOOL project.txt
SET ECHO ON
/*
CIS 353 - Database Design Project
Kyle Casey
Matthew Newhouse
Tu Nguyen
Alexis Webster
*/
--< The SQL/DDL code that creates your schema >
--In the DDL, every IC must have a unique name; e.g. IC5, IC10, IC15, etc.
--
--
--
SET FEEDBACK OFF
--< The INSERT statements that populate the tables>
CREATE TABLE Book (
ISBN	CHAR(20),
publisher   CHAR(20)	NOT NULL,
title	CHAR(40)    NOT NULL,
retail_cost	FLOAT NOT NULL,
--
--
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT bookIC1 PRIMARY KEY (ISBN)
);
--
--
--
CREATE TABLE Librarian (
ssn	INTEGER,
librarian_name	CHAR(20)   NOT NULL,
date_of_hire	DATE	NOT NULL,
mentor_ssn	INTEGER,
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT lIC1 PRIMARY KEY (ssn),
-- MENTOR CONSTRAINT
CONSTRAINT lIC2 FOREIGN KEY (mentor_ssn) REFERENCES Librarian(ssn)
	ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED,
-- HIRE DATE CONSTRAINT (Library opened in 2000)
CONSTRAINT lIC3 CHECK(date_of_hire >= TO_DATE( '01 Jan 2000', 'DD MON YYYY' ))
);
--
--
--
CREATE TABLE LibraryCard (
card_number	INTEGER,
customer_name	CHAR(40)   NOT NULL,
expiration_date   DATE   NOT NULL,
zip_code	INTEGER   NOT NULL,
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
id	INTEGER,
genre	CHAR(40) NOT NULL,
group_name	CHAR(40)  NOT NULL,
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
order_date	DATE   NOT NULL,
return_date	DATE   NOT NULL,
due_date	DATE   NOT NULL,
penalty	INTEGER,
librarian_ssn	INTEGER NOT NULL,
c_number	INTEGER NOT NULL,
--
--
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT tIC1 PRIMARY KEY (transaction_number),
-- FOREIGN KEY CONSTRAINT FOR LIBRARIAN SSN
CONSTRAINT tIC2 FOREIGN KEY (librarian_ssn) REFERENCES Librarian(ssn)
	ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED,
-- FOREIGN KEY CONSTRIANT FOR CARD NUMBER
CONSTRAINT tIC3 FOREIGN KEY (c_number) REFERENCES LibraryCard(card_number) 
	ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED,
-- THE BOOKS MUST BE DUE BACK WITHIN 1 MONTH OF THE ORDER
CONSTRAINT tIC4 CHECK(due_date - order_date <= 31)
);
--
--
--
CREATE TABLE BookCopy (
copy_number	INTEGER,
isbn	CHAR(20),
condition	CHAR(20) NOT NULL,
date_received	DATE NOT NULL,
tnumber	INTEGER,
--
--
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT bcIC1 PRIMARY KEY (copy_number, isbn),
--TRANSACTION FOREIGN KEY
CONSTRAINT bcIC2 FOREIGN KEY (tnumber) REFERENCES Transaction(transaction_number) 
	ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED,
--BOOK CONDITION CONSTRAINT
CONSTRAINT bcIC3 CHECK (condition IN ('New', 'Good', 'Bad')),
--NEWLY PUBLISHED CONSTRAINT, if bookcopy was received within this decade (2020's), must not have "bad" condition.
CONSTRAINT bcIC4 CHECK (condition NOT IN ('Bad') OR (condition IN ('Bad') AND date_received > TO_DATE( '01 Jan 2020', 'DD MON YYYY' )))
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
-- PRIMARY KEY CONSTRIANT
CONSTRAINT aIC1 PRIMARY KEY (a_isbn, author)
);
--
--
--
CREATE TABLE Joins (
groupid   INTEGER,
card_num   INTEGER,
date_of_join	DATE	NOT NULL,
--
-- PRIMARY KEY CONSTRIANT
CONSTRAINT jIC1 PRIMARY KEY (groupid, card_num),
-- FOREIGN KEY CONSTRAINT FOR GROUP ID
CONSTRAINT jIC2 FOREIGN KEY (groupid) REFERENCES ReadingGroup(id)
	ON DELETE CASCADE,
-- FOREIGN KEY CONSTRAINT FOR CARD NUMBER
CONSTRAINT jIC3 FOREIGN KEY (card_num) REFERENCES LibraryCard(card_number)
	ON DELETE CASCADE,
-- DATE OF JOIN CONSTRAINT (MUST BE ON OR AFTER 01/01/2000)
CONSTRAINT jIC4 CHECK(date_of_join > TO_DATE( '01 Jan 2000', 'DD MON YYYY' ))
);
--Important: Keep the number of rows in each table small enough so that the results of your
--queries can be verified by hand. See the Sailors database as an example.
SET FEEDBACK ON
COMMIT;
--
--< One query (per table) of the form: SELECT * FROM table; in order to display your database >
--
--< The SQL queries>
--Include the following for each query:
--	− A comment line stating the query number and the feature(s) it demonstrates
--(e.g. -- Q25 – correlated subquery).
--	− A comment line stating the query in English.
--	− The SQL code for the query.
--
--< The insert/delete/update statements to test the enforcement of ICs >
-- BOOKS(ISBN, PUBLISHER, TITLE, COST)
INSERT INTO Book VALUES ('1234567891234', 'George Allen', 'The Hobbit', 10.50);
INSERT INTO Book VALUES ('9876543212022', 'Scholastic', 'The Hunger Games', 15.99);
INSERT INTO Book VALUES ('9780316726610', 'Hyperion', 'The Five People You Meet in Heaven', 7.99);
INSERT INTO Book VALUES ('9874631221390', 'Disney', 'Percy Jackson', 5.99);
-- LIBRARIANS(SSN,NAME,HIRE_DATE,MENTOR_SSN)
INSERT INTO Librarian VALUES (123456789, 'Steven', TO_DATE('10/14/13', 'MM/DD/YY'), 246710121 );
INSERT INTO Librarian VALUES (246710121, 'Leah', TO_DATE('3/22/20', 'MM/DD/YY'),  342090842);
INSERT INTO Librarian VALUES (748201099, 'Wean',TO_DATE('11/19/00', 'MM/DD/YY'), 246710121);
INSERT INTO Librarian VALUES (342090842, 'Julia', TO_DATE('01/05/17', 'MM/DD/YY'), NULL);
INSERT INTO Librarian VALUES (813291233, 'Bob', TO_DATE('05/05/21', 'MM/DD/YY'), NULL);
-- LIBRARY CARDS(NUMBER,CUSTOMER_NAME,EXIPRATION_DATE,ZIP_CODE)
INSERT INTO LibraryCard VALUES (54321, 'Joseph', TO_DATE('10/25/21', 'MM/DD/YY'), 49221);
INSERT INTO LibraryCard VALUES (76543, 'Albert', TO_DATE('06/30/20', 'MM/DD/YY'), 49521);
INSERT INTO LibraryCard VALUES (76528, 'Sam',TO_DATE('12/24/23', 'MM/DD/YY'), 49420);
INSERT INTO LibraryCard VALUES (11111, 'Joe',TO_DATE('02/24/18', 'MM/DD/YY'), 45432);
-- READING GROUPS(ID,GENRE,Name)
INSERT INTO ReadingGroup VALUES (1001, 'Fantasy', 'Fans of Fantasy');
INSERT INTO ReadingGroup VALUES (1002, 'True Crime Non-Fiction', 'Literary Detectives');
INSERT INTO ReadingGroup VALUES (1003, 'Religious Fiction', 'Our Philosophy');
-- TRANSACTION(TRANS_NUM, ORDER_DATE, RETURN_DATE,DUE_DATE,PENALTY,LIBRARIAN_SSN,CARD_NUM)
INSERT INTO Transaction VALUES (12344,
	TO_DATE('11/10/20', 'MM/DD/YY'), 
	TO_DATE('12/24/20', 'MM/DD/YY'),
	TO_DATE('11/24/20', 'MM/DD/YY'),
	0,123456789,54321);
INSERT INTO Transaction VALUES (12345,
	TO_DATE('02/02/22', 'MM/DD/YY'), 
	TO_DATE('02/16/22', 'MM/DD/YY'),
	TO_DATE('02/15/22', 'MM/DD/YY'),
	0,246710121,76543);
INSERT INTO Transaction VALUES (12347,
	TO_DATE('11/13/21', 'MM/DD/YY'), 
	TO_DATE('11/20/21', 'MM/DD/YY'),
	TO_DATE('11/27/21', 'MM/DD/YY'),
	0, 748201099, 76528);
-- BOOK COPIES(COPY_NUMBER, ISBN, CONDITION, DATE_RECEIVED, TRANSACTION NUMBER)
INSERT INTO BookCopy VALUES (10,'1234567891234','Good',TO_DATE('01/05/99', 'MM/DD/YY'),12344);
INSERT INTO BookCopy VALUES (1,'9876543212022','New',TO_DATE('10/22/12', 'MM/DD/YY'),12345);
INSERT INTO BookCopy VALUES (5,'9780316726610', 'Bad',TO_DATE('02/04/98', 'MM/DD/YY'),12347);
INSERT INTO BookCopy VALUES (2,'9780316726610', 'Good',TO_DATE('07/07/99', 'MM/DD/YY'),NULL);
-- AUTHORS(AUTHOR_ISBN, AUTHOR_NAME)
INSERT INTO Authors VALUES ('1234567891234', 'J. R. R. Tolkien');
INSERT INTO Authors VALUES ('9876543212022', 'Suzanne Collins');
INSERT INTO Authors VALUES ('9876543212022', 'Mitch Albom');
-- JOINS(GROUP_ID, CARD_NUMBER, DATE_OF_JOIN)
INSERT INTO Joins VALUES (1001, 54321,TO_DATE('01/07/00', 'MM/DD/YY'));
INSERT INTO Joins VALUES (1002, 76543,TO_DATE('05/15/21', 'MM/DD/YY'));
INSERT INTO Joins VALUES (1003, 76528,TO_DATE('01/08/20', 'MM/DD/YY'));
--
--
--
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
-- QUERIES
--
--
-- JOIN W/ 4 RELATIONS
 -- Joins ...
SELECT LC.card_number, LC.customer_name, T.transaction_number, RG.group_name, J.date_of_join
FROM LibraryCard LC, ReadingGroup RG, Joins J, Transaction T
WHERE LC.card_number = T.c_number and LC.card_number = J.card_num and J.groupid = RG.id
ORDER BY LC.card_number;
--
--
-- SELF JOIN QUERY
-- Find the ssn's of the mentor and mentee Librarians
SELECT L1.ssn, L1.librarian_name,  L2.ssn, L2.librarian_name
FROM Librarian L1, Librarian L2
WHERE L1.ssn = L2.mentor_ssn;
--
--
-- MINUS QUERY
-- Library Cards without any books checked out
SELECT LC.card_number, LC.customer_name
FROM LibraryCard LC, Transaction T
MINUS
SELECT LC.card_number, LC.customer_name
FROM LibraryCard LC, Transaction T
WHERE LC.card_number = T.c_number;
--
--
--
-- MAX QUERY
-- Find priciest book (max retail cost)
SELECT B.title, B.isbn, B.retail_cost
FROM Book B
WHERE B.retail_cost = 
	(SELECT MAX(B.retail_cost)
	FROM Book B
);
--
--
--
-- GROUP BY / HAVING QUERY
-- All customers have have checked out a book in bad condition.
SELECT LC.card_number, LC.customer_name
FROM LibraryCard LC, Transaction T, BookCopy BC
WHERE LC.card_number = T.c_number AND T.transaction_number = BC.tnumber
GROUP BY LC.card_number, LC.customer_name, BC.condition
HAVING BC.condition = 'Bad'
ORDER BY LC.card_number;
--
--
-- CORRELATED SUBQUERY
-- Librarians not involved in any current transactions and hired on or before 01/01/2020.
SELECT L.ssn, L.librarian_name
FROM Librarian L
WHERE L.date_of_hire > TO_DATE( '01 Jan 2020', 'DD MON YYYY' ) AND NOT EXISTS
	(SELECT * FROM Transaction T WHERE T.librarian_ssn = L.ssn);
--
--
--
-- NON-CORRELATED SUBQUERY
-- Book that doesn't have any copies and is published by Disney.
SELECT B.ISBN, B.title
FROM Book B
WHERE B.publisher = 'Disney'
AND B.ISBN NOT IN (SELECT BC.isbn FROM BookCopy BC);
--
--
--
-- RELATIONAL DIVISION QUERY
-- Find card number and name of every Card that has joined a reading group with a fantasy genre.
SELECT LC.card_number, LC.customer_name
FROM LibraryCard LC
WHERE NOT EXISTS(
(SELECT RG.genre FROM ReadingGroup RG WHERE RG.genre = 'Fantasy')
MINUS
(SELECT RG.genre FROM ReadingGroup RG, Joins J WHERE RG.id = J.groupid 
	and J.card_num = LC.card_number and RG.genre = 'Fantasy' ));
--
--
-- OUTER JOIN QUERY
-- Show transactions of customers for those that have them.
SELECT LC.card_number, LC.customer_name, T.transaction_number, T.due_date
FROM LibraryCard LC LEFT OUTER JOIN Transaction T ON LC.card_number = T.c_number;
--
--
/*Include the following items for every IC that you test (Important: see the next section titled
“Submit a final report” regarding which ICs you need to test).*/
	--− A comment line stating: Testing: < IC name>
	--− A SQL INSERT, DELETE, or UPDATE that will test the IC.
COMMIT;
--
SPOOL OFF
