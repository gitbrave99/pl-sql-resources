------------------COLECCIONES Y TIPO DE COMPUESTOS------------------
--------------------------------------------------------------------
    SON COMPONENTES QUE PUEDEN ALBEGAR MLTIPLES VALORES, A DIFRENCIA DE LOS
    ESCALARES QUE SOLO PUEDEN TENER 1

    SON DE 2 TIPOS
    RECORDS =  OBJTEO QUE TIENE UNA FILA CON COLUMNAS DE DISTINTOS TIPOS
    COLECCIONES O COLLECTIONS = GUARDAR MUCHOS VALORES DEL MISMO TIPO 
        ARRAYS ASOCIATIVOS(INDEX BY)
        NESTED TABLES
        VARRAYS
    

-------------RECORDS----------------

EJEMPLO:
    empleado EMPLOYEES%ROWTYPE
    
    TYPE empleado IS RECORD 
    (nombre VARCHAR2(100),
     salario NUMBER,
     fecha EMPLOYEES.HIRE_DATE%TYPE,
     datos_completos EMPLOYEES%ROWTYPE
    );

    emple1 empleado;



DEFINIDOS DE FORMA PERSONALIZADA
    TYPE nombre IS RECORD (campo1,campo2,...)
UNA VEZ DECLARADOS EL TIPO (PLANTILLA) PODEMOS CREAR VARIABLES DE ESTE TIPO
    variable TIPO;
LOS CAMPOS PUEDEN SER DE CUARQUIER TIPO, INCLUIDO OTROS RECORDS O COLLECTIONS
    PUEDE LLEVAR LA CLAUSULA NULL Y DEFAULT



-- PLSQL RECORDS    
SET SERVEROUTPUT ON;
DECLARE
    TYPE empleado IS RECORD
    ( 
     nombre VARCHAR2(100),
     salario NUMBER,
     fecha EMPLOYEES.HIRE_DATE%TYPE,
     datac EMPLOYEES%ROWTYPE
    );
    emp1 empleado;
    emp2 empleado;
BEGIN
    SELECT * INTO emp1.datac  FROM EMPLOYEES WHERE EMPLOYEE_ID = 108;
    emp1.nombre := emp1.datac.FIRST_NAME ||' ' ||emp1.datac.last_name;
    emp1.salario:= emp1.datac.SALARY;
    emp1.fecha  := emp1.datac.HIRE_DATE;

    DBMS_OUTPUT.PUT_LINE('Nombre: '||emp1.nombre);
    DBMS_OUTPUT.PUT_LINE('Salrio: '||emp1.salario);
    DBMS_OUTPUT.PUT_LINE('Fecha contratación: '||emp1.fecha);
    emp2:=emp1;
    DBMS_OUTPUT.PUT_LINE('Fecha contratación: '||emp2.fecha);
END;

-----INSERT
CREATE TABLE REGIONES AS SELECT * FROM REGIONS
SELECT * FROM REGIONES
delete from REGIONES 
DECLARE
    reg REGIONES%ROWTYPE;
BEGIN
    SELECT * INTO reg FROM REGIONS WHERE REGION_ID=4;
    INSERT INTO REGIONES VALUES reg;
    COMMIT;
END;
----UPDATE 
DECLARE
    reg REGIONS%TYPE;
BEGIN
    SELECT * INTO reg FROM REGIONS WHERE REGION_ID=4;
    
    INSERT INTO REGIONS VALUES(reg);

END;


-------------------------------------------------------------------
-------------------------------------------------------------------
-- ARRAYS ASOCIATIVOS    (INDEX BY TABLE)
-------------------------------------------------------------------
-------------------------------------------------------------------
        -- colecciones pl/sql con dos columnas 
        -- clave primaria de tipo entero o varchar  
        -- valores: tipo escalar o record
        -- no soporta booleanos

-- binary integer y pls_integer son mejores xq alamacenan la informacion 
    en un espacio mas corto

------------------------------------------------------
EJEMPLOS
    TYPE DEPARTAMENTOS IS TABLE OF
        DEPARTAMENTS.DEPARTMENT_NAME%TYPE
    INDEX BY PLS_INTEGER;

TYPE EMPLOYEES IS TABLE OF
    EMPLOYEES%ROWTYPE
INDEX BY PLS_INTEGER;
------------------------------------------------------
metodos de los ARRAYS
    - exists(n) = si existe elemento
    - count     = total elementos
    - first     = primer elemento
    - last      = ultimo elemento
    - prior(n)  = devuelve el indice anterior a N
    - next(n)   = devuelve el indice posterior a N
    - delete    = borra todo
    - delete(n) = borra el indice N
    - delete(m,n)= borra en un rango M a N

------------------------------------------------------
SET SERVEROUTPUT ON;
DECLARE
    TYPE DEPARTAMENTOS IS TABLE OF
        DEPARTMENTS.DEPARTMENT_NAME%TYPE
    INDEX BY PLS_INTEGER;

    TYPE EMPLEADOS IS TABLE OF
        EMPLOYEES%ROWTYPE
    INDEX BY PLS_INTEGER;

    DEPTS DEPARTAMENTOS;
    EMPLES EMPLEADOS;

BEGIN

        -- TIPO SIMPLE 
    DEPTS(1):='INFORMATICA';
    DEPTS(2):='RRHH';
    DBMS_OUTPUT.PUT_LINE('1. '||DEPTS(1));
    IF DEPTS.EXISTS(3) THEN
        DBMS_OUTPUT.PUT_LINE(3);    
    ELSE 
        DBMS_OUTPUT.PUT_LINE('No existe');    
        DBMS_OUTPUT.PUT_LINE('LAST: '||DEPTS.LAST);  
        DBMS_OUTPUT.PUT_LINE('FIRST: '||DEPTS.FIRST);  
    END IF;

        -- TIPO COMPLETO
    SELECT * INTO EMPLES(1) FROM EMPLOYEES WHERE EMPLOYEE_ID=100;
    DBMS_OUTPUT.PUT_LINE('Nombre: '||EMPLES(1).FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('Email: '||EMPLES(1).EMAIL);

END;


------------------------------------------------------------
SET SERVEROUTPUT ON;
DECLARE
    TYPE DEPARTAMENTOS IS TABLE OF
        DEPARTMENTS%ROWTYPE
    INDEX BY PLS_INTEGER;

    DEPTS DEPARTAMENTOS;
BEGIN

    FOR i IN 1..10 LOOP
        SELECT * INTO DEPTS(i) FROM DEPARTMENTS WHERE DEPARTMENT_ID=I*10;
    END LOOP;

    FOR i IN REVERSE DEPTS.FIRST..DEPTS.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(DEPTS(i).DEPARTMENT_NAME);        
    END LOOP;

END;


----------------------------------------------------------------
----------------------------------------------------------------
-------------------------PRACTICA------------------------

SET SERVEROUTPUT ON;
DECLARE
    TYPE EMPLE_RECORD IS RECORD
    (
        nombre EMPLOYEES.FIRST_NAME%TYPE,
        salario EMPLOYEES.SALARY%TYPE,
        cod_dept EMPLOYEES.DEPARTMENT_ID%TYPE
    );
    TYPE EMPLE_TABLE IS TABLE OF
        EMPLE_RECORD
    INDEX BY PLS_INTEGER;
    emp1 EMPLE_TABLE;
BEGIN
    FOR i IN 100..206 LOOP
        SELECT FIRST_NAME||' '||LAST_NAME,SALARY,DEPARTMENT_ID
        INTO emp1(i)
        FROM EMPLOYEES WHERE EMPLOYEE_ID=i;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('PRIMERO: '|| emp1(emp1.FIRST).nombre);
    DBMS_OUTPUT.PUT_LINE('ULTIMO: '|| emp1(emp1.LAST).nombre);
    DBMS_OUTPUT.PUT_LINE('CANTIDAD: '||emp1.COUNT);

    FOR i IN emp1.FIRST..emp1.LAST LOOP
        IF emp1(i).salario < 7000 THEN
            emp1.DELETE(i);
            DBMS_OUTPUT.PUT_LINE('ELIMINADO');
        END IF;
    END LOOP; 
    
    -- FOR i IN emp1.FIRST..emp1.LAST LOOP
    --     DBMS_OUTPUT.PUT_LINE('CANTIDAD: '||emp1(i).nombre);
    -- END LOOP;

    DBMS_OUTPUT.PUT_LINE('DESPUÉS: '||emp1(1).nombre);
    DBMS_OUTPUT.PUT_LINE('CANTIDAD: '||emp1.COUNT);
END;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
    AGREGAR EN UNA COLLECTION DEL TYPO EMPLOYEES%ROWTYPE CON UN CURSOR
    SET SERVEROUTPUT ON;
DECLARE
   TYPE empleado IS TABLE OF
        EMPLOYEES%ROWTYPE
    INDEX BY PLS_INTEGER;
    empf EMPLOYEES%ROWTYPE;
    CURSOR cemps IS SELECT * FROM EMPLOYEES;
    emps empleado;
    ind NUMBER:=1;
BEGIN
    OPEN cemps;
        LOOP
            FETCH cemps INTO empf;
            emps(ind):=empf;
            ind:=ind+1;
            EXIT WHEN cemps%NOTFOUND;
        END LOOP;
    CLOSE cemps;
        DBMS_OUTPUT.PUT_LINE('nombre: '||emps(emps.LAST).FIRST_NAME);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

