

DROP PROCEDURE IF EXISTS SP_EstadoOrden_Delete;
GO


CREATE PROCEDURE SP_EstadoOrden_Delete
    @idEstadoOrden INT,
	@mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si existe antes de intentar eliminarlo
        IF NOT EXISTS (SELECT 1 FROM EstadoOrden WHERE idEstadoOrden = @idEstadoOrden)
        BEGIN
            ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'No se encontró un estado de orden con el ID proporcionado, no se ha eliminado ningún registro.';
            SET @idMensajeSalida = 1;
            RETURN;
        END
        ELSE
        BEGIN
            DELETE FROM EstadoOrden
            WHERE idEstadoOrden = @idEstadoOrden;

            COMMIT TRANSACTION;
            SET @mensajeSalida = 'El estado de la orden ha sido eliminado.';
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

EXEC SP_EstadoOrden_Delete '2'

SELECT * FROM EstadoOrden

*/