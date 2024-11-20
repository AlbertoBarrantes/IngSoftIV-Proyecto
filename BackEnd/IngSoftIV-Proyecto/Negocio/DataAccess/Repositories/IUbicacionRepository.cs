using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Negocio.DTOs;
using Negocio.Entities;

namespace Negocio.DataAccess.Repositories
{
    public interface IUbicacionRepository
    {


        // Obtener ubicacion filtrada
        Task<List<Ubicacion>> ObtenerUbicacionesFiltradas(int? productoID, string? pasillo, string? estante);

        // Insertar una ubicacion
        Task<Respuesta> InsertarUbicacion(Ubicacion ubicacion);

        // Actualizar una ubicacion
        Task<Respuesta> ActualizarUbicacion(Ubicacion ubicacion);

        // Eliminar una ubicacion
        Task<Respuesta> EliminarUbicacion(int idUbicacion);








    }
}
