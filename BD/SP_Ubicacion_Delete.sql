

DROP PROCEDURE IF EXISTS SP_Ubicacion_Delete;
GO


CREATE PROCEDURE SP_Ubicacion_Delete
    @idUbicacion INT,
	@mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el id existe en Ubicacion
        IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @idUbicacion)
        BEGIN
            SET @mensajeSalida = 'No se encontr� una ubicaci�n con el ID proporcionado, no se ha eliminado ning�n registro.';
            SET @idMensajeSalida = 1;
			ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Elimina la ubicaci�n si existe
        DELETE FROM Ubicacion
        WHERE idUbicacion = @idUbicacion;

        COMMIT TRANSACTION;

		SET @mensajeSalida = 'La ubicaci�n ha sido eliminada correctamente.';
        SET @idMensajeSalida = 0;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
		SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;
    END CATCH;
END;
GO

/*
SELECT * FROM Ubicacion
*/
