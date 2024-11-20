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
    public class ProductoRepository : IProductoRepository
    {

        private readonly AppDbContext _context;

        // Constructor
        public ProductoRepository(AppDbContext context)
        {
            _context = context;
        }


        // XXX cambiar {0} por SQL parameter

        // Obtener productos filtrados
        public async Task<List<Producto>> ObtenerProductosFiltrados(string? codigoBarras, string? descripcion)
        {

            var query = "EXEC SP_Producto_Select @codigoBarras = {0}, @descripcion = {1}";

            return await _context.Productos
                .FromSqlRaw(query, codigoBarras ?? (object)DBNull.Value, descripcion ?? (object)DBNull.Value)
                .ToListAsync();

        }


    




        // Insertar un producto en la base de datos
        public async Task<Respuesta> InsertarProducto(Producto producto)
        {
            var respuesta = new Respuesta();

            try { 

                var mensajeSalida = new SqlParameter("@mensajeSalida", SqlDbType.VarChar, 255) { Direction = ParameterDirection.Output };
                var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

                // Ejecuta el SP
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Producto_Insert @codigoBarras = @codigoBarras, @descripcion = @descripcion, @unidadMedida = @unidadMedida, @peso = @peso, @dimension = @dimension, @numeroLote = @numeroLote, @stock = @stock, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    new SqlParameter("@codigoBarras", producto.codigoBarras),
                    new SqlParameter("@descripcion", producto.descripcion),
                    new SqlParameter("@unidadMedida", producto.unidadMedida),
                    new SqlParameter("@peso", producto.peso),
                    new SqlParameter("@dimension", producto.dimension),
                    new SqlParameter("@numeroLote", producto.numeroLote),
                    new SqlParameter("@stock", producto.stock),
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();

            } catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al insertar el producto: {ex.Message}";
            }

            return respuesta;
        }








        // Actualizar un producto en la base de datos
        public async Task<Respuesta> ActualizarProducto(Producto producto)
        {
            var respuesta = new Respuesta();

            try
            {
                var mensajeSalida = new SqlParameter("@mensajeSalida", SqlDbType.VarChar, 255) { Direction = ParameterDirection.Output };
                var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

                // Ejecuta el SP
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Producto_Update @idProducto = @idProducto, @codigoBarras = @codigoBarras, @descripcion = @descripcion, @unidadMedida = @unidadMedida, @peso = @peso, @dimension = @dimension, @numeroLote = @numeroLote, @stock = @stock, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    new SqlParameter("@idProducto", producto.idProducto),
                    new SqlParameter("@codigoBarras", producto.codigoBarras),
                    new SqlParameter("@descripcion", producto.descripcion),
                    new SqlParameter("@unidadMedida", producto.unidadMedida),
                    new SqlParameter("@peso", producto.peso),
                    new SqlParameter("@dimension", producto.dimension),
                    new SqlParameter("@numeroLote", producto.numeroLote),
                    new SqlParameter("@stock", producto.stock),
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();

            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al actualizar el producto: {ex.Message}";
            }

            return respuesta;

        }








        // Eliminar un producto en la base de datos
        public async Task<Respuesta> EliminarProducto(int idProducto)
        {
            var respuesta = new Respuesta();

            try
            {

                var mensajeSalida = new SqlParameter("@mensajeSalida", SqlDbType.VarChar, 255) { Direction = ParameterDirection.Output };
                var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

                // Ejecuta el SP
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC SP_Producto_Delete @idProducto = @idProducto, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
                    new SqlParameter("@idProducto", idProducto),
                    mensajeSalida,
                    codigoSalida
                );

                respuesta.Codigo = (int)codigoSalida.Value;
                respuesta.Mensaje = mensajeSalida.Value.ToString();
            }
            catch (Exception ex)
            {
                respuesta.Codigo = -1;
                respuesta.Mensaje = $"Error al eliminar el producto: {ex.Message}";
            }

            return respuesta;

        }


    }
}










// Insertar un producto en la base de datos
//public async Task<Respuesta> InsertarProducto(Producto producto)
//{
//    var respuesta = new Respuesta();

//    try
//    {

//        var mensajeSalida = new SqlParameter("@mensajeSalida", SqlDbType.VarChar, 255) { Direction = ParameterDirection.Output };
//        var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

//        // Ejecuta el SP
//        await _context.Database.ExecuteSqlRawAsync(
//            "EXEC SP_Producto_Insert @codigoBarras = @codigoBarras, @descripcion = @descripcion, @unidadMedida = @unidadMedida, @peso = @peso, @dimension = @dimension, @numeroLote = @numeroLote, @stock = @stock, @mensajeSalida = @mensajeSalida OUTPUT, @idMensajeSalida = @idMensajeSalida OUTPUT",
//            new SqlParameter("@codigoBarras", producto.codigoBarras),
//            new SqlParameter("@descripcion", producto.descripcion),
//            new SqlParameter("@unidadMedida", producto.unidadMedida),
//            new SqlParameter("@peso", producto.peso),
//            new SqlParameter("@dimension", producto.dimension),
//            new SqlParameter("@numeroLote", producto.numeroLote),
//            new SqlParameter("@stock", producto.stock),
//            mensajeSalida,
//            codigoSalida
//        );

//        respuesta.Codigo = (int)codigoSalida.Value;
//        respuesta.Mensaje = mensajeSalida.Value.ToString();

//    }
//    catch (Exception ex)
//    {
//        respuesta.Codigo = -1;
//        respuesta.Mensaje = $"Error al insertar el producto: {ex.Message}";
//    }

//    return respuesta;
//}