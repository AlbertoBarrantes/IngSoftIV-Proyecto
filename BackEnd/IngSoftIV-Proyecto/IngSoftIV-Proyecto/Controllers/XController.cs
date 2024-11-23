using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Negocio.DataAccess.Contexts;
using Negocio.Entities;

namespace IngSoftIV_Proyecto.Controllers
{
    public class XController : Controller
    {
        private readonly AppDbContext _context;

        public XController(AppDbContext context)
        {
            _context = context;
        }

        // GET: X
        public async Task<IActionResult> Index()
        {
            return View(await _context.OrdenCompra.ToListAsync());
        }

        // GET: X/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var ordenCompra = await _context.OrdenCompra
                .FirstOrDefaultAsync(m => m.idOrdenCompra == id);
            if (ordenCompra == null)
            {
                return NotFound();
            }

            return View(ordenCompra);
        }

        // GET: X/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: X/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("idOrdenCompra,estadoOrdenID,proveedor,fechaOrden")] OrdenCompra ordenCompra)
        {
            if (ModelState.IsValid)
            {
                _context.Add(ordenCompra);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(ordenCompra);
        }

        // GET: X/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var ordenCompra = await _context.OrdenCompra.FindAsync(id);
            if (ordenCompra == null)
            {
                return NotFound();
            }
            return View(ordenCompra);
        }

        // POST: X/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("idOrdenCompra,estadoOrdenID,proveedor,fechaOrden")] OrdenCompra ordenCompra)
        {
            if (id != ordenCompra.idOrdenCompra)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(ordenCompra);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!OrdenCompraExists(ordenCompra.idOrdenCompra))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(ordenCompra);
        }

        // GET: X/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var ordenCompra = await _context.OrdenCompra
                .FirstOrDefaultAsync(m => m.idOrdenCompra == id);
            if (ordenCompra == null)
            {
                return NotFound();
            }

            return View(ordenCompra);
        }

        // POST: X/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var ordenCompra = await _context.OrdenCompra.FindAsync(id);
            if (ordenCompra != null)
            {
                _context.OrdenCompra.Remove(ordenCompra);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool OrdenCompraExists(int id)
        {
            return _context.OrdenCompra.Any(e => e.idOrdenCompra == id);
        }
    }
}
