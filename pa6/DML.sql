-- File: companyDML-a1.sql 
-- SQL/DML (on the COMPANY database)
/*
--
IMPORTANT SPECIFICATIONS
--
(A)
-- Download the script file PA-06-companyDB.sql and use it to create your COMPANY database in sqlplus.
-- Dowlnoad the file companyDBinstance.pdf; it is provided for your convenience when checking the results of your queries.
--
(B)
--Implement the queries below by ***editing this file*** to include
your name and your SQL code in the indicated places.   
--
(C)
After you have written the SQL code in the appropriate places:
-- Run this file (from the command line in sqlplus). It will produce the spooled file companyDML-a1.txt.
-- Upload the spooled file (companyDML-a1.txt) to BB.*/
--
*/
SPOOL companyDML-a1.txt
SET ECHO ON
-- ---------------------------------------------------------------
-- 
-- Name: Matthew Newhouse
--
-- ------------------------------------------------------------
-- NULL AND SUBSTRINGS -------------------------------
--
/*(10A)
Find the ssn and last name of every employee who doesn't have a  supervisor, or their last name contains at least two occurences of the letter 'a'. Sort the results by ssn.
*/
SELECT ssn, lname, super_ssn
FROM EMPLOYEE
WHERE super_ssn IS NULL or lname like '%a%a%'
ORDER BY SSN;

--
-- JOINING 3 TABLES ------------------------------
-- 
/*(11A)
For every employee who works more than 30 hours on any project: Find the ssn, lname, project number, project name, and number of hours. Sort the results by ssn.
*/
SELECT E.ssn, E.lname, P.pnumber, P.pname, W.hours
FROM EMPLOYEE E, WORKS_ON W, PROJECT P
WHERE E.ssn = W.essn and W.pno = P.pnumber and W.hours>30
ORDER BY E.SSN;
--
-- JOINING 3 TABLES ---------------------------
--
/*(12A)
Write a query that consists of one block only.
For every employee who works on a project that is not controlled by the department they work for: Find the employee's lname, the department they works for, the project number that they work on, and the number of the department that controls that project. Sort the results by lname.
*/
SELECT E.lname, E.dno, P.pnumber, P.dnum
FROM EMPLOYEE E, PROJECT P, WORKS_ON W 
WHERE W.pno = P.pnumber and P.dnum!=E.dno and W.essn = E.ssn
ORDER BY E.lname;
--
-- JOINING 4 TABLES -------------------------
--
/*(13A)
For every employee who works for more than 20 hours on any project that is located in the same location as their department: Find the ssn, lname, project number, project location, department number, and department location. Sort the results by lname
*/
SELECT E.ssn, E.lname, W.pno, P.plocation, P.dnum, L.dlocation
FROM WORKS_ON W, EMPLOYEE E, DEPT_LOCATIONS L, PROJECT P
WHERE W.hours>20 and P.plocation = L.dlocation and W.pno = P.pnumber and E.ssn = W.essn and E.dno = L.dnumber
ORDER BY E.lname;
--
-- SELF JOIN -------------------------------------------
-- 
/*(14A)
Write a query that consists of one block only.
For every employee whose salary is less than 70% of his/her immediate supervisor's salary: Find that employee's ssn, lname, salary; and their supervisor's ssn, lname, and salary. Sort the results by ssn.  
*/
SELECT E1.ssn, E1.lname, E1.salary, E1.super_ssn, E2.ssn, E2.lname, E2.salary
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.salary < E2.salary * .70 and E1.super_ssn = E2.ssn
ORDER BY E1.SSN;
--
-- USING MORE THAN ONE RANGE VARIABLE ON ONE TABLE -------------------
--
/*(15A)
For projects located in Houston: Find pairs of last names such that the two employees in the pair work on the same project. Remove duplicates. Sort the result by the lname in the left column in the result. 
*/
SELECT E1.lname,  E2.lname, P.pnumber, P.plocation
FROM PROJECT P, EMPLOYEE E1, EMPLOYEE E2, WORKS_ON W1, WORKS_ON W2
WHERE W1.essn = E1.ssn and W2.essn = E2.ssn and W1.pno = P.pnumber and W2.pno = P.pnumber and P.plocation = 'Houston' and E1.ssn < E2.ssn
ORDER BY E1.lname;
--
------------------------------------
--
SET ECHO OFF
SPOOL OFF


