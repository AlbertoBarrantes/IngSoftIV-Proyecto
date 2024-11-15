


DROP PROCEDURE IF EXISTS SP_EstadoOrden_Delete;
GO



CREATE PROCEDURE SP_EstadoOrden_Delete
    @idEstadoOrden INT
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- verifica si existe antes de intentar eliminarlo
        IF NOT EXISTS (SELECT 1 FROM EstadoOrden WHERE idEstadoOrden = @idEstadoOrden)
        BEGIN
            SET @mensajeSalida = 'No se encontró un estado con el ID proporcionado, no se ha eliminado ningún registro.';
            SET @idMensajeSalida = 1;
        END
        ELSE
        BEGIN
            DELETE FROM EstadoOrden
            WHERE idEstadoOrden = @idEstadoOrden;

            SET @mensajeSalida = 'El estado ha sido eliminado.';
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



/*

EXEC SP_EstadoOrden_Delete '2'

SELECT * FROM EstadoOrden

*/