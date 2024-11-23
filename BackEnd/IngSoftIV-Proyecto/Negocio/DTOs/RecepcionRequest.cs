using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.DTOs
{
    public class RecepcionRequest
    {
        [Required(ErrorMessage = "El id del producto es obligatorio.")] 
        public int productoID { get; set; }
        
        [Required(ErrorMessage = "El id de la orden de compra es obligatorio.")]
        public int ordenCompraID { get; set; }

        [Required(ErrorMessage = "La cantidad es obligatoria.")]
        public int cantidad { get; set; }

        [Required(ErrorMessage = "La fecha de recepción es obligatoria.")]
        public DateTime fechaRecepcion { get; set; }




    }
}


//CREATE TABLE Recepcion (
//	  idRecepcion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
//    productoID INT NOT NULL,
//    ordenCompraID INT NOT NULL,
//    cantidad INT NOT NULL,
//    fechaRecepcion DATE NOT NULL,
//    FOREIGN KEY (productoID) REFERENCES Producto(idProducto) ON DELETE CASCADE,
//    FOREIGN KEY (ordenCompraID) REFERENCES OrdenCompra(idOrdenCompra) ON DELETE CASCADE
//);