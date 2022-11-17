PAQUETES PLSQL
formados por 2 componentes
    - SPEC (CABECERA): packages spec, espeficicacion del paquete
        * encontramos:
                      - variables
                      - declaraciones
        * podemos agregar OBJETOS publicos

    - BODY: 
        *encontramos
                    - variables
                    - codigo
                    - proc
                    - func
                    - ...
        * podemos agregar OBJETOS privadas, SOLO PUEDEN LLAMARSE DENTOR DEL BODY


-- AMBITO DE LAS VARIABLES EN UN PAQUETE
    en el ejemplo anterior la variable v1 se inicializa con 10
    por lo que cuando lo usamos y le agregamos 1 mientras dura la sesion del usuario ese contador
    tomará el valor del resultado anterior
    ejemplo: antes: 10, despues: 11, antes:11, despues:12.....

-- LA CABECERA Y EL CUERPO VAN SEPARADOS SE PUDEN CREAR POR SEPARADO


----PAQUETES PREDEFINIDOS QUE TIENE ORACLE
    - DBMS_OUTPUT
    - UTL_FILE
    - UTL_MAIL
    - DBMS_ALERT
    - DBMS_LOCK
    - DBMS_APPLICACION_INFO
    - HTP
    - DBMS_SHEDULER

--CREACION DE LA CABECERA
CREATE OR REPLACE PACKAGE PACK1
IS
    v1 NUMBER:=10;
    v2 VARCHAR2(100);
END;
/
--- USO DE PAQUETE
SET SERVEROUTPUT ON;
BEGIN
    PACK1.v1:= PACK1.v1 + 1;
    PACK1.v2:='MY EDAD ES: '||PACK1.v1;
    DBMS_OUTPUT.PUT_LINE('variable: '||PACK1.v2);
END;


-- AMBITO DE LAS VARIABLES EN UN PAQUETE
    en el ejemplo anterior la variable v1 se inicializa con 10
    por lo que cuando lo usamos y le agregamos 1 mientras dura la sesion del usuario ese contador
    tomará el valor del resultado anterior
    ejemplo: antes: 10, despues: 11, antes:11, despues:12.....


--*****************************************************************************************************
--*****************************************************************************************************
-- CREANDO UN PACKAGE USANDO UN PROCEDURE
-- CABECERA O SPEC
CREATE OR REPLACE PACKAGE pConvertCharUpperLower
IS
    --DECLARAMOS EL PROCEDIMIENTO A USAR
    PROCEDURE PCONVERTTEXT(ptextv VARCHAR2, pconversion_type CHAR);
END;
/

--CREANDO EL BODY

CREATE OR REPLACE PACKAGE BODY pConvertCharUpperLower
IS
    --CREAMOS FUNCION PARA CONVERTIR EL VALOR A UPPER
    FUNCTION CONVERT_UPPER(ptext VARCHAR2) RETURN VARCHAR2
        IS
    BEGIN
        RETURN UPPER(ptext);
    END CONVERT_UPPER;
    -- CREAMOS UNA FUNCION QUE CONVIERTA A LOWER
    FUNCTION CONVERT_LOWER(ptext VARCHAR2) RETURN VARCHAR2
    IS
    BEGIN
        RETURN LOWER(ptext);
    END CONVERT_LOWER;


--CREAMOS EL PROCEDIMIENTO PARA 
PROCEDURE PCONVERTTEXT(ptextv VARCHAR2, pconversion_type CHAR)
IS
BEGIN
    CASE pconversion_type
        WHEN 'U' THEN
            DBMS_OUTPUT.PUT_LINE('UPPER: '||CONVERT_UPPER(ptextv));
        WHEN 'L' THEN
            DBMS_OUTPUT.PUT_LINE('lower: '||CONVERT_LOWER(ptextv));
    END CASE;
END PCONVERTTEXT;
END pConvertCharUpperLower;


--USO DEL PACKAGE
SET SERVEROUTPUT ON;
DECLARE
    tup VARCHAR2(100):='ISAAC';
    tlo VARCHAR2(100):='isaac';
BEGIN
    pConvertCharUpperLower.PCONVERTTEXT(tlo,'U');
    pConvertCharUpperLower.PCONVERTTEXT(tup,'L');
END;




--*****************************************************************************************************
--*****************************************************************************************************
-- CREANDO UN PACKAGE USANDO UNA FUNCION
-- CABECERA O SPEC
CREATE OR REPLACE PACKAGE pConvertCharUpperLower
IS
    --DECLARAMOS EL PROCEDIMIENTO A USAR
    FUNCTION PCONVERTTEXT(ptextv VARCHAR2, pconversion_type CHAR) RETURN VARCHAR2;
END;
/

--CREANDO EL BODY
CREATE OR REPLACE PACKAGE BODY pConvertCharUpperLower
IS
    --CREAMOS FUNCION PARA CONVERTIR EL VALOR A UPPER
    FUNCTION CONVERT_UPPER(ptext VARCHAR2) RETURN VARCHAR2
        IS
    BEGIN
        RETURN UPPER(ptext);
    END CONVERT_UPPER;
    -- CREAMOS UNA FUNCION QUE CONVIERTA A LOWER
    FUNCTION CONVERT_LOWER(ptext VARCHAR2) RETURN VARCHAR2
    IS
    BEGIN
        RETURN LOWER(ptext);
    END CONVERT_LOWER;

--CREAMOS EL PROCEDIMIENTO PARA 
FUNCTION PCONVERTTEXT(ptextv VARCHAR2, pconversion_type CHAR) RETURN VARCHAR2
IS
BEGIN
    CASE pconversion_type
        WHEN 'U' THEN
            RETURN CONVERT_UPPER(ptextv);
        WHEN 'L' THEN
            RETURN CONVERT_LOWER(ptextv);
    END CASE;
END PCONVERTTEXT;
END pConvertCharUpperLower;


--USO DEL PACKAGE
SET SERVEROUTPUT ON;
DECLARE
    tup VARCHAR2(100):='ISAAC';
    tlo VARCHAR2(100):='isaac';
BEGIN
    DBMS_OUTPUT.PUT_LINE(pConvertCharUpperLower.PCONVERTTEXT(tlo,'U'));
    DBMS_OUTPUT.PUT_LINE(pConvertCharUpperLower.PCONVERTTEXT(tup,'L'));
END;


---USO DEL PAQUETE PARA UN SELECT DE EMPLEADOS
SELECT
    employee_id,
    pConvertCharUpperLower.PCONVERTTEXT(first_name,'L'),
    pConvertCharUpperLower.PCONVERTTEXT(first_name,'U')
FROM
    employees;


--***************************************************
--   SOBERCARGA DE PROCEDIMIENTOS

CREATE OR REPLACE 
PACKAGE PACK2 AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
    FUNCTION COUNT_EMPLOYEES(ID NUMBER) RETURN NUMBER;
    FUNCTION COUNT_EMPLOYEES(ID VARCHAR2) RETURN NUMBER;
END PACK2;


CREATE OR REPLACE
PACKAGE BODY PACK2 AS

  FUNCTION COUNT_EMPLOYEES(ID NUMBER) RETURN NUMBER AS
    c NUMBER;
  BEGIN
    -- SOBREESCRITURA  CON PARAMETRO NUMBER
    SELECT COUNT(*) INTO c FROM EMPLOYEES WHERE DEPARTMENT_ID=ID;
    RETURN c;
  END COUNT_EMPLOYEES;

  FUNCTION COUNT_EMPLOYEES(ID VARCHAR2) RETURN NUMBER AS
    c NUMBER;
  BEGIN
    -- SOBREESCRITURA  CON PARAMETRO VARCHAR2
    SELECT COUNT(*) INTO c FROM EMPLOYEES E,DEPARTMENTS D
        WHERE DEPARTMENT_NAME = ID
        AND E.DEPARTMENT_ID=D.DEPARTMENT_ID;
        
    RETURN c;
  END COUNT_EMPLOYEES;
END PACK2;



----PRUEBA SOBRECARGA DE FUNCIONES
BEGIN
    -- DBMS_OUTPUT.PUT_LINE(PACK2.COUNT_EMPLOYEES(50));
    DBMS_OUTPUT.PUT_LINE(PACK2.COUNT_EMPLOYEES('Marketing'));
END;



-- PARA PODER USAR ARCHIVOS HAY Q DARLE LOS PERMISOS
    --creamos un directorio en la base de datos
        GRANT CREATE ANY DIRECTORY TO HR;
    -- agregamoslos permisos para  utilizar UTL_FILE
        GRANT EXECUTE ON SYS.UTL_FILE TO HR;
    
    -- MIRAR DOCUMENTACION DE UTL_FILE
    DESC UTL_FILE



-- PROCEDIMIENTO QUE LEE UN ARCHIVO 
GRANT EXECUTE ON SYS.UTL_FILE TO ADMINHR;

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE pRead_file IS
    string VARCHAR2(32767);
    Vfile UTL_FILE.FILE_TYPE;
BEGIN
    --OPEN FILE
    Vfile:= UTL_FILE.FOPEN('exercises','doc.txt','R');
    LOOP
        BEGIN
        --READ FILE
            UTL_FILE.GET_LINE(Vfile,string);
            DBMS_OUTPUT.PUT_LINE(string);
        EXCEPTION   
            WHEN NO_DATA_FOUND THEN EXIT;
        END;                            
    END LOOP;
    UTL_FILE.FCLOSE(Vfile);
END;
/


------------------------------------------------
-- PROCEDIMIENTO QUE LEE UN ARCHIVO Y LO GUARDA EN UN TABLA
GRANT EXECUTE ON SYS.UTL_FILE TO ADMINHR;

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE pRead_file IS
    string VARCHAR2(32767);
    Vfile UTL_FILE.FILE_TYPE;
BEGIN
    --OPEN FILE
    Vfile:= UTL_FILE.FOPEN('exercises','doc.txt','R');
    LOOP
        BEGIN
        --READ FILE
            UTL_FILE.GET_LINE(Vfile,string);
            INSERT INTO F1 VALUES(string);
        EXCEPTION   
            WHEN NO_DATA_FOUND THEN EXIT;
        END;                            
    END LOOP;
    UTL_FILE.FCLOSE(Vfile);
END;
/


*****************************************************
*****************************************************
    PRACTICA
-- PACKAGES
--**************************
-- PRACTICA 
/*
1. Crear un paquete denominado REGIONES que tenga los
siguientes componentes:
• PROCEDIMIENTOS:
    • - ALTA_REGION, con parámetro de código y nombre Región. Debe devolver un error si la región ya existe. 
        Inserta una nueva región en la tabla. Debe llamar a la función EXISTE_REGION
        para controlarlo.
    • - BAJA_REGION, con parámetro de código de región y que debe borrar una región. 
        Debe generar un error si la región no existe, Debe llamar a la función EXISTE_REGION para
        controlarlo
    • - MOD_REGION: se le pasa un código y el nuevo nombre de la región Debe modificar el nombre 
        de una región ya existente. Debe generar un error si la región no existe, Debe llamar a la
        función EXISTE_REGION para controlarlo

FUNCIONES
    • CON_REGION. Se le pasa un código de región y devuelve el nombre
    • EXISTE_REGION. Devuelve verdadero si la región existe. Se usa en los procedimientos 
        y por tanto es */

CREATE OR REPLACE PACKAGE REGIONESS
AS
    -- PROCEDIMIENTOS
    PROCEDURE ALTA_REGION(codigo IN NUMBER, nombre IN VARCHAR2);
    PROCEDURE BAJA_REGION(codigo IN NUMBER);
    PROCEDURE MOD_REGION(codigo IN NUMBER, newNombre IN VARCHAR2);
    -- FUNCIONES  
    FUNCTION CON_REGION(codigo IN NUMBER) RETURN VARCHAR2;
END REGIONESS;
/

CREATE OR REPLACE PACKAGE BODY REGIONESS
AS
    --FUNCION PARA OBTENER EL NOMBRE POR LE CODIGO
    FUNCTION  CON_REGION(codigo IN NUMBER) RETURN VARCHAR2 AS
        nombre VARCHAR2(100);
    BEGIN
        SELECT REGION_NAME INTO nombre FROM REGIONS WHERE REGION_ID=codigo;
        RETURN nombre;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'NO EXISTE';
    END;
    -- FUNCION PARA VALIDAR SI EXISTE
    FUNCTION EXISTE_REGION(codigo NUMBER) RETURN BOOLEAN AS
    idr REGIONS.REGION_ID%TYPE:=0;        
    BEGIN
        SELECT REGION_ID INTO idr FROM REGIONS WHERE REGION_ID = codigo;
        RETURN TRUE;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END;
    --PROCEDIMIENTO PARA CREAR UNA REGION
    PROCEDURE ALTA_REGION(codigo IN NUMBER, nombre IN VARCHAR2)
    IS
    BEGIN
        IF EXISTE_REGION(codigo) THEN
            DBMS_OUTPUT.PUT_LINE('REGION YA EXISTE');
        ELSE
            INSERT INTO REGIONS(REGION_ID,REGION_NAME)VALUES (codigo,nombre);
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Region agregada');
        END IF;
    END;

    --PROCEDIMIENTO PARA BORRAR REGION
    PROCEDURE BAJA_REGION(codigo IN NUMBER) AS
    BEGIN
        IF EXISTE_REGION(codigo) THEN
            DELETE FROM REGIONS WHERE REGION_ID=codigo;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Region borrada');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Region no existe');
        END IF;
    END;
    --PROCEDIMIENTO PARA MODIFICAR LA REGION
    PROCEDURE MOD_REGION(codigo IN NUMBER, newNombre IN VARCHAR2) AS
    BEGIN
        IF EXISTE_REGION(codigo) THEN
            UPDATE REGIONS SET REGION_NAME = newNombre WHERE REGION_ID=codigo;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Region modificada');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Region no existe');
        END IF;
    END;

END REGIONESS;
/

---- USO DEL PAQUETE
EXECUTE REGIONESS.ALTA_REGION(600,'ANIMACIONES');
EXECUTE REGIONESS.MOD_REGION(7,'SALSAMORA');
EXECUTE REGIONESS.BAJA_REGION(600);

DECLARE
    nm VARCHAR2(100);
BEGIN
    nm:= REGIONESS.CON_REGION(7);
    DBMS_OUTPUT.PUT_LINE(nm);
END;

-----------------------------------
/*
2. Crear un paquete denominado NOMINA que tenga sobrecargado la función CALCULAR_NOMINA de la siguiente forma:
    • CALCULAR_NOMINA(NUMBER): se calcula el salario del empleado restando un 15% de IRPF.
    • CALCULAR_NOMINA(NUMBER,NUMBER): el segundo parámetro es el porcentaje a aplicar. Se calcula el salario del
        empleado restando ese porcentaje al salario
    • CALCULAR_NOMINA(NUMBER,NUMBER,CHAR): el segundo parámetro es el porcentaje a aplicar, el tercero vale ‘V’ . Se
        calcula el salario del empleado aumentando la comisión que le pertenece y restando ese porcentaje al salario 
        siempre y cuando el empleado tenga comisión.
*/
CREATE OR REPLACE PACKAGE NOMINA AS
    FUNCTION CALCULAR_NOMINA(idEmp NUMBER) RETURN NUMBER;
    FUNCTION CALCULAR_NOMINA(idEmp NUMBER, porcentaje NUMBER) RETURN NUMBER;
    FUNCTION CALCULAR_NOMINA(idEmp NUMBER, porcentaje NUMBER,comision VARCHAR2:='V1') RETURN NUMBER;
END NOMINA;
/

CREATE OR REPLACE PACKAGE BODY NOMINA AS
    -- FUNCION PARA RESTAR UN 15%
    FUNCTION CALCULAR_NOMINA(idEmp NUMBER) RETURN NUMBER AS
        salario NUMBER;
    BEGIN
        SELECT SALARY INTO salario FROM EMPLOYEES WHERE EMPLOYEE_ID= idEmp;
        RETURN salario -(salario * (salario/100));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERRORS');
    END;
    
    --FUNCION PARA RESTAR UN % DE PARAMETRO
    FUNCTION CALCULAR_NOMINA(idEmp NUMBER, porcentaje NUMBER ) RETURN NUMBER AS
        salario NUMBER:=0;
    BEGIN
        SELECT SALARY INTO salario FROM EMPLOYEES WHERE EMPLOYEE_ID= idEmp;
        RETURN salario - (salario * (porcentaje/100));
    END;
    
    --FUNCION PARA RESTAR UN % DE PARAMETRO y UNA COMISION
    FUNCTION CALCULAR_NOMINA(idEmp NUMBER, porcentaje NUMBER, comision VARCHAR2:='V1') RETURN NUMBER AS
        salario NUMBER:=0;
        comision NUMBER:=0;
    BEGIN
        SELECT SALARY, COMMISSION_PCT INTO salario,comision FROM EMPLOYEES WHERE EMPLOYEE_ID= idEmp;
        RETURN (salario +(salario*comision)) -  (salario * (porcentaje/100));
    END;
END NOMINA;

--//USO DEL PAQUETE
declare
x number;
BEGIN
x:=NOMINA.CALCULAR_NOMINA(150,'8');
DBMS_OUTPUT.PUT_LINE(x);
END;
/
desc nomina;









