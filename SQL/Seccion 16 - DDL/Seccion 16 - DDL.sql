----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
--DDL DATA-DEFINITION-LANGUAGE
--CREATE
--ALTER
--DROP

-- tablas      --datos
-- indices     --rendimiento
-- vistas      --select guardada
-- sinonimos   --alias de tablas


CREATE TABLE PRUEBADDL(
    CODIGO NUMBER,
    NOMBRE VARCHAR2(100)
)
--ocupamos para describir o mostrar detalles de la tabla
DESC PRUEBADDL;


-- agregar dato DEFAULT AL HACER INSERT Y NO AGREGAR DATO EN ACOLUMN AGREGARA ESTOS 
CREATE TABLE PRUEBADDL2(
    CODIGO NUMBER,
    NOMBRE VARCHAR2(100) DEFAULT 'TOMAS',
    FECHA_ENTRADA DATE DEFAULT SYSDATE
)

INSERT INTO PRUEBADDL2(CODIGO)VALUES(1)

----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- CONSTRAINTS PRIMARY KEY- NOT NULL
    -- NOT NULL
    -- UNIQUE
    -- PRIMARY KEY
    -- FOREIGN KEY
    -- CHECK

CREATE TABLE PRUEBADDL(
    CODIGO NUMBER PRIMARY KEY, -- PRIMARY KEY A NIVEL DE COLUMNA
    NOMBRE VARCHAR2(100) NOT NULL
)

CREATE TABLE PRUEBADDL(
    CODIGO1 NUMBER PRIMARY KEY,
    CODIGO2 NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL,
    
    PRIMARY KEY(CODIGO1,CODIGO2) --PRIMARY KEY A NIVEL DE TABLA
)



-- UNIQUE
CREATE TABLE PRUEBA5(
    CODIGO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100) UNIQUE -- UNIQUE A NIVEL DE COLUMNA
)
-- nose puede repetir el nombre
INSERT INTO PRUEBA5 VALUES(2,'isaac')


CREATE TABLE PRUEBA6(
    CODIGO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100),
    CONSTRAINT NOMBRE_I UNIQUE(NOMBRE) --UNIQUE A NIVEL DE TABLA
)
INSERT INTO PRUEBA6 VALUES(2,'isaac')

----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- FOREGIN KEY
CREATE TABLE CURSO(
    ID_CURSO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100)
);

CREATE TABLE ALUMNO(
    ID_ALUMNO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100),
    ID_CURSO NUMBER REFERENCES CURSO(ID_CURSO) -- FOREIGN KEY A NIVEL DE COLUMNA
);


INSERT INTO CURSO VALUES(1,'diseño web')
INSERT INTO ALUMNO VALUES(1,'NATALY',1)


CREATE TABLE ALUMNO1(
    ID_ALUMNO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100),
    ID_CURSO NUMBER,
    CONSTRAINT CURSO_ALUMNO FOREIGN KEY(ID_CURSO) REFERENCES CURSO(ID_CURSO)
);


----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- CHECK


CREATE TABLE EMPLEADO(
    ID_ALUMNO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100) NOT NULL,
    SALARY NUMBER CHECK(SALARY > 300)
);
INSERT INTO EMPLEADO VALUES(1,'jorge',301)

CREATE TABLE EMPLEADO1(
    ID_EMPLEADO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100)  NOT NULL CHECK (NOMBRE=UPPER(NOMBRE)),
    SALARY NUMBER CHECK(SALARY > 300)
);
INSERT INTO EMPLEADO1 VALUES(1,'JORGE',301)


----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- CREAR TABLAS DE OTRAS TABLAS

CREATE TABLE EMPLEBASEEMPLOYEE AS SELECT * FROM EMPLOYEES


CREATE TABLE EMPLOYEE2
AS SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID=50


CREATE TABLE EMPLE3COLPERSON
AS 
SELECT FIRST_NAME ||' '|| LAST_NAME AS NOMBRE, SALARY AS SALARIO, SALARY * 12 AS SALARIO_NETO
 FROM EMPLOYEES

SELECT * FROM EMPLE3COLPERSON


----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- ALTER TABLE
        -- AÑADIR COLUMNA
        -- MODIFICAR UNA COLUMNA
        -- DEFINIR DEFAULT VALUE
        -- BORRAR UNA COLUMNA
        -- READ-ONLY

-- AL AÑADIR UNA NUEVA COLUMNA SE AGREGARIA UN NULL A LAS FILAS QUE YA ESTAN 
    ALTER TABLE EMPLE3
    ADD (PROFESOR VARCHAR(100))


    ALTER TABLE CURSO
    ADD (PROFESOR VARCHAR(100))

-- MODIFICAAR EL TAMAÑA DE UNA COLUMNA PROFESOR
    ALTER TABLE CURSO
    MODIFY (PROFESOR VARCHAR(129))

-- MODIFICAAR EL TIPO DE UNA COLUMNA PROFESOR
    ALTER TABLE CURSO
    MODIFY (PROFESOR NUMBER)

-- AGREGAR COLUMNA Y AÑADIRLE UN DEFAULT
    ALTER TABLE CURSO
    ADD (TUTOR VARCHAR2(100) DEFAULT 'TUTOR1')

-- ELIMINAR COLUMNA
    ALTER TABLE CURSO
    DROP(TUTOR)

-- TABLA DE SOLO LECTURA
    ALTER TABLE CURSO READ ONLY;

-- MODIFICARLA A LO NORMAL
    ALTER TABLE CURSO READ WRITE;

----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- DROP TABLE borrar cuanto hay constraints
    DROP TABLE CURSO CASCADE CONSTRAINTS;


----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- CREAR VISTAS

    CREATE VIEW VWEMPLEADO AS
    SELECT * FROM EMPLOYEES

-- SE PUEDEN HACER SELEC PERSONALIZADOS
    SELECT JOB_ID, AVG(SALARY)
    FROM VWEMPLEADO
    GROUP BY JOB_ID

--
    CREATE VIEW VW_EMPLE_SALARIOS AS 
    SELECT FIRST_NAME || ' '|| LAST_NAME AS NOMBRE, SALARY AS SALARIO, SALARY * 12 AS ANUAL
    FROM EMPLOYEES

    select * from VW_EMPLE_SALARIOS

-- ELIMINAR VISTAS
DROP VIEW VIEW_NAME;

-- INSERT EN VISTAS la insercion se vera tanto en la VISTA como en la TABLA
CREATE VIEW V_CURSO AS SELECT * FROM CURSO;
INSERT INTO V_CURSO VALUES(2,'Back-end',1) ;
select * from CURSO

-- UPDATE EN LA VISTA se vera en la VISTA y en la TABLA
UPDATE V_CURSO SET PROFESOR = 1

-- UNIENDO 2 TABLAS REGIONES Y PAISES
CREATE VIEW VIEW_REGIONES_PAISES AS SELECT * FROM REGIONS NATURAL JOIN COUNTRIES
select * from VIEW_REGIONES_PAISES

-- NO SE PUEDE ACTUALIZAR TABLAS ATRAVES D EUNA VISTA QUE CONTIENE JOIN




----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- CREAR INDICES
-- los indices son creados para hacer mas eficientes la busquedas
-- merora el rendimiento de la base de datos    
    CREATE INDEX INDEX1 ON EMPLOYEES(LAST_NAME)

    SELECT * FROM EMPLOYEES WHERE LOWER(LAST_NAME) LIKE 'o%';

    CREATE INDEX INDEX2 ON EMPLOYEES (FIRST_NAME,LAST_NAME)

-- ELIMINAR INDEX
        DROP INDEX INDEX2;
----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- CREAR SECUENCIAS

--CACHE CUANTOS NUMEROAL ALMACENA PREVIAMENTE
CREATE SEQUENCE secuencia1 INCREMENT BY 1
MAXVALUE 1000 MINVALUE 20 CACHE 20;

-- OBTENER SIGUIENTE VALOR
    SELECT secuencia1.NEXTVAL FROM DUAL
-- OBTENER ULTIMO NUMERO OBTENIDO
    SELECT secuencia1.CURRVAL FROM DUAL

-- PODEMOS USARLO PARA INCREMENTAR UN ID DE UNA TABLE
    INSERT INTO REGION1 VALUES(secuencia1.NEXTVAL, 'ALGO AV')
    select * from REGION1

-- ELIMINAR SECUENCIA
    DROP SEQUENCE secuencia1;



----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- CREAR SINONIMOS

-- nombres cortos y claros
-- acceder a objetos de otros esquemas
-- 
CREATE SYNONYM DEPARTMENTOS FOR DEPARTMENTS;

SELECT * FROM DEPARTMENTOS

GRANT SELECT ON DEPARTMENTS TO PRUEBA;

-- ASIGNAR DEPARTAMENTOS A UN USUARIO Y ESQUEMA
CREATE SYNONYM DEPARTMENTOS FOR HR.DEPARTMENTS

























