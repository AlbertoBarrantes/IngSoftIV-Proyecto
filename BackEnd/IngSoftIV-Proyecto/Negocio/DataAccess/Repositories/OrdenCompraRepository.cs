using Microsoft.EntityFrameworkCore;
using Negocio.DataAccess.Contexts;
using Negocio.DTOs;
using Negocio.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.DataAccess.Repositories
{
    public class OrdenCompraRepository : IOrdenCompraRepository
    {

        private readonly AppDbContext _context;

        public OrdenCompraRepository(AppDbContext context)
        {
            _context = context;
        }





        // Consultar
        public async Task<List<OrdenCompra>> ConsultarOrdenCompra(int? idOrdenCompra, int? estadoOrdenID, string? proveedor, DateOnly? fechaOrden)
        {
            try
            {
                
                proveedor = proveedor?.Trim();

                // Logs
                Console.WriteLine($"Parámetros: id={idOrdenCompra}, estadoOrdenID={estadoOrdenID}, proveedor='{proveedor}', fechaOrden={fechaOrden}");

                var ordenes = await _context.OrdenCompra.FromSqlRaw(
                    "EXEC SP_OrdenCompra_Select @idOrdenCompra = {0}, @estadoOrdenID = {1}, @proveedor = {2}, @fechaOrden = {3}",
                    idOrdenCompra ?? (object)DBNull.Value,
                    estadoOrdenID ?? (object)DBNull.Value,
                    proveedor ?? (object)DBNull.Value,
                    fechaOrden ?? (object)DBNull.Value
                ).ToListAsync();

                return ordenes;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al consultar órdenes: {ex.Message}");
                return new List<OrdenCompra>();
            }
        }





        // Crear
        public async Task<Respuesta> CrearOrdenCompra(OrdenCompra ordenCompra)
        {
            var respuesta = new Respuesta();

            try
            {
                var mensajeSalida = new Microsoft.Data.SqlClient.SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new Microsoft.Data.SqlClient.SqlParameter("@idMensajeSalida", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_OrdenCompra_Insert @estadoOrdenID = {0}, @proveedor = {1}, @fechaOrden = {2}, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    ordenCompra.estadoOrdenID,
                    ordenCompra.proveedor,
                    ordenCompra.fechaOrden,
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();
            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al insertar nueva orden de compra: {ex.Message}";
            }

            return respuesta;
        }





        // Actualizar
        public async Task<Respuesta> ActualizarOrdenCompra(int idOrdenCompra, OrdenCompra ordenCompra)
        {
            
            var respuesta = new Respuesta();

            try
            {
                var mensajeSalida = new Microsoft.Data.SqlClient.SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new Microsoft.Data.SqlClient.SqlParameter("@idMensajeSalida", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_OrdenCompra_Update @idOrdenCompra = {0}, @estadoOrdenID = {1}, @proveedor = {2}, @fechaOrden = {3}, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    idOrdenCompra,
                    ordenCompra.estadoOrdenID,
                    ordenCompra.proveedor,
                    ordenCompra.fechaOrden,
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();
            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al actualizar orden de compra: {ex.Message}";
            }

            return respuesta;
        }





        // Eliminar
        public async Task<Respuesta> EliminarOrdenCompra(int idOrdenCompra)
        {
            
            var respuesta = new Respuesta();

            try
            {
                var mensajeSalida = new Microsoft.Data.SqlClient.SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new Microsoft.Data.SqlClient.SqlParameter("@idMensajeSalida", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_OrdenCompra_Delete @idOrdenCompra = {0}, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    idOrdenCompra,
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();
            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al eliminar orden de compra: {ex.Message}";
            }

            return respuesta;
        }





    }
}
