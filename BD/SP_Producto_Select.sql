

DROP PROCEDURE IF EXISTS SP_Producto_Select;
GO

CREATE PROCEDURE SP_Producto_Select
    @codigoBarras VARCHAR(45) = NULL,
    @descripcion VARCHAR(255) = NULL
AS
BEGIN
    
	DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        
		SET @codigoBarras = NULLIF(@codigoBarras, '');
        SET @descripcion = NULLIF(@descripcion, '');

        SELECT *
        FROM Producto
        WHERE (codigoBarras = @codigoBarras OR @codigoBarras IS NULL)
          AND (descripcion LIKE '%' + @descripcion + '%' OR @descripcion IS NULL);

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

        SELECT @mensajeSalida AS mensaje, @idMensajeSalida AS codigo;

    END TRY
    BEGIN CATCH
        
        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        SELECT @mensajeError AS mensaje, -1 AS codigo;
    END CATCH;
END;
GO




/*

EXEC SP_Producto_Select '',''

*/


