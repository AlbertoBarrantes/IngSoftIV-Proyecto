using QuestPDF.Fluent;
using QuestPDF.Infrastructure;
using Negocio.Entities;
using System.Collections.Generic;
using QuestPDF.Helpers;

namespace Negocio.Services
{
    public class OrdenCompraReportService
    {
        public byte[] GenerarReporteOrdenes(List<OrdenCompra> ordenesCompra, List<EstadoOrden> estadosOrden)
        {
            return Document.Create(container =>
            {
                container.Page(page =>
                {
                    page.Margin(20);
                    page.Size(PageSizes.A4);

                    // Encabezado del reporte
                    page.Header().Text("Reporte de Órdenes de Compra")
                        .FontSize(20).Bold().AlignCenter();

                    // Tabla del contenido
                    page.Content().Table(table =>
                    {
                        // Definir columnas
                        table.ColumnsDefinition(columns =>
                        {
                            columns.RelativeColumn(1); // ID Orden
                            columns.RelativeColumn(2); // Proveedor
                            columns.RelativeColumn(2); // Fecha Orden
                            columns.RelativeColumn(2); // Estado
                        });

                        // Encabezado de la tabla
                        table.Header(header =>
                        {
                            header.Cell().Text("ID Orden").FontSize(12).Bold();
                            header.Cell().Text("Proveedor").FontSize(12).Bold();
                            header.Cell().Text("Fecha Orden").FontSize(12).Bold();
                            header.Cell().Text("Estado").FontSize(12).Bold();
                        });

                        // Filas dinámicas
                        foreach (var orden in ordenesCompra)
                        {
                            table.Cell().Text(orden.idOrdenCompra.ToString());
                            table.Cell().Text(orden.proveedor);
                            table.Cell().Text(orden.fechaOrden.ToString("yyyy-MM-dd"));

                            // Busca el nombre del estado
                            var estadoNombre = estadosOrden
                                .FirstOrDefault(e => e.idEstadoOrden == orden.estadoOrdenID)?.nombre ?? "Desconocido";
                            table.Cell().Text(estadoNombre);
                        }
                    });

                    // Pie de página
                    page.Footer().AlignRight().Text(x =>
                    {
                        x.Span("Página ");
                        x.CurrentPageNumber();
                        x.Span(" de ");
                        x.TotalPages();
                    });
                });
            }).GeneratePdf();
        }
    }
}
