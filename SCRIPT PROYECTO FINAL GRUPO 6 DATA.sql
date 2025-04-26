

------------------- BASE DE DATOS TRANSACCIONAL SANTORY BY REYNALDO------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--GRUPO 06


--CREACIÓN DE LA DB TRANSACCIONAL

CREATE DATABASE Transacciones_Zapateria;
USE Transacciones_Zapateria;

---------------Tablas----------------------

-- Tabla Proveedor
CREATE TABLE TZ_Proveedor_TB (
    Id_proveedor INT Constraint TZ_Proveedor_TB_Id_proveedor_PK PRIMARY KEY IDENTITY(1,1),
    Nombre_proveedor VARCHAR(100) NOT NULL
);

-- Tabla Rol
CREATE TABLE TZ_Rol_TB (
    Id_rol INT Constraint TZ_Rol_TB_Id_rol_PK PRIMARY KEY IDENTITY(1,1),
    Nombre_rol VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(255) NOT NULL
);


-- Tabla Metodo_Pago
CREATE TABLE TZ_Metodo_Pago_TB (
    Id_metodo_pago INT Constraint TZ_Metodo_Pago_TB_Id_metodo_pago_PK PRIMARY KEY IDENTITY(1,1),
    Nombre_metodo_pago VARCHAR(255) NOT NULL
);

-- Tabla Divisi�n
CREATE TABLE TZ_Division_TB (
    Id_division INT Constraint TZ_Division_TB_Id_division_PK PRIMARY KEY IDENTITY(1,1),
    Id_proveedor INT Constraint TZ_Division_TB_id_proveedor_PK NOT NULL,
    Categoria VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255) NOT NULL,
    FOREIGN KEY (Id_proveedor) REFERENCES TZ_Proveedor_TB(Id_proveedor)
);

-- Tabla Usuario
CREATE TABLE TZ_Usuario_TB (
    Id_usuario INT Constraint TZ_Usuario_TB_Id_usuario_PK PRIMARY KEY IDENTITY(1,1),
    Id_rol INT  Constraint TZ_Usuario_TB_Rol_FK NOT NULL,
    Nombre_usuario VARCHAR(100) NOT NULL,
    Primer_apellido VARCHAR(100) NOT NULL,
    Segundo_apellido VARCHAR(100) NOT NULL,
    Correo_usuario VARCHAR(100) UNIQUE NOT NULL,
    Direccion_usuario VARCHAR(255) NOT NULL,
    FOREIGN KEY (Id_rol) REFERENCES TZ_Rol_TB(Id_rol)
);


-- Tabla Producto
CREATE TABLE TZ_Producto_TB (
    Id_producto INT Constraint TZ_Producto_TB_Id_producto_PK PRIMARY KEY IDENTITY(1,1),
    Id_division INT Constraint TZ_Producto_TB_Id_division_FK NOT NULL,
    Descripcion VARCHAR(255) NOT NULL,
    Color VARCHAR(50) NOT NULL,
    Talla VARCHAR(50) NOT NULL,
    Fecha_Produccion DATE NOT NULL,
    Costo_unitario DECIMAL(10,2) NOT NULL,
    Precio_venta DECIMAL(10,2) NOT NULL,
    Codigo VARCHAR(100) NOT NULL,
    FOREIGN KEY (Id_division) REFERENCES TZ_Division_TB(Id_division)
);

CREATE TABLE TZ_Contacto_Proveedor_TB (
    Id_contacto_proveedor INT Constraint TZ_Contacto_proveedor_TB_Id_Contacto_proveedor_PK PRIMARY KEY IDENTITY(1,1),
    Id_proveedor INT Constraint TZ_Contacto_proveedor_TB_Id_Proveedor NOT NULL,
    Telefono_proveedor VARCHAR(50) NOT NULL,
    Pais_proveedor VARCHAR(50) NOT NULL,
    Correo_proveedor VARCHAR(125) UNIQUE NOT NULL,
    Direccion_proveedor VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_proveedor) REFERENCES TZ_Proveedor_TB(Id_proveedor)
);

-- Tabla Telefono_Usuario
CREATE TABLE TZ_Telefono_Usuario_TB (
    Id_telefono_usuario INT Constraint TZ_Telefono_Usuario_TB_Id_telefono_usuario_PK PRIMARY KEY IDENTITY(1,1),
    Id_usuario INT Constraint TZ_Telefono_Usuario_TB_Id_usuario_PK NOT NULL,
    Telefono_usuario VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_usuario) REFERENCES TZ_Usuario_TB(Id_usuario)
);

-- Tabla Inventario
CREATE TABLE TZ_Inventario_TB (
    Id_inventario INT Constraint TZ_Inventario_TB_Id_inventario_PK PRIMARY KEY IDENTITY(1,1),
    Id_producto INT Constraint TZ_Inventario_TB_Id_producto_FK NOT NULL,
    Unidades_vendidas INT NOT NULL,
    Stock INT NOT NULL,
    FOREIGN KEY (Id_producto) REFERENCES TZ_Producto_TB(Id_producto)
);

-- Tabla Pago
CREATE TABLE TZ_Pago_TB (
    Id_pago INT Constraint TZ_Pago_TB_Id_pago_FK PRIMARY KEY IDENTITY(1,1),
    Id_usuario INT Constraint TZ_Pago_TB_Id_usuario_FK NOT NULL,
    Id_metodo_pago INT Constraint TZ_Pago_TB_Id_Id_metodo_pago NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    Fecha_pago DATE NOT NULL,
    FOREIGN KEY (Id_usuario) REFERENCES TZ_Usuario_TB(Id_usuario),
    FOREIGN KEY (Id_metodo_pago) REFERENCES TZ_Metodo_Pago_TB(Id_metodo_pago)
);

-- Tabla Compra
CREATE TABLE TZ_Compra_TB (
    Id_compra INT CONSTRAINT TZ_Compra_TB_Id_compra_PK PRIMARY KEY IDENTITY(1,1),
    Id_usuario INT CONSTRAINT TZ_Compra_TB_Id_usuario_FK FOREIGN KEY (Id_usuario) REFERENCES TZ_Usuario_TB(Id_usuario),
    Fecha_compra DATE NOT NULL,
    Total_compra DECIMAL(10,2) NOT NULL
);

-- Tabla Detalle_Compra
CREATE TABLE TZ_Detalle_Compra_TB (
    Id_detalle_compra INT Constraint TZ_Detalle_Compra_TB_Id_detalle_compra_PK PRIMARY KEY IDENTITY(1,1),
    Id_compra INT Constraint TZ_Detalle_Compra_TB_Id_compra_FK NOT NULL,
    Id_producto INT NOT NULL,
    Cantidad INT NOT NULL,
    Costo_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Id_compra) REFERENCES TZ_Compra_TB(Id_compra),
    FOREIGN KEY (Id_producto) REFERENCES TZ_Producto_TB(Id_producto)
);

-- Tabla Venta
CREATE TABLE TZ_Venta_TB (
    Id_venta INT Constraint TZ_Venta_TB_Id_venta_PK PRIMARY KEY IDENTITY(1,1),
	Id_usuario INT Constraint TZ_Venta_TB_Id_Usuario_FK Foreign key (Id_usuario) References TZ_Usuario_TB(Id_usuario),
	Id_pago INT Constraint TZ_Venta_TB_Id_pago_FK Foreign key (Id_pago) References TZ_Pago_TB(Id_pago),
    Fecha_venta DATE NOT NULL,
    Hora_venta TIME NOT NULL,
    Total_venta DECIMAL(10,2) NOT NULL
);

-- Tabla Detalle_Venta
CREATE TABLE TZ_Detalle_Venta_TB (
    Id_detalle_venta INT Constraint TZ_Detalle_Venta_TB_Id_detalle_venta PRIMARY KEY IDENTITY(1,1),
    Id_venta INT  Constraint TZ_Detalle_Venta_TB_Id_venta NOT NULL Foreign key (Id_venta) References TZ_Venta_TB(Id_venta),
    Id_producto INT Constraint TZ_Detalle_Venta_TB_Id_producto_FK NOT NULL,
    Cantidad INT NOT NULL,
    Precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Id_venta) REFERENCES TZ_Venta_TB(Id_venta),
    FOREIGN KEY (Id_producto) REFERENCES TZ_Producto_TB(Id_producto)
);


------------------ Insercion de datos---------------------------------------

INSERT INTO TZ_Proveedor_TB (Nombre_proveedor) VALUES
('Zapatos Elegantes'),
('Calzado Moderno'),
('Pies Felices'),
('Estilo y Confort'),
('Moda Urbana'),
('Paso Ligero'),
('Calzado Imperial'),
('Tendencias en Pies'),
('Paso a Paso'),
('Camina Bonito'),
('Elegancia Natural'),
('Zapatería Mundial'),
('Pies de Lujo'),
('Confort Total'),
('Estilo Natural'),
('Andar Urbano'),
('Pisada Firme'),
('Calzado Real'),
('Pies Felices Plus'),
('Zapatos a la Moda'),
('Camino Seguro');

INSERT INTO TZ_Rol_TB (Nombre_rol, Descripcion) VALUES
('Administrador', 'Administrador con acceso completo a todas las funciones'),
('Vendedor', 'Encargado de realizar ventas y gestionar inventarios'),
('Cliente', 'Usuario que compra productos');

INSERT INTO TZ_Metodo_Pago_TB (Nombre_metodo_pago) VALUES
('Sinpe'),
('Tarjeta'),
('Efectivo');

INSERT INTO TZ_Division_TB (Id_proveedor, Categoria, Descripcion) VALUES
(1, 'Casual', 'Zapatos para uso diario'),
(2, 'Deportivo', 'Calzado para actividades físicas'),
(3, 'Formal', 'Zapatos elegantes para eventos'),
(4, 'Infantil', 'Calzado cómodo para niñas'),
(5, 'Botas', 'Calzado resistente para exteriores'),
(6, 'Sandalias', 'Calzado ligero y fresco'),
(7, 'Casual', 'Comodidad sin igual'),
(8, 'Deportivo', 'Calzado para actividades físicas'),
(9, 'Formal', 'Zapatos elegantes para eventos'),
(10, 'Infantil', 'Calzado cómodo para niñas y niños'),
(11, 'Botas', 'Calzado resistente para exteriores'),
(12, 'Sandalias', 'Calzado ligero y fresco'),
(13, 'Elegante', 'Diseños exclusivos para toda ocasión'),
(14, 'Casual', 'Moda y confort en cada paso'),
(15, 'Formal', 'Hecho a mano con materiales premium'),
(16, 'Deportivo', 'Comodidad sin igual'),
(17, 'Infantil', 'Zapatos para uso diario'),
(18, 'Botas', 'Calzado resistente para exteriores'),
(19, 'Verano', 'Calzado ligero y fresco'),
(20, 'Fiesta', 'Diseños exclusivos para eventos'),
(21, 'Invierno', 'Abrigo total para tus pies');

INSERT INTO TZ_Usuario_TB (Id_rol, Nombre_usuario, Primer_apellido, Segundo_apellido, Correo_usuario, Direccion_usuario) VALUES
(1, 'Carlos', 'Pérez', 'González', 'admin@zapateria.com', 'Av. Central, San José'),
(2, 'Juan', 'Rodríguez', 'Mora', 'vendedor1@zapateria.com', 'Calle 8, Alajuela'),
(3, 'María', 'López', 'Vargas', 'cliente1@zapateria.com', 'Calle 10, Heredia'),
(2, 'Luis', 'Martínez', 'Soto', 'vendedor2@zapateria.com', 'Calle 4, Cartago'),
(3, 'Ana', 'Fernández', 'Ríos', 'cliente2@zapateria.com', 'Calle 6, Puntarenas'),
(1, 'Roberto', 'Jiménez', 'Álvarez', 'admin2@zapateria.com', 'Calle 12, Guanacaste'),
(3, 'Daniela', 'Cordero', 'Ramírez', 'cliente3@zapateria.com', 'Calle 7, Limón'),
(2, 'Esteban', 'Salazar', 'Araya', 'vendedor3@zapateria.com', 'Calle 11, San José'),
(1, 'Patricia', 'Mora', 'Campos', 'admin3@zapateria.com', 'Av. 5, Alajuela'),
(3, 'Andrés', 'Vargas', 'Solano', 'cliente4@zapateria.com', 'Calle 13, Cartago'),
(2, 'Lucía', 'Chacón', 'Ureña', 'vendedora4@zapateria.com', 'Calle 15, Heredia'),
(1, 'Mauricio', 'Castro', 'Acosta', 'admin4@zapateria.com', 'Av. 9, San Ramón'),
(3, 'Laura', 'Navarro', 'Delgado', 'cliente5@zapateria.com', 'Calle 3, Liberia'),
(2, 'Jorge', 'Soto', 'Céspedes', 'vendedor5@zapateria.com', 'Calle 18, San Carlos'),
(1, 'Andrea', 'Guzmán', 'Leiva', 'admin5@zapateria.com', 'Av. 10, Escazú'),
(3, 'Felipe', 'Herrera', 'Rojas', 'cliente6@zapateria.com', 'Calle 2, Nicoya'),
(2, 'Gabriela', 'Pérez', 'Loaiza', 'vendedora6@zapateria.com', 'Calle 17, Pérez Zeledón'),
(3, 'Ricardo', 'Zúñiga', 'Mendoza', 'cliente7@zapateria.com', 'Calle 8, Grecia'),
(1, 'Natalia', 'Sánchez', 'Valverde', 'admin6@zapateria.com', 'Av. 6, San José'),
(2, 'Manuel', 'Campos', 'Serrano', 'vendedor7@zapateria.com', 'Calle 19, Puntarenas'),
(3, 'Isabel', 'Alvarado', 'Esquivel', 'cliente8@zapateria.com', 'Calle 5, Cartago'),
(3, 'Rebeca', 'Morales', 'Jiménez', 'cliente9@zapateria.com', 'Calle 20, San José'),
(2, 'Carlos', 'Alpízar', 'González', 'vendedor8@zapateria.com', 'Calle 21, Cartago'),
(1, 'Elena', 'Vega', 'Chacón', 'admin7@zapateria.com', 'Av. 2, Heredia'),
(3, 'Julio', 'Sáenz', 'Valverde', 'cliente10@zapateria.com', 'Calle 22, Alajuela'),
(2, 'Marcela', 'Paniagua', 'Solís', 'vendedora9@zapateria.com', 'Calle 23, Guanacaste'),
(1, 'Ignacio', 'Ramírez', 'Porras', 'admin8@zapateria.com', 'Av. 3, Limón'),
(3, 'Tatiana', 'Zamora', 'Martínez', 'cliente11@zapateria.com', 'Calle 24, San Carlos'),
(2, 'Héctor', 'Calvo', 'Sánchez', 'vendedor10@zapateria.com', 'Calle 25, Puntarenas'),
(1, 'Adriana', 'Bonilla', 'Méndez', 'admin9@zapateria.com', 'Av. 4, Escazú'),
(3, 'Sebastián', 'Granados', 'López', 'cliente12@zapateria.com', 'Calle 26, Grecia'),
(2, 'Pamela', 'Zúñiga', 'Gómez', 'vendedora11@zapateria.com', 'Calle 27, Nicoya'),
(3, 'Óscar', 'Campos', 'Bolaños', 'cliente13@zapateria.com', 'Calle 28, Liberia'),
(2, 'Jennifer', 'Céspedes', 'Salas', 'vendedora12@zapateria.com', 'Calle 29, Pérez Zeledón'),
(1, 'Marvin', 'León', 'Camacho', 'admin10@zapateria.com', 'Av. 5, San Ramón'),
(3, 'Valeria', 'Guzmán', 'Venegas', 'cliente14@zapateria.com', 'Calle 30, Moravia');

INSERT INTO TZ_Contacto_Proveedor_TB (Id_proveedor, Telefono_proveedor, Pais_proveedor, Correo_proveedor, Direccion_proveedor) VALUES
(1, '+506 2222-1234', 'Costa Rica', 'elegantes.shoes@gmail.com', 'Calle 1, San José, Costa Rica'),
(2, '+505 7856-1123', 'Nicaragua', 'calzado.nica.moderno@gmail.com', 'Barrio Monseñor Lezcano, Managua'),
(3, '+507 6985-4432', 'Panamá', 'piesfelices.pa@gmail.com', 'Calle 50, Bella Vista, Panamá'),
(4, '+52 55 4896-3312', 'México', 'estilo.confort.mx@gmail.com', 'Colonia Roma Norte, CDMX'),
(5, '+57 317 889-5566', 'Colombia', 'modaurbana.co@gmail.com', 'Carrera 7 #45-23, Bogotá'),
(6, '+504 9723-4411', 'Honduras', 'pasoligero.hn@gmail.com', 'Colonia Palmira, Tegucigalpa'),
(7, '+503 7894-2312', 'El Salvador', 'imperial.sv.shoes@gmail.com', 'Boulevard del Hipódromo, San Salvador'),
(8, '+502 4423-8845', 'Guatemala', 'tendencias.gt.pies@gmail.com', 'Zona 10, Ciudad de Guatemala'),
(9, '+1 809-565-9988', 'República Dominicana', 'pasoapaso.rd@gmail.com', 'Av. Winston Churchill, Santo Domingo'),
(10, '+506 2222-1004', 'Costa Rica', 'caminabonito.cr@gmail.com', 'Montecillos, Alajuela'),
(11, '+505 7765-9087', 'Nicaragua', 'elegancia.natural.ni@gmail.com', 'Reparto San Juan, León'),
(12, '+507 6211-3345', 'Panamá', 'zapateria.mundial.pa@gmail.com', 'Albrook, Panamá'),
(13, '+52 33 2154-9988', 'México', 'piesdelujo.mx@gmail.com', 'Av. Chapultepec, Guadalajara'),
(14, '+57 312 665-7789', 'Colombia', 'confort.total.co@gmail.com', 'Cra. 9, Medellín'),
(15, '+504 2233-9876', 'Honduras', 'estilonatural.hn@gmail.com', 'Barrio El Centro, San Pedro Sula'),
(16, '+503 7144-2200', 'El Salvador', 'andarurbano.sv@gmail.com', 'Santa Tecla, La Libertad'),
(17, '+502 4420-1234', 'Guatemala', 'pisadafirme.gt@gmail.com', 'Mixco, Guatemala'),
(18, '+1 829-987-3322', 'República Dominicana', 'calzadoroyal.rd@gmail.com', 'La Romana, República Dominicana'),
(19, '+506 2222-1013', 'Costa Rica', 'piesfelicesplus.cr@gmail.com', 'Guachipelín, Escazú'),
(20, '+52 55 7456-0011', 'México', 'zapatos.moda.mx@gmail.com', 'Av. Insurgentes Sur, CDMX'),
(21, '+507 6901-2233', 'Panamá', 'camino.seguro.pa@gmail.com', 'Punta Pacífica, Panamá');


INSERT INTO TZ_Telefono_Usuario_TB (Id_usuario, Telefono_usuario) VALUES
(1, '8888-1234'),
(2, '8888-5678'),
(3, '8888-9876'),
(4, '8888-1122'),
(5, '8888-3344'),
(6, '8888-5566'),
(7, '8888-1001'),
(8, '8888-1002'),
(9, '8888-1003'),
(10, '8888-1004'),
(11, '8888-1005'),
(12, '8888-1006'),
(13, '8888-1007'),
(14, '8888-1008'),
(15, '8888-1009'),
(16, '8888-1010'),
(17, '8888-1011'),
(18, '8888-1012'),
(19, '8888-1013'),
(20, '8888-1014'),
(21, '8888-1015'),
(22, '8888-1022'),
(23, '8888-1023'),
(24, '8888-1024'),
(25, '8888-1025'),
(26, '8888-1026'),
(27, '8888-1027'),
(28, '8888-1028'),
(29, '8888-1029'),
(30, '8888-1030'),
(31, '8888-1031'),
(32, '8888-1032'),
(33, '8888-1033'),
(34, '8888-1034'),
(35, '8888-1035'),
(36, '8888-1036');


INSERT INTO TZ_Producto_TB (Id_division, Descripcion, Color, Talla, Fecha_Produccion, Costo_unitario, Precio_venta, Codigo) VALUES
(5, 'PA 250 C N CH N', 'Negro', '40', '2024-03-01', 16588.00, 33900.00, 'CNCHN1'),
(7, 'PA 256 CH BGE', 'Beige', '38', '2024-03-01', 2520.00, 16450.00, 'CHBGE2'),
(2, 'PA 260 / 6.ROSADO', 'Rosa', '37', '2024-03-01', 1895.00, 16950.00, 'ROSADO3'),
(4, 'PA 256 ROSA / 6.R', 'Rosa', '39', '2024-03-01', 2596.00, 17950.00, 'ROSAR4'),
(9, 'PA 256 LILA / 64.', 'Lila', '36', '2024-03-01', 2596.00, 17950.00, 'LILA64'),
(3, 'PA 250 C AVELLANA', 'Avellana', '42', '2024-03-01', 15111.00, 33900.00, 'AVELL5'),
(14, 'PA 271 CH N/ROJO', 'Rojo', '41', '2024-03-01', 2556.00, 16950.00, 'CHROJO'),
(6, 'PA 272 CH N/PLATA', 'Plata', '40', '2024-03-01', 15111.00, 33900.00, 'CHPLAT'),
(8, 'PA 287 COMB AVELL', 'Avellana', '43', '2024-03-01', 16588.00, 33900.00, 'CBAVEL'),
(10, 'PA 287 COMB 3.AZU', 'Azul', '38', '2024-03-01', 16588.00, 33900.00, 'CBAZUL'),
(15, 'PA 287 COMB ROSA', 'Rosa', '39', '2024-03-01', 15111.00, 33900.00, 'CBROSA'),
(1, 'PA 287 COMB NEGRO', 'Negro', '41', '2024-03-01', 16588.00, 33900.00, 'CBNEGR'),
(2, 'AIDA 03 / 278.AVE', 'Avellana', '37', '2024-03-01', 15111.00, 33900.00, 'AVESND'),
(11, 'AIDA 03 / 2.BLANC', 'Blanco', '36', '2024-03-01', 15111.00, 33900.00, 'AIDABL'),
(5, 'TS 044 TAMARINDO', 'Marrón', '38', '2024-03-01', 15111.00, 33900.00, 'TAM044'),
(20, '2043 ORO/ROSA', 'Rosa', '37', '2024-03-01', 15111.00, 33900.00, 'OROROS'),
(8, 'TS 066 CANADA / 2', 'Beige', '38', '2024-03-01', 2556.00, 16950.00, 'CANADA'),
(6, 'TS 066 CANADA AZU', 'Azul', '39', '2024-03-01', 15111.00, 33900.00, 'CANAZU'),
(13, 'PA 103 CABRA NEGR', 'Negro', '40', '2024-03-01', 2185.00, 16450.00, 'CABNEG'),
(10, 'TS 103 / 3.AZUL', 'Azul', '42', '2024-03-01', 15111.00, 33900.00, '103AZU'),
(15, 'TS 019 B / 97.MIE', 'Miel', '38', '2024-03-01', 2556.00, 16950.00, 'MIE019'),
(12, 'TS 019 B / 278.AV', 'Avellana', '39', '2024-03-01', 2556.00, 16950.00, 'AV019B'),
(17, 'TS 103 C NEGRO /', 'Negro', '41', '2024-03-01', 15111.00, 33900.00, '103CNE'),
(16, 'TS 100 H NEGRO /', 'Negro', '43', '2024-03-01', 2556.00, 16950.00, '100HNE'),
(3, 'TS 100 H AZUL / 3', 'Azul', '36', '2024-03-01', 2556.00, 16950.00, '100HAZ'),
(18, 'TS 046B N MALLA /', 'Negro', '39', '2024-03-01', 2556.00, 16950.00, 'MALLA1'),
(19, 'TS 066 TOSC TAN /', 'Toscana', '40', '2024-03-01', 15111.00, 33900.00, 'TOSCAN'),
(11, 'TS 016 CHAROL / 8', 'Negro', '38', '2024-03-01', 13584.00, 32900.00, 'CH016N'),
(4, 'SIMBA 01 BCO NEGR', 'Negro', '41', '2024-03-01', 15111.00, 33900.00, 'SIMNEG'),
(7, 'SAMBA 01 COMB / 9', 'Negro', '42', '2024-03-01', 15111.00, 33900.00, 'SAMBA9');


INSERT INTO TZ_Inventario_TB (Id_producto, Unidades_vendidas, Stock) VALUES
(1, 10, 90),
(2, 5, 45),
(3, 3, 47),
(4, 7, 93),
(5, 4, 26),
(6, 12, 88),
(7, 8, 32),
(8, 9, 41),
(9, 6, 54),
(10, 5, 35),
(11, 2, 38),
(12, 3, 37),
(13, 1, 49),
(14, 7, 23),
(15, 4, 56),
(16, 5, 44),
(17, 6, 40),
(18, 3, 27),
(19, 8, 34),
(20, 4, 31),
(21, 2, 36),
(22, 7, 29),
(23, 5, 50),
(24, 9, 33),
(25, 3, 61),
(26, 1, 39),
(27, 6, 48),
(28, 4, 52),
(29, 2, 58),
(30, 3, 59);


INSERT INTO TZ_Pago_TB (Id_usuario, Id_metodo_pago, Monto, Fecha_pago) VALUES
(3, 1, 21050.00, '2024-03-01'),
(5, 2, 34075.00, '2024-03-02'),
(7, 2, 12500.00, '2024-03-03'),
(10, 1, 28090.00, '2024-03-04'),
(13, 3, 15000.00, '2024-03-05'),
(16, 2, 19999.00, '2024-03-06'),
(18, 2, 37525.00, '2024-03-07'),
(20, 1, 42000.00, '2024-03-08'),
(21, 2, 31530.00, '2024-03-09'),
(24, 3, 27899.00, '2024-03-10'),
(26, 1, 18888.00, '2024-03-11'),
(27, 3, 15975.00, '2024-03-12'),
(30, 2, 29590.00, '2024-03-13'),
(33, 1, 25000.00, '2024-03-14'),
(1, 2, 39999.00, '2024-03-15'),
(2, 1, 18500.00, '2024-03-16'),
(4, 2, 31025.00, '2024-03-17'),
(6, 3, 26000.00, '2024-03-18'),
(8, 2, 27075.00, '2024-03-19'),
(11, 3, 38990.00, '2024-03-20'),
(14, 1, 33040.00, '2024-03-21'),
(17, 3, 14999.00, '2024-03-22'),
(19, 2, 20955.00, '2024-03-23'),
(22, 2, 30500.00, '2024-03-24'),
(25, 2, 38000.00, '2024-03-25'),
(28, 3, 22030.00, '2024-03-26'),
(29, 1, 29560.00, '2024-03-27'),
(31, 2, 27870.00, '2024-03-28'),
(32, 3, 38910.00, '2024-03-29'),
(34, 1, 31240.00, '2024-03-30'),
(9, 3, 20500.00, '2024-03-31'),
(12, 2, 21000.00, '2024-04-01'),
(15, 1, 18000.00, '2024-04-02'),
(3, 1, 21500.00, '2023-05-12'),
(5, 2, 19900.00, '2023-07-23'),
(7, 2, 32100.00, '2023-08-14'),
(10, 3, 28450.00, '2023-09-01'),
(13, 1, 18900.00, '2023-10-22'),
(16, 2, 29900.00, '2025-05-03'),
(18, 3, 36500.00, '2025-06-10'),
(20, 1, 27200.00, '2025-07-15'),
(21, 2, 18400.00, '2025-08-19'),
(24, 1, 30000.00, '2025-09-22'),
(10, 2, 53850.00, '2025-03-05'),
(25, 2, 67800.00, '2025-03-02'),
(34, 2, 67800.00, '2025-02-22'),
(16, 1, 33900.00, '2025-02-18'),
(29, 2, 67800.00, '2025-02-22'),
(20, 3, 50850.00, '2025-01-21'),
(7, 1, 33900.00, '2025-01-15'),
(28, 1, 50850.00, '2025-01-09'),
(21, 3, 50850.00, '2025-01-27'),
(3, 1, 33900.00, '2025-01-30');


INSERT INTO TZ_Compra_TB (id_usuario, fecha_compra, total_compra) VALUES
(1, '2025-04-01', 50850.00),
(6, '2025-04-03', 67800.00),
(9, '2025-04-05', 101700.00),
(12, '2025-04-07', 33900.00),
(15, '2025-04-09', 50850.00),
(19, '2025-04-11', 84750.00),
(24, '2025-04-13', 67800.00),
(27, '2025-04-15', 16950.00),
(32, '2025-04-17', 50850.00),
(6, '2023-06-01', 67800.00),
(9, '2023-07-01', 101700.00),
(12, '2023-08-01', 33900.00),
(15, '2025-05-01', 50850.00),
(19, '2025-06-05', 84750.00),
(24, '2025-07-07', 67800.00),
(27, '2025-08-12', 16950.00),
(32, '2025-09-18', 50850.00),
(3,  '2023-05-12', 21500.00),
(5,  '2023-07-23', 19900.00),
(7,  '2023-08-14', 32100.00),
(10, '2023-09-01', 28450.00),
(13, '2023-10-22', 18900.00),
(16, '2025-05-03', 29900.00),
(18, '2025-06-10', 36500.00),
(20, '2025-07-15', 27200.00),
(21, '2025-08-19', 18400.00),
(24, '2025-09-22', 30000.00),
(6,  '2025-10-03', 42000.00),
(9,  '2025-11-06', 33900.00),
(12, '2025-12-09', 28500.00),
(15, '2023-01-10', 16000.00),
(19, '2023-02-12', 28400.00),
(21, '2023-03-15', 24900.00),
(22, '2023-04-16', 27500.00),
(25, '2023-05-18', 31000.00),
(28, '2023-06-21', 29500.00),
(30, '2023-07-23', 38900.00),
(31, '2023-08-25', 31200.00),
(33, '2023-09-27', 25000.00),
(34, '2023-10-30', 33900.00),
(10, '2025-03-05', 53850.00),
(25, '2025-03-02', 67800.00),
(34, '2025-02-22', 67800.00),
(16, '2025-02-18', 33900.00),
(29, '2025-02-22', 67800.00),
(20, '2025-01-21', 50850.00),
(7, '2025-01-15', 33900.00),
(28, '2025-01-09', 50850.00),
(21, '2025-01-27', 50850.00),
(3, '2025-01-30', 33900.00);


-- TZ_Detalle_Compra_TB: Insert corregido (solo hasta Id_compra = 50)
INSERT INTO TZ_Detalle_Compra_TB (Id_compra, Id_producto, Cantidad, Costo_unitario) VALUES
(1, 1, 1, 16588),
(1, 2, 1, 2520),
(1, 3, 1, 1895),
(2, 4, 1, 2596),
(2, 5, 1, 2596),
(2, 6, 1, 15111),
(3, 7, 1, 2556),
(3, 8, 1, 15111),
(3, 9, 1, 16588),
(4, 10, 1, 16588),
(4, 11, 1, 15111),
(4, 12, 1, 16588),
(5, 13, 1, 15111),
(5, 14, 1, 15111),
(5, 15, 1, 15111),
(6, 16, 1, 15111),
(6, 17, 1, 2556),
(6, 18, 1, 15111),
(7, 19, 1, 2185),
(7, 20, 1, 15111),
(7, 21, 1, 2556),
(8, 22, 1, 2556),
(8, 23, 1, 15111),
(8, 24, 1, 2556),
(9, 25, 1, 2556),
(9, 26, 1, 15111),
(9, 27, 1, 13584),
(10, 28, 1, 15111),
(10, 29, 1, 15111),
(10, 30, 1, 15111),
(45, 23, 3, 17950.00),
(46, 30, 2, 33900.00),
(47, 1, 2, 33900.00),
(48, 17, 2, 16950.00),
(49, 10, 2, 33900.00),
(50, 27, 3, 16950.00);

INSERT INTO TZ_Venta_TB (Id_usuario, Id_pago, Fecha_venta, Hora_venta, Total_venta) VALUES
(16, 1, '2023-01-06', '13:05:00', 23576.41),
(23, 2, '2023-02-12', '10:57:00', 60445.62),
(2, 3, '2023-03-03', '11:13:00', 62662.94),
(1, 4, '2023-04-27', '16:23:00', 37791.55),
(27, 5, '2023-05-03', '16:47:00', 55604.25),
(35, 6, '2023-06-09', '14:10:00', 57184.80),
(2, 7, '2023-06-18', '09:18:00', 60248.41),
(3, 8, '2023-06-27', '08:47:00', 55965.81),
(28, 9, '2023-07-08', '08:19:00', 56550.36),
(35, 10, '2023-07-12', '09:56:00', 19904.37),
(14, 11, '2023-07-24', '10:08:00', 48202.52),
(30, 12, '2023-11-01', '15:36:00', 60514.53),
(16, 13, '2023-12-01', '08:28:00', 60889.12),
(10, 14, '2024-02-13', '14:10:00', 41540.20),
(24, 15, '2024-03-16', '14:44:00', 27032.53),
(18, 16, '2024-04-08', '16:23:00', 25853.64),
(14, 17, '2024-04-09', '11:51:00', 35818.60),
(4, 18, '2024-04-19', '10:31:00', 19720.96),
(2, 19, '2024-04-24', '13:03:00', 31878.22),
(28, 20, '2024-05-09', '11:42:00', 31298.58),
(33, 21, '2024-05-18', '14:29:00', 35422.81),
(17, 22, '2024-05-20', '15:19:00', 46338.07),
(23, 23, '2024-06-14', '10:41:00', 18033.83),
(27, 24, '2024-07-10', '11:13:00', 46196.74),
(9, 25, '2024-07-16', '13:25:00', 54845.35),
(14, 26, '2024-08-28', '16:15:00', 30056.88),
(29, 27, '2024-09-05', '11:08:00', 29977.36),
(10, 28, '2024-10-11', '14:14:00', 51546.95),
(17, 29, '2024-12-03', '16:37:00', 56814.76),
(6, 30, '2024-12-07', '13:55:00', 44238.21),
(24, 31, '2024-12-27', '09:24:00', 20896.60),
(5, 32, '2025-01-11', '13:33:00', 52759.16),
(8, 33, '2025-01-19', '16:02:00', 67345.22),
(2, 34, '2025-01-24', '12:21:00', 27503.73),
(8, 35, '2025-02-08', '09:58:00', 28819.49),
(12, 36, '2025-02-17', '10:47:00', 41761.21),
(17, 37, '2025-03-25', '12:40:00', 22459.18),
(18, 38, '2025-04-04', '11:15:00', 23523.01),
(11, 39, '2025-04-19', '08:29:00', 53406.06),
(29, 40, '2025-05-05', '08:10:00', 48041.76),
(29, 41, '2025-05-13', '16:51:00', 65175.52),
(27, 42, '2025-06-21', '10:35:00', 42489.37),
(25, 43, '2025-07-11', '11:35:00', 61449.21),
(12, 44, '2025-07-13', '14:12:00', 51513.77),
(31, 45, '2025-07-28', '12:57:00', 48532.56),
(28, 46, '2025-08-06', '15:20:00', 19290.25),
(15, 47, '2025-09-16', '13:02:00', 29604.61),
(28, 48, '2025-09-28', '08:25:00', 21785.83),
(5, 49, '2025-10-12', '10:11:00', 48076.41),
(17, 50, '2025-11-14', '13:04:00', 40283.43),
(12, 51, '2025-11-27', '13:09:00', 31320.79),
(17, 52, '2025-11-28', '13:24:00', 22899.29),
(28, 53, '2025-12-26', '15:28:00', 18446.13);


INSERT INTO TZ_Detalle_Venta_TB (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 2, 16450.00),
(1, 2, 1, 16950.00),
(2, 3, 1, 17950.00),
(2, 4, 2, 17950.00),
(3, 5, 1, 33900.00),
(4, 6, 3, 33900.00),
(5, 7, 1, 16950.00),
(6, 8, 1, 33900.00),
(7, 9, 2, 33900.00),
(8, 10, 1, 33900.00),
(9, 11, 4, 33900.00),
(10, 12, 2, 33900.00),
(11, 13, 3, 33900.00),
(12, 14, 1, 33900.00),
(13, 15, 2, 33900.00),
(14, 16, 2, 16950.00),
(15, 17, 3, 33900.00),
(16, 18, 1, 16450.00),
(17, 19, 1, 33900.00),
(18, 20, 1, 16950.00),
(19, 20, 1, 16950.00),
(20, 6, 3, 33900.00),
(21, 1, 2, 16450.00),
(21, 3, 1, 17950.00),
(22, 3, 1, 17950.00),
(25, 20, 1, 16950.00),
(28, 15, 2, 33900.00),
(29, 13, 3, 33900.00),
(30, 6, 3, 33900.00),
(30, 9, 2, 33900.00),
(30, 3, 1, 17950.00),
(11, 1, 2, 16450.00),
(17, 16, 2, 16950.00),
(44, 23, 3, 17950.00),
(45, 30, 2, 33900.00),
(46, 1, 2, 33900.00),
(47, 17, 2, 16950.00),
(48, 10, 2, 33900.00),
(49, 27, 3, 16950.00),
(50, 15, 1, 33900.00);


SELECT MAX(Id_venta) FROM TZ_Venta_TB;


use Transacciones_Zapateria;
execute EliminacionConReinicion;


----------------------APARTADOS DE PRUEBAS--------------------------------------------------
----Procedimientos para eliminar los datos de las tablas y reiniciar el contador a 0.


Create or alter procedure EliminacionConReinicion
AS
BEGIN
DELETE FROM TZ_Detalle_Venta_TB;
DBCC CHECKIDENT ('TZ_Detalle_Venta_TB', RESEED, 0);

DELETE FROM TZ_Venta_TB;
DBCC CHECKIDENT ('TZ_Venta_TB', RESEED, 0);

DELETE FROM TZ_Detalle_Compra_TB;
DBCC CHECKIDENT ('TZ_Detalle_Compra_TB', RESEED, 0);

DELETE FROM TZ_Compra_TB;
DBCC CHECKIDENT ('TZ_Compra_TB', RESEED, 0);

DELETE FROM TZ_Pago_TB;
DBCC CHECKIDENT ('TZ_Pago_TB', RESEED, 0);

DELETE FROM TZ_Inventario_TB;
DBCC CHECKIDENT ('TZ_Inventario_TB', RESEED, 0);

DELETE FROM TZ_Producto_TB;
DBCC CHECKIDENT ('TZ_Producto_TB', RESEED, 0);

DELETE FROM TZ_Telefono_Usuario_TB;
DBCC CHECKIDENT ('TZ_Telefono_Usuario_TB', RESEED, 0);

DELETE FROM TZ_Contacto_Proveedor_TB;
DBCC CHECKIDENT ('TZ_Contacto_Proveedor_TB', RESEED, 0);

DELETE FROM TZ_Usuario_TB;
DBCC CHECKIDENT ('TZ_Usuario_TB', RESEED, 0);

DELETE FROM TZ_Division_TB;
DBCC CHECKIDENT ('TZ_Division_TB', RESEED, 0);

DELETE FROM TZ_Metodo_Pago_TB;
DBCC CHECKIDENT ('TZ_Metodo_Pago_TB', RESEED, 0);

DELETE FROM TZ_Rol_TB;
DBCC CHECKIDENT ('TZ_Rol_TB', RESEED, 0);

DELETE FROM TZ_Proveedor_TB;
DBCC CHECKIDENT ('TZ_Proveedor_TB', RESEED, 0);
END;

execute EliminacionConReinicioN;



-------------------------------------------------------------------------------------------------------------
------------------------DATAMART DE SANTORY BY REYNALDO------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

--CREACIÓN DEL DATAMART
Create database Datamart_Zapateria;
Use Datamart_Zapateria;


--DIMENSIONES

------Dimencion producto
Create table Dim_Producto (
    Id_producto INT Constraint Dim_Producto_TB_Id_producto_PK PRIMARY KEY,
    Codigo_producto VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255) NOT NULL,
    Color VARCHAR(50) NOT NULL,
    Talla VARCHAR(50) NOT NULL,
    Precio_venta DECIMAL(10,2) NOT NULL,
    Costo_unitario DECIMAL(10,2) NOT NULL
);

------Dimencion Proveedor
Create table Dim_Proveedor (
    Id_proveedor INT Constraint Dim_Proveedor_TB_Id_proveedor PRIMARY KEY,
    Nombre_proveedor VARCHAR(100) NOT NULL,
    Pais_proveedor VARCHAR(50) NOT NULL,
	Gmail_proveedor Varchar(125) Not null unique
);

----Dimencion division o categoria
Create Table Dim_Categoria (
    Id_categoria INT Constraint Dim_Categoria_TB_Id_categoria  PRIMARY KEY,
    Nombre_categoria VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255) NOT NULL
);


-----------Dimencion Cliente
Create table Dim_Cliente (
    Id_cliente INT Constraint Dim_Cliente_TB_Id_cliente PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
	Primer_apellido VARCHAR (255) not null,
	Segundo_apellido Varchar (255) not null,
    Ubicacion VARCHAR(255) NOT NULL
);

CREATE TABLE Dim_Vendedor (
    Id_vendedor INT CONSTRAINT Dim_Vendedor_Id_TB_vendedor_PK PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Primer_apellido VARCHAR(100) NOT NULL,
    Segundo_apellido VARCHAR(100) NOT NULL,
    Ubicacion VARCHAR(255) NOT NULL,
);


Create Table Dim_Metodo_Pago (
    Id_metodo_pago INT Constraint Dim_Metodo_Pago_TB_Id_metodo_pago_PK PRIMARY KEY,
    Metodo_pago VARCHAR(50) NOT NULL
);

Create table Dim_Tiempo(
	Id_tiempo int CONSTRAINT Dim_Tiempo_TB_Id_tiempo_PK primary key,
	Fecha Date not null,
	Dia Int not null,
	Mes Int not null,
	Anio Int not null
);
-----Tabla de hechos
CREATE TABLE Fact_Ventas (
    Id_fact_venta INT IDENTITY(1,1) CONSTRAINT Fact_Ventas_Id_fact_venta_PK PRIMARY KEY,
    Id_producto INT NOT NULL CONSTRAINT Fact_Ventas_Id_producto_FK REFERENCES Dim_Producto(Id_producto),
    Id_proveedor INT NOT NULL CONSTRAINT Fact_Ventas_Id_proveedor_FK REFERENCES Dim_Proveedor(Id_proveedor),
    Id_categoria INT NOT NULL CONSTRAINT Fact_Ventas_Id_categoria_FK REFERENCES Dim_Categoria(Id_categoria),
    Id_cliente INT NULL CONSTRAINT Fact_Ventas_Id_cliente_FK REFERENCES Dim_Cliente(Id_cliente),
    Id_vendedor INT NULL CONSTRAINT Fact_Ventas_Id_vendedor_FK REFERENCES Dim_Vendedor(Id_vendedor),
    Id_metodo_pago INT NOT NULL CONSTRAINT Fact_Ventas_Id_metodo_pago_FK REFERENCES Dim_Metodo_Pago(Id_metodo_pago),
    Id_tiempo INT NOT NULL CONSTRAINT Fact_Ventas_Id_tiempo_FK REFERENCES Dim_Tiempo(Id_tiempo),
    Cantidad_vendida INT NOT NULL,
    Precio_unitario DECIMAL(10,2) NOT NULL,
    Costo_unitario DECIMAL(10,2) NOT NULL,
    Total_venta DECIMAL(10,2) NOT NULL
);


-----------------------------------------------------procedure insert Para llenar el datamart----------------------------------------- 

USE Datamart_Zapateria;
GO


-------------------------------------Cargar DIM Producto------------------------------------

CREATE OR ALTER PROCEDURE sp_Cargar_Dim_Producto
AS
BEGIN    
    INSERT INTO Dim_Producto (
        Id_producto, Codigo_producto, Descripcion,
        Color,Talla, Precio_venta, Costo_unitario
    )
    SELECT distinct
        p.Id_producto, p.Codigo, p.Descripcion,
        p.Color, p.Talla, p.Precio_venta,
        p.Costo_unitario
    FROM Transacciones_Zapateria.dbo.TZ_Producto_TB p;
    
END;

EXEC sp_Cargar_Dim_Producto;

SELECT * FROM Dim_Producto;


-------------------------------------Cargar DIM Proveedor------------------------------------


CREATE OR ALTER PROCEDURE sp_Cargar_Dim_Proveedor
AS
BEGIN    
    INSERT INTO Dim_Proveedor(
        Id_proveedor, Nombre_proveedor, Pais_proveedor, Gmail_proveedor
    )
    SELECT distinct
        p.Id_proveedor, p.Nombre_proveedor, cp.Pais_proveedor, cp.Correo_proveedor
    FROM Transacciones_Zapateria.dbo.TZ_Proveedor_TB p
	Left Join Transacciones_Zapateria.dbo.TZ_Contacto_proveedor_TB  CP 
	on p.Id_proveedor = cp.Id_proveedor;
    
END;

EXEC sp_Cargar_Dim_Proveedor;
select * from Dim_Proveedor

-------------------------------------Cargar DIM Categoria------------------------------------


CREATE OR ALTER PROCEDURE Sp_cargar_dim_categoria
AS
BEGIN 
	insert into Dim_Categoria(
		Id_categoria, Nombre_categoria, Descripcion
	)

	select distinct 
	d.id_division, d.categoria, descripcion from
	Transacciones_Zapateria.dbo.TZ_Division_TB d 

END;

EXEC Sp_cargar_dim_categoria;
SELECT * FROM Dim_Categoria;

-------------------------------------Cargar DIM Cliente------------------------------------

create or alter procedure SP_Cargar_DIM_Cliente 
as 
Begin
	INSERT INTO Dim_Cliente(Id_cliente,Nombre,
		Primer_apellido, Segundo_apellido, Ubicacion
	)

	Select distinct c.Id_usuario, c.NOmbre_usuario, c.Primer_apellido,
	c.Segundo_apellido, c.Direccion_usuario from
	Transacciones_Zapateria.dbo.TZ_Usuario_TB c 
	where c.Id_rol = 3; --- id rol cliente

ENd;
EXEC SP_Cargar_DIM_Cliente

SELECT * FROM Dim_Cliente

-------------------------------------Cargar DIM Vendedor------------------------------------


CREATE OR ALTER PROCEDURE SP_Cargar_DIM_Vendedor
AS
BEGIN
  
    INSERT INTO Dim_Vendedor (
        Id_vendedor, Nombre, Primer_apellido, Segundo_apellido, Ubicacion
    )
    SELECT distinct
        u.Id_usuario,
        u.Nombre_usuario,
        u.Primer_apellido,
        u.Segundo_apellido,
        u.Direccion_usuario
    FROM Transacciones_Zapateria.dbo.TZ_Usuario_TB u
    WHERE u.Id_rol IN (1, 2);  -- rol vendedores y admin
 
END;

exec SP_Cargar_DIM_Vendedor
select * from Dim_Vendedor;


-------------------------------------Cargar DIM Metodo_pago------------------------------------

create or alter procedure Sp_Cargar_Dim_Metodo_Pago
as 
begin
	
	insert into Dim_Metodo_Pago(
		Id_metodo_pago, Metodo_pago
	)	

	select distinct m.id_metodo_pago, m.Nombre_metodo_pago
	from Transacciones_Zapateria.dbo.TZ_Metodo_Pago_TB m;

end;

exec Sp_Cargar_Dim_Metodo_Pago;
select * from Dim_Metodo_Pago;


-------------------------------------Cargar DIM Tiempo------------------------------------


CREATE OR ALTER PROCEDURE SP_Cargar_DIM_Tiempo
AS
BEGIN

    INSERT INTO Dim_Tiempo (
        Id_tiempo,
        Fecha,
        Dia,
        Mes,
        Anio
    )
    SELECT distinct
        CONVERT(INT, CONVERT(VARCHAR(8), v.Fecha_venta, 112)) AS Id_tiempo,
        v.Fecha_venta AS Fecha, DAY(v.Fecha_venta) AS Dia,
        MONTH(v.Fecha_venta) AS Mes, YEAR(v.Fecha_venta) AS Anio
    FROM Transacciones_Zapateria.dbo.TZ_Venta_TB v
    GROUP BY v.Fecha_venta
    ORDER BY v.Fecha_venta;
END;

Exec SP_Cargar_DIM_Tiempo;
select * from Dim_Tiempo;


-------------------------------------Cargar DIM Fact_ventas------------------------------------

CREATE OR ALTER PROCEDURE SP_Cargar_Fact_Ventas
AS
BEGIN
    INSERT INTO Fact_Ventas (
        Id_producto, Id_proveedor, Id_categoria,
        Id_cliente, Id_vendedor, Id_metodo_pago,
        Id_tiempo, Cantidad_vendida, Precio_unitario,
        Costo_unitario, Total_venta
    )
    SELECT
        dv.Id_producto,
        pr.Id_proveedor,
        d.Id_division,
        CASE 
            WHEN u.Id_rol = 3 AND u.Id_usuario IN (SELECT Id_cliente FROM Dim_Cliente) THEN u.Id_usuario
            ELSE NULL
        END,
        CASE 
            WHEN u.Id_rol IN (1, 2) AND u.Id_usuario IN (SELECT Id_vendedor FROM Dim_Vendedor) THEN u.Id_usuario
            ELSE NULL
        END,
        p.Id_metodo_pago,
        CONVERT(INT, CONVERT(VARCHAR(8), v.Fecha_venta, 112)),
        dv.Cantidad,
        dv.Precio_unitario,
        prod.Costo_unitario,
        dv.Cantidad * dv.Precio_unitario 
    FROM Transacciones_Zapateria.dbo.TZ_Detalle_Venta_TB dv
    INNER JOIN Transacciones_Zapateria.dbo.TZ_Venta_TB v ON dv.Id_venta = v.Id_venta
    INNER JOIN Transacciones_Zapateria.dbo.TZ_Pago_TB p ON v.Id_pago = p.Id_pago
    INNER JOIN Transacciones_Zapateria.dbo.TZ_Producto_TB prod ON dv.Id_producto = prod.Id_producto
    INNER JOIN Transacciones_Zapateria.dbo.TZ_Division_TB d ON prod.Id_division = d.Id_division
    INNER JOIN Transacciones_Zapateria.dbo.TZ_Proveedor_TB pr ON d.Id_proveedor = pr.Id_proveedor
    INNER JOIN Transacciones_Zapateria.dbo.TZ_Usuario_TB u ON v.Id_usuario = u.Id_usuario
    WHERE
        CONVERT(INT, CONVERT(VARCHAR(8), v.Fecha_venta, 112)) IN (SELECT Id_tiempo FROM Dim_Tiempo)
        AND NOT EXISTS (
            SELECT 1
            FROM Fact_Ventas fv
            WHERE fv.Id_producto = dv.Id_producto
              AND fv.Id_tiempo = CONVERT(INT, CONVERT(VARCHAR(8), v.Fecha_venta, 112))
              AND fv.Cantidad_vendida = dv.Cantidad
              AND fv.Total_venta = dv.Cantidad * dv.Precio_unitario
        );
END;

exec SP_Cargar_Fact_Ventas;
select * from Fact_Ventas;


----------------------------------------------- Consultas --------------------------------------------


select * from Fact_Ventas
select * from Dim_Categoria
select * from Dim_Cliente
select * from Dim_Metodo_Pago
select * from Dim_Producto
select * from Dim_Proveedor
select * from Dim_Tiempo
select * from Dim_Vendedor;


-----------------------------------------------Ejecucion de procedimientos--------------------------------------------


create or alter procedure CargarDatosDatamart
as
begin 
execute sp_Cargar_Dim_Producto;
execute Sp_cargar_dim_categoria;
execute SP_Cargar_DIM_Vendedor;
execute SP_Cargar_DIM_Cliente;
execute Sp_Cargar_Dim_Metodo_Pago;
execute sp_Cargar_Dim_Proveedor;
execute SP_Cargar_DIM_Tiempo;
execute SP_Cargar_Fact_Ventas;
end;

------------------------Procedimiento para eliminar los datos de las dimenciones-----------------

Create or alter procedure Eliminar_Datos_Dim
as
begin
delete from fact_ventas;
DBCC CHECKIDENT ('Fact_Ventas', RESEED,0);
delete from dim_cliente;
delete from dim_producto;
delete from dim_categoria;
delete from dim_metodo_pago;
delete from dim_proveedor;
delete from dim_tiempo;
delete from dim_vendedor;

end;

use Datamart_Zapateria
EXECUTE Eliminar_Datos_Dim


execute CargarDatosDatamart