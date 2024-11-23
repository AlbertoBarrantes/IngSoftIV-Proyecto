using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Negocio.DataAccess.Contexts;
using Negocio.DTOs;
using Negocio.Entities;
using static System.Runtime.InteropServices.JavaScript.JSType;
using static Azure.Core.HttpHeader;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Model;

namespace Negocio.DataAccess.Repositories
{
    public class RecepcionRepository : IRecepcionRepository
    {

        private readonly AppDbContext _context;

        public RecepcionRepository(AppDbContext context)
        {
            _context = context;
        }




        // GET
        public async Task<List<Recepcion>> ConsultarRecepcion(int? idRecepcion, int? productoID, int? ordenCompraID, DateTime? fechaRecepcion)
        {

            try
            {
                var recepciones = await _context.Recepcion.FromSqlRaw(
                    "EXEC SP_Recepcion_Select @idRecepcion = {0}, @productoID = {1}, @ordenCompraID = {2}, @fechaRecepcion = {3}",
                    idRecepcion ?? (object)DBNull.Value,
                    productoID ?? (object)DBNull.Value,
                    ordenCompraID ?? (object)DBNull.Value,
                    fechaRecepcion ?? (object)DBNull.Value
                    ).ToListAsync();
                return recepciones;
            }
            catch
            {
                return new List<Recepcion>();
            }

        }





        // POST
        public async Task<Respuesta> CrearRecepcion(RecepcionRequest recepcion)
        {
            var respuesta = new Respuesta();

            try
            {
                var mensajeSalida = new Microsoft.Data.SqlClient.SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new Microsoft.Data.SqlClient.SqlParameter("@idMensajeSalida", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Recepcion_Insert @productoID = {0}, @ordenCompraID = {1}, @cantidad = {2}, @fechaRecepcion = {3}, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    recepcion.productoID,
                    recepcion.ordenCompraID,
                    recepcion.cantidad,
                    recepcion.fechaRecepcion,
                    mensajeSalida,
                    codigoSalida
                    );
                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();


            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al insertar nueva recepcion: {ex.Message}";
            }

            return respuesta;
        }





        // PUT
        public async Task<Respuesta> ActualizarRecepcion(int idRecepcion, RecepcionRequest recepcion)
        {
            var respuesta = new Respuesta();

            try
            {
                var mensajeSalida = new Microsoft.Data.SqlClient.SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new Microsoft.Data.SqlClient.SqlParameter("@idMensajeSalida", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Recepcion_Update @idRecepcion = {0}, @productoID = {1}, @ordenCompraID = {2}, @cantidad = {3}, @fechaRecepcion = {4}, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    idRecepcion,
                    recepcion.productoID,
                    recepcion.ordenCompraID,
                    recepcion.cantidad,
                    recepcion.fechaRecepcion,
                    mensajeSalida,
                    codigoSalida
                    );
                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();
            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al actualizar recepcion: {ex.Message}";
            }

            return respuesta;
        }





        // DELETE
        public async Task<Respuesta> EliminarRecepcion(int idRecepcion)
        {

            var respuesta = new Respuesta();

            try
            {
                var mensajeSalida = new Microsoft.Data.SqlClient.SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new Microsoft.Data.SqlClient.SqlParameter("@idMensajeSalida", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Recepcion_Delete @idRecepcion = {0}, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    idRecepcion,
                    mensajeSalida,
                    codigoSalida
                    );
                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();
            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al eliminar recepcion: {ex.Message}";


            }

            return respuesta;

        }



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