

DROP PROCEDURE IF EXISTS SP_Almacenamiento_Update;
GO


CREATE PROCEDURE SP_Almacenamiento_Update
    @idAlmacenamiento INT,
    @ubicacionID INT,
    @recepcionID INT,
    @cantidadAlmacenada INT,
	@mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT

AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el almacenamiento existe
        IF NOT EXISTS (SELECT 1 FROM Almacenamiento WHERE idAlmacenamiento = @idAlmacenamiento)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'No se encontró un registro de almacenamiento con el ID proporcionado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 1;
			RETURN
        END
        -- Verifica si la ubicación existe
        ELSE IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @ubicacionID)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'La ubicación especificada no existe. Verifique la ubicación antes de proceder.';
            SET @idMensajeSalida = 2;
			RETURN;
        END
        -- Verifica si la recepción existe
        ELSE IF NOT EXISTS (SELECT 1 FROM Recepcion WHERE idRecepcion = @recepcionID)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'La recepción especificada no existe. Verifique la recepción antes de proceder.';
            SET @idMensajeSalida = 3;
			RETURN;
        END
		ELSE IF @cantidadAlmacenada < 0
		BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'La cantidad almacenada no puede ser negativa.';
            SET @idMensajeSalida = 3;
			RETURN;
		END
        ELSE
        BEGIN
            -- Actualiza si todas las verificaciones son correctas
            UPDATE Almacenamiento
            SET ubicacionID = @ubicacionID,
                recepcionID = @recepcionID,
                cantidadAlmacenada = @cantidadAlmacenada
            WHERE idAlmacenamiento = @idAlmacenamiento;
			COMMIT TRANSACTION;
            SET @mensajeSalida = 'El registro de almacenamiento ha sido actualizado correctamente.';
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
