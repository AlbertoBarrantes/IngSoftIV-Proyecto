

DROP PROCEDURE IF EXISTS SP_Recepcion_Update;
GO


CREATE PROCEDURE SP_Recepcion_Update
    @idRecepcion INT,
    @productoID INT,
    @ordenCompraID INT,
    @cantidad INT,
    @fechaRecepcion DATE,
    @mensajesalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el registro de recepción existe en Recepcion
        IF NOT EXISTS (SELECT 1 FROM Recepcion WHERE idRecepcion = @idRecepcion)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'No se encontró un registro de recepción con el ID proporcionado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 1;
			RETURN;
        END
        -- Verifica si el producto existe en Producto
        ELSE IF NOT EXISTS (SELECT 1 FROM Producto WHERE idProducto = @productoID)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'El producto especificado no existe. Verifique el producto antes de proceder.';
            SET @idMensajeSalida = 2;
			RETURN;
        END
        -- Verifica si la orden de compra existe en OrdenCompra
        ELSE IF NOT EXISTS (SELECT 1 FROM OrdenCompra WHERE idOrdenCompra = @ordenCompraID)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'La orden de compra especificada no existe. Verifique la orden antes de proceder.';
            SET @idMensajeSalida = 3;
			RETURN;
        END
        ELSE
        BEGIN
            -- Realiza la actualización si todas las verificaciones pasan
            UPDATE Recepcion
            SET productoID = @productoID,
                ordenCompraID = @ordenCompraID,
                cantidad = @cantidad,
                fechaRecepcion = @fechaRecepcion
            WHERE idRecepcion = @idRecepcion;
			COMMIT TRANSACTION;
            SET @mensajeSalida = 'El registro de recepción ha sido actualizado correctamente.';
            SET @idMensajeSalida = 0;
        END

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;

    END CATCH;
END;
GO
