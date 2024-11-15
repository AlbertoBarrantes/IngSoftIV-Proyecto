


DROP PROCEDURE IF EXISTS SP_Recepcion_Delete;
GO



CREATE PROCEDURE SP_Recepcion_Delete
    @idRecepcion INT
AS
BEGIN
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el registro de recepción existe en Recepcion
        IF NOT EXISTS (SELECT 1 FROM Recepcion WHERE idRecepcion = @idRecepcion)
        BEGIN
            SET @mensajeSalida = 'No se encontró un registro de recepción con el ID proporcionado, no se ha eliminado ningún registro.';
            SET @idMensajeSalida = 1;
        END
        ELSE
        BEGIN
            -- Elimina el registro de recepción si existe
            DELETE FROM Recepcion
            WHERE idRecepcion = @idRecepcion;

            SET @mensajeSalida = 'El registro de recepción ha sido eliminado correctamente.';
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
