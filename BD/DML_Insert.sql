


USE AlmacenDB;
GO



-- Inserts para xProducto
INSERT INTO Producto (codigoBarras, descripcion, unidadMedida, peso, dimension, numeroLote, stock)
VALUES 
    ('7501001234567', 'Coca Cola 600ml', 'ml', 600.00, '20x10x5 cm', 'A12345', 100),
    ('7502001234568', 'Sabritas Original 240g', 'g', 240.00, '15x20x5 cm', 'B56789', 50),
    ('7503001234569', 'Pan Bimbo Grande', 'g', 700.00, '30x15x10 cm', 'C11111', 75),
    ('7504001234570', 'Leche Alpura 1L', 'L', 1.00, '25x10x7 cm', 'D22222', 200);





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
    (3, 'Bebidas Costa Rica', '2024-10-15');



-- Inserts para xUbicacion
INSERT INTO Ubicacion (productoID, pasillo, estante)
VALUES 
    (1, 'A1', 'Estante 3'),
    (2, 'B2', 'Estante 5'),
    (3, 'C1', 'Estante 1'),
    (4, 'D3', 'Estante 7');



-- Inserts para xRecepcion
INSERT INTO Recepcion (productoID, ordenCompraID, cantidad, fechaRecepcion)
VALUES 
    (1, 1, 500, '2024-10-07'),
    (2, 2, 300, '2024-10-12'),
    (3, 3, 150, '2024-10-18');



-- Inserts para xAlmacenamiento
INSERT INTO Almacenamiento (ubicacionID, recepcionID, cantidadAlmacenada)
VALUES 
    (1, 1, 300),  -- Coca Cola recibida y almacenada en pasillo A1, Estante 3
    (2, 2, 150),  -- Sabritas recibidas y almacenadas en pasillo B2, Estante 5
    (3, 3, 100);  -- Pan Bimbo recibido y almacenado en pasillo C1, Estante 1
