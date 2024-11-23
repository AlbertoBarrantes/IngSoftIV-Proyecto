using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Negocio.DTOs;
using Negocio.Entities;

namespace Negocio.DataAccess.Repositories
{
    public interface IOrdenCompraRepository
    {

        // GET
        Task<List<OrdenCompra>> ConsultarOrdenCompra(int? id, int? estadoOrdenID, string? proveedor, DateOnly? fechaOrden);

        // POST
        Task<Respuesta> CrearOrdenCompra(OrdenCompra ordenCompra);

        // PUT
        Task<Respuesta> ActualizarOrdenCompra(int id, OrdenCompra ordenCompra);

        // DELETE
        Task<Respuesta> EliminarOrdenCompra(int id);

    }
}
