
using Azure.Core;
using Microsoft.AspNetCore.Mvc;
using Negocio.DataAccess.Repositories;
using Negocio.DTOs;
using Negocio.Entities;

namespace IngSoftIV_Proyecto.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EstadoOrdenController : ControllerBase
    {

        private readonly IEstadoOrdenRepository _estadoOrdenRepository;

        // Contructor
        public EstadoOrdenController(IEstadoOrdenRepository estadoOrdenRepository)
        {
            _estadoOrdenRepository = estadoOrdenRepository;
        }





        // GET: api/<EstadoOrdenController>
        [HttpGet]
        public async Task<ActionResult<List<EstadoOrden>>> ObtenerEstadoOrden([FromQuery] string? nombre, [FromQuery] string? descripcion)
        {
            // Convierte el request en una entidad Producto
            var estados = await _estadoOrdenRepository.ObtenerEstadoOrden(nombre, descripcion);
            return Ok(estados);

        }





        // POST api/<EstadoOrdenController>
        [HttpPost]
        public async Task<ActionResult<Respuesta>> InsertarEstadoOrden([FromBody] EstadoOrdenRequest request)
        {

            // Valida los datos usando las anotaciones de la clase EstadoOrdenRequest
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Convierte el request en una entidad EstadoOrden
            var estadoOrden = new EstadoOrden
            {
                nombre = request.Nombre,
                descripcion = request.Descripcion,
            };

            // Llama al método del repositorio
            var resultado = await _estadoOrdenRepository.InsertarEstadoOrden(estadoOrden);

            // Devuelve el resultado basado en el código de respuesta
            return resultado.Codigo == 0 ? Ok(resultado) : BadRequest(resultado);

        }





        // PUT api/<EstadoOrdenController>/5
        [HttpPut("{id}")]
        public async Task<ActionResult<Respuesta>> ActualizarEstadoOrden(int id, [FromBody] EstadoOrdenRequest request)
        {

            // Valida los datos usando las anotaciones de la clase EstadoOrdenRequest
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Convierte el request en una entidad EstadoOrden
            var estadoOrden = new EstadoOrden
            {
                idEstadoOrden = id,
                nombre = request.Nombre,
                descripcion = request.Descripcion,
            };

            // Llama al método del repositorio
            var resultado = await _estadoOrdenRepository.ActualizarEstadoOrden(estadoOrden);

            // Devuelve el resultado basado en el código de respuesta
            return resultado.Codigo == 0 ? Ok(resultado) : BadRequest(resultado);

        }





        // DELETE
        [HttpDelete("{id}")]
        public async Task<ActionResult<Respuesta>> EliminarEstadoOrden(int id)
        {
            // Elimina el estado de la orden
            var respuesta = await _estadoOrdenRepository.EliminarEstadoOrden(id);

            // Devuelve el resultado
            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);

        }

    }

}