


DROP PROCEDURE IF EXISTS SP_Almacenamiento_Update;
GO



CREATE PROCEDURE SP_Almacenamiento_Update
    @idAlmacenamiento INT,
    @ubicacionID INT,
    @recepcionID INT,
    @cantidadAlmacenada INT

AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el almacenamiento existe en Almacenamiento
        IF NOT EXISTS (SELECT 1 FROM Almacenamiento WHERE idAlmacenamiento = @idAlmacenamiento)
        BEGIN
            SET @mensajeSalida = 'No se encontró un registro de almacenamiento con el ID proporcionado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 1;
        END
        -- Verifica si la ubicación existe en Ubicacion
        ELSE IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @ubicacionID)
        BEGIN
            SET @mensajeSalida = 'La ubicación especificada no existe. Verifique la ubicación antes de proceder.';
            SET @idMensajeSalida = 2;
        END
        -- Verifica si la recepción existe en Recepcion
        ELSE IF NOT EXISTS (SELECT 1 FROM Recepcion WHERE idRecepcion = @recepcionID)
        BEGIN
            SET @mensajeSalida = 'La recepción especificada no existe. Verifique la recepción antes de proceder.';
            SET @idMensajeSalida = 3;
        END
        ELSE
        BEGIN
            -- Actualiza si todas las verificaciones son correctas
            UPDATE Almacenamiento
            SET ubicacionID = @ubicacionID,
                recepcionID = @recepcionID,
                cantidadAlmacenada = @cantidadAlmacenada
            WHERE idAlmacenamiento = @idAlmacenamiento;

            SET @mensajeSalida = 'El registro de almacenamiento ha sido actualizado correctamente.';
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
