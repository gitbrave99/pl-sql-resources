-- USAR SQL CON PL/SQL

-----------------------------------------------
ejemplo solo para una fila

SET SERVEROUTPUT ON
DECLARE 
    salario NUMBER;
    nombre EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT SALARY,FIRST_NAME INTO salario,nombre
    FROM EMPLOYEES WHERE EMPLOYEE_ID=100;
    DBMS_OUTPUT.PUT_LINE(nombre||' su SALARIO ='||salario);
END;

----------------------------------------------
-- ejemplo con rowtype  una sola fila

SET SERVEROUTPUT ON
DECLARE 
    empleado EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO empleado
    FROM EMPLOYEES WHERE EMPLOYEE_ID=100;
    DBMS_OUTPUT.PUT_LINE(empleado.FIRST_NAME||' su SALARIO ='||empleado.SALARY);
END;

------------------------------------------------------------------
-- PRACTICA
SALARIO MAXIMO DPARTAMENTO 100
SET SERVEROUTPUT ON
DECLARE 
    empleado EMPLOYEES%ROWTYPE;
    salario_maximo NUMBER;
BEGIN

    SELECT SALARY INTO salario_maximo FROM EMPLOYEES emp
    WHERE ROWNUM =1 AND DEPARTMENT_ID=100
    ORDER BY SALARY DESC;

    DBMS_OUTPUT.PUT_LINE('salrio maximo: '|| salario_maximo);
END;


SET SERVEROUTPUT ON
DECLARE 
    salario_maximo NUMBER;
    salario_minimo salario_maximo%TYPE; 
BEGIN

    SELECT MAX(SALARY),MIN(SALARY) INTO salario_maximo,salario_minimo FROM EMPLOYEES;
    

    DBMS_OUTPUT.PUT_LINE('diferencia de salarios: : '|| (salario_maximo-salario_minimo));
END;


--INSERT
 DECLARE 
    c1 TEST.c1%TYPE;
 BEGIN
    c1:=20;
    INSERT INTO TEST(c1,c2) VALUES(c1,'second test');
    COMMIT;
 END;


--UPDATE
DECLARE 
    c1 TEST.c1%TYPE;
 BEGIN
    c1:=10;
    UPDATE TEST SET c2='updated test' WHERE c1=10;
    COMMIT;
 END;
--DELETE

DECLARE
    id TEST.C1%TYPE:=10;
BEGIN
    DELETE FROM TEST WHERE C1=id;
    INSERT INTO TEST(c1,c2) VALUES(30,'test 10 deleted');
    commit;
END;

 select * from test
------------------------------------------------------------------


DECLARE
    maxid NUMBER;
BEGIN
    select DEPARTMENT_ID INTO maxid from DEPARTMENTS;
    maxid:=maxid+1;
    
    insert into DEPARTMENTS(DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
    VALUES(maxid ,'INFORMATICA', 100,1000);
    COMMIT;
END;

------------------------------------------------------------------