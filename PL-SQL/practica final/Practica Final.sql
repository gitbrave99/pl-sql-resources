CREACION DE TABLAS
CREATE TABLE FACTURAS(
    COD_FACTURA NUMBER NOT NULL PRIMARY KEY,
    FECHA DATE,
    DESCRIPCION VARCHAR2(100)
);

CREATE TABLE LINEAS_FACTURAS(
    COD_PRODUCTO NUMBER,
    CODG_FACTURA NUMBER,
    UNIDADES NUMBER,
    FECHA DATE
);
 ALTER TABLE LINEAS_FACTURAS MODIFY ("COD_PRODUCTO" NOT NULL ENABLE);

CREATE TABLE PRODUCTOS(
    COD_PRODUCTO NUMBER,
    NOMBRE_PRODUCTO VARCHAR2(100),
    PVP NUMBER,
    TOTAL_VENDIDO NUMBER
);

CREATE TABLE CONTROL_LOG(
    COD_EMPLEADO NUMBER,
    FECHA DATE,
    TABLA_AFECTADA VARCHAR2(50),
    COD_OPERACION CHAR(1)
)


Insert into PRODUCTOS
(COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDO) values
('1','TORNILLO','1',NULL);
Insert into HR.PRODUCTOS
(COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDO) values
('2','TUERCA','5',null);
Insert into HR.PRODUCTOS
(COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDO) values
('3','ARANDELA','4',null);
Insert into HR.PRODUCTOS
(COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDO) values
('4','MARTILLO','40',null);
Insert into HR.PRODUCTOS
(COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDO) values
('5','CLAVO','1',null);

********************************************************************
********************************************************************