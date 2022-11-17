-- CONTROLAMOS LOS NULOS
    -- NVL(expresion,valor)
    -- NVL2(expresion,valor1,valor2)
    -- NULLIF (expresion,expresion)
    -- COALESCE(expresion1,expresion2,expresionn)


    -- NVL(EXPRESION,VALOR)
        -- si la expresion es nula devuelve el valor
        -- sino devuelve la expresion
        
        SELECT NVL('HOLA','SALU') FROM DUAL;
        SELECT NVL(NULL,'Salud') FROM DUAL;

        SELECT FIRST_NAME, NVL(COMMISSION_PCT,0) FROM EMPLOYEES


----------------------------------------------------------------------------
--**************************************************************************
----------------------------------------------------------------------------

    --NVL2(expresion, v1,v2)
        -- si la expresion no es nula devuelve v1
        -- si la expresion es nula devuelve v2

        SELECT FIRST_NAME, NVL2(COMMISSION_PCT,SALARY,SALARY * 1.1)FROM EMPLOYEES


----------------------------------------------------------------------------
--**************************************************************************
----------------------------------------------------------------------------

    -- NULLIF(v1,v2)
        -- si v1 y v2 son iguales nos devuelve un NULL
        -- si son distintos devuelve V1

        SELECT NULLIF('HOLA','SALU') FROM DUAL;

        SELECT COUNTRY_ID, UPPER(SUBSTR(COUNTRY_NAME,1,2)),
        NULLIF(COUNTRY_ID,UPPER(SUBSTR(COUNTRY_NAME,1,2))),
        NVL2(NULLIF(COUNTRY_ID,UPPER(SUBSTR(COUNTRY_NAME,1,2))),'NO','SON IGUALES')
        FROM COUNTRIES


----------------------------------------------------------------------------
--**************************************************************************
----------------------------------------------------------------------------

    -- COALESCE(V1,V2,V3,V4...Vn)
        -- si el primer valor es nulo pasa al siguiente, si este no es nulo lo devuelve
        -- si 
    SELECT COALESCE('V1','V2','V3') FROM DUAL; ---> 'V1'
    SELECT COALESCE(NULL,'V2','V3') FROM DUAL; ---> 'V2'
    SELECT COALESCE(NULL,NULL,'V3') FROM DUAL; ---> 'V3'

    SELECT FIRST_NAME, COALESCE(TO_CHAR(COMMISSION_PCT),TO_CHAR(MANAGER_ID), 'SIN JEFES NI COMISION') FROM EMPLOYEES;


----------------------------------------------------------------------------
--**************************************************************************
----------------------------------------------------------------------------

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
