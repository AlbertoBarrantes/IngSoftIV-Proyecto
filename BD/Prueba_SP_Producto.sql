


-- Insert para Producto con SP
EXEC SP_Producto_Insert 
    'XXX7504001234570', 
    'Leche Alpura 1L', 
    'L', 
    1.00, 
    '25x10x7 cm', 
    'D45345345', 
    200

SELECT * FROM Producto



-- Update para Producto con SP
EXEC SP_Producto_Update
    '10',
    '1111111111111', 
    'Leche Alpura 1L', 
    'L', 
    1.00, 
    '25x10x7 cm', 
    'D45345345', 
    200

SELECT * FROM Producto



-- Delete para Producto con SP
EXEC SP_Producto_Delete '10'

SELECT * FROM Producto



-- Select para Producto con SP (nombre, descripcion)
EXEC SP_Producto_Select
    '',
    ''