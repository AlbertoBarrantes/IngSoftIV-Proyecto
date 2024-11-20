

DROP PROCEDURE IF EXISTS SP_Ubicacion_Update;
GO


CREATE PROCEDURE SP_Ubicacion_Update
    @idUbicacion INT,
    @productoID INT,
    @pasillo VARCHAR(45),
    @estante VARCHAR(45),
	@mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si la ubicación existe
        IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE idUbicacion = @idUbicacion)
        BEGIN
            SET @mensajeSalida = 'No se encontró una ubicación con el ID proporcionado, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 1;
			ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verifica si el producto existe en Producto
        IF NOT EXISTS (SELECT 1 FROM Producto WHERE idProducto = @productoID)
        BEGIN
            SET @mensajeSalida = 'El producto no existe, no se ha actualizado ningún registro.';
            SET @idMensajeSalida = 2;
			ROLLBACK TRANSACTION;
            RETURN;
        END
        
        -- Actualiza ubicacion
        UPDATE Ubicacion
        SET productoID = @productoID,
            pasillo = @pasillo,
            estante = @estante
        WHERE idUbicacion = @idUbicacion;

        COMMIT TRANSACTION;

		SET @mensajeSalida = 'La ubicación ha sido actualizada correctamente.';
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
SELECT * FROM Ubicacion
*/