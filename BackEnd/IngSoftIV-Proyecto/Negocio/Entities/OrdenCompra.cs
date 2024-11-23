using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Entities
{
    public class OrdenCompra
    {



        [Key]
        [Column("idOrdenCompra")]
        public int idOrdenCompra { get; set; }

        [Column("estadoOrdenID")]
        public int estadoOrdenID { get; set; }

        [Column("proveedor")]
        public string proveedor { get; set; } = string.Empty;

        [Column("fechaOrden")]
        public DateOnly fechaOrden { get; set; }

    }
}


//CREATE TABLE OrdenCompra (
//	idOrdenCompra INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
//    estadoOrdenID INT NOT NULL,
//    proveedor VARCHAR(100) NOT NULL,
//    fechaOrden DATE NOT NULL,
//    FOREIGN KEY (estadoOrdenID) REFERENCES EstadoOrden(idEstadoOrden) ON DELETE CASCADE
//);