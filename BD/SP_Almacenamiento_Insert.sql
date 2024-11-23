

DROP PROCEDURE IF EXISTS SP_Almacenamiento_Insert;
GO


CREATE PROCEDURE SP_Almacenamiento_Insert
    @ubicacionID INT,
    @recepcionID INT,
    @cantidadAlmacenada INT,
	@mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si la ubicación existe
        IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @ubicacionID)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'La ubicación especificada no existe. Verifique la ubicación antes de proceder.';
            SET @idMensajeSalida = 1;
			RETURN;
        END
        -- Verifica si la recepción existe
        ELSE IF NOT EXISTS (SELECT 1 FROM Recepcion WHERE idRecepcion = @recepcionID)
        BEGIN
			ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'La recepción especificada no existe. Verifique la recepción antes de proceder.';
            SET @idMensajeSalida = 2;
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
            -- Inserta si no hay problemas
            INSERT INTO Almacenamiento (ubicacionID, recepcionID, cantidadAlmacenada)
            VALUES (@ubicacionID, @recepcionID, @cantidadAlmacenada);
			COMMIT TRANSACTION;
            SET @mensajeSalida = 'Se ingresó el nuevo almacenamiento.';
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
