

SELECT * FROM Producto
SELECT * FROM OrdenCompra


SELECT * FROM Recepcion

EXEC SP_Recepcion_Insert
    @productoID = 1,
    @ordenCompraID = 1,
    @cantidad = 9999,
    @fechaRecepcion = '2024-1-1';

SELECT * FROM Recepcion



-------------------------------------------------------------------



SELECT * FROM Producto
SELECT * FROM OrdenCompra


SELECT * FROM Recepcion

EXEC SP_Recepcion_Update
    @idRecepcion    = 6,
    @productoID     = 2,
    @ordenCompraID  = 2,
    @cantidad       = 6666,
    @fechaRecepcion = '2024-12-31';

SELECT * FROM Recepcion



-------------------------------------------------------------------



SELECT * FROM Recepcion

EXEC SP_Recepcion_Delete
    @idRecepcion = 4;

SELECT * FROM Recepcion



-------------------------------------------------------------------



SELECT * FROM Recepcion

EXEC SP_Recepcion_Select
    @productoID = NULL,
    @ordenCompraID = NULL,
    @fechaRecepcion = NULL;


