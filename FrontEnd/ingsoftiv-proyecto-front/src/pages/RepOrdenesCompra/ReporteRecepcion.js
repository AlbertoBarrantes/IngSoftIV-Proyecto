import React, { useState, useEffect } from 'react';
import axios from 'axios';
import jsPDF from 'jspdf';
import 'jspdf-autotable';
import 'bootstrap/dist/css/bootstrap.min.css';

const ReporteRecepcion = () => {
  const [recepciones, setRecepciones] = useState([]);
  const [filtros, setFiltros] = useState({
    productoID: '',
    ordenCompraID: '',
    fechaInicio: '',
    fechaFin: '',
  });

  // Cargar las recepciones al iniciar
  useEffect(() => {
    fetchRecepciones();
  }, []);

  // Obtener datos del API (filtrado)
  const fetchRecepciones = async () => {
    const { productoID, ordenCompraID, fechaInicio, fechaFin } = filtros;
    const url = `https://localhost:5555/api/Recepcion?productoID=${productoID}&ordenCompraID=${ordenCompraID}&fechaInicio=${fechaInicio}&fechaFin=${fechaFin}`;
    try {
      const response = await axios.get(url);
      setRecepciones(response.data);
    } catch (error) {
      console.error('Error al obtener las recepciones:', error);
      setRecepciones([]); // Limpiar la tabla si hay error
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
    doc.text('Reporte de Recepciones', 10, 10);

    // Crear tabla
    const tableColumn = ['ID Recepción', 'Producto ID', 'Orden Compra ID', 'Cantidad', 'Fecha Recepción'];
    const tableRows = recepciones.map((recepcion) => [
      recepcion.idRecepcion,
      recepcion.productoID,
      recepcion.ordenCompraID,
      recepcion.cantidad,
      new Date(recepcion.fechaRecepcion).toLocaleDateString(),
    ]);

    // Agregar tabla al PDF
    doc.autoTable({
      head: [tableColumn],
      body: tableRows,
      startY: 20,
    });

    // Descargar el PDF
    doc.save('ReporteRecepcion.pdf');
  };

  return (
    <div className="container mt-5">
      <h1 className="mb-4">Reporte de Recepciones</h1>

      {/* Filtros */}
      <div className="card p-4 mb-4">
        <div className="row">
          <div className="col-md-3">
            <label htmlFor="productoID" className="form-label">
              Producto ID
            </label>
            <input
              type="text"
              className="form-control"
              id="productoID"
              name="productoID"
              value={filtros.productoID}
              onChange={handleChange}
              placeholder="Ej: 123"
            />
          </div>
          <div className="col-md-3">
            <label htmlFor="ordenCompraID" className="form-label">
              Orden Compra ID
            </label>
            <input
              type="text"
              className="form-control"
              id="ordenCompraID"
              name="ordenCompraID"
              value={filtros.ordenCompraID}
              onChange={handleChange}
              placeholder="Ej: 456"
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
          <button className="btn btn-primary me-2" onClick={fetchRecepciones}>
            Filtrar
          </button>
          <button className="btn btn-success" onClick={exportarPDF}>
            Descargar PDF
          </button>
        </div>
      </div>

      {/* Tabla */}
      {recepciones.length > 0 ? (
        <table className="table table-striped">
          <thead className="table-dark">
            <tr>
              <th>ID Recepción</th>
              <th>Producto ID</th>
              <th>Orden Compra ID</th>
              <th>Cantidad</th>
              <th>Fecha Recepción</th>
            </tr>
          </thead>
          <tbody>
            {recepciones.map((recepcion) => (
              <tr key={recepcion.idRecepcion}>
                <td>{recepcion.idRecepcion}</td>
                <td>{recepcion.productoID}</td>
                <td>{recepcion.ordenCompraID}</td>
                <td>{recepcion.cantidad}</td>
                <td>{new Date(recepcion.fechaRecepcion).toLocaleDateString()}</td>
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

export default ReporteRecepcion;
