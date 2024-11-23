using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Negocio.DTOs
{
    public class AlmacenamientoRequest
    {

        [Required(ErrorMessage = "El id de la ubicación es obligatorio.")]
        public int ubicacionID { get; set; }

        [Required(ErrorMessage = "El id de la recepción es obligatorio.")]
        public int recepcionID { get; set; }

        [Required(ErrorMessage = "La cantidad almacenada es obligatoria.")]
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