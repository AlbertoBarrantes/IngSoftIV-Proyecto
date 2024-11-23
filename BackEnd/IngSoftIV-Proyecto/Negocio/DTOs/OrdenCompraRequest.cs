using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.DTOs
{
    public class OrdenCompraRequest
    {

        [Required(ErrorMessage = "El estado de la orden es obligatorio.")]
        public int estadoOrdenID { get; set; }

        [Required(ErrorMessage = "El proveedor es obligatorio.")]
        [MaxLength(100, ErrorMessage = "El nombre del proveedor no puede ser mayor a 100 caracteres.")]
        public string proveedor { get; set; } = string.Empty;

        [Required(ErrorMessage = "La fecha de la orden es obligatoria.")]
        public DateOnly fechaOrden { get; set; }

    }
}


//CREATE TABLE OrdenCompra (
//	  idOrdenCompra INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
//    estadoOrdenID INT NOT NULL,
//    proveedor VARCHAR(100) NOT NULL,
//    fechaOrden DATE NOT NULL,
//    FOREIGN KEY (estadoOrdenID) REFERENCES EstadoOrden(idEstadoOrden) ON DELETE CASCADE
//);