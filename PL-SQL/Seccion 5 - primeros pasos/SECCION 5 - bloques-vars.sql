las variables declaradas en los hijos no pueden ser accedidas en el padre
pesi la delos padrea alos hijos porque son globales

SET SERVEROUTPUT ON

DECLARE
    nombre VARCHAR(100) := 'isaac'; --varible global
BEGIN
    dbms_output.put_line('nombre: ' || nombre);
    DECLARE
        nombre VARCHAR(100) := 'jacob'; --variable local al bloque
    BEGIN
        dbms_output.put_line('nombre: ' || nombre);
    END;

END;

SET SERVEROUTPUT ON
DECLARE
    nombre varchar2(100);
    yearA CONSTANT NUMBER:=2023;
    fechaNac date:='31-03-1999';
    n3 number null:=12;
    n1 number:=12;
    n2 number:=12;
    mayorEdad BOOLEAN;
BEGIN
    nombre:='isaac';
    mayorEdad:=FALSE;
    mayorEdad:=TRUE;
    mayorEdad:=NULL;
    DBMS_OUTPUT.PUT_LINE('Suma: '||(n1+n2));
    DBMS_OUTPUT.PUT_LINE('Nombre: '||nombre||'Año: '||n3||' fecha nacimiento: '||fechaNac);
END;    

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON
DECLARE

    impuesto constant number:=21;
    precio number(5,2);
    resultado precio%TYPE;
    
BEGIN
    precio:=100.50;
    resultado:= precio*impuesto/100;
    DBMS_OUTPUT.PUT_LINE('Impuesto: '||resultado);
END;  


--------------------------------------
---------------------------------------
--exepciones no predefinidas

SET SERVEROUTPUT ON
DECLARE
   MI_EXCEP EXCEPTION;
   PRAGMA EXCEPTION_INIT(MI_EXCEP,-937);
   V1 NUMBER;
   V2 NUMBER;
BEGIN
    SELECT EMPLOYEE_ID,SUM(SALARY) INTO V1,V2 FROM EMPLOYEES; 
    DBMS_OUTPUT.PUT_LINE(V1);
EXCEPTION
   WHEN MI_EXCEP THEN 
       DBMS_OUTPUT.PUT_LINE('FUNCION DE GRUPO INCORRECTA');
   WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INDEFINIDO');
END;

--------------------------------------
--------------------------------------
exceptiones predefinidas
SET SERVEROUTPUT ON
DECLARE
    EMPL EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO EMPL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID>1;
    
    DBMS_OUTPUT.PUT_LINE(EMPL.FIRST_NAME);
EXCEPTION
-- NO_DATA_FOUND   ORA-01403
-- TOO_MANY_ROWS
-- ZERO_DIVIDE
-- DUP_VAL_ON_INDEX
   WHEN NO_DATA_FOUND THEN 
       DBMS_OUTPUT.PUT_LINE('ERROR, EMPLEADO INEXISTENTE');
  WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR, DEMASIADOS EMPLEADO');
   WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INDEFINIDO');

END;
