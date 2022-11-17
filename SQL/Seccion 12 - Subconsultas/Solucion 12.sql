
----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------

-- PRACTICA

-- 1-Mostrar los compañeros que trabajan en el mismo departamento que John Chen

    SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEES
    WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM EMPLOYEES
    WHERE CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME)='John Chen')

-- 2-¿Qué departamentos tienen su sede en Toronto?
    select * from DEPARTMENTS D
    WHERE LOCATION_ID=(select LOCATION_ID from LOCATIONS where LOCATION_ID=1800)
    
-- 3- Visualizar los empleados que tengan más de 5 empleados a su cargo.         
    SELECT FIRST_NAME FROM EMPLOYEES 
    WHERE EMPLOYEE_ID in (select MANAGER_ID from EMPLOYEES group by MANAGER_ID having count(*)>5)
    
-- 3-¿En qué ciudad trabajar Guy Himuro?    
    SELECT CITY FROM LOCATIONS
    WHERE LOCATION_ID =
                (SELECT LOCATION_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID =
                    (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE first_name='Guy' and last_name='Himuro'));
    
-- 4-¿Qué empleados tienen el salario mínimo?
    select FIRST_NAME,SALARY from EMPLOYEES
    where SALARY = (select MIN(SALARY) from EMPLOYEES)


-- 5-• Visualizar los departamentos en los cuales el salario máximo sea mayor a 10000.
    select DEPARTMENT_NAME from DEPARTMENTS
    where DEPARTMENT_ID IN 
    (SELECT DEPARTMENT_ID from EMPLOYEES
    GROUP BY DEPARTMENT_ID
    HAVING MAX(SALARY) > 1000)

-- 6-Indicar los tipos de trabajo de los empleados que entraron en la empresa entre 2002 y 2003

    SELECT JOB_TITLE FROM JOBS
    WHERE JOB_ID IN (select JOB_ID from EMPLOYEES where TO_CHAR(HIRE_DATE,'YYYY') IN (2002,2003))

select TO_CHAR(SYSDATE,'yyyy') FROM DUAL