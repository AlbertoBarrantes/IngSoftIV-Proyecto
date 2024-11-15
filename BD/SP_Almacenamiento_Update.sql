


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
            SET @mensajeSalida = 'No se encontr� un registro de almacenamiento con el ID proporcionado, no se ha actualizado ning�n registro.';
            SET @idMensajeSalida = 1;
        END
        -- Verifica si la ubicaci�n existe en Ubicacion
        ELSE IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @ubicacionID)
        BEGIN
            SET @mensajeSalida = 'La ubicaci�n especificada no existe. Verifique la ubicaci�n antes de proceder.';
            SET @idMensajeSalida = 2;
        END
        -- Verifica si la recepci�n existe en Recepcion
        ELSE IF NOT EXISTS (SELECT 1 FROM Recepcion WHERE idRecepcion = @recepcionID)
        BEGIN
            SET @mensajeSalida = 'La recepci�n especificada no existe. Verifique la recepci�n antes de proceder.';
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
