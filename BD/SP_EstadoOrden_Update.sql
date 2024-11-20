

DROP PROCEDURE IF EXISTS SP_EstadoOrden_Update;
GO


CREATE PROCEDURE SP_EstadoOrden_Update
    @idEstadoOrden INT,
    @nombre VARCHAR(45),
    @descripcion VARCHAR(255),
    @mensajesalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica el id de estado
        IF NOT EXISTS (SELECT 1 FROM EstadoOrden WHERE idEstadoOrden = @idEstadoOrden)
        BEGIN
            ROLLBACK TRANSACTION;
            SET @mensajeSalida = 'No se encontró un estado con el ID proporcionado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 1;
            RETURN;
        END
        ELSE
        BEGIN
            UPDATE EstadoOrden
            SET nombre = @nombre,
                descripcion = @descripcion
            WHERE idEstadoOrden = @idEstadoOrden;
            
            COMMIT TRANSACTION;
            SET @mensajeSalida = 'El estado ha sido actualizado correctamente.';
            SET @idMensajeSalida = 0;
        END

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;

    END CATCH;
END;
GO


/*

EXEC SP_EstadoOrden_Update
    '1',
    'Pendiente', 
    'Orden en espera de procesamiento'
    
SELECT * FROM EstadoOrden

*/