
-- NATURAL JOIN 
    -- no es recomendable usar si hay mas de 2 columnas iguales en las tablas
        -- combinación natural: realiza un join entre dos tablas cuando los campos por los  
        -- cuales se enlazan tienen el mismo nombre. Involucra claves primarias y foráneas.

SELECT * FROM REGIONS NATURAL JOIN COUNTRIES;

SELECT REGION_ID, REGION_NAME,COUNTRY_ID, COUNTRY_NAME FROM REGIONS RG NATURAL JOIN COUNTRIES C;

SELECT REGION_NAME, COUNTRY_NAME FROM REGIONS RG NATURAL JOIN COUNTRIES C;


----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- CLAUSULA USING
    --usado para decir de manera explicita la columna q relaciona las tablas
-- COUNT=104 ==
SELECT D.DEPARTMENT_NAME, E.FIRST_NAME FROM EMPLOYEES  E
JOIN DEPARTMENTS D 
USING (DEPARTMENT_ID) --como columna de union
where E.SALARY > 100

-- COUNT=31 == sale menos xq hay un conficto en dos id que son manager_id y departmen_id
SELECT DEPARTMENT_NAME, FIRST_NAME FROM EMPLOYEES
NATURAL JOIN DEPARTMENTS;


----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- ON
    -- PUEDO RELACIONAR TABLAS CUANDO LAS COLUMNAS sean diferentes
SELECT D.DEPARTMENT_NAME, E.FIRST_NAME FROM EMPLOYEES  E
JOIN DEPARTMENTS D 
on (E.DEPARTMENT_ID=D.DEPARTMENT_ID) --como columna de union
    -- on (E.DEPARTMENT_ID<>D.DEPARTMENT_ID) --como columna de union
where E.SALARY > 100


    -- PUEDO RELACIONAR TABLAS CUANDO LAS COLUMNAS sean diferentes
SELECT D.DEPARTMENT_NAME, E.FIRST_NAME FROM EMPLOYEES  E
JOIN DEPARTMENTS D 
on (E.DEPARTMENT_ID=D.DEPARTMENT_ID) --como columna de union
join LOCATIONS L    
on (D.LOCATION_ID= L.LOCATION_ID)
AND SALARY > 300


----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- JOINS CON WHERE
    -- RECOMENDACION =utilizar join en enlace de tablas
select DEPARTMENT_NAME, FIRST_NAME
from EMPLOYEES e, DEPARTMENTS d, LOCATIONS L
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
    and D.LOCATION_ID = L.LOCATION_ID


----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- SELF-JOINS

SELECT TRABAJADOR.EMPLOYEE_ID, TRABAJADOR.FIRST_NAME AS "EMPLEADO", 
JEFE.EMPLOYEE_ID, JEFE.FIRST_NAME AS "JEFE"
FROM EMPLOYEES TRABAJADOR JOIN EMPLOYEES JEFE
ON (TRABAJADOR.MANAGER_ID = JEFE.EMPLOYEE_ID)

----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- JOINS SIN IGUALDAD:NON-EQUIJOINS

select DEPARTMENT_NAME 
from DEPARTMENTS D JOIN LOCATIONS L
on D.LOCATION_ID <> L.LOCATION_ID
and L.CITY ='Seattle'

select * from EMPLOYEES

----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- OUTER-JOINS
    -- LEFT OUTER
    -- RIGHT OUTER
    -- FULL OUTER

-- muestra el DEPARTMENT_ID nullo en departments que no se le asigno a un empleado
SELECT DEPARTMENT_NAME, FIRST_NAME FROM DEPARTMENTS D
RIGHT OUTER JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- muestra todos los departamentos aunque sean nulos 
SELECT DEPARTMENT_NAME, FIRST_NAME FROM DEPARTMENTS D
LEFT OUTER JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- muestra el departamento nulo que no tiene empleado, y todos los departamentos
SELECT DEPARTMENT_NAME, FIRST_NAME FROM DEPARTMENTS D
FULL OUTER JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;


----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- USO DE WITH SON COMO TABLAS TEMPORALES

SELECT DEPARTMENT_ID, DEPARTMENT_NAME, SUM(SALARY) AS SALARY FROM EMPLOYEES
JOIN DEPARTMENTS
USING (DEPARTMENT_ID)
GROUP BY DEPARTMENT_ID,DEPARTMENT_NAME
HAVING SUM(SALARY) > 400;

WITH SUMA_SALARIO AS 
    (SELECT DEPARTMENT_ID,DEPARTMENT_NAME,SUM(SALARY) AS SALARIO FROM EMPLOYEES
     GROUP BY DEPARMENT_ID)
     SELECT * FROM SUMA_SALARIO WHERE SALARIO > 2000;


WITH
    SUMA_SALARIOS AS (SELECT DEPARTMENT_ID,SUM(SALARY) AS SALARIOS FROM EMPLOYEES GROUP BY DEPARTMENT_ID),
    NUM_EMPLEADOS AS (SELECT DEPARTMENT_ID,COUNT(*)      AS EMPLEADOS FROM EMPLOYEES GROUP BY DEPARTMENT_ID)
SELECT DEPARTMENT_NAME,SALARIOS,EMPLEADOS
FROM 
    DEPARTMENTS,
    SUMA_SALARIOS,
    NUM_EMPLEADOS
WHERE
    DEPARTMENTS.DEPARTMENT_ID = SUMA_SALARIOS.DEPARTMENT_ID
    AND DEPARTMENTS.DEPARTMENT_ID = NUM_EMPLEADOS.DEPARTMENT_ID



























