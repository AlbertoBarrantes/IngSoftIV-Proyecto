using Microsoft.AspNetCore.Mvc;
using Negocio.DataAccess.Repositories;
using Negocio.DTOs;
using Negocio.Entities;


namespace IngSoftIV_Proyecto.Controllers
{
    [Route("api/[controller]")]
    public class UbicacionController : ControllerBase
    {

        private readonly IUbicacionRepository _ubicacionRepository;

        // Constructor
        public UbicacionController(IUbicacionRepository ubicacionRepository)
        {
            _ubicacionRepository = ubicacionRepository;
        }





        // GET: api/Ubicacion
        [HttpGet]
        public async Task<ActionResult<List<Ubicacion>>> ObtenerUbicaciones([FromQuery] int? productoID, [FromQuery] string? pasillo, [FromQuery] string? estante)
        {
            // Convierte el request en una entidad Ubicacion
            var ubicaciones = await _ubicacionRepository.ObtenerUbicacionesFiltradas(productoID, pasillo, estante);
            return Ok(ubicaciones);

        }






        // Método POST
        [HttpPost]
        public async Task<ActionResult<Respuesta>> InsertarUbicacion([FromBody] UbicacionRequest request)
        {

            // Valida los datos usando las anotaciones de la clase UbicacionRequest
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Convierte el request en una entidad Ubicacion
            var ubicacion = new Ubicacion
            {
                productoID = request.productoID,
                pasillo = request.pasillo,
                estante = request.estante
            };

            // Inserta la entidad en la base de datos
            var respuesta = await _ubicacionRepository.InsertarUbicacion(ubicacion);

            // Devuelve el resultado basado en el código de respuesta
            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);
        }





        //Metodo PUT
        [HttpPut("{id}")]
        public async Task<ActionResult<Respuesta>> ActualizarUbicacion(int id, [FromBody] UbicacionRequest request)
        {
            // Valida los datos usando las anotaciones de la clase UbicacionRequest
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Convierte el request en una entidad Ubicacion
            var ubicacion = new Ubicacion
            {
                idUbicacion = id,
                productoID = request.productoID,
                pasillo = request.pasillo,
                estante = request.estante
            };

            // Actualiza la entidad en la base de datos
            var respuesta = await _ubicacionRepository.ActualizarUbicacion(ubicacion);

            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);
        }





        // Método DELETE
        [HttpDelete("{id}")]
        public async Task<ActionResult<Respuesta>> EliminarUbicacion(int id)
        {
            // Elimina la entidad en la base de datos
            var respuesta = await _ubicacionRepository.EliminarUbicacion(id);

            return respuesta.Codigo == 0 ? Ok(respuesta) : BadRequest(respuesta);
        }




    }
}
