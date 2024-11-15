


DROP PROCEDURE IF EXISTS SP_Recepcion_Update;
GO



CREATE PROCEDURE SP_Recepcion_Update
    @idRecepcion INT,
    @productoID INT,
    @ordenCompraID INT,
    @cantidad INT,
    @fechaRecepcion DATE 
AS
BEGIN
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

   

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el registro de recepción existe en Recepcion
        IF NOT EXISTS (SELECT 1 FROM Recepcion WHERE idRecepcion = @idRecepcion)
        BEGIN
            SET @mensajeSalida = 'No se encontró un registro de recepción con el ID proporcionado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 1;
        END
        -- Verifica si el producto existe en Producto
        ELSE IF NOT EXISTS (SELECT 1 FROM Producto WHERE idProducto = @productoID)
        BEGIN
            SET @mensajeSalida = 'El producto especificado no existe. Verifique el producto antes de proceder.';
            SET @idMensajeSalida = 2;
        END
        -- Verifica si la orden de compra existe en OrdenCompra
        ELSE IF NOT EXISTS (SELECT 1 FROM OrdenCompra WHERE idOrdenCompra = @ordenCompraID)
        BEGIN
            SET @mensajeSalida = 'La orden de compra especificada no existe. Verifique la orden antes de proceder.';
            SET @idMensajeSalida = 3;
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

            SET @mensajeSalida = 'El registro de recepción ha sido actualizado correctamente.';
            SET @idMensajeSalida = 0;
        END

        COMMIT TRANSACTION;

        -- Mensaje de salida como resultado
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        -- Mensaje de error como resultado
        SELECT @mensajeError AS Mensaje, -1 AS Código;
    END CATCH;

    RETURN @idMensajeSalida;
END;
GO
