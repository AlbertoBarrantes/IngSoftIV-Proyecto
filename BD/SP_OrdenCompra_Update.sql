

DROP PROCEDURE IF EXISTS SP_OrdenCompra_Update;
GO


CREATE PROCEDURE SP_OrdenCompra_Update
    @idOrdenCompra INT,
    @estadoOrdenID INT,
    @proveedor VARCHAR(100),
    @fechaOrden DATE
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- verifica si la orden de compra existe
        IF NOT EXISTS (SELECT 1 FROM OrdenCompra WHERE idOrdenCompra = @idOrdenCompra)
        BEGIN
            SET @mensajeSalida = 'No se encontró una orden de compra con el ID proporcionado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 1;
        END
        -- verifica si el estado de orden existe
        IF NOT EXISTS (SELECT 1 FROM EstadoOrden WHERE idEstadoOrden = @estadoOrdenID)
        BEGIN
            SET @mensajeSalida = 'No se encontró el estado de orden indicado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 2;
        END
        ELSE
        -- actualiza la información
        BEGIN
            UPDATE OrdenCompra
            SET estadoOrdenID = @estadoOrdenID,
                proveedor = @proveedor,
                fechaOrden = @fechaOrden
            WHERE idOrdenCompra = @idOrdenCompra;

            SET @mensajeSalida = 'La orden de compra ha sido actualizada.';
            SET @idMensajeSalida = 0;
        END

        COMMIT TRANSACTION;

        -- mensaje de salida
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        -- mensaje de error
        SELECT @mensajeError AS Mensaje, -1 AS Código;

    END CATCH;

    RETURN @idMensajeSalida;

END;
GO
