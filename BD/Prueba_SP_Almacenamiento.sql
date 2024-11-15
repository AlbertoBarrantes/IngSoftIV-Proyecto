
SELECT * FROM Ubicacion
SELECT * FROM Recepcion



SELECT * FROM Almacenamiento

EXEC SP_Almacenamiento_Insert
    '4',        --@ubicacionID INT,
    '3',        --@recepcionID INT,
    '99'        --@cantidadAlmacenada INT

SELECT * FROM Almacenamiento



-------------------------------------------------------------------



SELECT * FROM Almacenamiento

EXEC SP_Almacenamiento_Update
    '4',         --@idAlmacenamiento INT,
    '3',         --@ubicacionID INT,
    '2',         --@recepcionID INT,
    '66'          --@cantidadAlmacenada INT

SELECT * FROM Almacenamiento



-------------------------------------------------------------------



SELECT * FROM Almacenamiento

EXEC SP_Almacenamiento_Delete
    '4'           --@idAlmacenamiento INT

SELECT * FROM Almacenamiento



-------------------------------------------------------------------



SELECT * FROM Almacenamiento

EXEC SP_Almacenamiento_Select
    '',         --@ubicacionID INT = NULL,
    '',         --@recepcionID INT = NULL,
    '150'         --@cantidadAlmacenada INT = NULL

