


DROP PROCEDURE IF EXISTS SP_Almacenamiento_Insert;
GO



CREATE PROCEDURE SP_Almacenamiento_Insert
    @ubicacionID INT,
    @recepcionID INT,
    @cantidadAlmacenada INT

AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si la ubicación existe
        IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @ubicacionID)
        BEGIN
            SET @mensajeSalida = 'La ubicación especificada no existe. Verifique la ubicación antes de proceder.';
            SET @idMensajeSalida = 1;
        END
        -- Verifica si la recepción existe
        ELSE IF NOT EXISTS (SELECT 1 FROM Recepcion WHERE idRecepcion = @recepcionID)
        BEGIN
            SET @mensajeSalida = 'La recepción especificada no existe. Verifique la recepción antes de proceder.';
            SET @idMensajeSalida = 2;
        END
        ELSE
        BEGIN
            -- Inserta si no hay problemas
            INSERT INTO Almacenamiento (ubicacionID, recepcionID, cantidadAlmacenada)
            VALUES (@ubicacionID, @recepcionID, @cantidadAlmacenada);

            SET @mensajeSalida = 'El registro de almacenamiento ha sido ingresado correctamente.';
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
