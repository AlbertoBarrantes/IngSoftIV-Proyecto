

DROP PROCEDURE IF EXISTS SP_Producto_Delete;
GO

CREATE PROCEDURE SP_Producto_Delete
    @idProducto INT
AS
BEGIN
    -- variables de mensaje de salida
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY

        -- eliminar producto
        DELETE FROM Producto
        WHERE idProducto = @idProducto;

        -- revisa si se eliminó
        IF @@ROWCOUNT > 0
        BEGIN
            SET @mensajeSalida = 'Producto eliminado.';
			SET @idMensajeSalida = 0;
        END
        ELSE
        BEGIN
            SET @mensajeSalida = 'No se eliminó el producto';
			SET @idMensajeSalida = 1;
        END

        -- mensaje de salida
        SELECT @mensajeSalida AS mensaje, @idMensajeSalida AS codigo;

    END TRY
    BEGIN CATCH
        -- variable de mensaje de salida
        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        --mensaje de error
        SELECT @mensajeError AS mensaje, -1 AS codigo;
    END CATCH;
END;
GO


/*
EXEC SP_Producto_Delete 1;
*/