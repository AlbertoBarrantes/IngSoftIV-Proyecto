


-- prueba OrdenCompra insert
EXEC SP_OrdenCompra_Insert
    '1',                            -- estadoOrdenID
    'Distribuidora Alimentos S.A.', -- proveedor
    '2024-10-05'                    -- fechaOrden



SELECT * FROM EstadoOrden

SELECT * FROM OrdenCompra



-- prueba OrdenCompra update
EXEC SP_OrdenCompra_Update
    '4',            -- @idOrdenCompra
    '5',            -- @estadoOrdenID
    'ACMEXYZ',         -- @proveedor
    '2025-10-05'    -- @fechaOrden

SELECT * FROM EstadoOrden

SELECT * FROM OrdenCompra



-- prueba SP_OrdenCompra_Delete
EXEC SP_OrdenCompra_Delete
    '5'          --idOrdenCompra

SELECT * FROM OrdenCompra



-- prueba SP_OrdenCompra_Select
EXEC SP_OrdenCompra_Select
    '',         -- idEstadoOrden
    's.a',         -- proveedor
    ''          -- fechaOrden

SELECT * FROM OrdenCompra


