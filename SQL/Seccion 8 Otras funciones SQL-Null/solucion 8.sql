--seccion 8
-- PRACTICA

-- 1-De la tabla LOCATIONS visualizar el nombre de la ciudad y el estado provincia. 
--     En el caso de que no tenga que aparezca el texto “No tiene”
    SELECT CITY,NVL(STATE_PROVINCE,'No tiene')
    FROM LOCATIONS

-- 2-Visualizar el salario de los empleados incrementado en la comisión
--     (PCT_COMMISSION). Si no tiene comisión solo debe salir el salario
    SELECT SALARY, COMMISSION_PCT, NVL2(COMMISSION_PCT,(SALARY * COMMISSION_PCT)+SALARY,SALARY )
    FROM EMPLOYEES;

-- 3-Seleccionar el nombre del departamento y el manager_id. Si no tiene,
--     debe salir un -1
    SELECT DEPARTMENT_NAME, NVL(MANAGER_ID,-1) FROM DEPARTMENTS

-- 4-De la tabla LOCATIONS, devolver NULL si la ciudad y la provincia son
-- iguales. Si no son iguales devolver la CITY.
    SELECT CITY,STATE_PROVINCE, NULLIF(CITY,STATE_PROVINCE) FROM LOCATIONS