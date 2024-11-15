


DROP PROCEDURE IF EXISTS SP_Almacenamiento_Select;
GO



CREATE PROCEDURE SP_Almacenamiento_Select
    @ubicacionID INT = NULL,
    @recepcionID INT = NULL,
    @cantidadAlmacenada INT = NULL
AS
BEGIN
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY

        SET @ubicacionID = NULLIF(@ubicacionID,'');
        SET @recepcionID = NULLIF(@recepcionID,'');
        SET @cantidadAlmacenada = NULLIF(@cantidadAlmacenada,'');

        -- Consulta con filtros opcionales
        SELECT idAlmacenamiento, ubicacionID, recepcionID, cantidadAlmacenada
        FROM Almacenamiento
        WHERE (@ubicacionID IS NULL OR ubicacionID = @ubicacionID)
          AND (@recepcionID IS NULL OR recepcionID = @recepcionID)
          AND (@cantidadAlmacenada IS NULL OR cantidadAlmacenada = @cantidadAlmacenada);

        SET @mensajeSalida = 'Consulta realizada exitosamente.';
        SET @idMensajeSalida = 0;

        -- Mensaje de salida como resultado
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH
        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        -- Mensaje de error como resultado
        SELECT @mensajeError AS Mensaje, -1 AS Código;
    END CATCH;
END;
GO
