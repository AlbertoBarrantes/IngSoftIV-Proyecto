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

