


DROP PROCEDURE IF EXISTS SP_OrdenCompra_Select;
GO



CREATE PROCEDURE SP_OrdenCompra_Select
    @estadoOrdenID INT = NULL,
    @proveedor VARCHAR(100) = NULL,
    @fechaOrden DATE = NULL
AS
BEGIN

    DECLARE @mensajeSalida VARCHAR(255);
    DECLARE @idMensajeSalida INT;

    BEGIN TRY
        
        -- consulta con filtros
        SET @estadoOrdenID = NULLIF(@estadoOrdenID,'');
        SET @fechaOrden = NULLIF(@fechaOrden,'');

        SELECT idOrdenCompra, estadoOrdenID, proveedor, fechaOrden
        FROM OrdenCompra
        WHERE (@estadoOrdenID IS NULL OR estadoOrdenID = @estadoOrdenID)
          AND (@proveedor IS NULL OR proveedor LIKE '%' + @proveedor + '%')
          AND (@fechaOrden IS NULL OR fechaOrden = @fechaOrden);

        SET @mensajeSalida = 'Consulta realizada exitosamente.';
        SET @idMensajeSalida = 0;

        -- mensaje de salida
        SELECT @mensajeSalida AS Mensaje, @idMensajeSalida AS Código;

    END TRY
    BEGIN CATCH

        DECLARE @mensajeError VARCHAR(500);
        SET @mensajeError = ERROR_MESSAGE();

        -- mensaje de error
        SELECT @mensajeError AS Mensaje, -1 AS Código;

    END CATCH;

END;
GO
