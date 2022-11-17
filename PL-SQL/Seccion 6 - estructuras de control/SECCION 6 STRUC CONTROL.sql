------------------------------------------------------------
                ESTRUCTURAS DE CONTROL
------------------------------------------------------------
 
 OPERADORES RELACIONEALES O DE COMPRARACION
    =  igual
    <> distinti DE
    <  menor que
    >  mayor que
    >= mayor o igual que 
    <= menor o igual que
OPRADORES LOGICOS
    1- AND 
    2- OR 
    3- NOT

PLS_INTEGER
    ocupa menos quelos number por esllo van en en for loop



SET SERVEROUTPUT ON
DECLARE
    numero number:= 11;
BEGIN 

    IF MOD(numero,2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('NUMERO PAR');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NUMERO IMPAR');

    END IF;
    
END;


--------------------------
ELSE IF
SET SERVEROUTPUT ON;
DECLARE 
    edad NUMBER:=12;
BEGIN
    IF edad > 18 THEN
        DBMS_OUTPUT.PUT_LINE('MAYOR EDAD');
    ELSIF edad = 12 THEN
        DBMS_OUTPUT.PUT_LINE('ADOLESCENTE');
    END IF;
END;

------------------------------------------------------------------------------------------
--****************************************************************************************
------------------------------------------------------------------------------------------

-- CASE
DECLARE 
    v1 char(1);
BEGIN
    v1:='B';
    CASE v1
        WHEN 'B' THEN
            DBMS_OUTPUT.PUT_LINE('VERY GOOD');
        WHEN 'C' THEN 
            DBMS_OUTPUT.PUT_LINE('VERY BAD');
        WHEN 'D' THEN
            DBMS_OUTPUT.PUT_LINE('EXCELLENT');
        ELSE    
            DBMS_OUTPUT.PUT_LINE('no hay recurso');
    END CASE;
END;

-- SEARCHED CASE

DECLARE 
    v1 NUMBER:=12;
BEGIN
    CASE 
        WHEN v1 > 11 AND v1 < 18  THEN
            DBMS_OUTPUT.PUT_LINE('ADOLESCENTE');
        WHEN v1 >17 AND v1 < 41 THEN 
            DBMS_OUTPUT.PUT_LINE('MAYOR DE EDAD');
        WHEN v1 > 40 THEN
            DBMS_OUTPUT.PUT_LINE('ADULTO');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('ANCIANO');
    END CASE;
END;


------------------------------------------------------------------------------------------
--****************************************************************************************
------------------------------------------------------------------------------------------
--BUCLE LOOP

DECLARE
    x number:=1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(x);
        x:= x+1;
        --PRIMERA FORMA PARA SALIR DEL BUCLE
        /*IF x=10 THEN 
            EXIT;
        END IF;*/
        -- SEGUNDA FORMA PARA SALIR DEL BUCLE
        EXIT WHEN x =10;
    END LOOP;

END;


--LOOPS ANINDADOS

DECLARE
    s PLS_INTEGER:= 0;
    i PLS_INTEGER:= 0;
    j PLS_INTEGER;
BEGIN
    <<parent>>
    LOOP
        i:= i+1;
        j:= 100;
        DBMS_OUTPUT.PUT_LINE('--PARENT--'||i);
        <<child>>
        LOOP
            EXIT parent WHEN (i>3);
            DBMS_OUTPUT.PUT_LINE('                child'||j);
            j:=j+1;
            EXIT child WHEN (j > 105);
        END LOOP child;
    END LOOP parent;
    DBMS_OUTPUT.PUT_LINE('finished');
END;
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---CONTINUE
DECLARE 
    x NUMBER:=0;
BEGIN
    LOOP
        x:=x+1;
        --PRIMERA FORMA PARA DAR CONTINUE
        /*IF x = 3 THEN
            CONTINUE;
        END IF;*/
        --SEGUNDA FORMA PARA DAR CONTINUE 
        CONTINUE WHEN x=3;

        DBMS_OUTPUT.PUT_LINE('COUNTER : '||x);
        EXIT WHEN x=5;
    END LOOP;
END;

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--FOR LOOP 
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
-- FOR LOOP IN  REVERSE
BEGIN
    FOR i IN REVERSE 1..10 LOOP
        EXIT WHEN i =4;
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--WHILE LOOP
DECLARE
    existe BOOLEAN :=FALSE;
    counter NUMBER:=0;
BEGIN
    WHILE existe LOOP
        DBMS_OUTPUT.PUT_LINE('NO SLADRA POR Q DONDE ES TRUE');
    END LOOP;

    WHILE NOT existe LOOP
        DBMS_OUTPUT.PUT_LINE('NEGAMOS EXISTE');
        existe:=TRUE;
    END LOOP;
    WHILE counter < 5 LOOP
        DBMS_OUTPUT.PUT_LINE(counter);
        counter:= counter+1;
    -- PODEMOS SALIR DEL BUCLE CON EXIT 
        EXIT WHEN counter = 3;
    END LOOP;
END;

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
DECLARE
    p VARCHAR2(30);
    n PLS_INTEGER:= 5;
BEGIN
    FOR j IN 2..ROUND(SQRT(n)) LOOP
        IF n MOD j = 0 THEN
            p:= 'no es numero primro';
            GOTO print_now;
        END IF;
    END LOOP;
    p:= ' Es un número primo';

    <<print_now>>
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(n) || p);
END;

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-----------------EJERCICIOS-----------------------

-- PRACTICA 8  
    
    -- EJERCICIO 1 
TABLA DE MULTIPLICAR CON LOOP
SET SERVEROUTPUT ON;
DECLARE
    ind NUMBER:=1;
    tbb NUMBER:=1;  
BEGIN 
  LOOP
  EXIT WHEN ind=11;
    DBMS_OUTPUT.PUT_LINE('TABLA DEL: '|| ind);
    LOOP
    EXIT WHEN tbb=11;
        DBMS_OUTPUT.PUT_LINE(ind||' * '|| tbb|| '=' ||(ind*tbb));
        tbb:=tbb+1;
    END LOOP;
    tbb:=0;
    ind:=ind+1;
  END LOOP;
END;















