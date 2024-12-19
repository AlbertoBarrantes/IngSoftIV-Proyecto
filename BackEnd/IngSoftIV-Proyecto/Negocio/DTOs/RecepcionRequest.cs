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
