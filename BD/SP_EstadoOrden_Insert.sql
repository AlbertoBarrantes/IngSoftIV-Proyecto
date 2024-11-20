

DROP PROCEDURE IF EXISTS SP_EstadoOrden_Insert;
GO


CREATE PROCEDURE SP_EstadoOrden_Insert
    @nombre VARCHAR(45),
    @descripcion VARCHAR(255),
	@mensajeSalida VARCHAR(255) OUT,
	@idmensajeSalida INT OUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el nombre de EstadoOrden ya existe
        IF EXISTS (SELECT 1 FROM EstadoOrden WHERE nombre = @nombre)
        BEGIN
            SET @mensajeSalida = 'El nombre del estado ya existe, no se ha ingresado un nuevo estado.';
            SET @idMensajeSalida = 1;
			ROLLBACK TRANSACTION;
			RETURN;
        END
        
		-- Insert        
        INSERT INTO EstadoOrden (nombre, descripcion)
        VALUES (@nombre, @descripcion);
		COMMIT TRANSACTION;
        SET @mensajeSalida = 'Se ha ingresado el nuevo estado.';
        SET @idMensajeSalida = 0;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
		SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;
    
	END CATCH;
END;
GO


/*

EXEC SP_EstadoOrden_Insert
    'Pendiente', 
    'Orden en espera de procesamiento'

EXEC SP_EstadoOrden_Insert
    'En Proceso', 
    'Orden actualmente en preparación'

SELECT * FROM EstadoOrden

*/