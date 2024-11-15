using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Negocio.Entities;
using Negocio.DTOs;

namespace Negocio.DataAccess.Repositories
{
    public interface IProductoRepository
    {

        // Obtener productos filtrados
        Task<List<Producto>> ObtenerProductosFiltrados(string? codigoBarras, string? descripcion);

        // Insertar un producto
        Task<Respuesta> InsertarProducto(Producto producto);

        // Actualizar un producto
        Task ActualizarProducto(Producto producto);

        // Eliminar un producto
        Task EliminarProducto(int idProducto);



    }
}
