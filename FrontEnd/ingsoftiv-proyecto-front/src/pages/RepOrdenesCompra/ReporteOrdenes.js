import React, { useState, useEffect } from "react";
import axios from "axios";
import jsPDF from "jspdf";
import "jspdf-autotable";
import "bootstrap/dist/css/bootstrap.min.css";

const ReporteOrdenes = () => {
  const [ordenes, setOrdenes] = useState([]);
  const [filtros, setFiltros] = useState({
    estadoOrdenID: "",
    proveedor: "",
    fechaInicio: "",
    fechaFin: "",
  });

  // Estados para cargar los datos de los estados de orden
  const [estadoOrden, setEstadoOrden] = useState([]);

  // Cargar las órdenes y los estados de orden al iniciar
  useEffect(() => {
    fetchEstadoOrden();
  }, []);

  // Obtener datos del API (filtrado)
  const fetchOrdenes = async () => {
    const { estadoOrdenID, proveedor, fechaInicio, fechaFin } = filtros;
    const url = `https://localhost:5555/api/OrdenCompra/ordenes?estadoOrdenID=${estadoOrdenID}&proveedor=${proveedor}&fechaInicio=${fechaInicio}&fechaFin=${fechaFin}`;
    try {
      const response = await fetch(url);
      if (!response.ok) {
        throw new Error("Error al obtener los datos del servidor");
      }
      const data = await response.json();
      setOrdenes(data);
    } catch (error) {
      console.error("Error al obtener las órdenes:", error);
      setOrdenes([]); // Limpiar la tabla si hay error
    }
  };

  // Obtiene los estados de orden desde la API
  const fetchEstadoOrden = async () => {
    try {
      const response = await axios.get(`https://localhost:5555/api/EstadoOrden`);
      setEstadoOrden(response.data);
    } catch (error) {
      console.error("Error al obtener los estados de orden:", error);
    }
  };

  // Manejar cambios en los filtros
  const handleChange = (e) => {
    setFiltros({
      ...filtros,
      [e.target.name]: e.target.value,
    });
  };

  // Exportar datos a PDF
  const exportarPDF = () => {
    const doc = new jsPDF();

    // Agregar título
    doc.setFontSize(16);
    doc.text("Reporte de Órdenes de Compra", 10, 10);

    // Crear tabla
    const tableColumn = ["ID Orden", "Proveedor", "Fecha Orden", "Estado"];
    const tableRows = ordenes.map((orden) => [
      orden.idOrdenCompra,
      orden.proveedor,
      orden.fechaOrden,
      estadoOrden.find((estado) => estado.idEstadoOrden === orden.estadoOrdenID)?.nombre || "N/A",
    ]);

    // Agregar tabla al PDF
    doc.autoTable({
      head: [tableColumn],
      body: tableRows,
      startY: 20,
    });

    // Descargar el PDF
    doc.save("ReporteOrdenes.pdf");
  };

  return (
    <div className="container mt-5">
      <h1 className="mb-4">Reporte de Órdenes de Compra</h1>

      {/* Filtros */}
      <div className="card p-4 mb-4">
        <div className="row">
          <div className="col-md-3">
            {/* Dropdown para seleccionar el estado de la orden */}
            <label htmlFor="estadoOrdenID" className="form-label">
              Estado de la Orden
            </label>
            <select
              className="form-control"
              id="estadoOrdenID"
              name="estadoOrdenID"
              value={filtros.estadoOrdenID}
              onChange={handleChange}
            >
              <option value="">Todos</option>
              {estadoOrden.map((estado) => (
                <option key={estado.idEstadoOrden} value={estado.idEstadoOrden}>
                  {estado.nombre}
                </option>
              ))}
            </select>
          </div>
          <div className="col-md-3">
            <label htmlFor="proveedor" className="form-label">
              Proveedor
            </label>
            <input
              type="text"
              className="form-control"
              id="proveedor"
              name="proveedor"
              value={filtros.proveedor}
              onChange={handleChange}
              placeholder="Ej: Distribuidora"
            />
          </div>
          <div className="col-md-3">
            <label htmlFor="fechaInicio" className="form-label">
              Fecha Inicio
            </label>
            <input
              type="date"
              className="form-control"
              id="fechaInicio"
              name="fechaInicio"
              value={filtros.fechaInicio}
              onChange={handleChange}
            />
          </div>
          <div className="col-md-3">
            <label htmlFor="fechaFin" className="form-label">
              Fecha Fin
            </label>
            <input
              type="date"
              className="form-control"
              id="fechaFin"
              name="fechaFin"
              value={filtros.fechaFin}
              onChange={handleChange}
            />
          </div>
        </div>
        <div className="mt-3">
          <button className="btn btn-primary me-2" onClick={fetchOrdenes}>
            Filtrar
          </button>
          <button className="btn btn-success" onClick={exportarPDF}>
            Descargar PDF
          </button>
        </div>
      </div>

      {/* Tabla */}
      {ordenes.length > 0 ? (
        <table className="table table-striped">
          <thead className="table-dark">
            <tr>
              <th>ID Orden</th>
              <th>Proveedor</th>
              <th>Fecha Orden</th>
              <th>Estado</th>
            </tr>
          </thead>
          <tbody>
            {ordenes.map((orden) => (
              <tr key={orden.idOrdenCompra}>
                <td>{orden.idOrdenCompra}</td>
                <td>{orden.proveedor}</td>
                <td>{orden.fechaOrden}</td>
                <td>
                  {
                    estadoOrden.find(
                      (estado) => estado.idEstadoOrden === orden.estadoOrdenID
                    )?.nombre
                  }
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <div className="alert alert-info">No se encontraron resultados</div>
      )}
    </div>
  );
};

export default ReporteOrdenes;
