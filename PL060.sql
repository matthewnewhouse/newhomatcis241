-- PL060
-- author: JRA
-- -----------------------------------------------------------------
SET SERVEROUTPUT ON 
SET VERIFY OFF
-- ----------------------------------
ACCEPT boatName CHAR PROMPT 'Enter a boat name: '
ACCEPT ratingInc NUMBER PROMPT 'Enter an increment for ratings: '
ACCEPT allowedMaxRating NUMBER PROMPT 'Enter the max allowed rating: '
DECLARE
   sr     sailors%ROWTYPE;
   CURSOR sCursor IS
          SELECT S.sid, S.sname, S.rating, S.age, S.trainee
          FROM   sailors S, reservations R, boats B
          WHERE  S.sid = R.sid  AND 
                 R.bid = B.bid    AND
                 B.bname = '&boatName'
          ORDER BY S.sid;
--
BEGIN
   OPEN sCursor;
   LOOP
      -- Fetch the qualifying rows one by one
      FETCH sCursor INTO sr;
      EXIT WHEN sCursor%NOTFOUND;
      -- Print the sailor' old record
      DBMS_OUTPUT.PUT_LINE ('+++++ old row: '||sr.sid||' '
             ||sr.sname||sr.rating||'  '||sr.age||'  '||sr.trainee); 
      sr.rating := sr.rating + &ratingInc;

      -- A nested block
      DECLARE 
         aboveAllowedMax EXCEPTION;
      BEGIN  
         IF   sr.rating > &allowedMaxRating 
         THEN RAISE aboveAllowedMax;
         ELSE UPDATE sailors
              SET rating = sr.rating
              WHERE sailors.sid = sr.sid;
              -- Print the sailor' new record
             DBMS_OUTPUT.PUT_LINE ('+++++ new row: '||sr.sid||' '
                  ||sr.sname||sr.rating||'  '||sr.age||'  '||sr.trainee);    
         END IF;

      EXCEPTION
        WHEN aboveAllowedMax THEN
           DBMS_OUTPUT.PUT_LINE('+++++ Update rejected: '||
 			'The new rating would have been: '|| sr.rating);
        WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE('+++++ update rejected: ' ||
                                   SQLCODE||'...'||SQLERRM);
      END;
      -- end of the nested block
END LOOP;

   COMMIT;
   CLOSE sCursor;
END;
/

-- Let's see what happened to the database
SELECT S.sid, S.rating
FROM   sailors S, reservations R, boats B
WHERE  S.sid = R.sid  AND 
       R.bid = B.bid  AND
       B.bname = '&boatName';
--
UNDEFINE boatName
UNDEFINE ratingInc
UNDEFINE allowedMaxRating

