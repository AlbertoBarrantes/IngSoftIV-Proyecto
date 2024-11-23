

DROP PROCEDURE IF EXISTS SP_OrdenCompra_Select;
GO


CREATE PROCEDURE SP_OrdenCompra_Select
    @idOrdenCompra INT = NULL,
    @estadoOrdenID INT = NULL,
    @proveedor VARCHAR(100) = NULL,
    @fechaOrden DATE = NULL
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        
        SET @idOrdenCompra = NULLIF(@idOrdenCompra,'');
        SET @estadoOrdenID = NULLIF(@estadoOrdenID,'');
        SET @proveedor = NULLIF(@proveedor,'');
        SET @fechaOrden = NULLIF(@fechaOrden,'');

        SELECT idOrdenCompra, estadoOrdenID, proveedor, fechaOrden
        FROM OrdenCompra
        WHERE (@idOrdenCompra IS NULL OR idOrdenCompra = @idOrdenCompra)
          AND (@estadoOrdenID IS NULL OR estadoOrdenID = @estadoOrdenID)
          AND (@proveedor IS NULL OR proveedor LIKE '%' + @proveedor + '%')
          AND (@fechaOrden IS NULL OR fechaOrden = @fechaOrden);

        SET @mensajeSalida = 'Consulta realizada exitosamente.';
        SET @idMensajeSalida = 0;

        -- mensaje de salida
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH

        SET @mensajeSalida = ERROR_MESSAGE();
        SET @idMensajeSalida = -1;
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END CATCH;
END;
GO


/*
SELECT * FROM OrdenCompra;
*/