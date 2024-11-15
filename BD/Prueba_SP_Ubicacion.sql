


EXEC SP_Ubicacion_Insert
    11,          -- productoID INT
    'A1',       -- pasillo VARCHAR(45)
    'Estante 3' --estante VARCHAR(45)

SELECT * FROM Producto

SELECT * FROM Ubicacion


-------------------------------------------------------------------

SELECT * FROM Ubicacion

EXEC SP_Ubicacion_Update
    1,              --@idUbicacion INT,
    11,             --@productoID INT,
    'B11',          --@pasillo VARCHAR(45),
    'Estante 11'   --@estante VARCHAR(45)

SELECT * FROM Ubicacion

-------------------------------------------------------------------

SELECT * FROM Ubicacion

EXEC SP_Ubicacion_Delete
    1  --@idUbicacion INT

SELECT * FROM Ubicacion

-------------------------------------------------------------------

SELECT * FROM UBICACION

EXEC SP_Ubicacion_Select
    '4',     --@productoID INT
    'D3',     --@pasillo VARCHAR(45)
    'Estante 7'      --@estante VARCHAR(45)






