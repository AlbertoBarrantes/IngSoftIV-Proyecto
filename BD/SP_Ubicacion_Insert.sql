

DROP PROCEDURE IF EXISTS SP_Ubicacion_Insert;
GO


CREATE PROCEDURE SP_Ubicacion_Insert
    @productoID INT,
    @pasillo VARCHAR(45),
    @estante VARCHAR(45),
	@mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verifica si el producto existe antes de agregar la ubicación
        IF NOT EXISTS (SELECT 1 FROM Producto WHERE idProducto = @productoID)
        BEGIN
            SET @mensajeSalida = 'El producto no existe. Verifique el producto antes de continuar.';
            SET @idMensajeSalida = 1;
			ROLLBACK TRANSACTION;
            RETURN;
        END
        
        -- Insertar si las validaciones son exitosas
        INSERT INTO Ubicacion (productoID, pasillo, estante)
        VALUES (@productoID, @pasillo, @estante);

        COMMIT TRANSACTION;

		SET @mensajeSalida = 'La ubicación ha sido ingresada correctamente.';
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