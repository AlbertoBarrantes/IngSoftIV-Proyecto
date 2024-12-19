

USE AlmacenDB;
GO

-- Limpieza de entradas
DELETE FROM Almacenamiento;
DELETE FROM Recepcion;
DELETE FROM Ubicacion;
DELETE FROM OrdenCompra;
DELETE FROM EstadoOrden;
DELETE FROM Producto;

-- Reinicio de IDs
DBCC CHECKIDENT ('Producto', RESEED, 0);
DBCC CHECKIDENT ('EstadoOrden', RESEED, 0);
DBCC CHECKIDENT ('OrdenCompra', RESEED, 0);
DBCC CHECKIDENT ('Ubicacion', RESEED, 0);
DBCC CHECKIDENT ('Recepcion', RESEED, 0);
DBCC CHECKIDENT ('Almacenamiento', RESEED, 0);

-- Inserts para xProducto
INSERT INTO Producto (codigoBarras, descripcion, unidadMedida, peso, dimension, numeroLote, stock)
VALUES 
    ('1234567', 'Laptop HP Pavilion 15.6" Core i7',                  'kg',   1.75, '35.8 x 24.6 x 1.9 cm',  'A12345', 100),
    ('1234568', 'Monitor LG UltraGear 27" IPS QHD',                  'kg',   5.00, '61.4 x 45.0 x 22.0 cm', 'B56789', 50),
    ('1234569', 'Teclado mecánico Logitech G PRO',                   'g',    980.00, '36.1 x 15.3 x 3.4 cm',  'C11111', 75),
    ('1234570', 'Mouse gaming Razer DeathAdder V2',                  'g',    82.00, '12.7 x 6.1 x 4.2 cm',   'D22222', 200),
    ('1234571', 'Auriculares inalámbricos Sony WH-1000XM5',          'g',    250.00, '22.0 x 18.0 x 7.5 cm',  'E33333', 60),
    ('1234572', 'Router TP-Link Archer AX73 Wi-Fi 6',                'kg',   0.65, '26.5 x 18.4 x 6.5 cm',  'F44444', 40),
    ('1234573', 'Disco duro externo Seagate 5TB',                    'g',    300.00, '11.4 x 7.6 x 2.1 cm',  'G55555', 120),
    ('1234574', 'Cámara web Logitech StreamCam Full HD',             'g',    222.00, '6.6 x 5.8 x 4.8 cm',   'H66666', 180),
    ('1234575', 'Impresora multifunción Epson EcoTank L3250',        'kg',   3.90, '37.5 x 34.7 x 17.9 cm', 'I77777', 25);

-- Inserts para xEstadoOrden
INSERT INTO EstadoOrden (nombre, descripcion)
VALUES 
    ('Pendiente',  'Orden en espera de procesamiento'),
    ('En Proceso', 'Orden actualmente en preparación'),
    ('Completada', 'Orden lista y entregada');

-- Inserts para xOrdenCompra
INSERT INTO OrdenCompra (estadoOrdenID, proveedor, fechaOrden)
VALUES 
    (1, 'Distribuidora de Laptops S.A.',        '2024-10-05'),
    (2, 'Pantallas y Monitores S.A.',           '2024-10-10'),
    (3, 'Accesorios Gamer CR',                  '2024-10-15'),
    (1, 'Audio y Conectividad S.A.',            '2024-10-20'),
    (2, 'Redes y Tecnología Avanzada S.A.',     '2024-10-22'),
    (3, 'Almacenamiento Seguro S.A.',           '2024-10-25'),
    (1, 'Periféricos para Streaming S.A.',      '2024-10-28'),
    (2, 'Impresoras y Multifuncionales CR',     '2024-10-30'),
    (3, 'Componentes Tecnológicos S.A.',        '2024-11-01');

-- Inserts para xUbicacion
INSERT INTO Ubicacion (productoID, pasillo, estante)
VALUES 
    (1, 'A1', 'E-11'),
    (2, 'A2', 'E-22'),
    (3, 'A3', 'E-9'),
    (4, 'B1', 'E-7'),
    (5, 'B2', 'E-13'),
    (6, 'B3', 'E-6'),
    (7, 'C1', 'E-4'),
    (8, 'C2', 'E-1'),
    (9, 'C3', 'E-11');

-- Inserts para xRecepcion
INSERT INTO Recepcion (productoID, ordenCompraID, cantidad, fechaRecepcion)
VALUES 
    (1, 1, 500, '2024-10-07'),
    (2, 2, 300, '2024-10-12'),
    (3, 3, 150, '2024-10-18'),
    (4, 4, 200, '2024-10-21'),
    (5, 5, 250, '2024-10-29'),
    (6, 6, 100, '2024-10-31'),
    (7, 7, 400, '2024-11-02'),
    (8, 8, 350, '2024-11-05'),
    (9, 9, 500, '2024-11-07');

-- Inserts para xAlmacenamiento
INSERT INTO Almacenamiento (ubicacionID, recepcionID, cantidadAlmacenada)
VALUES 
    (1, 1, 300),  
    (2, 2, 150),  
    (3, 3, 100),  
    (4, 4, 150),  
    (5, 5, 200),  
    (6, 6, 90),   
    (7, 7, 380),  
    (8, 8, 300),  
    (9, 9, 450);

-- Verificación de los datos
SELECT * FROM Producto;
SELECT * FROM EstadoOrden;
SELECT * FROM OrdenCompra;
SELECT * FROM Ubicacion;
SELECT * FROM Recepcion;
SELECT * FROM Almacenamiento;
