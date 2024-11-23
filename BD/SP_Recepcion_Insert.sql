

DROP PROCEDURE IF EXISTS SP_Recepcion_Insert;
GO


CREATE PROCEDURE SP_Recepcion_Insert
    @productoID INT,
    @ordenCompraID INT,
    @cantidad INT,
    @fechaRecepcion DATE = NULL,
	@mensajeSalida VARCHAR(255) OUT,
	@idmensajeSalida INT OUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

		SET @fechaRecepcion = COALESCE( NULLIF(@fechaRecepcion, '') , GETDATE() );

        -- Validacion: ¿productoID existe?
        IF NOT EXISTS (SELECT 1 FROM Producto WHERE idProducto = @productoID)
        BEGIN
            ROLLBACK TRANSACTION;
			SET @mensajeSalida = 'El producto especificado no existe. Verifique el producto antes de proceder.';
            SET @idMensajeSalida = 1;
			RETURN;
        END

        -- Validación: ¿ordenCompraID existe en OrdenCompra?
        ELSE IF NOT EXISTS (SELECT 1 FROM OrdenCompra WHERE idOrdenCompra = @ordenCompraID)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'La orden de compra especificada no existe. Verifique la orden antes de proceder.';
            SET @idMensajeSalida = 2;
			RETURN;
        END
		-- Validación: ¿cantidad es negativo?
		ELSE IF @cantidad < 0
		BEGIN
			ROLLBACK TRANSACTION;
			SET @mensajeSalida = 'La cantidad no puede ser negativa.';
            SET @idMensajeSalida = 3;
			RETURN;
		END
        ELSE
        BEGIN
            -- Insertar
            INSERT INTO Recepcion (productoID, ordenCompraID, cantidad, fechaRecepcion)
            VALUES (@productoID, @ordenCompraID, @cantidad, @fechaRecepcion);
			COMMIT TRANSACTION;
            SET @mensajeSalida = 'El registro de recepción ha sido ingresado correctamente.';
            SET @idMensajeSalida = 0;
        END

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        ROLLBACK TRANSACTION;
		SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;

    END CATCH;
END;
GO
