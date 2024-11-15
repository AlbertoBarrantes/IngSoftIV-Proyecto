
using System.ComponentModel.DataAnnotations;


namespace Negocio.Entities
{
    public class Producto
    {

        [Key] 
        public int idProducto { get; set; }

        [Required]
        [MaxLength(45)] 
        public string codigoBarras { get; set; } = string.Empty;

        [Required]
        [MaxLength(255)]
        public string descripcion { get; set; } = string.Empty;

        [Required]
        [MaxLength(45)]
        public string unidadMedida { get; set; } = string.Empty;

        [Required] 
        public decimal peso { get; set; }

        [Required]
        [MaxLength(45)]
        public string dimension { get; set; } = string.Empty;

        [Required]
        [MaxLength(45)]
        public string numeroLote { get; set; } = string.Empty;

        [Required] public int stock { get; set; }
    }
}

// Tabla Producto
// idProducto   int
// codigoBarras varchar(45)
// descripcion  varchar(255)
// unidadMedida varchar(45)
// peso         decimal(10,2)
// dimension    varchar(45)
// numeroLote   varchar(45)
// stock        int