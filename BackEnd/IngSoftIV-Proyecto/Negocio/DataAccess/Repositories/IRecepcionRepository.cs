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


//CREATE TABLE Recepcion (
//	  idRecepcion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
//    productoID INT NOT NULL,
//    ordenCompraID INT NOT NULL,
//    cantidad INT NOT NULL,
//    fechaRecepcion DATE NOT NULL,
//    FOREIGN KEY (productoID) REFERENCES Producto(idProducto) ON DELETE CASCADE,
//    FOREIGN KEY (ordenCompraID) REFERENCES OrdenCompra(idOrdenCompra) ON DELETE CASCADE
//);