-- TIPOS DE CONVERSIN
    -- IMPLICITA
    -- EXPLICITA

select '10'+10 from dual
SELECT 10||'10'FROM DUAL
select 'hoy es '||SYSDATE from dual
select MONTHS_BETWEEN(SYSDATE,'10-10-10') FROM dual

-- CONVERSIONES EXPLICITAS

-- TO_CHAR(DATE/NUMBER, FORMATO)
-- TO_CHAR(DATE, FORMATO)
/*
YYYY  = AÑO 4 DIGITOS
YEAR  = AÑO(INGLÉS)
MM    = MES 2 DIGITOS
MONTH = MES EN TEXTO
MON   = ABREVIATURA DEL MES
DY    = ABREVIATURA DEL DIA
DAY   = DIA EN TEXTO
DD    = NUMERO DEL DÍA
*/

select TO_CHAR( SYSDATE,'DD-MON-YYYY') from dual

-- PODEMOS OBTENER EL DIA, MES Y AÑO todo lo expresado anteriormente
select SYSDATE,TO_CHAR( SYSDATE,'YYYY') from dual
select sysdate from dual




-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

AM      =   PM MERIDIANO
HH      =   FORMATO 12 HORAS
HH24    =   FORMATO 24 HORAS
MI      =   MINUTO
SS          SEGUNDOS

DECLARE 
    MESSAGE VARCHAR2(100);
BEGIN
    MESSAGE:= TO_CHAR(SYSDATE,'"Son las " HH24:MI "del dia de hoy" DAY "del año" YYYY');
    DBMS_OUTPUT.PUT_LINE(MESSAGE);
END;


SELECT SYSDATE, TO_CHAR(SYSDATE,'HH:MI') FROM DUAL
SELECT SYSDATE, TO_CHAR(SYSDATE,'"Son las " HH24:MI "del dia de hoy" DAY "del año" YYYY') FROM DUAL;

-- CONVERTIR NUMEROS A CHARACTER

9   =   NUMERO
0   =   VISUALIZA UN CERO
$   =   DOLAR
L   =   MONEDA LOCAL
.   =   PUNTO DECIMAL
,   =   MILES SEPARADOR

SELECT SALARY,TO_CHAR(SALARY,'9999') FROM EMPLOYEES

-- FORMATO DE 5 NUMEROS QUE AL NO TENER NUMEROS MAYORES Q 0 COLOQUE UN CERO DE 
-- RELLENO COLOCANDO TODOS DE LA MISMA LONGITUD

SELECT SALARY,TO_CHAR(SALARY,'00009') FROM EMPLOYEES;

-- ANTEPONER EL SIMBOLO DE $
SELECT SALARY,TO_CHAR(SALARY,'$00009') FROM EMPLOYEES;

-- AGREGANDO DECIMALES
SELECT SALARY,TO_CHAR(SALARY,'$00009.99') FROM EMPLOYEES;






--------------------------------------------------------------------
--------------------------------------------------------------------

-- CONVERTIR CARACTERES A FECHAS

-- TO_DATE(STRING,FORMATO)

SELECT TO_DATE('10-01-99') FROM DUAL;
SELECT TO_DATE('10-JAN-99') FROM DUAL;


SELECT TO_DATE('10-23-99','mm-dd-YY') FROM DUAL;
SELECT TO_DATE('JAN-23-99','mon-dd-YY') FROM DUAL;



-- FORMATO RR

YY
0-49    =   2000
50-99   =   1900
-- ultimo digito mayor que 49 agrega año 1900
SELECT TO_CHAR(TO_DATE('10-01-99','DD-MM-RR'),'DD-MM-YYYY') FROM DUAL

-- ultimo digito mayor que 49 agrega año 2000
SELECT TO_CHAR(TO_DATE('10-01-22','DD-MM-RR'),'DD-MM-YYYY') FROM DUAL

--------------------------------------------------------------------
--------------------------------------------------------------------
-- CONVERTIR STRING A NUMEROS
-- TO_NUMBER(STRING,'FORMATO')

SELECT TO_NUMBER('1000.00','9999.99') FROM DUAL;
SELECT TO_NUMBER('$1500','L9999') FROM DUAL;
select rtrim('algo   '),'dos' from dual




SELECT FIRST_NAME, INSTR(FIRST_NAME,'a',4) FROM EMPLOYEES










