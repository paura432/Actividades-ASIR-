--Creacion de la base de datos.
CREATE DATABASE FACTURASDATABASE;
USE FACTURASDATABASE;
--Creacion de las tablas.
CREATE TABLE CLIENTES
	(
	 IDCLIENTE INT NOT NULL PRIMARY KEY,
	 NOMBRE VARCHAR(35) NOT NULL,
	 TELEFONO CHAR(9),
	 DIRECCION VARCHAR(35) NOT NULL,
	 EMAIL VARCHAR(35)
	);
CREATE TABLE PROVEEDORES
	(
	 IDPROVEEDOR INT NOT NULL PRIMARY KEY,
	 NOMBRE VARCHAR(30) NOT NULL,
	 TELEFONO CHAR(9),
	 DIRECCION VARCHAR(30) NOT NULL,
	 EMAIL VARCHAR(30)
	);
CREATE TABLE PRODUCTOS
	(
	 IDPRODUCTO INT IDENTITY PRIMARY KEY,
	 NOMBRE VARCHAR(35) NOT NULL,
	 STOCK INT NOT NULL,
	 PRECIO DECIMAL(4,2) NOT NULL
	);
CREATE TABLE FACTURAS
	(
	 IDFACTURA INT IDENTITY PRIMARY KEY,
	 IDCLIENTE INT NOT NULL,
	 IDSUPERMERCADO INT NOT NULL,
	 IDPRODUCTO INT NOT NULL,
	 IMPORTE DECIMAL(4,2) NOT NULL,
	 FECHA DATETIME NOT NULL,
	 CANTIDAD INT NOT NULL,
	 FOREIGN KEY (IDCLIENTE) REFERENCES CLIENTES,
	 FOREIGN KEY (IDPROVEEDOR) REFERENCES PROVEEDORES,
	 FOREIGN KEY (IDPRODUCTO) REFERENCES PRODUCTOS
	);

--Introduccion de valores en las tablas.
INSERT INTO CLIENTES VALUES 
(012345678, 'Pau Ramos', '630118759', 'CalleAntracita 30', 'pauramosimo@gmail.com'),
(123456789, 'Eduardo Suarez', '630920932', 'Calle Alcalde Enrique Gálvez 33', 'eduardosuarez@gmail.com'),
(234567891, 'Felipe Compota', '638203989', 'Calle del Alcalde Francisco Moreno Menéndez 122','felipecompota@hotmail.com'),
(345678912, 'Fernando Poleo', '679289329', 'Calle Amatista 26', 'fernandopoleo@gmail.com'),
(456789123, 'Javier Tornado', '617298321', 'Calle de las Amazonas 32', 'javiertornado@gmail.com');
INSERT INTO PROVEEDORES VALUES 
(567891234, 'Fruta', '620909192', 'Camino de Abajo a Alpedrete 56', 'fruta@fresca.es'),
(678912345, 'CocaCola', '678934562', 'Camino de las Arenillas 37', 'Coca@Cola.com'),
(789123456, 'Pizza Tarradellas', '609865789', 'Calle Aretha Franklin 78', 'Pizza@Tarradellas.com'),
(891234567, 'Fini', '612976348', 'Calle de la Amazonia 9', 'chuches@Fini.com'),
(912345678, 'haggen dazs', '6026738495', 'Calle del Alcalde José María de las Heras 32', 'helados@haggendazs.com');
INSERT INTO PRODUCTOS VALUES 
('Manzanas golden 2kg', 40, 12.50),
('Cocacola 1L', 10, 6.75),
('Nuves de azucar', 4, 3.70),
('Cebolla', 80, 7.50),
('Peras 1,5kg', 20, 8.50),
('Helado sabor chicle', 70, 5.50),
('Sugus', 10, 4.50);
('Pizza', 10, 4.50);
INSERT INTO FACTURAS VALUES
(01942639, 45987465, 4, 15.96, 2021-12-07, 20),
(01857492, 03265789, 2, 89.65, 2021-05-17, 240),
(11549854, 94485964, 1, 11.20, 2021-08-15, 10),
(02654895, 84653565, 5, 8.26, 2021-02-14, 7),
(12654859, 56498568, 3, 0.50, 2021-06-30, 90);

--Vista de las tablas.
SELECT * FROM CLIENTES;
SELECT * FROM PROVEEDORES;
SELECT * FROM PRODUCTOS;
SELECT * FROM FACTURAS;

--Declaracion de la variable.
DECLARE @IDFACT INT;

--Creacion del procedimiento almacenado.
CREATE PROCEDURE INFOFACTURA
	@IDFACT INT
AS
SELECT D.IDFACTURA "Num. Factura", D.FECHA "Fecha", A.NOMBRE "Cliente", A.TELEFONO "Movil", 
B.NOMBRE "Proveedor", B.DIRECCION "Direccion", C.NOMBRE "Producto", D.CANTIDAD "Unidades", D.IMPORTE "Precio"
FROM CLIENTES A, PROVEEDORES B, PRODUCTOS C, FACTURAS D
WHERE A.IDCLIENTE = D.IDCLIENTE AND B.IDPROVEEDOR=D.IDPROVEEDOR AND C.IDPRODUCTO=D.IDPRODUCTO
AND D.IDFACTURA=@IDFACT;
--DROP PROCEDURE INFOFACTURA;

--Llamada del procedimiento almacenado.
EXECUTE INFOFACTURA 2;