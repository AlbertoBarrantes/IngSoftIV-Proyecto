using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Negocio.DTOs;
using Negocio.Entities;

namespace Negocio.DataAccess.Repositories
{
    public interface IRecepcionRepository
    {

        // GET
        Task<List<Recepcion>> ConsultarRecepcion(int? idRecepcion, int? productoID, int? ordenCompraID, DateTime? fechaRecepcion);

        // POST
        Task<Respuesta> CrearRecepcion(RecepcionRequest recepcion);

        // PUT
        Task<Respuesta> ActualizarRecepcion(int idRecepcion, RecepcionRequest recepcion);

        // DELETE
        Task<Respuesta> EliminarRecepcion(int idRecepcion);
    }
}
