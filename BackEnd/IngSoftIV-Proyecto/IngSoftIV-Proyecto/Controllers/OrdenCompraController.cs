using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Negocio.DataAccess.Repositories;
using Negocio.Entities;
using Negocio.DTOs;

namespace IngSoftIV_Proyecto.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrdenCompraController : ControllerBase
    {

        private readonly IOrdenCompraRepository _ordenCompraRepository;

        // Contructor
        public OrdenCompraController(IOrdenCompraRepository ordenCompraRepository)
        {
            _ordenCompraRepository = ordenCompraRepository;
        }





        // GET
        [HttpGet]
        public async Task<ActionResult<List<OrdenCompra>>> ConsultarOrdenCompra([FromQuery] int? id,
                                                                                [FromQuery] int? estadoOrdenID,
                                                                                [FromQuery] string? proveedor,
                                                                                [FromQuery] DateOnly? fechaOrden)
        {
            // Convierte el request en una entidad OrdenCompra
            var ordenes = await _ordenCompraRepository.ConsultarOrdenCompra(id, estadoOrdenID, proveedor, fechaOrden);
            return Ok(ordenes);

        }





        // POST
        [HttpPost]
        public async Task<ActionResult<Respuesta>> CrearOrdenCompra([FromBody] OrdenCompraRequest request)
        {

            // Valida los datos usando las anotaciones de la clase OrdenCompra
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Convierte el request en una entidad OrdenCompra
            var ordenCompra = new OrdenCompra
            {
                estadoOrdenID = request.estadoOrdenID,
                proveedor = request.proveedor,
                fechaOrden = request.fechaOrden,
            };

            // Llama al método del repositorio
            var respuesta = await _ordenCompraRepository.CrearOrdenCompra(ordenCompra);

            // Devuelve el resultado basado en el código de respuesta
            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);
            
        }





        // PUT
        [HttpPut("{id}")]
        public async Task<ActionResult<Respuesta>> ActualizarOrdenCompra(int id, [FromBody] OrdenCompraRequest request)
        {

            // Valida los datos usando las anotaciones de la clase OrdenCompra
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var ordenCompra = new OrdenCompra
            {
                estadoOrdenID = request.estadoOrdenID,
                proveedor = request.proveedor,
                fechaOrden = request.fechaOrden
            };

            // Llama al método del repositorio
            var respuesta = await _ordenCompraRepository.ActualizarOrdenCompra(id, ordenCompra);
            
            // Devuelve el resultado
            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);

        }





        // DELETE
        [HttpDelete("{id}")]
        public async Task<ActionResult<Respuesta>> EliminarOrdenCompra(int id)
        {

            // Llama al método del repositorio
            var respuesta = await _ordenCompraRepository.EliminarOrdenCompra(id);

            // Devuelve el resultado
            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);

        }

    }
}
