-- expresiones condicionales
    -- CASE 
    
    -- CASE variable
            -- WHEN 'v1' THEN 'r1'
            -- WHEN 'v2' THEN 'r2'
    -- END

    -- CASE SEARCHED
    
        -- CASE
        --     WHEN variable .... THEN 'R1'
        --     WHEN variable .... THEN 'R2'
        --     ELSE 'RELSE'
        -- END

    -- DECODE(VALOR, C1,V1, C2,V2, C3,V3, V4 ) V4= ELSE
            --   si valor cumple C1 devuelde V1
            --   si valor cumple C2 devuelde V2
            --   si valor cumple C3 devuelde V3
            --   SINO V4
    -- PUEDE O NO TENER TODAS LAS CONDICIONES
----------------------------------------------------------------------------
--**************************************************************************
----------------------------------------------------------------------------
-- CASE
        SELECT FIRST_NAME, JOB_ID,
        (CASE JOB_ID
            WHEN 'SH_CLERK' THEN  'TIPO1'
            WHEN 'ST_MAN'   THEN    'TIPO2'
            WHEN 'ST_CLERK' THEN  'TIPO3'
            ELSE 'SIN TIPO'
        END) AS "TIPO"
        FROM EMPLOYEES WHERE DEPARTMENT_ID=50;
    
----------------------------------------------------------------------------
--**************************************************************************
----------------------------------------------------------------------------
-- CASE SEARCHED
SELECT TO_CHAR(MIN(SALARY),'L999999.99'),
       TO_CHAR(AVG(SALARY),'L999999.99'),
       TO_CHAR(MAX(SALARY),'L999999.99')
FROM EMPLOYEES

    SELECT FIRST_NAME,SALARY ,
    CASE
        WHEN SALARY BETWEEN 0   AND  2999   THEN 'POCO'
        WHEN SALARY BETWEEN 3000 AND 3755   THEN 'PROMEDIO'
        WHEN SALARY BETWEEN 3756 AND 17278  THEN 'MÁXIMO'   
    END AS "NIVEL"
    FROM EMPLOYEES

----------------------------------------------------------------------------
--**************************************************************************
----------------------------------------------------------------------------
    -- DECODE
    -- DECODE(VALOR,C1,V1,C2,V2,C3,V4)
    SELECT FIRST_NAME,DEPARTMENT_ID ,
    DECODE(DEPARTMENT_ID,60,'INFORMATICA',
                         10, 'VENTAS',
                         'OTRO')
    FROM EMPLOYEES



----------------------------------------------------------------------------
--**************************************************************************
----------------------------------------------------------------------------
    -- PRACTICA

-- 1- Visualizar los siguientes datos con CASE. 
        -- o Si el departamento es 50 ponemos Transporte
        -- o Si el departamento es 90 ponemos Dirección
        -- o Cualquier otro número ponemos “Otro departamento”

        SELECT DEPARTMENT_ID,
            DECODE(DEPARTMENT_ID, 50, 'Transporte',
                                  90, 'Dirección',
                                      'Otro departamento')
        FROM DEPARTMENTS

-- 2-Mostrar de la tabla LOCATIONS, la ciudad y el país. Ponemos los siguientes datos dependiendo de COUNTRY_ID.
--         o Si es US y CA ponemos América del Norte
--         o Si es CH, UK, DE,IT ponemos Europa
--         o Si es BR ponemos América del Sur
--         o Si no es ninguno ponemos ‘Otra zona’

        SELECT COUNTRY_ID, CITY,
        CASE 
                WHEN COUNTRY_ID IN ('US','CA') THEN 'America del norte'
                WHEN COUNTRY_ID IN ('CH','UK','IT') THEN 'Europa'
                WHEN COUNTRY_ID='BR' THEN 'Amera de Sur'
                ELSE 'Otra zona'
        END AS "ZONA"
          FROM LOCATIONS

-- 3- Realizar el primer ejercicio con DECODE en vez de con CASE
    -- READY TOP
