

DROP PROCEDURE IF EXISTS SP_Producto_Delete;
GO


CREATE PROCEDURE SP_Producto_Delete
    @idProducto INT,
	@mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
		BEGIN TRANSACTION;

		 -- Validación: Verificar si el producto existe
        IF NOT EXISTS (SELECT 1 FROM Producto WHERE idProducto = @idProducto)
        BEGIN
            SET @mensajeSalida = 'El ID del producto no existe, no se ha eliminado el producto.';
            SET @idMensajeSalida = 3;
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Eliminar producto
        DELETE FROM Producto
        WHERE idProducto = @idProducto;

        COMMIT TRANSACTION;

        SET @mensajeSalida = 'Producto eliminado exitosamente.';
        SET @idMensajeSalida = 0;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
		SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;
    END CATCH;
END;
GO


/*
SELECT * FROM Producto;
EXEC SP_Producto_Delete 1;
*/