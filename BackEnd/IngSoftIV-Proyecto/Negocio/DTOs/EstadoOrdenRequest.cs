using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.DTOs
{
    public class EstadoOrdenRequest
    {
        [Required(ErrorMessage = "El nombre es obligatorio.")]
        [MaxLength(45, ErrorMessage = "El campo de nombre no puede exceder los 45 caracteres.")]
        public string Nombre { get; set; } = string.Empty;

        [Required(ErrorMessage = "La descripcion es obligatoria.")]
        [MaxLength(255, ErrorMessage = "El campo de descripcion no puede exceder los 255 caracteres.")]
        public string Descripcion { get; set; } = string.Empty;

    }
}
