-- DATA MANIPULATION LANGUAGE

-- INSERT UPDATE DELETE
-- DATA MANIPULATION LANGUAGE

-- INSERT UPDATE DELETE
INSERT INTO REGIONS (REGION_ID,REGION_NAME) VALUES(24,'TEST INSERT')
-- SI SE AGREGAN TODAS LOS VALUES NO ES NECESARIO AGREGAR LAS COLUMNAS
    INSERT INTO REGIONS VALUES(25,'TEST INSET SIN COLUMNS')


----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- INSERT MULTIPLE
create table dept2(
    codigo number,
    nombre varchar(100)
)

insert into dept2 values(1,UPPER('tech'))
insert into dept2(codigo,nombre) select DEPARTMENT_ID,DEPARTMENT_NAME from DEPARTMENTS

----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- UPDATE MULTIPLE
update dept2
set nombre =(select DEPARTMENT_NAME from DEPARTMENTS WHERE DEPARTMENT_NAME='Finance')
WHERE codigo =1

----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- DELETE MULTIPLE
delete REGION1 WHERE REGION_ID in (select REGION_ID from REGIONS WHERE
                                    REGION_ID in(1,3))

-- DELETE ELIMINAR TEMPORALMENTE LAS FILAS SI QUREMOS HACER ROLLBACK

-- TRUNCATE BORRA DEFINITIVAMENTE LAS FILAS