






-- crear la base de datos
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AlmacenDB')
BEGIN
	CREATE DATABASE AlmacenDB;
	PRINT 'La base de datos fue creada exitosamente';
END
ELSE
BEGIN
	PRINT 'La base de datos ya existe.';
END
GO





USE AlmacenDB;
GO





-- xProducto
CREATE TABLE Producto (
	idProducto INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	codigoBarras VARCHAR(45) NOT NULL UNIQUE,
	descripcion VARCHAR(255) NOT NULL,
	unidadMedida VARCHAR(45) NOT NULL,
	peso DECIMAL(10,2) NOT NULL,
	dimension VARCHAR(45) NOT NULL,
	numeroLote VARCHAR(45) NOT NULL,
	stock INT NOT NULL DEFAULT 0
);






-- xEstadoOrden
CREATE TABLE EstadoOrden (
	idEstadoOrden INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(45) NOT NULL,
	descripcion VARCHAR(255) NOT NULL
);





-- xOrdenCompra
CREATE TABLE OrdenCompra (
	idOrdenCompra INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	estadoOrdenID INT NOT NULL,
	proveedor VARCHAR(100) NOT NULL,
	fechaOrden DATE NOT NULL,
	FOREIGN KEY (estadoOrdenID) REFERENCES EstadoOrden(idEstadoOrden) ON DELETE CASCADE
);





-- xUbicacion
CREATE TABLE Ubicacion (
	idUbicacion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	productoID INT NOT NULL,
	pasillo VARCHAR(45) NOT NULL,
	estante VARCHAR(45) NOT NULL,
	FOREIGN KEY (productoID) REFERENCES Producto(idProducto)
);





-- xRecepcion
CREATE TABLE Recepcion (
	idRecepcion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	productoID INT NOT NULL,
	ordenCompraID INT NOT NULL,
	cantidad INT NOT NULL,
	fechaRecepcion DATE NOT NULL,
	FOREIGN KEY (productoID) REFERENCES Producto(idProducto) ON DELETE CASCADE,
	FOREIGN KEY (ordenCompraID) REFERENCES OrdenCompra(idOrdenCompra) ON DELETE CASCADE
);





-- xAlmacenamiento
CREATE TABLE Almacenamiento (
	idAlmacenamiento INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ubicacionID INT NOT NULL,
	recepcionID INT NOT NULL,
	cantidadAlmacenada INT NOT NULL,
	FOREIGN KEY (ubicacionID) REFERENCES Ubicacion(idUbicacion) ON DELETE CASCADE,
	FOREIGN KEY (recepcionID) REFERENCES  Recepcion(idRecepcion) ON DELETE CASCADE
);


PRINT 'Tablas creadas';
GO