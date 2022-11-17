------------------------------------------------------------------------------------
--**********************************************************************************
------------------------------------------------------------------------------------
--PRACTICA WHERE 

-- Averigua los empleados que trabajen en el departamento 100
    SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 100;

--Usando la tabla LOCATIONS, averigua el nombre de la Ciudad (city) y la
-- dirección (Street_address) de los departamentos situados en Estados Unidos (COUNTRY_ID=US)

    SELECT CITY, STREET_ADDRESS FROM LOCATIONS WHERE COUNTRY_ID = 'US'

-- Visualiza los países que están en la región 3. (REGION_ID de la tabla
-- COUNTRIES

    SELECT * FROM COUNTRIES WHERE REGION_ID =3

-- Averiguar el nombre y salario de los empleados que NO tengan como jefe al
-- MANAGER 114 (columna MANAGER_ID)

    SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE MANAGER_ID <> 14

-- Visualizar los empleados que empezaron a trabajar a partir del año 2006
    
    SELECT FIRST_NAME|| ' '||LAST_NAME, SALARY, TO_CHAR(HIRE_DATE,'YYYY') FROM EMPLOYEES
    WHERE TO_CHAR(HIRE_DATE,'YYYY') > '2006'
    ORDER BY HIRE_DATE ASC 

--Seleccionar los empleados que tenga como tipo de trabajo ‘ST_CLERK

    SELECT FIRST_NAME,SALARY FROM EMPLOYEES WHERE JOB_ID ='ST_CLERK'

-- Indicar los datos de los empleados que tengan como apellidos “Smith”
-- (LAST_NAME)

    SELECT FIRST_NAME|| ' '|| LAST_NAME,SALARY  FROM EMPLOYEES 
    WHERE LAST_NAME = 'Smith'



------------------------------------------------------------------------------------
--**********************************************************************************
------------------------------------------------------------------------------------
--PRACTICA BETWEEN 

--  Averiguar los empleados que están entre el departamento 40 y el 60
    SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID BETWEEN 40 AND 60

-- Visualizar los empleados que entraron entre 2002 y 2004
    SELECT * FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YYYY') BETWEEN '2002' AND '2004'

-- Indica los apellidos de los empleados que empiezan desde ‘D’ hasta ‘G’;
    SELECT LAST_NAME FROM EMPLOYEES 
    WHERE  SUBSTR(LAST_NAME,0,1) BETWEEN 'D' AND 'G'

-- Averiguar los empleados de los departamentos 30,60 y 90. Hay que usar la
-- cláusula IN
    SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (30,60,90)

-- Averiguar los empleados que tienen el tipo de trabajo IT_PROG y PU_CLERK.
    SELECT * FROM EMPLOYEES WHERE JOB_ID IN( 'IT_PROG','PU_CLERK')

-- • Indica las ciudades que están en Inglaterra (UK) y Japón (JP).. Tabla
-- LOCATIONS
    SELECT * FROM LOCATIONS WHERE COUNTRY_ID IN ('UK','JP') 




------------------------------------------------------------------------------------
--**********************************************************************************
------------------------------------------------------------------------------------
--PRACTICA AND OR MULTIPLE

-- Obtener el nombre y la fecha de la entrada y el tipo de trabajo de los
-- empleados que sean IT_PROG y que ganen menos de 6000 dólares
    SELECT FIRST_NAME,HIRE_DATE, J.JOB_TITLE  FROM EMPLOYEES E
    INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID 
    WHERE E.JOB_ID = 'IT_PROG' AND E.SALARY < 6000

-- Seleccionar los empleados que trabajen en el departamento 50 o 80,
-- cuyo nombre comience por S y que ganen más de 3000 dólares.
    SELECT FIRST_NAME  FROM EMPLOYEES E
    WHERE LOWER(SUBSTR(E.FIRST_NAME,0,1)) = 's' AND E.SALARY > 3000

-- ¿Qué empleados de job_id IT_PROG tienen un prefijo 5 en el teléfono
-- y entraron en la empresa en el año 2007?
    SELECT FIRST_NAME, PHONE_NUMBER FROM EMPLOYEES
    WHERE SUBSTR(PHONE_NUMBER,0,1)=5 AND TO_CHAR(HIRE_DATE,'YYYY') = '2007';
    

------------------------------------------------------------------------------------
--**********************************************************************************
------------------------------------------------------------------------------------

--IS NULL
-- Listar las ciudades de la tabla LOCATIONS no tienen STATE_PROVINCE
    SELECT * FROM LOCATIONS WHERE STATE_PROVINCE IS NULL


-- Averiguar el nombre, salario y comisión de aquellos empleados que tienen
-- comisión. También debemos visualizar una columna calculada denominada
-- “Sueldo Total”, que sea el sueldo más la comisión
    SELECT FIRST_NAME,SALARY, (SALARY+(SALARY*COMMISSION_PCT/100 )) AS "Sueldo Total"
    FROM EMPLOYEES ORDER BY 3 ASC


------------------------------------------------------------------------------------------
--****************************************************************************************
------------------------------------------------------------------------------------------
-- PRACTICA LIKE

-- Indicar los datos de los empleados cuyo FIRST_NAME empieza por ‘J’
    SELECT FIRST_NAME FROM EMPLOYEES WHERE FIRST_NAME LIKE 'J%'

-- Averiguar los empleados que comienzan por ‘S’ y terminan en ‘n’
    SELECT FIRST_NAME FROM EMPLOYEES WHERE FIRST_NAME LIKE 'J%n'

--Indicar los países que tienen una “r” en la segunda letra (Tabla COUNTRIES)
    SELECT COUNTRY_NAME FROM COUNTRIES WHERE COUNTRY_NAME LIKE '_r%'
