﻿using Negocio.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Entities
{
    public class EstadoOrden
    {

        [Key]
        [Column("idEstadoOrden")]
        public int idEstadoOrden { get; set; }
        
        [Column("nombre")]
        public string nombre { get; set; } = string.Empty;

        [Column("descripcion")]
        public string descripcion { get; set; } = string.Empty;

    }
}

