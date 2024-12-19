using Negocio.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Entities
{
    public class Ubicacion
    {

        [Key]
        [Column("idUbicacion")]
        public int idUbicacion { get; set; }

        [Column("productoID")]
        public int productoID { get; set; }

        [Column("pasillo")]
        public string pasillo { get; set; } = string.Empty;

        [Column("estante")]
        public string estante { get; set; } = string.Empty;


    }
}

