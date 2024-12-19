using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Negocio.DTOs
{
    public class AlmacenamientoRequest
    {

        [Required(ErrorMessage = "El id de la ubicación es obligatorio.")]
        public int ubicacionID { get; set; }

        [Required(ErrorMessage = "El id de la recepción es obligatorio.")]
        public int recepcionID { get; set; }

        [Required(ErrorMessage = "La cantidad almacenada es obligatoria.")]
        public int cantidadAlmacenada { get; set; }

    }
}
