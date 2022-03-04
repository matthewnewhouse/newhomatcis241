-- File: companyDML-a2.sql 
-- SQL/DML (on the COMPANY database)
/*
--
IMPORTANT SPECIFICATIONS
--
(A)
-- Use the COMPANY database that you created in the previous DML assignment.
--
(B)
--Implement the queries below by ***editing this file*** to include
your name and your SQL code in the indicated places.   
--
(C)
After you have written the SQL code in the appropriate places:
-- Run this file (from the command line in sqlplus). It will produce the spooled file companyDML-a2.txt.
-- Upload the spooled file (companyDML-a2.txt) to BB.*/
--
*/
SPOOL companyDML-a2.txt
SET ECHO ON
-- ---------------------------------------------------------------
-- 
-- Name: Matthew Newhouse
--
-- ------------------------------------------------------------
--
/*(16A) Hint: A NULL in the hours column should be considered as zero hours.
Find the ssn, lname, and the total number of hours worked on projects for every employee whose total is less than 40 hours. Sort the result by lname
*/ 
SELECT E.ssn, E.lname, sum (W.hours)
FROM EMPLOYEE E, WORKS_ON W
WHERE E.ssn = W.essn
GROUP BY E.ssn, E.lname
HAVING sum (W.hours) < 40 or sum(W.hours) IS NULL
ORDER BY E.lname;
--
------------------------------------
-- 
/*(17A)
For every project that has more than 2 employees working on it: Find the project number, project name, number of employees working on it, and the total number of hours worked by all employees on that project. Sort the results by project number.
*/ 
SELECT P.pnumber, P.pname,count(W.pno), sum(W.hours)
FROM Project P, WORKS_ON W, EMPLOYEE E
WHERE E.ssn=W.essn and W.pno = P.pnumber
GROUP BY P.pnumber, P.pname
HAVING count(W.pno) > 2
ORDER BY P.pnumber;
-- 
-- CORRELATED SUBQUERY --------------------------------
--
/*(18A)
For every employee who has the highest salary in their department: Find the dno, ssn, lname, and salary. Sort the results by department number.
*/
-- <<< Your SQL code replaces this whole line>>>
--
-- NON-CORRELATED SUBQUERY -------------------------------
--
/*(19A)
For every employee who does not work on any project that is located in Houston: Find the ssn and lname. Sort the results by lname
*/
-- <<< Your SQL code replaces this whole line>>>
--
-- DIVISION ---------------------------------------------
--
/*(20A) Hint: This is a DIVISION query
For every employee who works on every project that is located in Stafford: Find the ssn and lname. Sort the results by lname
*/
-- <<< Your SQL code replaces this whole line>>>
--
SET ECHO OFF
SPOOL OFF


