-----------------------------------------------------------------------------------------
---**************************************************************************************
-----------------------------------------------------------------------------------------
-- FUNCIONES DE CARACTER
-- En la tabla LOCATIONS, averiguar las ciudades que son de Canada o
-- Estados unidos (Country_id=CA o US) y que la longitud del nombre de la
-- calle sea superior a 15. 

    SELECT * FROM LOCATIONS WHERE COUNTRY_ID IN( 'CA','US')
    AND LENGTH(STREET_ADDRESS) > 15

-- Muestra la longitud del nombre y el salario anual (por 14) para los
-- empleados cuyo apellido contenga el carácter 'b' después de la 3ª
-- posición

    SELECT LENGTH(FIRST_NAME),LAST_NAME, (SALARY*14)  FROM EMPLOYEES
    WHERE LAST_NAME LIKE '___b%'

-- Averiguar los empleados que ganan entre 4000 y 7000 euros y que
-- tienen alguna 'a' en el nombre. (Debemos usar INSTR y da igual que sea
-- mayúscula que minúsculas) y que tengan comisión.

    SELECT * FROM EMPLOYEES 
    WHERE INSTR(FIRST_NAME,'A') <> 0 AND SALARY BETWEEN 4000 AND 7000
    AND COMMISSION_PCT IS NOT NULL

-- Visualizar las iniciales de nombre y apellidos separados por puntos. Por
-- ejemplo: A.R.
    SELECT FIRST_NAME, LAST_NAME, (SUBSTR(FIRST_NAME,0,1)||'.'||SUBSTR(LAST_NAME,0,1)) 
    FROM EMPLOYEES


-- Mostrar empleados donde el nombre o apellido comienza con S..
    SELECT * FROM EMPLOYEES WHERE (FIRST_NAME) LIKE 's%' OR (LAST_NAME) LIKE 's%'

-- Visualizar el nombre del empleado, su salario, y con asteriscos, el número miles de dólares 
-- que gana. Se asocia ejemplo. (PISTA: se puede usar RPAD. Ordenado por salario

SELECT FIRST_NAME, SALARY, RPAD('*',(SALARY/100),'*') AS "RANKING" FROM EMPLOYEES
ORDER BY SALARY DESC



-------------------------------------------------------------------------------------------------
---**********************************************************************************************
-------------------------------------------------------------------------------------------------
-- FUNCIONES DE FECHA
-- Indicar el número de días que los empleados llevan en la empresa
select FIRST_NAME,HIRE_DATE, SYSDATE-HIRE_DATE from EMPLOYEES

-- Indicar la fecha que será dentro de 15 días
SELECT SYSDATE+15 FROM DUAL

-- ¿Cuántos MESES faltan para la navidad? La cifra debe salir
-- redondeada, con 1 decimal
    SELECT ROUND(MONTHS_BETWEEN(TO_DATE('31-12-2022','dd/mm/yyyy'),SYSDATE),1) FROM DUAL;
    
-- Indicar la fecha de entrada de un empleado y el último día del mes que
-- entró
    SELECT HIRE_DATE, LAST_DAY(HIRE_DATE) FROM EMPLOYEES

-- Utilizando la función ROUND, indicar los empleados que entraron en los
-- últimos 15 días de cada mes

    SELECT FIRST_NAME, HIRE_DATE, ROUND(HIRE_DATE,'MONTH') AS REDONDEO FROM EMPLOYEES



    
-----------------------------------------------------------------------------------------
---**************************************************************************************
-----------------------------------------------------------------------------------------

-- PRACTICA FUNCIONES NUMERICAS
-- Visualizar el nombre y salario de los empleados de los que el número de
-- empleado es impar (PISTA: MOD)

SELECT FIRST_NAME, SALARY FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID,2)=0

-- Prueba con los siguientes valores aplicando las funciones TRUNC y
-- ROUND, con 1 y 2 decimales.
    SELECT ROUND(25.67,0), TRUNC(25.67,0) FROM DUAL

    
