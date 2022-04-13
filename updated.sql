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
SET FEEDBACK OFF
--< The INSERT statements that populate the tables>
CREATE TABLE Book (
ISBN	INTEGER,
publisher   CHAR(20)	NOT NULL,
title	CHAR(40)    NOT NULL,
retail_cost	FLOAT NOT NULL,
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT bookIC1 PRIMARY KEY (ISBN)
);
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
CREATE TABLE LibraryCard (
card_number	INTEGER,
customer_name	CHAR(40)   NOT NULL,
expiration_date   DATE   NOT NULL,
zip_code	INTEGER   NOT NULL,
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT lcIC1 PRIMARY KEY (card_number),
-- ZIP CODE CONSTRAINT (All Michigan zip codes start with a 4, our library is in Michigan)
CONSTRAINT lcIC2 CHECK(zip_code >= 40000 AND zip_code < 50000)
);
--
CREATE TABLE ReadingGroup (
id	INTEGER,
genre	CHAR(40) NOT NULL,
group_name	CHAR(40)  NOT NULL,
--
-- PRIMARY KEY CONSTRAINT
CONSTRAINT readIC1 PRIMARY KEY (id)
);
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
CREATE TABLE BookCopy (
copy_number	INTEGER,
isbn	INTEGER,
condition	CHAR(20) NOT NULL,
date_received	DATE NOT NULL,
tnumber	INTEGER NOT NULL,
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
CREATE TABLE Authors (
a_isbn	INTEGER,
author	CHAR(40) NOT NULL,
--
-- PRIMARY KEY CONSTRIANT
CONSTRAINT aIC1 PRIMARY KEY (a_isbn, author)
);
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
INSERT INTO Book VALUES (1234567891234, 'George Allen', 'The Hobbit', 10.50);
INSERT INTO Book VALUES (9876543212022, 'Scholastic', 'The Hunger Games', 15.99);
INSERT INTO Book VALUES (9780316726610, 'Hyperion', 'The Five People You Meet in Heaven', 7.99);
INSERT INTO Book VALUES (9874631221390, 'Disney', 'Percy Jackson', 5.99);
-- LIBRARIANS(SSN,NAME,HIRE_DATE,MENTOR_SSN)
INSERT INTO Librarian VALUES (123456789, 'Steven', TO_DATE('10/14/93', 'MM/DD/YY'), 987654321 );
INSERT INTO Librarian VALUES (246710121, 'Leah', TO_DATE('3/22/90', 'MM/DD/YY'),  101142222);
INSERT INTO Librarian VALUES (748201099, 'Wean',TO_DATE('11/19/18', 'MM/DD/YY'), 246710121);
INSERT INTO Librarian VALUES (342090842, 'Julia', TO_DATE('01/05/22', 'MM/DD/YY'), NULL);
-- LIBRARY CARDS(NUMBER,CUSTOMER_NAME,EXIPRATION_DATE,ZIP_CODE)
INSERT INTO LibraryCard VALUES (54321, 'Joseph', TO_DATE('10/25/21', 'MM/DD/YY'), 49221);
INSERT INTO LibraryCard VALUES (76543, 'Albert', TO_DATE('06/30/20', 'MM/DD/YY'), 49521);
INSERT INTO LibraryCard VALUES (76528, 'Sam',TO_DATE('12/24/23', 'MM/DD/YY'), 49420);
-- READING GROUPS(ID,GENRE,Name)
INSERT INTO ReadingGroup VALUES (1001, 'Fantasy', 'Fans of Fantasy');
INSERT INTO ReadingGroup VALUES (1002, 'True Crime Non-Fiction', 'Literary Detectives');
INSERT INTO ReadingGroup VALUES (1003, 'Religious Fiction', 'Our Philosophy');
-- TRANSACTION(TRANS_NUM, ORDER_DATE, RETURN_DATE,DUE_DATE,PENALTY,LIBRARIAN_SSN,CARD_NUM)
INSERT INTO Transaction VALUES (7654321,
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
INSERT INTO BookCopy VALUES (10,1234567891234,'Good',TO_DATE('01/05/99', 'MM/DD/YY'),7654321);
INSERT INTO BookCopy VALUES (1,9876543212022,'New',TO_DATE('10/22/12', 'MM/DD/YY'),12345);
INSERT INTO BookCopy VALUES (5, 9780316726610, 'Bad',TO_DATE('02/04/98', 'MM/DD/YY'),12347);
-- AUTHORS(AUTHOR_ISBN, AUTHOR_NAME)
INSERT INTO Authors VALUES (1234567891234, 'J. R. R. Tolkien');
INSERT INTO Authors VALUES (9876543212022, 'Suzanne Collins');
INSERT INTO Authors VALUES (9876543212022, 'Mitch Albom');
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
--SHOW ALL TABLES
SELECT * FROM Book;
SELECT * FROM Librarian;
SELECT * FROM LibraryCard;
SELECT * FROM ReadingGroup;
SELECT * FROM Transaction;
SELECT * FROM BookCopy;
SELECT * FROM Authors;
SELECT * FROM Joins;
--
/*Include the following items for every IC that you test (Important: see the next section titled
“Submit a final report” regarding which ICs you need to test).*/
	--− A comment line stating: Testing: < IC name>
	--− A SQL INSERT, DELETE, or UPDATE that will test the IC.
COMMIT;
--
SPOOL OFF
