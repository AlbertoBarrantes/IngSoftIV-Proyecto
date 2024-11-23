using Microsoft.AspNetCore.Mvc;
using Negocio.Entities;
using Negocio.DataAccess.Repositories;
using Negocio.DTOs;

namespace IngSoftIV_Proyecto.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class AlmacenamientoController : ControllerBase
    {

        private readonly IAlmacenamientoRepository _almacenamientoRepository;

        // Contructor
        public AlmacenamientoController(IAlmacenamientoRepository almacenamientoRepository)
        {
            _almacenamientoRepository = almacenamientoRepository;
        }





        // GET
        [HttpGet]
        public async Task<ActionResult<List<Almacenamiento>>> ConsultarAlmacenamiento([FromQuery] int? id,
                                                                            [FromQuery] int? ubicacionID,
                                                                            [FromQuery] int? recepcionID,
                                                                            [FromQuery] int? cantidadAlmacenada)
        {
            // Convierte el request en una entidad Almacenamiento
            var almacenamientos = await _almacenamientoRepository.ConsultarAlmacenamiento(id, ubicacionID, recepcionID, cantidadAlmacenada);
            return Ok(almacenamientos);

        }





        // POST
        [HttpPost]
        public async Task<ActionResult<Respuesta>> CrearAlmacenamiento([FromBody] AlmacenamientoRequest request)
        {

            // Valida los datos usando las anotaciones de la clase Almacenamiento
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Convierte el request en una entidad Almacenamiento
            var almacenamiento = new AlmacenamientoRequest
            {
                ubicacionID = request.ubicacionID,
                recepcionID = request.recepcionID,
                cantidadAlmacenada = request.cantidadAlmacenada,
            };

            // Crea el Almacenamiento
            var respuesta = await _almacenamientoRepository.CrearAlmacenamiento(almacenamiento);

            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);

        }





        // PUT
        [HttpPut("{id}")]
        public async Task<ActionResult<Respuesta>> ActualizarAlmacenamiento(int id, [FromBody] AlmacenamientoRequest request)
        {

            // Valida los datos usando las anotaciones de la clase Almacenamiento
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Convierte el request en una entidad Almacenamiento
            var almacenamiento = new AlmacenamientoRequest
            {
                ubicacionID = request.ubicacionID,
                recepcionID = request.recepcionID,
                cantidadAlmacenada = request.cantidadAlmacenada,
            };

            // Actualiza el Almacenamiento
            var respuesta = await _almacenamientoRepository.ActualizarAlmacenamiento(id, almacenamiento);

            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);

        }





        // DELETE
        [HttpDelete("{id}")]
        public async Task<ActionResult<Respuesta>> EliminarAlmacenamiento(int id)
        {
            var respuesta = await _almacenamientoRepository.EliminarAlmacenamiento(id);
            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);
        }





    }
}
