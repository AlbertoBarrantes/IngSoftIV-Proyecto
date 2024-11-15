


DROP PROCEDURE IF EXISTS SP_Ubicacion_Insert;
GO



CREATE PROCEDURE SP_Ubicacion_Insert
    @productoID INT,
    @pasillo VARCHAR(45),
    @estante VARCHAR(45)

AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY

        BEGIN TRANSACTION;

        -- Verifica si el producto existe antes de agregar la ubicaci�n
        IF NOT EXISTS (SELECT 1 FROM Producto WHERE idProducto = @productoID)
        BEGIN
            SET @mensajeSalida = 'El producto especificado no existe. Verifique el producto antes de proceder.';
            SET @idMensajeSalida = 1;
        END
        ELSE
        BEGIN
            -- Inserta una nueva ubicaci�n si el producto es v�lido
            INSERT INTO Ubicacion (productoID, pasillo, estante)
            VALUES (@productoID, @pasillo, @estante);

            SET @mensajeSalida = 'La ubicaci�n ha sido ingresada correctamente.';
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
