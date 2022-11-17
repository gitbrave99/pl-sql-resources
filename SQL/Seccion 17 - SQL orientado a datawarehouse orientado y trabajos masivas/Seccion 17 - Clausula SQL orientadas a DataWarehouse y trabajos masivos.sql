----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- INLINE VIEW
CREATE VIEW VISTA_EMPLE AS SELECT * FROM EMPLOYEES ORDER BY SALARY DESC;
SELECT * FROM VISTA_EMPLE;

-- EJEMPLO  DE VIEW INLINE
    SELECT FIRST_NAME, SALARY FROM (SELECT * FROM EMPLOYEES ORDER BY SALARY DESC);

-- EJEMPLODE INSERT 
    INSERT INTO (SELECT * FROM REGION1) VALUES(7,'ALGO TEST INLINE VIEW')

-- EJEMPLO DE UPDATE
    UPDATE (SELECT * FROM REGION1 WHERE REGION_ID = 7) SET REGION_NAME ='TEST VIEW INLINE'





----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- INSERT ALL-SIN CONDICIONES: INSERT DATOS EN MULTIPLES TABLAS AL MISMO TIEMPO
-- * hace la insercion sin condiciones. por cada fila de la subconsulta se inserta una fila en las TABLAS de destino

-- INSERT ALL-CON CONDICIONES:
    -- por cada fila de la subconsulta se inserta una fila en las tablas de destino basado en una condicion

-- INSERT FIRST-CON CONDICIONES
    -- por cada fila de la subconsulta se inserta una fila en la primera tabla de destino que cumpla una condicion

-- PIVOTING INSERT
    -- convertir una fila no relacional en una fila normalizada. 
    CREATE TABLE NOM_EMPLES(
        COD_EMPLE NUMBER,
        FIRST_NAME VARCHAR2(100)
    )

    CREATE TABLE SALARIOS (
        COD_EMPLE NUMBER,
        SALARIO NUMBER
    )

-- EJEPMLO PARA VARIAS FILAS
-- en values(columas segun elquery de select...employess)
INSERT ALL 
    INTO NOM_EMPLES(COD_EMPLE,FIRST_NAME) VALUES(EMPLOYEE_ID,FIRST_NAME)
    INTO SALARIOS(COD_EMPLE,SALARIO) VALUES(EMPLOYEE_ID,SALARY)           
SELECT * FROM EMPLOYEES;    

-- EJEMPLO PARA INSERTAR UNA SOLA FILA
INSERT ALL
    INTO NOM_EMPLES VALUES(3000,'ALGO')
    INTO SALARIOS VALUES(300,1200)
SELECT 1 FROM DUAL;


----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- INSERT ALL-CON CONDICIONES:
CREATE TABLE EMPLES_FEJES(COD_EMPLE NUMBER,NOMBRE VARCHAR2(100), SALARIO NUMBER);
CREATE TABLE EMPLES_MANDOS(COD_EMPLE NUMBER,NOMBRE VARCHAR2(100), SALARIO NUMBER,DEPARTMENTO NUMBER);
CREATE TABLE EMPLES_NORMALES(COD_EMPLE NUMBER, NOMBRE VARCHAR2(100), SALARIO NUMBER,RESPONSABLE NUMBER);

INSERT ALL
    WHEN SALARY > 1000 THEN
        INTO EMPLES_FEJES VALUES(EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY)
    WHEN SALARY BETWEEN 800 AND 999 THEN
        INTO EMPLES_MANDOS VALUES(EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY, DEPARTMENT_ID)
    WHEN SALARY < 800 THEN
        INTO EMPLES_NORMALES VALUES(EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY, MANAGER_ID)
    WHEN DEPARTMENT_ID=100 THEN
        INTO FINANCIERO VALUES(EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY, MANAGER_ID)
SELECT * FROM EMPLOYEES;

select count(*) from FINANCIERO
union all
select count(*) from EMPLES_NORMALES

CREATE TABLE FINANCIERO(
    COD_EMPLE NUMBER, 
    NOMBRE VARCHAR2(100), 
    SALARIO NUMBER,
    RESPONSABLE NUMBER
)


----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- INSERT FIRST:
INSERT FIRST
    WHEN SALARY > 1000 THEN
        INTO EMPLES_FEJES VALUES(EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY)
    WHEN SALARY BETWEEN 800 AND 999 THEN
        INTO EMPLES_MANDOS VALUES(EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY, DEPARTMENT_ID)
    WHEN SALARY < 800 THEN
        INTO EMPLES_NORMALES VALUES(EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY, MANAGER_ID)
    WHEN DEPARTMENT_ID=100 THEN
        INTO FINANCIERO VALUES(EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY, MANAGER_ID)
SELECT * FROM EMPLOYEES;

select count(*) from FINANCIERO
union 
select * from EMPLES_FEJES
UNION
select count(*) from EMPLES_MANDOS
UNION
select count(*) from EMPLES_NORMALES


----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
--OPERADOR WITH
-- SUBQUERY FACTORING CLAUSE
                            -- ALIAS.COLUMNA
SELECT E.FIRST_NAME AS NOMBRE, DC.NUM_EMPLE AS NUMERO_EMPLEADOS,E.DEPARTMENT_ID
FROM EMPLOYEES E,
    (SELECT DEPARTMENT_ID, COUNT(*) AS NUM_EMPLE FROM EMPLOYEES GROUP BY DEPARTMENT_ID) DC -- ALIAS A LA CONSULTA
WHERE E.DEPARTMENT_ID = DC.DEPARTMENT_ID;


SELECT DEPARTMENT_ID, COUNT(*) AS NUM_EMPLE FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

WITH VISTA_NUM_EMPLE AS
    ( SELECT DEPARTMENT_ID, COUNT(*) AS NUM_EMPLE FROM EMPLOYEES GROUP BY DEPARTMENT_ID)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME AS NOMBRE, DC.NUM_EMPLE AS NUMERO_EMPLEADOS,E.DEPARTMENT_ID
FROM EMPLOYEES E, VISTA_NUM_EMPLE DC
WHERE E.DEPARTMENT_ID = DC.DEPARTMENT_ID
ORDER BY E.FIRST_NAME ASC;  
 

WITH SUM_SALARIO AS (SELECT DEPARTMENT_ID,SUM(SALARY) AS SALARIO_DEPARTAMENTO FROM EMPLOYEES GROUP BY DEPARTMENT_ID),
     NUM_EMPLE AS (SELECT DEPARTMENT_ID,COUNT(*) AS NUM_EMPLEADOS FROM EMPLOYEES GROUP BY DEPARTMENT_ID),
     NUM_EMPLE_TOTAL AS (SELECT COUNT(*) AS TOTAL_EMPLEADOS FROM EMPLOYEES)
SELECT DEPARTMENT_NAME, SALARIO_DEPARTAMENTO,NUM_EMPLEADOS,TOTAL_EMPLEADOS
FROM
DEPARTMENTS NATURAL JOIN SUM_SALARIO NATURAL JOIN NUM_EMPLE,NUM_EMPLE_TOTAL;

