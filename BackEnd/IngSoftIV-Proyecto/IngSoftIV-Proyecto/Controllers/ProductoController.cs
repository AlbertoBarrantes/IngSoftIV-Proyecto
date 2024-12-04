

using Microsoft.AspNetCore.Mvc;
using Negocio.DataAccess.Repositories;
using Negocio.Entities;
using Negocio.DTOs;

namespace IngSoftIV_Proyecto.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductoController : ControllerBase
    {
        private readonly IProductoRepository _productoRepository;

        // Constructor
        public ProductoController(IProductoRepository productoRepository)
        {
            _productoRepository = productoRepository;
        }





        // GET: api/Producto
        [HttpGet]
        public async Task<ActionResult<List<Producto>>> ObtenerProductos([FromQuery] string? codigoBarras, [FromQuery] string? descripcion)
        {
            // Convierte el request en una entidad Producto
            var productos = await _productoRepository.ObtenerProductosFiltrados(codigoBarras, descripcion);
            return Ok(productos);

        }





        // Método POST
        [HttpPost]
        public async Task<ActionResult<Respuesta>> InsertarProducto([FromBody] ProductoRequest request)
        {

            // Valida los datos usando las anotaciones de la clase ProductoRequest
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }



            // Convierte el request en una entidad Producto
            var producto = new Producto
            {
                codigoBarras = request.CodigoBarras,
                descripcion = request.Descripcion,
                unidadMedida = request.UnidadMedida,
                peso = request.Peso,
                dimension = request.Dimension,
                numeroLote = request.NumeroLote,
                stock = request.Stock
            };

            // Llama al método del repositorio
            var resultado = await _productoRepository.InsertarProducto(producto);

            // Devuelve el resultado basado en el código de respuesta
            return resultado.Codigo == 0 ? Ok(resultado) : BadRequest(resultado);
        }





        // Método PUT
        [HttpPut("{id}")]
        public async Task<ActionResult<Respuesta>> ActualizarProducto(int id, [FromBody] ProductoRequest request)
        {

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var producto = new Producto
            {
                idProducto = id,
                codigoBarras = request.CodigoBarras,
                descripcion = request.Descripcion,
                unidadMedida = request.UnidadMedida,
                peso = request.Peso,
                dimension = request.Dimension,
                numeroLote = request.NumeroLote,
                stock = request.Stock
            };

            // Llamada al repositorio para actualizar el producto
            var respuesta = await _productoRepository.ActualizarProducto(producto);

            // Devuelve el resultado basado en el código de respuesta
            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);
        }



        

       // Método DELETE
       [HttpDelete("{id}")]
        public async Task<ActionResult<Respuesta>> EliminarProducto(int id)
        {
            // Llamada al repositorio para eliminar el producto
            var resultado = await _productoRepository.EliminarProducto(id);

            // Devuelve el resultado basado en el código de respuesta
            return resultado.Codigo == 0 ? Ok(resultado) : BadRequest(resultado);
        }


    }

}
