
--********************************************************
--********************************************************
-- FUCIONES DE CONVERSION TO_CHAR
-- 1- Indicar los empleados que entraron en Mayo en la empresa. Debemos
--     buscar por la abreviatura del mes

    SELECT * FROM EMPLOYEES WHERE
    TO_CHAR(HIRE_DATE,'MON') = 'MAY';

-- 2-Indicar los empleados que entraron en el año 2007 usando la función   to_char
    
    SELECT * FROM EMPLOYEES WHERE
    TO_CHAR(HIRE_DATE,'YYYY') = '2007' --  Ó 2007

-- 3-¿Qué día de la semana (en letra) era el día que naciste?

    SELECT TO_CHAR(TO_DATE('31-03-1999','DD-MM-YYYY'),'DAY') FROM DUAL


-- 4- Averiguar los empleados que entraron en el mes de Junio. Debemos preguntar por el mes en letra.
-- Nota: La función TO_CHAR puedede volver espacios a la derecha)

    SELECT  HIRE_DATE,FIRST_NAME FROM EMPLOYEES
    WHERE RTRIM(TO_CHAR(HIRE_DATE,'MONTH'))='JUNE';


-- 5-Visualizar el salario de los empleados con dos decimales y en dólares ytambién en la moneda 
-- local (el ejemplo es con euros, suponiendo que el cambio esté en 0,79$)

    SELECT SALARY,TO_CHAR(SALARY,'$99,999.99'),TO_CHAR(SALARY*0.79,'U99,999.99') FIRST_NAME 
    FROM EMPLOYEES;




------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
--PRACTICA
-- 1-Convertir las siguientes cadenas a números

    SELECT TO_NUMBER('1210.73') FROM DUAL
    SELECT TO_NUMBER('$127.2','L9999.99') FROM DUAL

-- 2-Convertir los 3 primeros caracteres del número de teléfono en números y
--     multiplicarlos por 2.
    SELECT SUBSTR('1245-7845',1,3)*2 FROM DUAL;

/* 3-Convertir las siguientes cadenas en fecha (NOTA: el mes lo debemos
    poner en el idioma que tengamos en el SqlDeveloper. Por ejemplo, en
    español sería */
    
SELECT TO_CHAR(HIRE_DATE,'DD-MONTH-YYYY') FROM EMPLOYEES
    SELECT TO_DATE('10 DE FEBRUARY DE 2018','dd "DE" MONTH "DE" YYYY') FROM DUAL;
