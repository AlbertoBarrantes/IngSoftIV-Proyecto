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
