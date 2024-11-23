using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Entities
{
    public class Recepcion
    {

        [Key]
        [Column("idRecepcion")]
        public int idRecepcion { get; set; }
        [Column("productoID")]
        public int productoID { get; set; }
        [Column("ordenCompraID")]
        public int ordenCompraID { get; set; }
        [Column("cantidad")]
        public int cantidad { get; set; }
        [Column("fechaRecepcion")]
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