

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
    @stock INT,
    @mensajeSalida VARCHAR(255) OUTPUT,
    @idMensajeSalida INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validación: El stock no puede ser negativo
        IF (@stock < 0)
        BEGIN
            SET @mensajeSalida = 'El stock no puede ser negativo, no se ha actualizado el producto.';
            SET @idMensajeSalida = 1;
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validación: Código de barras duplicado excluyendo el producto actual
        IF EXISTS (SELECT 1 
                   FROM Producto 
                   WHERE codigoBarras = @codigoBarras AND idProducto != @idProducto)
        BEGIN
            SET @mensajeSalida = 'El código de barras ya existe en otro producto, no se ha actualizado el producto.';
            SET @idMensajeSalida = 2;
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validación: Verificar si el producto existe
        IF NOT EXISTS (SELECT 1 FROM Producto WHERE idProducto = @idProducto)
        BEGIN
            SET @mensajeSalida = 'El ID del producto no existe, no se ha actualizado el producto.';
            SET @idMensajeSalida = 3;
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Actualizar producto
        UPDATE Producto
        SET codigoBarras = @codigoBarras,
            descripcion = @descripcion,
            unidadMedida = @unidadMedida,
            peso = @peso,
            dimension = @dimension,
            numeroLote = @numeroLote,
            stock = @stock
        WHERE idProducto = @idProducto;

        COMMIT TRANSACTION;

        SET @mensajeSalida = 'Producto actualizado exitosamente.';
        SET @idMensajeSalida = 0;
    
	END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        -- Capturar error del sistema
        SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;
    END CATCH;
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
	

	
	
	
	