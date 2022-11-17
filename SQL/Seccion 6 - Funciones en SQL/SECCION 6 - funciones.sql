---------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-- FUNCIONES

select substr('hola',2,4) from dual
SELECT UPPER('hla'),LOWER('HOLA') FROM DUAL
SELECT INITCAP('ISAAC PREZA') FROM DUAL

-- CONCATENACION
-- 1 OPCION
SELECT FIRST_NAME||' '|| LAST_NAME FROM EMPLOYEES
-- 2 OPCION 
SELECT CONCAT(FIRST_NAME,CONCAT(' ',LAST_NAME)) FROM EMPLOYEES

SELECT FIRST_NAME,SUBSTR(FIRST_NAME,2,2) FROM EMPLOYEES

SELECT FIRST_NAME,LENGTH(FIRST_NAME) FROM EMPLOYEES
where LENGTH(FIRST_NAME) = 5

-- FUNCION INSTR para buscar si una palabra tiene una letra
-- 0 significa no >=1 la pocision

SELECT FIRST_NAME, INSTR(FIRST_NAME,'a') FROM EMPLOYEES

a que este a partir de la posicion 4
SELECT FIRST_NAME, INSTR(FIRST_NAME,'a',4) FROM EMPLOYEES

-- FUNCION DE CARACTER
-- LPAD, RPAD

-- RPAD: agregar espacios y permite agregar un caractere para rellenar estos espacios
SELECT RPAD(FIRST_NAME,20,'-') FROM EMPLOYEES
--LPAD: alla inversa
SELECT LPAD(FIRST_NAME,20,'-') FROM EMPLOYEES

--REPLACE, LTRIM, RTRIM
-- REPLACE: sustituimos las a por *
SELECT REPLACE(FIRST_NAME,'a','*') FROM EMPLOYEES

-- RTRIM: quita espacios a la derecha
-- LTRIM: quita los espacios de la izquierda

-- quita las letras n de la derecha
select FIRST_NAME,rtrim(FIRST_NAME,'n') from EMPLOYEES
-- quita las letras n de la izquierda
select FIRST_NAME,ltrim(FIRST_NAME,'D') from EMPLOYEES


--ROUND, TRUNC, MOD, POWER

--ROUND(C1,N)
SELECT ROUND(50.993,2) FROM DUAL
SELECT ROUND(50.92074,2) FROM DUAL

-- TRUNC
SELECT TRUNC(50.9290,2) FROM DUAL

--MOD(A,B)
SELECT MOD(10,2) FROM DUAL

--POWER
SELECT POWER(2,3) FROM DUAL



--funciones


--PRACTICA 9
-- En la tabla LOCATIONS, averiguar las ciudades que son de Canada o
-- Estados unidos (Country_id=CA o US) y que la longitud del nombre de la
-- calle sea superior a 15.

select * from LOCATIONS where Country_id IN ('CA','US')
AND LENGTH(STREET_ADDRESS) > 15


-------------------------------------------------------------------------------------------------
---**********************************************************************************************
-------------------------------------------------------------------------------------------------
---ARITMETICA CON FECHAS
-- suma 2 dias
select sysdate+2 from dual

--resta 2 dias
select sysdate-2 from dual

--cantidad de días en que ha trabajado
select FIRST_NAME,HIRE_DATE, SYSDATE-HIRE_DATE from EMPLOYEES

--cantidad de meses enre dos fechas
select HIRE_DATE,FIRST_NAME,MONTHS_BETWEEN(SYSDATE,HIRE_DATE) from EMPLOYEES

--SUMAR MESES
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3) FROM DUAL

-- NEXT_DAY
select NEXT_DAY(SYSDATE,'WED') from DUAL

-- LAST DAY ultimo día del mes
SELECT SYSDATE, LAST_DAY(SYSDATE ) FROM DUAL;

-- ROUND            
select sysdate, ROUND(sysdate,'MONTH'),ROUND(sysdate,'YEAR') FROM DUAL

--TRUNC
select sysdate, TRUNC(sysdate,'MONTH'),TRUNC(sysdate,'YEAR') FROM DUAL




