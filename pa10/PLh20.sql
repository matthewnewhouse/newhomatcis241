-- File PLh20.sql
-- Author: Matthew Newhouse
-- -----------------------------------------
SET SERVEROUTPUT ON
SET VERIFY OFF
-- -----------------------------------------
ACCEPT rateDecrement NUMBER PROMPT 'Enter the rate decrement: '
ACCEPT allowedMinRate NUMBER PROMPT 'Enter the allowed min. rate: '
DECLARE
   sr boats%ROWTYPE;
   CURSOR sCursor IS
   	SELECT *
	FROM boats B
	WHERE B.bid NOT IN(SELECT DISTINCT R.bid FROM reservations R)
	ORDER BY B.bid;
BEGIN
   OPEN sCursor;
   LOOP
      FETCH sCursor INTO sr;
      EXIT WHEN sCursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('+++++ Boat - ' ||sr.bid||': Old Rate = '||sr.rate); 
      sr.rate := sr.rate - &rateDecrement;
      DECLARE
         belowAllowedMin EXCEPTION;
      BEGIN
	 IF sr.rate < &allowedMinRate
	 THEN RAISE belowAllowedMin;
	 ELSE UPDATE boats
	      SET rate = sr.rate
	      WHERE boats.bid = sr.bid;
	      DBMS_OUTPUT.PUT_LINE('----- Boat - ' ||sr.bid||': New Rate = '||sr.rate);  
	 END IF;
      EXCEPTION
        WHEN belowAllowedMin THEN
	   DBMS_OUTPUT.PUT_LINE('----- Boat - ' ||sr.bid||': Update rejected; The new rate would have been ' || sr.rate);
        WHEN OTHERS THEN
	   DBMS_OUTPUT.PUT_LINE('----- Boat - ' ||Sr.bid||': Update rejected; '|| SQLCODE||'...'||SQLERRM);
      END;
END LOOP;
   COMMIT;
   CLOSE sCursor;
END;
/
SELECT *
FROM boats B
WHERE B.bid NOT IN(SELECT DISTINCT R.bid FROM reservations R)
ORDER BY B.bid;
--
UNDEFINE rateDecrement
UNDEFINE allowedMinRate
