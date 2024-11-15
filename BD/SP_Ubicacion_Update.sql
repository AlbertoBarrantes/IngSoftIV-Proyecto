


DROP PROCEDURE IF EXISTS SP_Ubicacion_Update;
GO



CREATE PROCEDURE SP_Ubicacion_Update
    @idUbicacion INT,
    @productoID INT,
    @pasillo VARCHAR(45),
    @estante VARCHAR(45)
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si la ubicaci�n existe
        IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @idUbicacion)
        BEGIN
            SET @mensajeSalida = 'No se encontr� una ubicaci�n con el ID proporcionado, no se ha actualizado ning�n registro.';
            SET @idMensajeSalida = 1;
        END
        -- Verifica si el producto existe en Producto
        ELSE IF NOT EXISTS (SELECT 1 FROM Producto WHERE idProducto = @productoID)
        BEGIN
            SET @mensajeSalida = 'El producto especificado no existe, no se ha actualizado ning�n registro.';
            SET @idMensajeSalida = 2;
        END
        ELSE
        BEGIN
            -- Actualiza info
            UPDATE Ubicacion
            SET productoID = @productoID,
                pasillo = @pasillo,
                estante = @estante
            WHERE idUbicacion = @idUbicacion;

            SET @mensajeSalida = 'La ubicaci�n ha sido actualizada correctamente.';
            SET @idMensajeSalida = 0;
        END

        COMMIT TRANSACTION;

        -- Mensaje de salida
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS C�digo;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        -- Mensaje de error como resultado
        SELECT @mensajeError AS Mensaje, -1 AS C�digo;
    END CATCH;

    RETURN @idMensajeSalida;

END;
GO
