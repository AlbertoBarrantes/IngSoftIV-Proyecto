


USE AlmacenDB;
GO



-- Inserts para xProducto
INSERT INTO Producto (codigoBarras, descripcion, unidadMedida, peso, dimension, numeroLote, stock)
VALUES 
    ('7501001234567', 'Coca Cola 600ml', 'ml', 600.00, '20x10x5 cm', 'A12345', 100),
    ('7502001234568', 'Sabritas Original 240g', 'g', 240.00, '15x20x5 cm', 'B56789', 50),
    ('7503001234569', 'Pan Bimbo Grande', 'g', 700.00, '30x15x10 cm', 'C11111', 75),
    ('7504001234570', 'Leche Alpura 1L', 'L', 1.00, '25x10x7 cm', 'D22222', 200),
	('7505001234571', 'Galletas Oreo 300g', 'g', 300.00, '10x15x5 cm', 'E33333', 60),
    ('7506001234572', 'Cereal Zucaritas 500g', 'g', 500.00, '25x20x7 cm', 'F44444', 40),
    ('7507001234573', 'Agua Cristal 1.5L', 'L', 1.50, '30x10x8 cm', 'G55555', 120),
    ('7508001234574', 'Papel Higiénico 4 rollos', 'unidades', 0.80, '20x20x10 cm', 'H66666', 180),
    ('7509001234575', 'Detergente Ariel 3kg', 'kg', 3.00, '40x30x20 cm', 'I77777', 25);





-- Inserts para xEstadoOrden
INSERT INTO EstadoOrden (nombre, descripcion)
VALUES 
    ('Pendiente', 'Orden en espera de procesamiento'),
    ('En Proceso', 'Orden actualmente en preparación'),
    ('Completada', 'Orden lista y entregada');






-- Inserts para xOrdenCompra
INSERT INTO OrdenCompra (estadoOrdenID, proveedor, fechaOrden)
VALUES 
    (1, 'Distribuidora Alimentos S.A.', '2024-10-05'),
    (2, 'Lácteos del Norte', '2024-10-10'),
    (3, 'Bebidas Costa Rica', '2024-10-15'),
	(1, 'Distribuidora El Buen Sabor', '2024-10-20'),
    (2, 'Lácteos de Occidente', '2024-10-22'),
    (3, 'Bebidas del Caribe', '2024-10-25'),
    (1, 'Panadería La Esperanza', '2024-10-28'),
    (2, 'Cárnicos del Norte', '2024-10-30');



-- Inserts para xUbicacion
INSERT INTO Ubicacion (productoID, pasillo, estante)
VALUES 
    (1, 'A1', 'Estante 3'),
    (2, 'B2', 'Estante 5'),
    (3, 'C1', 'Estante 1'),
    (4, 'D3', 'Estante 7'),
	(5, 'D4', 'Estante 2'),
    (6, 'E1', 'Estante 6'),
    (7, 'F2', 'Estante 4'),
    (8, 'G3', 'Estante 8'),
    (9, 'H5', 'Estante 10');



-- Inserts para xRecepcion
INSERT INTO Recepcion (productoID, ordenCompraID, cantidad, fechaRecepcion)
VALUES 
    (1, 1, 500, '2024-10-07'),
    (2, 2, 300, '2024-10-12'),
    (3, 3, 150, '2024-10-18'),
	(5, 4, 250, '2024-10-29'),
    (6, 5, 100, '2024-10-31'),
    (7, 1, 400, '2024-11-02'),
    (8, 2, 350, '2024-11-05'),
    (9, 3, 500, '2024-11-07');



-- Inserts para xAlmacenamiento
INSERT INTO Almacenamiento (ubicacionID, recepcionID, cantidadAlmacenada)
VALUES 
    (1, 1, 300),  -- Coca Cola recibida y almacenada en pasillo A1, Estante 3
    (2, 2, 150),  -- Sabritas recibidas y almacenadas en pasillo B2, Estante 5
    (3, 3, 100),  -- Pan Bimbo recibido y almacenado en pasillo C1, Estante 1
	(5, 4, 200),  -- Galletas Oreo almacenadas en pasillo D4, Estante 2
    (6, 5, 90),   -- Cereal Zucaritas almacenado en pasillo E1, Estante 6
    (7, 6, 380),  -- Agua Cristal almacenada en pasillo F2, Estante 4
    (8, 7, 300),  -- Papel Higiénico almacenado en pasillo G3, Estante 8
    (9, 8, 450);  -- Detergente Ariel almacenado en pasillo H5, Estante 10