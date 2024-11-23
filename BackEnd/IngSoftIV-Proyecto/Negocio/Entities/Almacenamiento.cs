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


//CREATE TABLE Almacenamiento (
//	idAlmacenamiento INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
//    ubicacionID INT NOT NULL,
//    recepcionID INT NOT NULL,
//    cantidadAlmacenada INT NOT NULL,
//    FOREIGN KEY (ubicacionID) REFERENCES Ubicacion(idUbicacion) ON DELETE CASCADE,
//    FOREIGN KEY (recepcionID) REFERENCES  Recepcion(idRecepcion) ON DELETE CASCADE
//);