using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Negocio.DTOs;
using Negocio.Entities;

namespace Negocio.DataAccess.Repositories
{
    public interface IAlmacenamientoRepository
    {

        // GET
        Task<List<Almacenamiento>> ConsultarAlmacenamiento(int? idAlmacenamiento, int? ubicacionID, int? recepcionID, int? cantidadAlmacenada);

        // POST
        Task<Respuesta> CrearAlmacenamiento(AlmacenamientoRequest almacenamiento);

        // PUT
        Task<Respuesta> ActualizarAlmacenamiento(int idAlmacenamiento, AlmacenamientoRequest almacenamiento);

        // DELETE
        Task<Respuesta> EliminarAlmacenamiento(int idAlmacenamiento);

    }
}


//CREATE TABLE Almacenamiento (
//	idAlmacenamiento INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
//    ubicacionID INT NOT NULL,
//    recepcionID INT NOT NULL,
//    cantidadAlmacenada INT NOT NULL,
//    FOREIGN KEY (ubicacionID) REFERENCES Ubicacion(idUbicacion) ON DELETE CASCADE,
//    FOREIGN KEY (recepcionID) REFERENCES  Recepcion(idRecepcion) ON DELETE CASCADE
//);