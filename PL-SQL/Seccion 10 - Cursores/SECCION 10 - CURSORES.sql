CURSORES 
    -implicitos: se generan cuando lanzo un comando como select

    -explicitos: lo defino 

ATRIBUTOS IMPLICITOS
    - SQL%ISOPEN   
    - SQL%FOUND
    - SQL%NOTFOUND
    - SQL%ROWCOUNT
    
SQL es el nombre que se le coloca a los nombres implicitos    

-- EJEMPLO CURSOR IMPLICITO
BEGIN
    UPDATE TEST SET C2='esta'
    where C1=280;
    DBMS_OUTPUT.PUT_LINE('ROWCOUN: '|| SQL%ROWCOUNT);
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ENCONTRADO');
    ELSIF SQL%NOTFoUND THEN
        DBMS_OUTPUT.PUT_LINE('NO ENCONTRADO');
    END IF;
END;


----------------------------------------------
EJEMPLO CURSOR: SOLO ACCEDE A UNA FILA
DECLARE
    CURSOR c1 is SELECT * from REGIONS;
    v1 REGIONS%ROWTYPE;
BEGIN

    open c1;
    FETCH c1 INTO v1;
        DBMS_OUTPUT.PUT_LINE('region name: '||v1.REGION_NAME);
    CLOSE c1;
END;


---------------------------------

-- RECORRER CURSOR CON BUCLE LOOP MOSTRANDO TODOS LOS DATOS DE ESA TABLE-----
-- USANDO ROWTYPE PARA REGIONS -----
DECLARE
    CURSOR allregions IS SELECT * FROM REGIONS ORDER BY REGION_ID ASC;
    regionf REGIONS%ROWTYPE;
BEGIN
   OPEN allregions;
   LOOP
        FETCH allregions INTO regionf;
            DBMS_OUTPUT.PUT_LINE('region: '||regionf.REGION_NAME);
        EXIT WHEN allregions%NOTFOUND;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Cantidad: '||allregions%ROWCOUNT);
    CLOSE allregions;
END;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- RECORRER CURSOR CON BUCLE FOR
DECLARE
    CURSOR c1 is SELECT * from REGIONS ORDER BY REGION_ID ASC;
BEGIN
-- LOS COMANDO OPEN, FETCH Y CLOSE SE HACEN IMPLICITOS CON FOR
    FOR i IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE('region name: '||i.REGION_NAME);        
    END LOOP;
END;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---BUCLE FOR CON SUBQUERIES 
BEGIN
    FOR i IN (SELECT * FROM COUNTRIES ORDER BY COUNTRY_NAME ASC) LOOP
        DBMS_OUTPUT.PUT_LINE('PAÍS '||i.COUNTRY_NAME);
    END LOOP;
END;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

************************************************************************************************************************
************************************************************************************************************************
--CURSORES CON PARAMETROS
SET SERVEROUTPUT ON;
DECLARE 
    --parametros a recivir varioss separlos por ,
    CURSOR C1(salario number) is SELECT * FROM EMPLOYEES
    WHERE SALARY < salario;
    emp EMPLOYEES%ROWTYPE;
BEGIN
    -- RECIVIR PARAMETROS CON FOR  
        FOR i IN C1(2200) LOOP
            DBMS_OUTPUT.PUT_LINE('NOMBRE: '||i.FIRST_NAME||' SALARIO: '||i.SALARY);
        END LOOP;
    -- RECIVIR PARAMETROS CON LOOP
        OPEN C1(2200);
            LOOP
            EXIT WHEN C1%NOTFOUND;
                FETCH C1 into emp;
                    DBMS_OUTPUT.PUT_LINE('NOMBRE: '||emp.FIRST_NAME||' SALARIO: '||emp.SALARY);
            END LOOP;
        CLOSE C1;

END;


-- UPDATE DELETE CON WHERE CURRENT OF
SET SERVEROUTPUT ON;
DECLARE
    emp EMPLOYEES%ROWTYPE;
    CURSOR cur IS SELECT * FROM EMPLOYEES FOR UPDATE;
BEGIN
    OPEN cur;
    LOOP 
        FETCH cur INTO emp;
        EXIT WHEN cur%NOTFOUND;
        IF emp.COMMISSION_PCT IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('OK');
            UPDATE EMPLOYEES SET SALARY = SALARY *1.10 WHERE CURRENT OF cur;
        ELSE
            DBMS_OUTPUT.PUT_LINE('SON NULOS');
            UPDATE EMPLOYEES SET SALARY = SALARY *0.15 WHERE CURRENT OF cur;
        END IF;
    END LOOP;
    CLOSE cur;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-------------------------------------------
------------

--PRACTICA
/*
1. Hacer un programa que tenga un cursor que vaya visualizando los
salarios de los empleados. Si en el cursor aparece el jefe (Steven
King) se debe generar un RAISE_APPLICATION_ERROR indicando
que el sueldo del jefe no se puede ver.
*/
SET SERVEROUTPUT ON;
DECLARE
    CURSOR listEmps IS SELECT * FROM EMPLOYEES ORDER BY EMPLOYEE_ID ASC;
    femp EMPLOYEES%ROWTYPE;
BEGIN
    OPEN listemps;
        FETCH listEmps INTO femp;
            IF femp.FIRST_NAME = 'Steven' AND femp.LAST_NAME = 'King' THEN
                RAISE_APPLICATION_ERROR(-20001,'No se puede mostrar datos del jefe');
                DBMS_OUTPUT.PUT_LINE('nombre: '||femp.FIRST_NAME);
            ELSE
                DBMS_OUTPUT.PUT_LINE('nombre: '||femp.FIRST_NAME);
            END IF;
END;

------------------------------------------------
---------------------------------
/*
2. Hacemos un bloque con dos cursores. (Esto se puede hacer
fácilmente con una sola SELECT pero vamos a hacerlo de esta
manera para probar parámetros en cursores)
• El primero de empleados
• El segundo de departamentos que tenga como parámetro el MANAGER_ID
• Por cada fila del primero, abrimos el segundo curso pasando el ID del MANAGER
• Debemos pintar el Nombre del departamento y el nombre del MANAGER_ID
• Si el empleado no es MANAGER de ningún departamento debemos poner “No es jefe de nada”
*/
SET SERVEROUTPUT ON
DECLARE
    DEPARTAMENTO DEPARTMENTS%ROWTYPE;
    jefe DEPARTMENTS.MANAGER_ID%TYPE;
    CURSOR C1 IS SELECT * FROM EMployees ORDER BY EMPLOYEE_ID ASC;
    CURSOR C2(j DEPARTMENTS.MANAGER_ID%TYPE)
    IS SELECT * FROM DEPARTMENTS WHERE MANAGER_ID=j;
begin
    for EMPLEADO in c1 loop
        open c2(EMPLEADO.employee_id) ;
            FETCH C2 into departamento;
                if c2%NOTFOUND then
                    DBMS_OUTPUT.PUT_LINE('');
                ELSE
                    DBMS_OUTPUT.PUT_LINE(EMPLEADO.FIRST_NAME || 'ES JEFE DEL DEPARTAMENTO '|| DEPARTAMENTO.DEPARTMENT_NAME);
                END IF;
        CLOSE C2;
    END LOOP;
END;

/*
3. Crear un cursor con parámetros que pasando el número de
    departamento visualice el número de empleados de ese departamento
*/
DECLARE
    CURSOR depts IS SELECT * FROM DEPARTMENTS ORDER BY DEPARTMENT_ID ASC;
    CURSOR emps(di EMPLOYEES.DEPARTMENT_ID%TYPE) IS SELECT COUNT(*) FROM EMPLOYEES WHERE DEPARTMENT_ID = di;
    cantidad NUMBER;
BEGIN

    FOR i IN depts LOOP
        OPEN emps(i.DEPARTMENT_ID);
            FETCH emps INTO cantidad;
                DBMS_OUTPUT.PUT_LINE('departamento:'||i.DEPARTMENT_NAME||' idep: '||i.DEPARTMENT_ID ||'         cantidad: '||cantidad);
        CLOSE emps;
    END LOOP;
EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;


-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
/*
4. Crear un bucle FOR donde declaramos una subconsulta que nos
devuelva el nombre de los empleados que sean ST_CLERCK. Es
decir, no declaramos el cursor sino que lo indicamos
directamente en el FOR.
*/

BEGIN
    FOR i IN (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'ST   _CLERK' ) LOOP
        DBMS_OUTPUT.PUT_LINE('NOMBRE: '||i.FIRST_NAME);
    END LOOP;
END;

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
/*
5. Creamos un bloque que tenga un cursor para empleados.
Debemos crearlo con FOR UPDATE.
• Por cada fila recuperada, si el salario es mayor de 8000 incrementamos el salario un 2%
• Si es menor de 800 lo hacemos en un 3%
• Debemos modificarlo con la cláusula CURRENT OF
• Comprobar que los salarios se han modificado correctamente
*/

SET SERVEROUTPUT ON;

DECLARE
    CURSOR liEmps IS SELECT * FROM EMPLOYEES FOR UPDATE;
BEGIN
    FOR i IN liEmps LOOP
        IF i.SALARY > 8000 THEN
            UPDATE EMPLOYEES SET SALARY= SALARY *1.02
            WHERE CURRENT OF liEmps;
            DBMS_OUTPUT.PUT_LINE('MAYOR A 8000 AUMENTO DE 2%');
        ELSE
            UPDATE EMPLOYEES SET SALARY= SALARY * 1.03
            WHERE CURRENT OF liEmps;
            DBMS_OUTPUT.PUT_LINE('MAYOR A 8000 AUMENTO DE 3%');
        END IF;
    END LOOP;
    COMMIT;
END;
