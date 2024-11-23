using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Negocio.DataAccess.Contexts;
using Negocio.DTOs;
using Negocio.Entities;

namespace Negocio.DataAccess.Repositories
{
    public class AlmacenamientoRepository : IAlmacenamientoRepository
    {

        private readonly AppDbContext _context;

        public AlmacenamientoRepository(AppDbContext context)
        {
            _context = context;
        }





        // GET
        public async Task<List<Almacenamiento>> ConsultarAlmacenamiento(int? idAlmacenamiento, int? ubicacionID, int? recepcionID, int? cantidadAlmacenada)
        {

            try
            {
                var almacenamientos = await _context.Almacenamiento.FromSqlRaw(
                    "EXEC SP_Almacenamiento_Select @idAlmacenamiento = {0}, @ubicacionID = {1}, @recepcionID = {2}, @cantidadAlmacenada = {3}",
                    idAlmacenamiento ?? (object)DBNull.Value,
                    ubicacionID ?? (object)DBNull.Value,
                    recepcionID ?? (object)DBNull.Value,
                    cantidadAlmacenada ?? (object)DBNull.Value
                    ).ToListAsync();
                return almacenamientos;
            }
            catch
            {
                return new List<Almacenamiento>();
            }

        }





        // POST
        public async Task<Respuesta> CrearAlmacenamiento(AlmacenamientoRequest almacenamiento)
        {
            var respuesta = new Respuesta();

            try
            {

                var mensajeSalida = new Microsoft.Data.SqlClient.SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new Microsoft.Data.SqlClient.SqlParameter("@idMensajeSalida", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Almacenamiento_Insert @ubicacionID = {0}, @recepcionID = {1}, @cantidadAlmacenada = {2}, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    almacenamiento.ubicacionID,
                    almacenamiento.recepcionID,
                    almacenamiento.cantidadAlmacenada,
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
        public async Task<Respuesta> ActualizarAlmacenamiento(int idAlmacenamiento, AlmacenamientoRequest almacenamiento)
        {
            var respuesta = new Respuesta();

            try
            {
                var mensajeSalida = new Microsoft.Data.SqlClient.SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new Microsoft.Data.SqlClient.SqlParameter("@idMensajeSalida", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Almacenamiento_Update @idAlmacenamiento = {0}, @ubicacionID = {1}, @recepcionID = {2}, @cantidadAlmacenada = {3}, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    idAlmacenamiento,
                    almacenamiento.ubicacionID,
                    almacenamiento.recepcionID,
                    almacenamiento.cantidadAlmacenada,
                    mensajeSalida,
                    codigoSalida
                    );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();

            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al actualizar almacenamiento: {ex.Message}";
            }

            return respuesta;
        }





        // DELETE
        public async Task<Respuesta> EliminarAlmacenamiento(int idAlmacenamiento)
        {
            var respuesta = new Respuesta();

            try
            {
                var mensajeSalida = new Microsoft.Data.SqlClient.SqlParameter("@mensajeSalida", System.Data.SqlDbType.VarChar, 255) { Direction = System.Data.ParameterDirection.Output };
                var codigoSalida = new Microsoft.Data.SqlClient.SqlParameter("@idMensajeSalida", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Almacenamiento_Delete @idAlmacenamiento = {0}, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    idAlmacenamiento,
                    mensajeSalida,
                    codigoSalida
                    );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();

            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al eliminar almacenamiento: {ex.Message}";
            }

            return respuesta;
        }





    }
}
