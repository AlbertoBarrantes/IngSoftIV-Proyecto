

DROP PROCEDURE IF EXISTS SP_OrdenCompra_Delete;
GO


CREATE PROCEDURE SP_OrdenCompra_Delete
    @idOrdenCompra INT,
    @mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si idOrdenCompra existe
        IF NOT EXISTS (SELECT 1 FROM OrdenCompra WHERE idOrdenCompra = @idOrdenCompra)
        BEGIN
        ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'No se encontró una orden de compra con el ID proporcionado, no se ha eliminado ningún registro.';
            SET @idMensajeSalida = 1;
        END
        ELSE
        BEGIN
            -- elimina
            DELETE FROM OrdenCompra
            WHERE idOrdenCompra = @idOrdenCompra;
             COMMIT TRANSACTION;
            SET @mensajeSalida = 'La orden de compra ha sido eliminada.';
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