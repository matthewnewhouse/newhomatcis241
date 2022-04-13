-- PL010
-- author: JRA
-- -----------------------------------------------------------
-- display result of procedure DBMS_OTPUT.PUT_LINE
SET SERVEROUTPUT ON 
-- Don't display the before/after caused by substitution variable, s
SET VERIFY OFF

-- declaring a bind variable, b, in SQL*plus
VARIABLE b NUMBER;

-- Entering a PL/SQL block - notice how we reference s and b.
BEGIN
   :b := &&q + 1;
   DBMS_OUTPUT.PUT_LINE('+++++ here it is .. '||:b||' and '|| &q);
END;
/
-- Now printing, in SQL*Plus, the bind variable b.
PRINT b;
UNDEFINE s   //just to clean up the environment
