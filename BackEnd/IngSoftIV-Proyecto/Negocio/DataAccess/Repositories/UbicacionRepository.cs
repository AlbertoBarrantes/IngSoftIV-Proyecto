
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Negocio.DataAccess.Contexts;
using System.Data;
using Microsoft.Data.SqlClient;
using Negocio.Entities;
using Negocio.DTOs;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Negocio.DataAccess.Repositories
{
    public class UbicacionRepository : IUbicacionRepository
    {

        private readonly AppDbContext _context;

        // Constructor
        public UbicacionRepository(AppDbContext context)
        {
            _context = context;
        }





        // Insertar
        public async Task<Respuesta> InsertarUbicacion(Ubicacion ubicacion)
        {
            var respuesta = new Respuesta();

            try
            {

                var mensajeSalida = new SqlParameter("@mensajeSalida", SqlDbType.VarChar, 255) { Direction = ParameterDirection.Output };
                var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

                // Ejecuta el SP
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Ubicacion_Insert @productoID = @productoID, @pasillo = @pasillo, @estante = @estante, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    new SqlParameter("@productoID", ubicacion.productoID),
                    new SqlParameter("@pasillo", ubicacion.pasillo),
                    new SqlParameter("@estante", ubicacion.estante),

                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();

            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al insertar la ubicación: {ex.Message}";
            }

            return respuesta;
        }




        // Actualizar
        public async Task<Respuesta> ActualizarUbicacion(Ubicacion ubicacion)
        {
            var respuesta = new Respuesta();

            try
            {

                var mensajeSalida = new SqlParameter("@mensajeSalida", SqlDbType.VarChar, 255) { Direction = ParameterDirection.Output };
                var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

                // Ejecuta el SP
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Ubicacion_Update @idUbicacion = @idUbicacion, @productoID = @productoID, @pasillo = @pasillo, @estante = @estante, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    new SqlParameter("@idUbicacion", ubicacion.idUbicacion),
                    new SqlParameter("@productoID", ubicacion.productoID),
                    new SqlParameter("@pasillo", ubicacion.pasillo),
                    new SqlParameter("@estante", ubicacion.estante),
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();

            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al actualizar la ubicación: {ex.Message}";
            }

            return respuesta;

        }





        // Eliminar
        public async Task<Respuesta> EliminarUbicacion(int idUbicacion)
        {
            var respuesta = new Respuesta();

            try
            {

                var mensajeSalida = new SqlParameter("@mensajeSalida", SqlDbType.VarChar, 255) { Direction = ParameterDirection.Output };
                var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

                // Ejecuta el SP
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Ubicacion_Delete @idUbicacion = @idUbicacion, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    new SqlParameter("@idUbicacion", idUbicacion),
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();

            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al eliminar la ubicación: {ex.Message}";
            }

            return respuesta;

        }





        // Obtener ubicaciones filtradas
        public async Task<List<Ubicacion>> ObtenerUbicacionesFiltradas(int? productoID, string? pasillo, string? estante)
        {
            try
            {
                // Ejecuta el SP
                var ubicaciones = await _context.Ubicacion.FromSqlRaw(
                    "EXEC SP_Ubicacion_Select @productoID = {0}, @pasillo = {1}, @estante = {2}",
                    productoID ?? (object)DBNull.Value,
                    pasillo ?? (object)DBNull.Value,
                    estante ?? (object)DBNull.Value
                )
                .ToListAsync();

                return ubicaciones;

                





            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al obtener las ubicaciones: {ex.Message}");
                return new List<Ubicacion>(); // Retorna lista vacía si ocurre un error
            }
        }


    }

}


// Tabla Ubicacion
//    idUbicacion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
//    productoID INT NOT NULL,
//    pasillo VARCHAR(45) NOT NULL,
//    estante VARCHAR(45) NOT NULL,
//    FOREIGN KEY (productoID) REFERENCES Producto(idProducto)