

DROP PROCEDURE IF EXISTS SP_Almacenamiento_Select;
GO


CREATE PROCEDURE SP_Almacenamiento_Select
    @idAlmacenamiento INT = NULL,
	@ubicacionID INT = NULL,
    @recepcionID INT = NULL,
    @cantidadAlmacenada INT = NULL
AS
BEGIN
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY

		SET @idAlmacenamiento = NULLIF(@idAlmacenamiento,'');
		SET @ubicacionID = NULLIF(@ubicacionID,'');
		SET @recepcionID = NULLIF(@recepcionID,'');
		SET @cantidadAlmacenada = NULLIF(@cantidadAlmacenada,'');

        -- Consulta con filtros opcionales
        SELECT idAlmacenamiento, ubicacionID, recepcionID, cantidadAlmacenada
        FROM Almacenamiento
        WHERE (@idAlmacenamiento IS NULL OR idAlmacenamiento = @idAlmacenamiento)
		  AND (@ubicacionID IS NULL OR ubicacionID = @ubicacionID)
          AND (@recepcionID IS NULL OR recepcionID = @recepcionID)
          AND (@cantidadAlmacenada IS NULL OR cantidadAlmacenada = @cantidadAlmacenada);

		IF @@ROWCOUNT > 0
		BEGIN
			SET @mensajeSalida = 'Consulta realizada exitosamente.';
			SET @idMensajeSalida = 0;
		END
		ELSE
        BEGIN
            SET @mensajeSalida = 'No se encontraron productos con los filtros indicados';
            SET @idMensajeSalida = 1;
        END

        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH
        
		SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END CATCH;
END;
GO
