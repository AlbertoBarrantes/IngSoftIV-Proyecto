

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
            SET @mensajeSalida = 'No se encontr� un registro de almacenamiento con el ID proporcionado, no se ha actualizado ning�n registro.';
            SET @idMensajeSalida = 1;
			RETURN
        END
        -- Verifica si la ubicaci�n existe
        ELSE IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @ubicacionID)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'La ubicaci�n especificada no existe. Verifique la ubicaci�n antes de proceder.';
            SET @idMensajeSalida = 2;
			RETURN;
        END
        -- Verifica si la recepci�n existe
        ELSE IF NOT EXISTS (SELECT 1 FROM Recepcion WHERE idRecepcion = @recepcionID)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'La recepci�n especificada no existe. Verifique la recepci�n antes de proceder.';
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
