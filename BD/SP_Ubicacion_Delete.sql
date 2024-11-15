


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

        -- Verifica si la ubicaci�n existe en Ubicacion
        IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @idUbicacion)
        BEGIN
            SET @mensajeSalida = 'No se encontr� una ubicaci�n con el ID proporcionado, no se ha eliminado ning�n registro.';
            SET @idMensajeSalida = 1;
        END
        ELSE
        BEGIN
            -- Elimina la ubicaci�n si existe
            DELETE FROM Ubicacion
            WHERE idUbicacion = @idUbicacion;

            SET @mensajeSalida = 'La ubicaci�n ha sido eliminada correctamente.';
            SET @idMensajeSalida = 0;
        END

        COMMIT TRANSACTION;

        -- Mensaje de salida
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS C�digo;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        -- Mensaje de error como resultado
        SELECT @mensajeError AS Mensaje, -1 AS C�digo;

    END CATCH;

    RETURN @idMensajeSalida;

END;
GO
