DROP PROCEDURE IF EXISTS SP_EstadoProducto_Insert;
GO

CREATE PROCEDURE SP_EstadoProducto_Insert
    @nombre VARCHAR(45),
    @descripcion VARCHAR(255)
AS
BEGIN
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        INSERT INTO EstadoProducto (nombre, descripcion)
        VALUES (@nombre, @descripcion);

        SET @mensajeSalida = 'Nuevo estado de producto insertado';
        SET @idMensajeSalida = 0;

        SELECT @mensajeSalida AS mensaje, @idMensajeSalida AS codigo;

    END TRY
    BEGIN CATCH
        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        SELECT @mensajeError AS mensaje, -1 AS codigo;
    END CATCH;
END;
GO
