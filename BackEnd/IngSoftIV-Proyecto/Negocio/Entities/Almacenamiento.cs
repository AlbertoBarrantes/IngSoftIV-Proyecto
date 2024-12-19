using Negocio.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Negocio.Entities
{
    public class Almacenamiento
    {


        [Key]
        [Column("idAlmacenamiento")]
        public int idAlmacenamiento { get; set; }
        
        [Column("ubicacionID")]
        public int ubicacionID { get; set; }
        
        [Column("recepcionID")]
        public int recepcionID { get; set; }
        
        [Column("cantidadAlmacenada")]
        public int cantidadAlmacenada { get; set; }

    }
}
