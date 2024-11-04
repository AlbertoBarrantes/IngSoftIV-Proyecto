

DROP PROCEDURE IF EXISTS SP_Producto_Insert;
GO

CREATE PROCEDURE SP_Producto_Insert
    @codigoBarras VARCHAR(45),
    @descripcion VARCHAR(255),
    @unidadMedida VARCHAR(45),
    @peso DECIMAL(10,2),
    @dimension VARCHAR(45),
    @numeroLote VARCHAR(45),
    @stock INT
AS
BEGIN
	
	DECLARE @mensajeSalida VARCHAR(255)
	DECLARE @idMensajeSalida INT
    
	BEGIN TRY
        BEGIN TRANSACTION;

		-- inserta solo si el codigo de barras no existe previamente
		IF EXISTS (SELECT codigoBarras FROM Producto WHERE codigoBarras = @codigoBarras)
		BEGIN
			SET @mensajeSalida = 'El código de barras ya existe, no se ha ingresado el nuevo producto.';
			SET @idMensajeSalida = 1;
		END
		ELSE
		BEGIN
			INSERT INTO Producto (codigoBarras, descripcion, unidadMedida, peso, dimension, numeroLote, stock)
			VALUES (@codigoBarras, @descripcion, @unidadMedida, @peso, @dimension, @numeroLote, @stock);
			
			SET @mensajeSalida = 'Se ha ingresado el nuevo producto.';
			SET @idMensajeSalida = 0;
		END

        COMMIT TRANSACTION;

		-- mensaje de salida
		SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

		DECLARE @mensajeError VARCHAR(500)
		SET @mensajeError = ERROR_MESSAGE()

		-- mensaje de error
		SELECT @mensajeError AS mensaje, -1 AS codigo

    END CATCH;
END;
GO



/*
EXEC SP_Producto_Insert
	'7501001234567', 
	'Coca Cola 600ml', 
	'ml', 
	600.00, 
	'20x10x5 cm', 
	'A12345', 
	100;
*/
