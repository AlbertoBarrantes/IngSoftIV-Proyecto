


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

        SET @mensajeSalida = 'Consulta realizada exitosamente.';
        SET @idMensajeSalida = 0;

        -- Mensaje de salida
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH

        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        -- Mensaje de error
        SELECT @mensajeError AS Mensaje, -1 AS Código;

    END CATCH;

END;
GO
