


DROP PROCEDURE IF EXISTS SP_EstadoOrden_Insert;
GO



CREATE PROCEDURE SP_EstadoOrden_Insert
    @nombre VARCHAR(45),
    @descripcion VARCHAR(255)
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el nombre ya existe para evitar duplicados
        IF EXISTS (SELECT nombre FROM EstadoOrden WHERE nombre = @nombre)
        BEGIN
            SET @mensajeSalida = 'El nombre del estado ya existe, no se ha ingresado un nuevo estado.';
            SET @idMensajeSalida = 1;
        END
        ELSE
        BEGIN
            INSERT INTO EstadoOrden (nombre, descripcion)
            VALUES (@nombre, @descripcion);

            SET @mensajeSalida = 'Se ha ingresado el nuevo estado.';
            SET @idMensajeSalida = 0;
        END

        COMMIT TRANSACTION;

		SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @mensajeError VARCHAR(500)
		SET @mensajeError = ERROR_MESSAGE()

		SELECT @mensajeError AS mensaje, -1 AS codigo
    
	END CATCH;

    RETURN @idMensajeSalida;

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