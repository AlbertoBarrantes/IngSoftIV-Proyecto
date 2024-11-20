using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Negocio.DataAccess.Contexts;
using Negocio.DTOs;
using Negocio.Entities;

namespace Negocio.DataAccess.Repositories
{
    public class EstadoOrdenRepository : IEstadoOrdenRepository
    {

        private readonly AppDbContext _context;

        // Constructor
        public EstadoOrdenRepository(AppDbContext context)
        {
            _context = context;
        }





        //Insertar
        public async Task<Respuesta> InsertarEstadoOrden(EstadoOrden estadoOrden)
        {

            var respuesta = new Respuesta();

            try
            {

                var mensajeSalida = new SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

                // Ejecuta el SP
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_EstadoOrden_Insert @nombre = @nombre, @descripcion = @descripcion, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    new SqlParameter("@nombre", estadoOrden.nombre),
                    new SqlParameter("@descripcion", estadoOrden.descripcion),
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();

            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al insertar nuevo estado de la orden: {ex.Message}";
            }

            return respuesta;
        }





        //Actualizar
        public async Task<Respuesta> ActualizarEstadoOrden(EstadoOrden estadoOrden)
        {
            var respuesta = new Respuesta();

            try
            {

                var mensajeSalida = new SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

                // Ejecuta el SP
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_EstadoOrden_Update @idEstadoOrden = @idEstadoOrden, @nombre = @nombre, @descripcion = @descripcion, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    new SqlParameter("@idEstadoOrden", estadoOrden.idEstadoOrden),
                    new SqlParameter("@nombre", estadoOrden.nombre),
                    new SqlParameter("@descripcion", estadoOrden.descripcion),
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();

            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al actualizar el estado de la orden: {ex.Message}";
            }

            return respuesta;

        }





        // Eliminar
        public async Task<Respuesta> EliminarEstadoOrden(int idEstadoOrden)
        {

            var respuesta = new Respuesta();

            try
            {

                var mensajeSalida = new SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

                // Ejecuta el SP
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_EstadoOrden_Delete @idEstadoOrden = @idEstadoOrden, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    new SqlParameter("@idEstadoOrden", idEstadoOrden),
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();

            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al eliminar el estado de la orden: {ex.Message}";
            }

            return respuesta;

        }





        // Obtener
        public async Task<List<EstadoOrden>> ObtenerEstadoOrden(string? nombre, string? descripcion)
        {
            try
            {
                // Ejecuta el SP
                var estados = await _context.EstadoOrden.FromSqlRaw(
                    "EXEC SP_EstadoOrden_Select @nombre = {0}, @descripcion = {1}",
                    nombre ?? (object)DBNull.Value,
                    descripcion ?? (object)DBNull.Value
                ).ToListAsync();

                return estados;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al obtener los estados: {ex.Message}");
                return new List<EstadoOrden>(); // Retorna lista vacía si ocurre un error
            }

        }



    }
}


// TABLE EstadoOrden
//	  idEstadoOrden INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
//    nombre VARCHAR(45) NOT NULL,
//    descripcion VARCHAR(255) NOT NULL