DROP PROCEDURE IF EXISTS SP_EstadoProducto_Select;
GO

CREATE PROCEDURE SP_EstadoProducto_Select
    @nombre VARCHAR(45) = NULL,
    @descripcion VARCHAR(255) = NULL
AS
BEGIN
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        SET @nombre = NULLIF(@nombre, '');
        SET @descripcion = NULLIF(@descripcion, '');

        SELECT *
        FROM EstadoProducto
        WHERE (nombre LIKE '%' + @nombre + '%' OR @nombre IS NULL)
          AND (descripcion LIKE '%' + @descripcion + '%' OR @descripcion IS NULL);

        IF @@ROWCOUNT > 0
        BEGIN
            SET @mensajeSalida = 'Consulta realizada exitosamente';
            SET @idMensajeSalida = 0;
        END
        ELSE
        BEGIN
            SET @mensajeSalida = 'No se encontraron estados de producto con los filtros especificados';
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

SP_EstadoProducto_Select '','';


SELECT * FROM EstadoProducto

*/