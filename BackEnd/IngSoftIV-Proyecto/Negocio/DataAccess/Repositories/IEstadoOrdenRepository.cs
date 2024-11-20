using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Negocio.DTOs;
using Negocio.Entities;

namespace Negocio.DataAccess.Repositories
{
    public interface IEstadoOrdenRepository
    {

        // GET
        Task<List<EstadoOrden>> ObtenerEstadoOrden(string? nombre, string? descripcion);

        // POST
        Task<Respuesta> InsertarEstadoOrden(EstadoOrden estadoOrden);
        
        // PUT
        Task<Respuesta> ActualizarEstadoOrden(EstadoOrden estadoOrden);

        // DELETE
        Task<Respuesta> EliminarEstadoOrden(int idEstadoOrden);

    }
    
}