

DROP PROCEDURE IF EXISTS SP_Recepcion_Select;
GO


CREATE PROCEDURE SP_Recepcion_Select
	@idRecepcion INT = NULL,
    @productoID INT = NULL,
    @ordenCompraID INT = NULL,
    @fechaRecepcion DATE = NULL
AS
BEGIN
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY

		SET @idRecepcion = NULLIF(@idRecepcion,'');
        SET @productoID = NULLIF(@productoID,'');
        SET @ordenCompraID = NULLIF(@ordenCompraID,'');
        SET @fechaRecepcion = NULLIF(@fechaRecepcion,'');

        SELECT idRecepcion, productoID, ordenCompraID, cantidad, fechaRecepcion
        FROM Recepcion
        WHERE (@idRecepcion IS NULL OR idRecepcion = @idRecepcion)
		  AND (@productoID IS NULL OR productoID = @productoID)
          AND (@ordenCompraID IS NULL OR ordenCompraID = @ordenCompraID)
          AND (@fechaRecepcion IS NULL OR fechaRecepcion = @fechaRecepcion);

        SET @mensajeSalida = 'Consulta realizada exitosamente.';
        SET @idMensajeSalida = 0;

        -- Mensaje de salida como resultado
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH
        
		SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END CATCH;
END;
GO
