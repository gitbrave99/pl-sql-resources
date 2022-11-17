-- SET OPERATORS
-- UNION
        -- elimina duplicados
-- UNION ALL
        -- nos muestra los duplicados
-- INTERSECT
    -- devuelve los datos q son comunes
-- MINUS    
    -- devuelve todos los q estan en A y no en B 

CREATE TABLE REGION1 as SELECT * FROM REGION1 WHERE REGION_ID =0
insert into REGION1 values(1,'Europe');
insert into REGION1 values(3,'Asia');
insert into REGION1 values(6,'Australia');
insert into REGION1 values(8,'Antartica');



-- ELIMINA DUPLICADOS
select REGION_ID, REGION_NAME from REGIONS
union 
select REGION_ID, REGION_NAME from REGION1;


-- MUESTSRA DUPLICADOS
select REGION_ID, REGION_NAME from REGIONS
union all
select REGION_ID, REGION_NAME from REGION1;

--FILAS QUE ESTEN EN LOS 2
select REGION_ID, REGION_NAME from REGIONS
INTERSECT
select REGION_ID, REGION_NAME from REGION1;

--FILAS QUE ESTEN EN REGIONS PERO NO EN REGIONS1
select REGION_ID, REGION_NAME from REGIONS
MINUS
select REGION_ID, REGION_NAME from REGION1;

select REGION_ID, REGION_NAME from REGION1
MINUS
select REGION_ID, REGION_NAME from REGIONS;


delete from REGIONS WHERE REGION_ID=20





