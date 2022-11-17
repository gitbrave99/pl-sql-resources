
----------------------------------------------------------------------------
--**************************************************************************
----------------------------------------------------------------------------
    -- PRACTICA

-- 1- Visualizar los siguientes datos con CASE. 
        -- o Si el departamento es 50 ponemos Transporte
        -- o Si el departamento es 90 ponemos Dirección
        -- o Cualquier otro número ponemos “Otro departamento”

        SELECT DEPARTMENT_ID,
        WHEN 50 THEN 'Transporte'
        WHEN 60 THEN 'Direccion'
        ELSE 'Otro departamento'
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
    SELECT DEPARTMENT_ID,
            DECODE(DEPARTMENT_ID, 50, 'Transporte',
                                  90, 'Dirección',
                                      'Otro departamento')
        FROM DEPARTMENTS