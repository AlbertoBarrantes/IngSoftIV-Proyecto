


DROP PROCEDURE IF EXISTS SP_Recepcion_Insert;
GO



CREATE PROCEDURE SP_Recepcion_Insert
    @productoID INT,
    @ordenCompraID INT,
    @cantidad INT,
    @fechaRecepcion DATE = NULL
AS
BEGIN
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    SET @fechaRecepcion = COALESCE( NULLIF(@fechaRecepcion, '') , GETDATE() );

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el producto existe en Producto
        IF NOT EXISTS (SELECT 1 FROM Producto WHERE idProducto = @productoID)
        BEGIN
            SET @mensajeSalida = 'El producto especificado no existe. Verifique el producto antes de proceder.';
            SET @idMensajeSalida = 1;
        END
        -- Verifica si la orden de compra existe en OrdenCompra
        ELSE IF NOT EXISTS (SELECT 1 FROM OrdenCompra WHERE idOrdenCompra = @ordenCompraID)
        BEGIN
            SET @mensajeSalida = 'La orden de compra especificada no existe. Verifique la orden antes de proceder.';
            SET @idMensajeSalida = 2;
        END
        ELSE
        BEGIN
            -- Inserta un nuevo registro de recepción si ambas verificaciones pasan
            INSERT INTO Recepcion (productoID, ordenCompraID, cantidad, fechaRecepcion)
            VALUES (@productoID, @ordenCompraID, @cantidad, @fechaRecepcion);

            SET @mensajeSalida = 'El registro de recepción ha sido ingresado correctamente.';
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
