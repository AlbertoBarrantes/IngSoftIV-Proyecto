


DROP PROCEDURE IF EXISTS SP_EstadoOrden_Update;
GO



CREATE PROCEDURE SP_EstadoOrden_Update
    @idEstadoOrden INT,
    @nombre VARCHAR(45),
    @descripcion VARCHAR(255)
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- revisa si existe el id
        IF NOT EXISTS (SELECT 1 FROM EstadoOrden WHERE idEstadoOrden = @idEstadoOrden)
        BEGIN
            SET @mensajeSalida = 'No se encontró un estado con el ID proporcionado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 1;
        END
        ELSE
        BEGIN
            UPDATE EstadoOrden
            SET nombre = @nombre,
                descripcion = @descripcion
            WHERE idEstadoOrden = @idEstadoOrden;

            SET @mensajeSalida = 'El estado ha sido actualizado correctamente.';
            SET @idMensajeSalida = 0;
        END

        COMMIT TRANSACTION;

        -- Mensaje de salida
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        -- Mensaje de salida de error
        SELECT @mensajeError AS Mensaje, -1 AS Código;
    END CATCH;

    RETURN @idMensajeSalida;

END;
GO



/*

EXEC SP_EstadoOrden_Update
    '1',
    'Pendiente', 
    'Orden en espera de procesamiento'
    
SELECT * FROM EstadoOrden

*/