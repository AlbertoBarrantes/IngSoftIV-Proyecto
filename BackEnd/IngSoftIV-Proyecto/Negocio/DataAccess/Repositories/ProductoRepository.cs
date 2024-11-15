using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Negocio.Entities;
using Microsoft.EntityFrameworkCore;
using Negocio.DataAccess.Contexts;
using System.Data;
using Microsoft.Data.SqlClient;
using Negocio.DTOs;

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




        // Obtener productos filtrados
        public async Task<List<Producto>> ObtenerProductosFiltrados(string? codigoBarras, string? descripcion)
        {
            
            var query = "EXEC SP_Producto_Select @codigoBarras = {0}, @descripcion = {1}";

            // Si los parámetros son nulos, pasamos DBNull.Value
            return await _context.Productos
                .FromSqlRaw(query, codigoBarras ?? (object)DBNull.Value, descripcion ?? (object)DBNull.Value)
                .ToListAsync();

        }




        // Insertar un producto en la base de datos
        public async Task<Respuesta> InsertarProducto(Producto producto)
        {
            var respuesta = new Respuesta();

            var mensajeSalida = new SqlParameter("@mensajeSalida", SqlDbType.VarChar, 255) { Direction = ParameterDirection.Output };
            var codigoSalida = new SqlParameter("@idMensajeSalida", SqlDbType.Int) { Direction = ParameterDirection.Output };

            // Ejecuta el SP sin usar catch para errores esperados
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

            return respuesta;
        }








        // Actualizar un producto en la base de datos
        public async Task ActualizarProducto(Producto producto)
        {
            await _context.Database.ExecuteSqlRawAsync(
                "EXEC SP_Producto_Update @idProducto = {0}, @codigoBarras = {1}, @descripcion = {2}, @unidadMedida = {3}, @peso = {4}, @dimension = {5}, @numeroLote = {6}, @stock = {7}",
                producto.idProducto, producto.codigoBarras, producto.descripcion, producto.unidadMedida, producto.peso, producto.dimension, producto.numeroLote, producto.stock
            );
        }


        // Eliminar un producto en la base de datos
        public async Task EliminarProducto(int idProducto)
        {
            await _context.Database.ExecuteSqlRawAsync(
                "EXEC SP_Producto_Delete @idProducto = {0}", idProducto
            );
        }

























    }
}
