DROP PROCEDURE IF EXISTS SP_EstadoProducto_Update;
GO

CREATE PROCEDURE SP_EstadoProducto_Update
    @idEstadoProducto INT,
    @nombre VARCHAR(45),
    @descripcion VARCHAR(255)
AS
BEGIN
    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        UPDATE EstadoProducto
        SET nombre = @nombre,
            descripcion = @descripcion
        WHERE idEstadoProducto = @idEstadoProducto;

        IF @@ROWCOUNT > 0
        BEGIN
            SET @mensajeSalida = 'Estado de producto actualizado';
            SET @idMensajeSalida = 0;
        END
        ELSE
        BEGIN
            SET @mensajeSalida = 'No se encontró el estado del producto especificado';
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
