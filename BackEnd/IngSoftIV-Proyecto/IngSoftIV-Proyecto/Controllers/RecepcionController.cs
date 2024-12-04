using Microsoft.AspNetCore.Mvc;
using Negocio.Entities;
using Negocio.DataAccess.Repositories;
using Negocio.DTOs;

namespace IngSoftIV_Proyecto.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class RecepcionController : ControllerBase
    {
       
        private readonly IRecepcionRepository _recepcionRepository;

        // Contructor
        public RecepcionController(IRecepcionRepository recepcionRepository)
        {
            _recepcionRepository = recepcionRepository;
        }

        // GET
        [HttpGet]
        public async Task<ActionResult<List<Recepcion>>> ConsultarRecepcion([FromQuery] int? id, [FromQuery] int? productoID, [FromQuery] int? ordenCompraID, [FromQuery] DateTime? fechaRecepcion)
        {
            // Convierte el request en una entidad Recepcion
            var recepciones = await _recepcionRepository.ConsultarRecepcion(id, productoID, ordenCompraID, fechaRecepcion);
            return Ok(recepciones);

        }


        // POST
        [HttpPost]
        public async Task<ActionResult<Respuesta>> CrearRecepcion([FromBody] RecepcionRequest request)
        {

            // Valida los datos usando las anotaciones de la clase Recepcion
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Convierte el request en una entidad Recepcion
            var recepcion = new RecepcionRequest
            {
                productoID = request.productoID,
                ordenCompraID = request.ordenCompraID,
                cantidad = request.cantidad,
                fechaRecepcion = request.fechaRecepcion,
            };

            // Crea la Recepcion
            var respuesta = await _recepcionRepository.CrearRecepcion(recepcion);

            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);

        }





        // PUT
        [HttpPut("{id}")]
        public async Task<ActionResult<Respuesta>> ActualizarRecepcion(int id, [FromBody] RecepcionRequest request)
        {

            // Valida los datos usando las anotaciones de la clase Recepcion
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Convierte el request en una entidad Recepcion
            var recepcion = new RecepcionRequest
            {
                productoID = request.productoID,
                ordenCompraID = request.ordenCompraID,
                cantidad = request.cantidad,
                fechaRecepcion = request.fechaRecepcion,
            };

            // Actualiza la Recepcion
            var respuesta = await _recepcionRepository.ActualizarRecepcion(id, recepcion);

            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);

        }


        // DELETE
        [HttpDelete("{id}")]
        public async Task<ActionResult<Respuesta>> EliminarRecepcion(int id)
        {
            var respuesta = await _recepcionRepository.EliminarRecepcion(id);
            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);
        }





    }
}
