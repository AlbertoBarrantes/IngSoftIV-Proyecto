


USE AlmacenDB;
GO



-- Inserts para Producto
INSERT INTO Producto (codigoBarras, descripcion, unidadMedida, peso, dimension, numeroLote, stock)
VALUES 
    ('7501001234567', 'Coca Cola 600ml', 'ml', 600.00, '20x10x5 cm', 'A12345', 100),
    ('7502001234568', 'Sabritas Original 240g', 'g', 240.00, '15x20x5 cm', 'B56789', 50),
    ('7503001234569', 'Pan Bimbo Grande', 'g', 700.00, '30x15x10 cm', 'C11111', 75),
    ('7504001234570', 'Leche Alpura 1L', 'L', 1.00, '25x10x7 cm', 'D22222', 200);



-- Inserts para EstadoProducto
INSERT INTO EstadoProducto (nombre, descripcion)
VALUES 
    ('Defectuoso', 'Producto dañado o incompleto'),
    ('Caducado', 'Producto con fecha de caducidad vencida'),
    ('Pendiente de Revisión', 'Producto a ser revisado por calidad');



-- Inserts para ProductoDefectuoso
INSERT INTO ProductoDefectuoso (estadoProductoID, productoID)
VALUES 
    (1, 1),  -- Coca Cola marcada como defectuosa
    (2, 2),  -- Sabritas caducadas
    (3, 3);  -- Pan Bimbo pendiente de revisión



-- Inserts para Devolucion
INSERT INTO Devolucion (productoID, cantidad, razon)
VALUES 
    (1, 10, 'Producto dañado durante el transporte'),
    (2, 5, 'Producto caducado detectado en bodega'),
    (4, 15, 'Error en pedido');



-- Inserts para EstadoOrden
INSERT INTO EstadoOrden (nombre, descripcion)
VALUES 
    ('Pendiente', 'Orden en espera de procesamiento'),
    ('En Proceso', 'Orden actualmente en preparación'),
    ('Completada', 'Orden lista y entregada');



-- Inserts para OrdenSalida
INSERT INTO OrdenSalida (estadoOrdenID, cliente, fechaSalida)
VALUES 
    (1, 'Supermercado La Central', '2024-11-10'),
    (2, 'Abarrotes El Buen Precio', '2024-11-12'),
    (3, 'Minisuper La Esperanza', '2024-11-15');



-- Inserts para Despacho
INSERT INTO Despacho (productoID, ordenSalidaID, cantidad)
VALUES 
    (1, 1, 30),  -- Coca Cola para Supermercado La Central
    (2, 1, 20),  -- Sabritas para Supermercado La Central
    (3, 2, 15),  -- Pan Bimbo para Abarrotes El Buen Precio
    (4, 3, 50);  -- Leche para Minisuper La Esperanza



-- Inserts para OrdenCompra
INSERT INTO OrdenCompra (estadoOrdenID, proveedor, fechaOrden)
VALUES 
    (1, 'Distribuidora Alimentos S.A.', '2024-10-05'),
    (2, 'Lácteos del Norte', '2024-10-10'),
    (3, 'Bebidas Costa Rica', '2024-10-15');



-- Inserts para Ubicacion
INSERT INTO Ubicacion (productoID, pasillo, estante)
VALUES 
    (1, 'A1', 'Estante 3'),
    (2, 'B2', 'Estante 5'),
    (3, 'C1', 'Estante 1'),
    (4, 'D3', 'Estante 7');



-- Inserts para Recepcion
INSERT INTO Recepcion (productoID, ordenCompraID, cantidad, fechaRecepcion)
VALUES 
    (1, 1, 500, '2024-10-07'),
    (2, 2, 300, '2024-10-12'),
    (3, 3, 150, '2024-10-18');



-- Inserts para Almacenamiento
INSERT INTO Almacenamiento (ubicacionID, recepcionID, cantidadAlmacenada)
VALUES 
    (1, 1, 300),  -- Coca Cola recibida y almacenada en pasillo A1, Estante 3
    (2, 2, 150),  -- Sabritas recibidas y almacenadas en pasillo B2, Estante 5
    (3, 3, 100);  -- Pan Bimbo recibido y almacenado en pasillo C1, Estante 1
