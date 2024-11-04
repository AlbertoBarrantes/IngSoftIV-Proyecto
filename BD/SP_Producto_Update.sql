

DROP PROCEDURE IF EXISTS SP_Producto_Update;
GO

CREATE PROCEDURE SP_Producto_Update
    @idProducto INT,
    @codigoBarras VARCHAR(45),
    @descripcion VARCHAR(255),
    @unidadMedida VARCHAR(45),
    @peso DECIMAL(10,2),
    @dimension VARCHAR(45),
    @numeroLote VARCHAR(45),
    @stock INT
AS
BEGIN

	DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;
	BEGIN TRY

		UPDATE Producto
		SET codigoBarras = @codigoBarras,
			descripcion = @descripcion,
			unidadMedida = @unidadMedida,
			peso = @peso,
			dimension = @dimension,
			numeroLote = @numeroLote,
			stock = @stock
		WHERE idProducto = @idProducto;

		IF @@ROWCOUNT > 0
		BEGIN
            SET @mensajeSalida = 'Producto actualizado.';
            SET @idMensajeSalida = 0;
        END
        ELSE
        BEGIN
            SET @mensajeSalida = 'El producto no fue actualizado';
            SET @idMensajeSalida = 1;
        END

		SELECT @mensajeSalida AS mensaje, @idMensajeSalida AS codigo;
	END TRY
	BEGIN CATCH
		DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

		SELECT @mensajeError AS mensaje, -1 AS codigo;
	END CATCH
END;
GO


/*
EXEC SP_Producto_Update
	@idProducto = 2,
    @codigoBarras = '7501001234567',
    @descripcion = 'Coca Cola 600ml',
    @unidadMedida = 'ml',
    @peso = 600.00,
    @dimension = '20x10x5 cm',
    @numeroLote = 'A12345',
    @stock = 100;

	SELECT * FROM Producto;
*/
	

	
	
	
	