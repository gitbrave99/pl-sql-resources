-- LAS SUBCONSULTAS SOLO DEVUELVEN UN VALOR
select max(salary) from employees


select first_name, salary from employees
where salary = 17278.8
-- SE OBTIENENE L SALARIO DINAMICO
select first_name, salary from employees
where salary = (select max(salary) from employees)

SELECT FIRST_NAME,DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME='Douglas'
                        AND LAST_NAME='Grant')


-- EMPLEADOS QUE GANAN MAS QUE EL PROMEDIO Y Q SEAN DEL DEPARTAMENTO 80
SELECT E.FIRST_NAME,E.LAST_NAME,E.SALARY,D.DEPARTMENT_NAME FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) 
AND D.DEPARTMENT_ID = 80

----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
        -- HAVING

-- departamentos que tienen mas del promedio de la empresa
SELECT DEPARTMENT_ID,TO_CHAR(AVG(SALARY),'$99999999.99') FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM EMPLOYEES)



----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------

    -- subconsultas multiples filas con clausula IN

  

-- AL COMPARAR 2 COLUMNAS ELIMINAMOS ESO DE QUE VARIOS EMPLEADOS DEL MISMO GRUPO DE MUESTREN
-- AUNQUE NO TENGN EL MISMO SALARIO
SELECT FIRST_NAME, LAST_NAME,SALARY, DEPARTMENT_ID FROM EMPLOYEES
WHERE (DEPARTMENT_ID,SALARY) IN (select DEPARTMENT_ID,MAX(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID)
ORDER BY DEPARTMENT_ID ASC

-- EMPLEADOS QUE SE ENCUENTRAN SEATLE
SELECT FIRST_NAME, LAST_NAME,SALARY, DEPARTMENT_ID FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS D JOIN LOCATIONS L
ON (D.LOCATION_ID = L.LOCATION_ID)
AND LOWER(CITY) ='seattle')



----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- subconsultas multiples filas con las claúsulas ANY-ALL
-- ANY VA CON > > = <>
-- mostrar todos los empleados que ganan mas q alguno de los salario de los empleados del trabajo JOB_TITLE = IT_PROG
SELECT FIRST_NAME,LAST_NAME,JOB_ID,SALARY FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG')
and JOB_ID <> 'IT_PROG' --FILTRO PARA Q NO MUESTRE LOS EMPLEADOS DE IT_PROG


-- ALL
-- mostras lo empleados cuyo salario sea mayor q los salarios de los empleados del area de IT_PROG
SELECT FIRST_NAME,LAST_NAME,JOB_ID,SALARY FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG')
and JOB_ID <> 'IT_PROG' 

----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- SUBCONSULTAS SINCRONIZADAS
    -- Una subconsulta sincronizada de SQL es una subconsulta que depende de la consulta externa.
    -- Significa que la cláusula WHERE de la subconsulta sincronizada usa los datos de la consulta 
    -- externa. Una subconsulta sincronizada de SQL se ejecuta una vez para cada fila seleccionada 
    -- de la consulta externa

-- EMPLEADO QUE MAS GANA EN CADA DEPARTAMENTO
--1 FORMA
    SELECT DEPARTMENT_ID,FIRST_NAME,SALARY
    FROM EMPLOYEES 
    WHERE (DEPARTMENT_ID,SALARY) IN (SELECT DEPARTMENT_ID,MAX(SALARY)
                                    FROM EMPLOYEES
                                        GROUP BY DEPARTMENT_ID)

-- 2 FORMA
    SELECT DEPARTMENT_ID,FIRST_NAME,SALARY
    FROM EMPLOYEES  EMP
    WHERE SALARY =(SELECT MAX(SALARY) FROM EMPLOYEES
                    WHERE DEPARTMENT_ID=EMP.DEPARTMENT_ID)




----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- EXISTS
-- NO EXISTS

-- que departamentoS no tienen empleados
    select DEPARTMENT_NAME from DEPARTMENTS dept
    WHERE NOT EXISTS (SELECT * FROM EMPLOYEES
                        WHERE DEPARTMENT_ID = dept.DEPARTMENT_ID)

-- que departamentoS tienen empleados
    select DEPARTMENT_NAME from DEPARTMENTS dept
    WHERE EXISTS (SELECT * FROM EMPLOYEES
                        WHERE DEPARTMENT_ID = dept.DEPARTMENT_ID)






----------------------------------------------------------------------------------------------------
--***************************************************************************************************
----------------------------------------------------------------------------------------------------
-- PRACTICA


SELECT FIRST_NAME,SALARY, DEPARTMENT_ID FROM EMPLOYEES
WHERE SALARY > ANY (SELECT MAX(SALARY) FROM EMPLOYEES
                    WHERE DEPARTMENT_ID IN(50,60,70) 
                    GROUP BY DEPARTMENT_ID)
    AND DEPARTMENT_ID IS NOT NULL





