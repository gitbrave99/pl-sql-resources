Sección 5: CONDICIONES Y ORDENACIONES-CLÁUSULAS WHERE Y ORDER BY


--COMPARAR FECHAS
SELECT * FROM EMPLOYEES WHERE HIRE_DATE ='06-06-2007'

--BETWEEN
SELECT * FROM EMPLOYEES
WHERE SALARY BETWEEN 500 AND 600

--IN
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10,20,30);

SELECT * FROM EMPLOYEES
WHERE JOB_ID IN ('SH_CLERK','ST_CLERK')
--ra
-- LIKE

select * from EMPLOYEES where FIRST_NAME LIKE 'a_%'
-- Cantidad de empleados que comienzan con S y terminan con a
Select count(*) from EMPLOYEES where FIRST_NAME LIKE 'S%'

-- paises que tienen r como segunda letra
SELECT * from COUNTRIES where COUNTRY_NAME like '_r%'


--------------------------------------------------------------
-- AND NOT OR
SELECT * FROM EMPLOYEES WHERE SALARY > 100 AND DEPARTMENT_ID=40

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID NOT IN (20,30,50)
    -- COMBINACIONES MULTIPLES

select FIRST_NAME, SALARY,HIRE_DATE, TO_DATE(HIRE_DATE,'DD/MM/YYYY') from EMPLOYEES
where SALARY > 100 and DEPARTMENT_ID = 90 and HIRE_DATE < '17-JUN-03'

SELECT TO_DATE('01-01-05','DD/MM/YYYY') FROM DUAL


--LIMITAR EL NUMERO DE REGISTSROS EN SELECT
-- MAYOR A 11G
SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEES
FETCH FIRST 5 ROWS ONLY

-- 5 MAYORES VENTAS , TIES RELACIONA LA 2DA COLUMNA POR ESO SALE MAYORES VENTAS
SELECT FIRST_NAME,SALARY FROM EMPLOYEES FETCH ORDER BY SALARY DESC
FETCH FIRST 5 ROWS WITH TIES;

-- SALTANDO LAS 5 PRIMERAS 
SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEES ORDER BY SALARY DESC
OFFSET  5 ROWS FETCH FIRST 7 ROWS WITH TIES;

-- PARA 11G
    SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES
    WHERE ROWNUM < 5;

--SACAR EL 20 PORCIENDO 
SELECT * FROM EMPLOYEES FETCH FIRST 20 PERCENT ROWS ONLY;

--












