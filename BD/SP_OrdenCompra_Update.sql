

DROP PROCEDURE IF EXISTS SP_OrdenCompra_Update;
GO


CREATE PROCEDURE SP_OrdenCompra_Update
    @idOrdenCompra INT,
    @estadoOrdenID INT,
    @proveedor VARCHAR(100),
    @fechaOrden DATE,
    @mensajesalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- verifica si la orden de compra existe
        IF NOT EXISTS (SELECT 1 FROM OrdenCompra WHERE idOrdenCompra = @idOrdenCompra)
        BEGIN
            ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'No se encontró una orden de compra con el ID proporcionado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 1;
            RETURN;
        END
        -- verifica si el estado de orden existe
        IF NOT EXISTS (SELECT 1 FROM EstadoOrden WHERE idEstadoOrden = @estadoOrdenID)
        BEGIN
            ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'No se encontró el estado de orden indicado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 2;
            RETURN;
        END
        ELSE
        -- actualiza la información
        BEGIN
            UPDATE OrdenCompra
            SET estadoOrdenID = @estadoOrdenID,
                proveedor = @proveedor,
                fechaOrden = @fechaOrden
            WHERE idOrdenCompra = @idOrdenCompra;
            COMMIT TRANSACTION;
            SET @mensajeSalida = 'La orden de compra ha sido actualizada.';
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