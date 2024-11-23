
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using Negocio.Entities;


namespace Negocio.DataAccess.Contexts
{
    public class AppDbContext : DbContext
    {


        // Constructor
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        // Propiedades
        public DbSet<Producto> Productos { get; set; }

        public DbSet<Ubicacion> Ubicacion { get; set; }

        public DbSet<EstadoOrden> EstadoOrden { get; set; }

        public DbSet<OrdenCompra> OrdenCompra { get; set; }

        public DbSet<Recepcion> Recepcion { get; set; }

        public DbSet<Almacenamiento> Almacenamiento { get; set; }

    }
}
