

DROP PROCEDURE IF EXISTS SP_Almacenamiento_Delete;
GO


CREATE PROCEDURE SP_Almacenamiento_Delete
    @idAlmacenamiento INT,
	@mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el almacenamiento existe en Almacenamiento
        IF NOT EXISTS (SELECT 1 FROM Almacenamiento WHERE idAlmacenamiento = @idAlmacenamiento)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'No se encontró un registro de almacenamiento con el ID proporcionado, no se ha eliminado ningún registro.';
            SET @idMensajeSalida = 1;
			RETURN;
        END
        ELSE	-- Elimina el registro de almacenamiento si existe
        BEGIN
            DELETE FROM Almacenamiento
            WHERE idAlmacenamiento = @idAlmacenamiento;
			COMMIT TRANSACTION;
            SET @mensajeSalida = 'El registro de almacenamiento ha sido eliminado correctamente.';
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
