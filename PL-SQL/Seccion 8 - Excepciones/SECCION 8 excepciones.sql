exxeipciones
- NO_DATA_FOUND     ora-1403
- TOO_MANY_ROWS
- ZERO_DIVIDE
- DUP_VAL_ON_INDEX : la clave ya ecxiste


-- excepciones predefinidas
-----------------------------------------------
SET SERVEROUTPUT ON
DECLARE 
    empl EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO empl FROM EMPLOYEES WHERE EMPLOYEE_ID> 1;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NOT EXIST');
    WHEN TOO_MANY_ROWS THEN 
        DBMS_OUTPUT.PUT_LINE('MANY ROWS. ¡EXPECT ONE!');
END;

-- excepciones no  predefinidas
PRAGMA ES COMO UN ASOCIADOR DE UNA EXCEPCION A UN CODIGO
-----------------------------------------------
DECLARE
    -- CREAMOS UN OBJETO DEL TIPO EXCEPTION
    MI_EXCEP EXCEPTION;
    -- CLAUSULA PRAGMA, asignamos el codigo del error que esta asociado a
    -- el tipo de error   
    PRAGMA EXCEPTION_INIT(MI_EXCEP, -937);
    V1 NUMBER;
    V2 NUMBER;
BEGIN
    SELECT  EMPLOYEE_ID,SUM(SALARY) INTO v1,v2 FROM EMPLOYEES;
        DBMS_OUTPUT.PUT_LINE(v1);
EXCEPTION
    WHEN MI_EXCEP THEN -- NOMBRE DE LA EXCEPCION DEFINIDA
        DBMS_OUTPUT.PUT_LINE('FUNCION DE GRUPO INCORRECTA NO HAY USO DE GROUP BY');
END;


-----------------------------------------------
-----------------------------------------------

SQLCODE SQLERRM

SQLCODE: nos provee el codigo del error
SQLERRM: sqlError Message

DECLARE
    empleado EMPLOYEES%ROWTYPE;
    -- VARIABLES PARA GUARDAR EL CODIGO Y EL MENSAJE DE ERROR
    code NUMBER;
    mensaje VARCHAR2(200);
BEGIN
    SELECT * INTO empleado FROM EMPLOYEES;
        DBMS_OUTPUT.PUT_LINE(empleado.SALARY);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        code:=SQLCODE;
        mensaje:=SQLERRM;
        INSERT INTO ERRORSM VALUES(code,mensaje);
        COMMIT;
END;


-----------------------------------------------
-----------------------------------------------

-- CONTROLAR SQL CON EXCEPCIONES 
SET SERVEROUTPUT ON;
DECLARE
    region REGIONS%ROWTYPE;
BEGIN
    region.REGION_NAME:='WAKANDA';
    region.REGION_ID:=122;
    SELECT *  INTO region FROM REGIONS WHERE REGION_ID= region.REGION_ID;
    DBMS_OUTPUT.PUT_LINE('REGION YA EXISTE');
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        INSERT INTO REGIONS VALUES(region.REGION_ID,region.REGION_NAME);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('agregado');
END;


-- EXCEPCIONES PERSONALIDAS POR EL DESARROOLLADOR
-- EXCEPCION PERSONALIZADA QUE EVITA REGIN_ID MAYORES A 100 Y QUE NO EXISTA
DECLARE
    regid_max EXCEPTION;
    regn VARCHAR2(100);
    regi NUMBER;
    regaux NUMBER;
BEGIN
    regn:='America Central';
    regi:=4;
    IF regi > 100 THEN
        RAISE regid_max;
    ELSE
        SELECT REGION_ID INTO regaux FROM REGIONS WHERE REGION_ID=regi;
        DBMS_OUTPUT.PUT_LINE('REGION ID YA EXISTE'|| regaux);
    END IF;
EXCEPTION 
    WHEN regid_max THEN
        DBMS_OUTPUT.PUT_LINE('ID MAYOR QUE 100');
    WHEN NO_DATA_FOUND THEN 
        INSERT INTO REGIONS VALUES(regi,regn);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('REGION INGRESADA');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPCION NO DEFINIDA');
END;


PRACTICA
------------------------------SET SERVEROUTPUT ON;
DECLARE
    CONTROL_REGIONES EXCEPTION;
    regn VARCHAR2(100);
    regi NUMBER;
    regaux VARCHAR2(100);
BEGIN
    regn:='EL SALVADOR';
    regi:=105;
    IF regi > 200 THEN
        RAISE CONTROL_REGIONES;
    ELSE
        SELECT REGION_NAME INTO regaux FROM REGIONS WHERE REGION_ID=regi;
        DBMS_OUTPUT.PUT_LINE('REGION YA EXISTE');
    END IF;
EXCEPTION 
    WHEN CONTROL_REGIONES THEN
        DBMS_OUTPUT.PUT_LINE('Codigo no permitido. Debe ser inferior a 200');
    WHEN NO_DATA_FOUND THEN
        INSERT INTO REGIONS VALUES(regi,regn);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('REGION INGRESADA');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NO DEFINIDO');
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;



--------------
AMBITO DE LA EXCEPCIONES CON BLOQUES
SET SERVEROUTPUT ON;
DECLARE
    regn VARCHAR2(100);
    regi NUMBER;
    regaux VARCHAR2(100);
BEGIN
    regn:='EL SALVADOR';
    regi:=102;
    DECLARE
        CONTROL_REGIONES EXCEPTION;
    BEGIN
        IF regi > 200 THEN
            RAISE CONTROL_REGIONES;
        ELSE
            SELECT REGION_NAME INTO regaux FROM REGIONS WHERE REGION_ID=regi;
            DBMS_OUTPUT.PUT_LINE('REGION YA EXISTE');
        END IF;
    EXCEPTION
        WHEN CONTROL_REGIONES THEN
            DBMS_OUTPUT.PUT_LINE('Codigo no permitido. Debe ser inferior a 200');
        WHEN NO_DATA_FOUND THEN
            INSERT INTO REGIONS VALUES(regi,regn);
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('REGION INGRESADA');
    END;
EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NO DEFINIDO');
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;


------------------------------------------
COMANDO RAISE_APPLICATION_ERROR
SET SERVEROUTPUT ON;
DECLARE 
    regi NUMBER;
    regn VARCHAR2(100);
BEGIN
    regi:=300;
    regn:='sana ta';
    IF regi > 100 THEN
                                    --CODIGO ENTRE -20000 Y -20999
        RAISE_APPLICATION_ERROR(-20001, 'LA ID NO PUEDE SER MAYOR QUE 100');
        --CUANDO UN ERROR ES GRAVE PODEMOS HACERLO ASI DE MODO QUE SE QUIEBRE O SE PARE EL PROCESO
    ELSE 
        INSERT INTO REGIONS VALUES(regi,regn);
        COMMIT;
    END IF;
END;


---------------------------------------------------------------------------
---------------------------------------------------------------------------

PRACTICA
------------------
DECLARE
    CONTROL_REGIONES EXCEPTION;
    regn VARCHAR2(100);
    regi NUMBER;
    regaux VARCHAR2(100);
BEGIN
    regn:='EL SALVADOR';
    regi:=400;
    IF regi > 200 THEN
        RAISE CONTROL_REGIONES;
    ELSE
        SELECT REGION_NAME INTO regaux FROM REGIONS WHERE REGION_ID=regi;
        DBMS_OUTPUT.PUT_LINE('REGION YA EXISTE');
    END IF;
EXCEPTION 
    WHEN CONTROL_REGIONES THEN
        RAISE_APPLICATION_ERROR(-20001,'region id no puede ser mayor a 200');
    WHEN NO_DATA_FOUND THEN
        INSERT INTO REGIONS VALUES(regi,regn);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('REGION INGRESADA');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NO DEFINIDO');
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;


