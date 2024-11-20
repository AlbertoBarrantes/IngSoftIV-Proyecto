using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.DTOs
{
    public class UbicacionRequest
    {

        [Required(ErrorMessage = "El producto es obligatorio")]
        public int productoID { get; set; }

        [Required(ErrorMessage = "El pasillo es obligatorio")]
        [MaxLength(45, ErrorMessage = "El pasillo no puede exceder los 45 caracteres.")]
        public string pasillo { get; set; } = string.Empty;

        [Required(ErrorMessage = "El estante es obligatorio")]
        [MaxLength(45, ErrorMessage = "El estante no puede exceder los 45 caracteres.")]
        public string estante { get; set; } = string.Empty;

    }
}


// Tabla Ubicacion
//    idUbicacion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
//    productoID INT NOT NULL,
//    pasillo VARCHAR(45) NOT NULL,
//    estante VARCHAR(45) NOT NULL,
//    FOREIGN KEY (productoID) REFERENCES Producto(idProducto)

// [Required(ErrorMessage = "XXX es obligatorio")]
// [MaxLength(45, ErrorMessage = "XXX no puede exceder los XXX caracteres.")]
