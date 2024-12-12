

DROP PROCEDURE IF EXISTS SP_Ubicacion_Select;
GO


CREATE PROCEDURE SP_Ubicacion_Select
    @productoID INT = NULL,
    @pasillo VARCHAR(45) = NULL,
    @estante VARCHAR(45) = NULL
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY

        SET @productoID = NULLIF(@productoID,'');

        -- Consulta con filtros opcionales
        SELECT idUbicacion, productoID, pasillo, estante
        FROM Ubicacion
        WHERE (@productoID IS NULL OR productoID = @productoID)
          AND (@pasillo IS NULL OR pasillo LIKE '%' + @pasillo + '%')
          AND (@estante IS NULL OR estante LIKE '%' + @estante + '%');

		IF @@ROWCOUNT > 0
		BEGIN
			SET @mensajeSalida = 'Consulta realizada, se encontraron resultados';
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
