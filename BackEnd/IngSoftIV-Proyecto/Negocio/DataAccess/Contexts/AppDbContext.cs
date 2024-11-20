
using Microsoft.EntityFrameworkCore;
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

    }
}
