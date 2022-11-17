--FUNCIONENES DE GRUPO
    -- APPROX_COUNT_DISTINCT
    -- AVG
    -- COUNT
    -- MIN
    -- MAX
    -- MEDIAN
    -- RANK

-- AVG(NUMBER)
select AVG(SALARY) from EMPLOYEES
-- MAX(NUMBER)
select MAX(SALARY) from EMPLOYEES
-- MIN(NUMBER)
select MIN(SALARY) from EMPLOYEES

SELECT AVG(SALARY),MAX(SALARY),MIN(SALARY) from EMPLOYEES
WHERE DEPARTMENT_ID=50

-- MAXIMA FECHA Y MINIMA DE CONTRATACIÓN
SELECT MAX(HIRE_DATE),MIN(HIRE_DATE) from EMPLOYEES
-- MAX AND MIN PARA NOMBRE SU PRIMER VOCAL
SELECT MAX(FIRST_NAME),MIN(FIRST_NAME) from EMPLOYEES

-- SI SON NULOS NOS LOS CUENTA
SELECT COUNT(*) FROM EMPLOYEES
SELECT COUNT(SALARY),COUNT(COMMISSION_PCT) FROM EMPLOYEES 
 
SELECT  COUNT(DISTINCT DEPARTMENT_ID) FROM EMPLOYEES


SELECT SUM(SALARY),COUNT(*) FROM EMPLOYEES;

SELECT MAX(SALARY)-MIN(SALARY) FROM EMPLOYEES;

----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- GROUP BY
    select DEPARTMENT_ID,SUM(SALARY) from EMPLOYEES
    where DEPARTMENT_ID is not NULL
    group by DEPARTMENT_ID

----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- HAVING
    select DEPARTMENT_ID,JOB_ID,COUNT(*), SUM(SALARY) from EMPLOYEES
    where DEPARTMENT_ID is not NULL 
    group by DEPARTMENT_ID,JOB_ID
    HAVING SUM(SALARY) > 100

    select DEPARTMENT_ID,JOB_ID,COUNT(*), SUM(SALARY) from EMPLOYEES
    group by DEPARTMENT_ID,JOB_ID
    HAVING sum(salary) > 200 and count(*) < 6
    ORDER BY DEPARTMENT_ID asc


















