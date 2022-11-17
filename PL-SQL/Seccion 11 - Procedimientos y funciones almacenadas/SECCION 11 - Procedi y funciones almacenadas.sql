LOS PARAMETROS NO SE PUDEN MODIFICAR SOLO SON DE LECTURA

    SINTAXIS
CREATE PROCEDURE P1 
    IS 
-- ZONA DE DECLARACION
    edad number:=10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('EDAD: '||edad);
    
END;


LLAMADO DE PROCEDIMIENTOS
-
    SET SERVEROUPUT ON;
    BEGIN 
        NOMBRE_PROCEDURE;
    END;

- EXECUTE NOMBRE_PROCEDURE;


*************************************************************************************
*************************************************************************************
    PROCEDIMIENTOS CON PARÁMETROS

SET SERVEROUTPUT ON;
---------------------------------------------
        -- PARAMETROS TIPO IN
---------------------------------------------
CREATE OR REPLACE PROCEDURE CALC_TAX(iEmple IN EMPLOYEES.EMPLOYEE_ID%TYPE, T IN NUMBER)
IS
    vTax NUMBER:=0;
    vSal vTax%TYPE:=0;
    --EXCEPCION PARA VALIDAR QUE EL TAX NO SEA NEGATIVO
    exTaxPositive EXCEPTION;
BEGIN
    SELECT SALARY INTO vSal FROM EMPLOYEES WHERE EMPLOYEE_ID=iEmple;
    IF T >= 0 AND T < 61 THEN
        vTax:=vSal * T/100;
        DBMS_OUTPUT.PUT_LINE('NAME: '|| vSal);
        DBMS_OUTPUT.PUT_LINE('TAX: '|| vTax);
    ELSE
        RAISE exTaxPositive;
        -- RAISE_APPLICATION_ERROR(-20000,'El porcentaje debe estar entre  0 y 60');
    END IF;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('No existe el empleado');

    WHEN exTaxPositive THEN
        DBMS_OUTPUT.PUT_LINE('El rango de impuesto es  0 - 60: '||T);
        -- vTax:=vTax *-1;
        -- vTax:=vSal * T/100;
        -- DBMS_OUTPUT.PUT_LINE('SALARIO: '|| vSal);
        -- DBMS_OUTPUT.PUT_LINE('TAX: '|| vTax);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CÓDIGO DE ERROR: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE('MENSAJE DE ERROR: '||SQLERRM);
END;

-- LLAMADO DEL PROCEDIMIENTO 
    BEGIN
        CALC_TAX(100,90);
    END;







    SET SERVEROUTPUT ON;
---------------------------------------------
        -- PARAMETROS TIPO OUT
---------------------------------------------
CREATE OR REPLACE PROCEDURE CALC_TAX_OUT(iEmple IN EMPLOYEES.EMPLOYEE_ID%TYPE, T IN NUMBER, R1 OUT NUMBER)
IS
    -- vTax NUMBER:=0;
    vSal NUMBER:=0;
    --EXCEPCION PARA VALIDAR QUE EL TAX NO SEA NEGATIVO
    exTaxPositive EXCEPTION;
BEGIN
    IF T >= 0 AND T < 61 THEN
        SELECT SALARY INTO vSal FROM EMPLOYEES WHERE EMPLOYEE_ID=iEmple;
        R1:=vSal * T/100;
        DBMS_OUTPUT.PUT_LINE('SALARIO: '||vSal);
    ELSE
        RAISE exTaxPositive;
    END IF;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('No existe el empleado');
    WHEN exTaxPositive THEN
        DBMS_OUTPUT.PUT_LINE('El rango de impuesto es  0 - 60: '||T);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CÓDIGO DE ERROR: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE('MENSAJE DE ERROR: '||SQLERRM);
END;

-- LLAMADO DEL PROCEDIMIENTO 
DECLARE
    R NUMBER;
BEGIN
    CALC_TAX_OUT(100,20,R);
    DBMS_OUTPUT.PUT_LINE('TAX: '||R);
END;

------------------------------------------------------------------------------
******************************************************************************
------------------------------------------------------------------------------
SET SERVEROUTPUT ON;
---------------------------------------------
        -- PARAMETROS TIPO IN/OUT
---------------------------------------------
CREATE OR REPLACE PROCEDURE CAL_TAX_INOUT(iIdEmple IN EMPLOYEES.EMPLOYEE_ID%TYPE,iTAX IN OUT NUMBER )
IS 
    salario EMPLOYEES.SALARY%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('TAX inicio: '||iTAX);
    IF iTAX < 61 AND iTAX >=0 THEN
        SELECT SALARY INTO salario FROM EMPLOYEES WHERE EMPLOYEE_ID=iIdEmple;
        iTAX:=salario * iTAX/100;
        DBMS_OUTPUT.PUT_LINE('SALARIO: '||salario);
    ELSE
        RAISE_APPLICATION_ERROR(-20000,'El impuesto de estar entre 0 y 60');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('HAY DATOS');
END;

------------LLAMADO

DECLARE
    idEmployee NUMBER:=120;
    tax NUMBER:=10;
BEGIN
    CAL_TAX_INOUT(idEmployee,tax);
    DBMS_OUTPUT.PUT_LINE('IMPUESTO:'||tax);
END;

------------------------------------------------------------------------------
******************************************************************************
------------------------------------------------------------------------------
------------------------------------------------------------------------------
******************************************************************************
------------------------------------------------------------------------------

    PRACTICA
-- 1- Crear un procedimiento llamado “visualizar” que visualice el nombre y
-- salario de todos los empleados.

CREATE OR REPLACE PROCEDURE visualizar IS
    CURSOR cAllEmps IS SELECT * FROM EMPLOYEES ORDER BY EMPLOYEE_ID ASC;
    empf EMPLOYEES%ROWTYPE;
BEGIN
    OPEN cAllEmps;
        LOOP
            FETCH cAllEmps INTO empf;
                DBMS_OUTPUT.PUT_LINE('NOMBRE: '||empf.FIRST_NAME||' SALARIO: '||empf.SALARY);
        EXIT WHEN cAllEmps%NOTFOUND;
        END LOOP;
    CLOSE cAllEmps;
END;

BEGIN 
    visualizar;
END;

-- 2- Modificar el programa anterior para incluir un parámetro que pase el número de departamento para que
-- visualice solo los empleados de ese departamento
-- • Debe devolver el número de empleados en una variable de tipo OUT

CREATE OR REPLACE PROCEDURE visualizar(idDept IN DEPARTMENTS.DEPARTMENT_ID%TYPE, oNumEmps OUT NUMBER) IS
    vTotalEmps NUMBER:=0;
BEGIN
    SELECT COUNT(*) INTO oNumEmps FROM EMPLOYEES WHERE DEPARTMENT_ID = idDept;
END;

DECLARE
    DEPARTMENT_ID NUMBER:=20;
    total NUMBER:=0;
BEGIN 
    visualizar(DEPARTMENT_ID,total);
    DBMS_OUTPUT.PUT_LINE('Total de empleados: '||total);
END;    




/*
3- Crear un bloque por el cual se de formato a un número de cuenta
   suministrado por completo, por ejmplo: 11111111111111111111
   
    • Formateado a: 1111-1111-11-1111111111
    • Debemos usar un parámetro de tipo IN-OUT
*/

SET SERVEROUTPUT ON;
CREATE PROCEDURE pFormatAccountNumber(cuenta IN OUT VARCHAR2)
IS
    guardar1 VARCHAR2(20);
    guardar2 VARCHAR2(20);
    guardar3 VARCHAR2(20);
    guardar4 VARCHAR2(20);
BEGIN

    guardar1:= SUBSTR(cuenta,1,4);
    guardar2:= SUBSTR(cuenta,5,4);
    guardar3:= SUBSTR(cuenta,9,2);
    guardar4:= SUBSTR(cuenta,10);
    cuenta:= guardar1||'-'||guardar2||'-'||guardar3||'-'||guardar4;
END;

DECLARE
    cuenta VARCHAR2(30):='11111111111111111111';
BEGIN
    pFormatAccountNumber(cuenta);
    DBMS_OUTPUT.PUT_LINE('formateado: '||cuenta);
END;



----------------------------------------------------------------------------------------
****************************************************************************************
----------------------------------------------------------------------------------------

    FUNCIONES
recomendacion usar tipo in out / out solo en PROCEDIMIENTOS

--FUNCIONES
CREATE OR REPLACE FUNCTION fCalcTax
(iIdEmp IN EMPLOYEES.EMPLOYEE_ID%TYPE,T IN NUMBER)
RETURN NUMBER
IS
    tax NUMBER:=0;
    sal NUMBER:=0;
BEGIN
    IF T < 61 AND T >=0 THEN
        SELECT SALARY INTO sal FROM EMPLOYEES WHERE EMPLOYEE_ID=iIdEmp;
        tax:=sal*T/100;
        RETURN tax;
    END IF;
EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

--LLAMADO DE FUNCTION

SET SERVEROUTPUT ON;

DECLARE
    ide NUMBER:=120;
    tax NUMBER:=20;
    res NUMBER;
BEGIN
    res:= fCalcTax(ide,tax);
    DBMS_OUTPUT.PUT_LINE('ID: '||ide||' tax: '||res);
END;



-- FUNCION CON COMANDOS SQL 
    SELECT FIRST_NAME, SALARY, fCalcTax(EMPLOYEE_ID,20) AS "IMPUESTO"  FROM EMPLOYEES


    
-----------------------------------------------------------------------------------------------------------
--*********************************************************************************************************
-----------------------------------------------------------------------------------------------------------
-- practica--FUNCIONES


-----------------------------------------------------------------------------------------------------------
--*********************************************************************************************************
-----------------------------------------------------------------------------------------------------------
-- PRACTICA
/*
1. Crear una función que tenga como parámetro un número de departamento y que devuelve la suma 
    de los salarios de dicho departamento. La imprimimos por pantalla.
• Si el departamento no existe debemos generar una excepción con dicho mensaje
• Si el departamento existe, pero no hay empleados dentro, también debemos generar una excepción para indicarlo
*/


CREATE OR REPLACE FUNCTION fGetTotalEmployeesByDept(iIdDept IN NUMBER)
RETURN NUMBER
IS
    vtotalemps NUMBER:=0;
    vidDept NUMBER:=0;
BEGIN
    SELECT DEPARTMENT_ID INTO vidDept FROM DEPARTMENTS WHERE DEPARTMENT_ID = iIdDept;
    IF  vidDept > 0 THEN
        SELECT COUNT(*) INTO vtotalemps FROM EMPLOYEES WHERE DEPARTMENT_ID= vidDept;
        IF vtotalemps < 1 THEN
            DBMS_OUTPUT.PUT_LINE('EXISTE EL DEPARTAMENTO PERO NO HAY EMPLEADOS');
            vtotalemps:=0;
        ELSE
            DBMS_OUTPUT.PUT_LINE('SI HAY EMPLEADOS');
        END IF;
    END IF;
    RETURN vtotalemps;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO HAY DATOS');
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
--***********************************
--LLAMADO
DECLARE
    total NUMBER:=0;
BEGIN
    total:= fGetTotalEmployeesByDept(10);
    DBMS_OUTPUT.PUT_LINE('total: '||total);
END;

/*
2. Modificar el programa anterior para incluir un parámetro de tipo OUT por
    el que vaya el número de empleados afectados por la query. Debe ser
    visualizada en el programa que llama a la función. De esta forma vemos
    que se puede usar este tipo de parámetros también en una función
    CALCULAR EL SALARIO TOTAL DEL DEPARTAMENTO
*/
CREATE OR REPLACE FUNCTION fGetTotalEmployeesByDept(iIdDept IN NUMBER, n_emples OUT NUMBER)
RETURN NUMBER
IS
    vtotalsal NUMBER:=0;
    vidDept NUMBER:=0;
BEGIN
    SELECT DEPARTMENT_ID INTO vidDept FROM DEPARTMENTS WHERE DEPARTMENT_ID = iIdDept;
    -- IF  vidDept > 0 THEN
        SELECT COUNT(*),SUM(SALARY) INTO n_emples,vtotalsal FROM EMPLOYEES WHERE DEPARTMENT_ID= vidDept;
        IF n_emples < 1 THEN
            DBMS_OUTPUT.PUT_LINE('EXISTE EL DEPARTAMENTO PERO NO HAY EMPLEADOS');
        ELSE
            DBMS_OUTPUT.PUT_LINE('SI HAY EMPLEADOS');
        END IF;
    -- END IF;
    RETURN vtotalsal;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO HAY DATOS');
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
--***********************************
--LLAMADO
DECLARE
    idDept NUMBER:=20;
    totalSal NUMBER:=0;
    totalEmps NUMBER:=0;
BEGIN
    totalSal:= fGetTotalEmployeesByDept(idDept,totalEmps);
    DBMS_OUTPUT.PUT_LINE('total salario: '||totalSal);
    DBMS_OUTPUT.PUT_LINE('total empleados: '||totalEmps);
END; 


--******************************************************************************************
/*
Crear una función llamada CREAR_REGION,
    • A la función se le debe pasar como parámetro un nombre de región y debe devolver un número, que es el código de región
        que calculamos dentro de la función
    • Se debe crear una nueva fila con el nombre de esa REGION
    • El código de la región se debe calcular de forma automática. Para ello se debe averiguar cual es el código de región más
        alto que tenemos en la tabla en ese momento, le sumamos 1 y el resultado lo ponemos como el código para la nueva región
        que estamos creando.
    • Si tenemos algún problema debemos generar un error
    • La función debe devolver el número que ha asignado a la región
*/

CREATE OR REPLACE FUNCTION FCREAR_REGION(piNombre IN VARCHAR2)
RETURN NUMBER
IS
    fregion REGIONS%ROWTYPE;
    lastid REGIONS.REGION_ID%TYPE;
    genid lastid%TYPE;
BEGIN
    SELECT REGION_ID INTO lastid FROM REGIONS WHERE ROWNUM = 1 ORDER BY REGION_ID DESC;
    genid:= lastid + 1;
    -- Insert rows in a Table
    INSERT INTO REGIONS (REGION_ID, REGION_NAME) VALUES(genid, piNombre);
    RETURN genid;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

---**********LLAMADO FUNCTION
DECLARE
    nmDept VARCHAR2(30):='ALGO';
    codDept NUMBER:=0;
BEGIN
    codDept:= FCREAR_REGION(nmDept);
    DBMS_OUTPUT.PUT_LINE('NUEVO CÓDIGO : '||codDept);
END; 
