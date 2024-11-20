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
        [Required(ErrorMessage = "El código de barras es obligatorio.")]
        [MaxLength(45, ErrorMessage = "El código de barras no puede exceder los 45 caracteres.")]
        public string CodigoBarras { get; set; } = string.Empty;

        [Required(ErrorMessage = "La descripción es obligatoria.")]
        [MaxLength(255, ErrorMessage = "La descripción no puede exceder los 255 caracteres.")]
        public string Descripcion { get; set; } = string.Empty;

        [Required(ErrorMessage = "La unidad de medida es obligatoria.")]
        [MaxLength(45, ErrorMessage = "La unidad de medida no puede exceder los 45 caracteres.")]
        public string UnidadMedida { get; set; } = string.Empty;

        [Required(ErrorMessage = "El peso es obligatorio.")]
        [Range(0, int.MaxValue, ErrorMessage = "El peso no puede ser negativo.")]
        public decimal Peso { get; set; }

        [Required(ErrorMessage = "Las dimensión es obligatoria.")]
        [MaxLength(45, ErrorMessage = "La dimensión no puede exceder los 45 caracteres.")]
        public string Dimension { get; set; } = string.Empty;

        [Required(ErrorMessage = "El número de lote es obligatorio.")]
        [MaxLength(45, ErrorMessage = "El número de lote no puede exceder los 45 caracteres.")]
        public string NumeroLote { get; set; } = string.Empty;

        [Required(ErrorMessage = "El stock es obligatorio.")]
        [Range(0, int.MaxValue, ErrorMessage = "El stock no puede ser negativo.")]
        public int Stock { get; set; }
    }
}
