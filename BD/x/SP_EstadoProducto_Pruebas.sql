
-- Insert para EstadoProducto con SP
EXEC SP_EstadoProducto_Insert 'Defectuoso', 'Producto dañado o incompleto'
EXEC SP_EstadoProducto_Insert 'Caducado', 'Producto con fecha de caducidad vencida'
EXEC SP_EstadoProducto_Insert 'Pendiente de Revisión', 'Producto a ser revisado por calidad'


-- Update para EstadoProducto con SP
EXEC SP_EstadoProducto_Update 'XxXDefectuoso', 'XxXProducto dañado o incompleto'


-- Delete para EstadoProducto con SP
EXEC SP_EstadoProducto_Delete 1


-- Select para EstadoProducto con SP (nombre, descripcion)
EXEC SP_EstadoProducto_Select '',''