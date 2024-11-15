


-- Insert para EstadoOrden con SP
EXEC SP_EstadoOrden_Insert 
    '111111111',
    '222222222'

SELECT * FROM EstadoOrden



-- Update para EstadoOrden con SP
EXEC SP_EstadoOrden_Update
    '3',
    '3333333',
    '4444444'
    
SELECT * FROM EstadoOrden



-- Delete para EstadoOrden con SP
EXEC SP_EstadoOrden_Delete '3'

SELECT * FROM EstadoOrden



-- Select para EstadoOrden con SP (nombre, descripcion)
EXEC SP_EstadoOrden_Select
    '',
    ''