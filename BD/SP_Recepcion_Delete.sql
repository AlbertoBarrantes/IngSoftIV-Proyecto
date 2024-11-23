

DROP PROCEDURE IF EXISTS SP_Recepcion_Delete;
GO


CREATE PROCEDURE SP_Recepcion_Delete
    @idRecepcion INT,
    @mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el registro de recepci�n existe en Recepcion
        IF NOT EXISTS (SELECT 1 FROM Recepcion WHERE idRecepcion = @idRecepcion)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'No se encontr� un registro de recepci�n con el ID proporcionado, no se ha eliminado ning�n registro.';
            SET @idMensajeSalida = 1;
			RETURN;
        END
        ELSE
        BEGIN
            -- Elimina
            DELETE FROM Recepcion
            WHERE idRecepcion = @idRecepcion;
			COMMIT TRANSACTION;
            SET @mensajeSalida = 'El registro de recepci�n ha sido eliminado correctamente.';
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

SELECT * FROM Recepcion;

*/