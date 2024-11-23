

DROP PROCEDURE IF EXISTS SP_OrdenCompra_Insert;
GO


CREATE PROCEDURE SP_OrdenCompra_Insert
    @estadoOrdenID INT,
    @proveedor VARCHAR(100),
    @fechaOrden DATE,
	@mensajeSalida VARCHAR(255) OUT,
	@idmensajeSalida INT OUT
    
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM EstadoOrden WHERE idEstadoOrden = @estadoOrdenID)
        BEGIN
            SET @mensajeSalida = 'No se encontró el estado de orden indicado, no se ha ingresado la orden de compra.';
			SET @idMensajeSalida = 1;
			ROLLBACK TRANSACTION;
			RETURN;
		END
        ELSE
        BEGIN
            INSERT INTO OrdenCompra (estadoOrdenID, proveedor, fechaOrden)
            VALUES (@estadoOrdenID, @proveedor, @fechaOrden);
            COMMIT TRANSACTION;
            SET @mensajeSalida = 'La orden de compra ha sido ingresada correctamente.';
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

/*
SELECT * FROM OrdenCompra
*/
