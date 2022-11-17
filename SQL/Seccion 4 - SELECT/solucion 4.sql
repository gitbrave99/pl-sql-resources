--SOLUCION PRACTICA SECCION 4 
--1- Visualizar el nombre y el número de teléfono de los empleados
    SELECT 'Nombre: '||FIRST_NAME||' teléfono: '||PHONE_NUMBER from EMPLOYEES
    
-- 2-Visualizar el nombre y el tipo de trabajo de los empleados (FIRST_NAME,
-- JOB_ID). Debe aparecer en la cabecera NOMBRE Y Tipo de Trabajo.
    SELECT FIRST_NAME, J.JOB_TITLE FROM EMPLOYEES E
    INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID

-- Selecciona todas las columnas de la tabla REGIONS
    SELECT * FROM REGIONS;

-- Indicar los nombres de los países de la tabla COUNTRIES
    SELECT COUNTRY_NAME FROM COUNTRIES

--Seleccionar las columnas STREET_ADDRESS, CITY, STATE_PROVINCE de
--la table LOCATIONS. Debemos poner las columnas como dirección, Ciudad y
--Estado
    SELECT STREET_ADDRESS, CITY, STATE_PROVINCE FROM LOCATIONS;


----------------------------------------------------------------------------------------------
--********************************************************************************************
----------------------------------------------------------------------------------------------

-- SOLUCION PRACTICA SECCION 4 OPERADORES ARITMETICOS

-- Realizar una SELECT para visualizar el siguiente resultado. El impuesto es el
-- 20% del salario.

    SELECT FIRST_NAME,SALARY, (SALARY*0.20) AS "BRUTO", (SALARY-(SALARY*0.20)) AS "NETO"  FROM EMPLOYEES;

-- Visualizar el salario anual de cada empleado, por 14 pagas. Debemos visualizar
-- las columnas como Nombre, Salario y Salario Anual

    SELECT FIRST_NAME,(SALARY*12) FROM EMPLOYEES


----------------------------------------------------------------------------------------------
--********************************************************************************************
----------------------------------------------------------------------------------------------

-- SOLUCION PRACTICA SECCION 4 LITERALES

-- Crear la consulta para visualizar los siguientes datos, usando el operador de concatenación ||
-- EJEMPLO: El empleado Donald del departamento 50 tiene un salario de 2600

    SELECT 'El empleado '||FIRST_NAME||' del departamento '|| D.DEPARTMENT_NAME||' tiene un salario de '||E.SALARY FROM EMPLOYEES E
    INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID

--Crear la siguiente consulta
-- EJEMPO: la calle 1297 via cola di rea pertenece a la ciudad: roma

SELECT 'La calle '||STREET_ADDRESS||' pertenece a la ciudad: '||CITY FROM LOCATIONS


----------------------------------------------------------------------------------------------
--********************************************************************************************
----------------------------------------------------------------------------------------------
-- SOLUCION PRACTICA SECCION 4 DISTINTC

-- Visualizar las ciudades donde hay departamentos, de la tabla locations. No
-- deben salir repetidos
    SELECT DISTINCT CITY  FROM LOCATIONS
    
--Visualizar los distintos tipos de JOB_ID por departamento de la tabla Employees

    SELECT DISTINCT DEPARTMENT_ID, JOB_ID FROM EMPLOYEES

