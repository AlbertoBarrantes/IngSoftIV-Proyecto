
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace Negocio.Entities
{
    public class Producto
    {

        [Key]
        [Column("idProducto")]
        public int idProducto { get; set; }

        [Required]
        [MaxLength(45)]
        [Column("codigoBarras")]
        public string codigoBarras { get; set; } = string.Empty;

        [Required]
        [MaxLength(255)]
        [Column("descripcion")]
        public string descripcion { get; set; } = string.Empty;

        [Required]
        [MaxLength(45)]
        [Column("unidadMedida")]
        public string unidadMedida { get; set; } = string.Empty;

        [Required]
        [Column("peso")]
        public decimal peso { get; set; }

        [Required]
        [MaxLength(45)]
        [Column("dimension")]
        public string dimension { get; set; } = string.Empty;

        [Required]
        [MaxLength(45)]
        [Column("numeroLote")]
        public string numeroLote { get; set; } = string.Empty;

        [Required]
        [Column("stock")] 
        public int stock { get; set; }
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