


DROP PROCEDURE IF EXISTS SP_OrdenCompra_Insert;
GO



CREATE PROCEDURE SP_OrdenCompra_Insert
    @estadoOrdenID INT,
    @proveedor VARCHAR(100),
    @fechaOrden DATE
    
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY

        BEGIN TRANSACTION;

        INSERT INTO OrdenCompra (estadoOrdenID, proveedor, fechaOrden)
        VALUES (@estadoOrdenID, @proveedor, @fechaOrden);

        SET @mensajeSalida = 'La orden de compra ha sido ingresada correctamente.';
        SET @idMensajeSalida = 0;

        COMMIT TRANSACTION;

        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH
    
        ROLLBACK TRANSACTION;

        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        SELECT @mensajeError AS Mensaje, -1 AS Código;
    
    END CATCH;

    RETURN @idMensajeSalida;

END;
GO

