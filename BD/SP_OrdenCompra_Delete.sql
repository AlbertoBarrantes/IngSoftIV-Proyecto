


DROP PROCEDURE IF EXISTS SP_OrdenCompra_Delete;
GO



CREATE PROCEDURE SP_OrdenCompra_Delete
    @idOrdenCompra INT
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si idOrdenCompra existe
        IF NOT EXISTS (SELECT 1 FROM OrdenCompra WHERE idOrdenCompra = @idOrdenCompra)
        BEGIN
            SET @mensajeSalida = 'No se encontró una orden de compra con el ID proporcionado, no se ha eliminado ningún registro.';
            SET @idMensajeSalida = 1;
        END
        ELSE
        BEGIN
            -- elimina
            DELETE FROM OrdenCompra
            WHERE idOrdenCompra = @idOrdenCompra;

            SET @mensajeSalida = 'La orden de compra ha sido eliminada.';
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
