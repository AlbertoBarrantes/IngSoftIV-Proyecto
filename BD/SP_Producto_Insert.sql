DROP PROCEDURE IF EXISTS SP_Producto_Insert;
GO

CREATE PROCEDURE SP_Producto_Insert
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

        -- Validación de stock negativo
        IF (@stock < 0)
        BEGIN
            SET @mensajeSalida = 'El stock no puede ser negativo, no se ha ingresado el nuevo producto.';
            SET @idMensajeSalida = 1;
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validación de código de barras duplicado
        IF EXISTS (SELECT 1 FROM Producto WHERE codigoBarras = @codigoBarras)
        BEGIN
            SET @mensajeSalida = 'El código de barras ya existe, no se ha ingresado el nuevo producto.';
            SET @idMensajeSalida = 2;
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        -- Insertar si las validaciones son exitosas
        INSERT INTO Producto (codigoBarras, descripcion, unidadMedida, peso, dimension, numeroLote, stock)
        VALUES (@codigoBarras, @descripcion, @unidadMedida, @peso, @dimension, @numeroLote, @stock);
        
        COMMIT TRANSACTION;

        SET @mensajeSalida = 'Se ha ingresado el nuevo producto.';
        SET @idMensajeSalida = 0;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;
    END CATCH;
END;
GO

SELECT * FROM Producto