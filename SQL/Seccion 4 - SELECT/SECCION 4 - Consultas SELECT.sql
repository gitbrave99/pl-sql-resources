
    TIPOS DE DATOS
TIPO        DESCRIPCION
CHAR(N)     maxicmo 2000 bytes y minimo 1 byte

VARCHAR(N)  11G: max 4000 y min 1 
            12C: max 32767 y min 1

NUMBER(p,s) parte entera: 1 38, decimal: -84 a 127
            p: digitos s decimales
            no es necesario especificar el tamaño

DATE        se usa desde -4712 hasta 9999

LONG        albergar caracteres de longitud variable
            max 2gb
            NO SE DEBERIA UTILIZAR EN LA ACTUALIDAD

CLOB        deberia usar para textos grandes
            alberga caracteres multi-byte o single-byte
            max: 4gb DB_BLOCK_SIZE

NCLOB, RAW, LONG RAW, BLOB, BFILE, ROWID
            


-- ALIAS

--RECOMENDADO
SELECT FIRST_NAME,SALARY AS "SALARIO EMP" FROM EMPLOYEES

SELECT FIRST_NAME,SALARY AS SALARIO FROM EMPLOYEES


-- LITERALES
SELECT 'NOMBRE: ', FIRST_NAME FROM EMPLOYEES;
SELECT 'NOMBRE: '||FIRST_NAME as "nombre empleado" FROM EMPLOYEES;


-- TABLA DUAL    
usamos esta tabla para tner un resultado de una operacion
en ves d usar otra tabla, en otras db podemos usar solo select en esta caso oracle no permite
podriamos utilizarlo para pruebas
SELECT 4+3 from DUAL;

-- NULOS
las operaciones con nulll da null



--DISTINCT
SELECT DISTINCT DEPARTMENT_ID, JOB_ID FROM EMPLOYEES ORDER BY 1

----------------------------------------------------------------------------------------------
--********************************************************************************************
----------------------------------------------------------------------------------------------
--PRACTICA













