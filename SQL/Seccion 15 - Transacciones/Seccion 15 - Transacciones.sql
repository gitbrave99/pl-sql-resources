---transacciones--

-- TRANSACCION
--     conjunto de operaciones contra la bse de datos
---             insert-update-delete
--      confirmacmos la transaccion con COMMIT
--      cancelamos la transaccion con   ROLLBACK
--      se terminia una transaccion cuando escribamos COMMIT ROLLBACK

-- si 2 usuario se conectan a un la base de datos si el usuario A hace una transaccion el usuario B vera esa
-- transaccion hasta que A haga un COMMIT o ROLLBACK;

INSERT INTO DEPT2 VALUES(134,'TEST TRANSACCION');
COMMIT;

 
----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------
-- SAVEPOINT
    -- hace como un salvado hasta el momento
INSERT INTO REGION1 VALUES(1235,'AMERICA');
INSERT INTO REGION1 VALUES(1236,'ASIA');

SAVEPOINT A; --GUARDAMOS EL PUNTO HASTA ESTOS 2 INSERT 
    INSERT INTO REGION1 VALUES(1234,'TEST SAVEPOINT');
    INSERT INTO REGION1 VALUES(1237,'TEST SAVEPOINT africa');
    --INSERTAMOS 2 FILAS MAS

ROLLBACK TO SAVEPOINT A; --regresamos hasta ese punto de las 2 insert anteriores


DELETE FROM REGION1 WHERE REGION_ID=1237;

-- SI UN USUARIO MODIFICA UNA FILA EN UNA SESION Y ESE DATO LO QUIERE USAR OTRO USUARIO EN OTRA SESION
-- ESTE USUARIO NO PODRA MODICARLA HASTA Q EL USAURIO 1 HAGA COMMIT  O ROLLBAK;


----------------------------------------------------------------------------------------------------
--**************************************************************************************************
----------------------------------------------------------------------------------------------------


    



    






    


