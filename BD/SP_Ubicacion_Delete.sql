


DROP PROCEDURE IF EXISTS SP_Ubicacion_Delete;
GO



CREATE PROCEDURE SP_Ubicacion_Delete
    @idUbicacion INT
AS
BEGIN
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si la ubicación existe en Ubicacion
        IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @idUbicacion)
        BEGIN
            SET @mensajeSalida = 'No se encontró una ubicación con el ID proporcionado, no se ha eliminado ningún registro.';
            SET @idMensajeSalida = 1;
        END
        ELSE
        BEGIN
            -- Elimina la ubicación si existe
            DELETE FROM Ubicacion
            WHERE idUbicacion = @idUbicacion;

            SET @mensajeSalida = 'La ubicación ha sido eliminada correctamente.';
            SET @idMensajeSalida = 0;
        END

        COMMIT TRANSACTION;

        -- Mensaje de salida
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
