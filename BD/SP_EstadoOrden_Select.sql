


DROP PROCEDURE IF EXISTS SP_EstadoOrden_Select;
GO



CREATE PROCEDURE SP_EstadoOrden_Select
    @nombre VARCHAR(45) = NULL,
    @descripcion VARCHAR(255) = NULL
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY

        SET @nombre = NULLIF(@nombre,'');
        SET @descripcion = NULLIF(@descripcion,'');
        
        SELECT idEstadoOrden, nombre, descripcion
        FROM EstadoOrden
        WHERE (@nombre IS NULL OR nombre LIKE '%' + @nombre + '%')
          AND (@descripcion IS NULL OR descripcion LIKE '%' + @descripcion + '%');

        SET @mensajeSalida = 'Consulta realizada exitosamente.';
        SET @idMensajeSalida = 0;

        -- mensaje de salida
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH

        SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END CATCH;
END;
GO



/*

EXEC SP_EstadoOrden_Select
    '',
    ''

SELECT * FROM EstadoOrden


*/