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

        SET @productoID = NULLIF(@productoID, '');
		SET @pasillo = NULLIF(@pasillo,'');
		SET @estante = NULLIF(@estante,'');

        SELECT 
            u.idUbicacion,
            u.productoID,
            p.descripcion AS productoDescripcion,
            u.pasillo,
            u.estante
        FROM Ubicacion u
        INNER JOIN Producto p ON u.productoID = p.idProducto
        WHERE (@productoID IS NULL OR u.productoID = @productoID)
          AND (@pasillo IS NULL OR u.pasillo LIKE '%' + @pasillo + '%')
          AND (@estante IS NULL OR u.estante LIKE '%' + @estante + '%');

        -- Validación
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

        -- Mensaje de salida
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH
        SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;
    END CATCH;
END;
GO


EXEC SP_Ubicacion_Select;