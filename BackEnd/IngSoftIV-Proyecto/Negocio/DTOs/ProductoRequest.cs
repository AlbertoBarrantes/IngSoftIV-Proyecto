using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;


namespace Negocio.DTOs
{
    public class ProductoRequest
    {
        [Required]
        [MaxLength(45)]
        public string CodigoBarras { get; set; } = string.Empty;

        [Required]
        [MaxLength(255)]
        public string Descripcion { get; set; } = string.Empty;

        [Required]
        [MaxLength(45)]
        public string UnidadMedida { get; set; } = string.Empty;

        [Required]
        public decimal Peso { get; set; }

        [Required]
        [MaxLength(45)]
        public string Dimension { get; set; } = string.Empty;

        [Required]
        [MaxLength(45)]
        public string NumeroLote { get; set; } = string.Empty;

        [Required]
        public int Stock { get; set; }
    }
}
