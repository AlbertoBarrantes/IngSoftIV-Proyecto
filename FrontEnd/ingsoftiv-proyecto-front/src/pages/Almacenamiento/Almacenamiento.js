import React, { useState, useEffect } from "react";
import axios from "axios";

const Almacenamiento = () => {
  const [almacenamientos, setAlmacenamientos] = useState([]);
  const [ubicacionID, setUbicacionID] = useState("");
  const [recepcionID, setRecepcionID] = useState("");
  const [cantidadAlmacenada, setCantidadAlmacenada] = useState("");
  const [editId, setEditId] = useState(null);
  const [loading, setLoading] = useState(false);
  const [ubicaciones, setUbicaciones] = useState([]);
  const [recepciones, setRecepciones] = useState([]);


  const API_URL = "https://localhost:5555/api/Almacenamiento";




  // Cargar los datos al iniciar
  useEffect(() => {
    fetchUbicaciones();
    fetchRecepciones();
    fetchAlmacenamientos();
  }, []);



  // Obtener ubicaciones desde la API
  const fetchUbicaciones = async () => {
    try {
      const response = await axios.get(`https://localhost:5555/api/Ubicacion`);
      setUbicaciones(response.data);
    } catch (error) {
      console.error("Error al obtener ubicaciones:", error);
    }
  };



  // Obtener recepciones desde la API
  const fetchRecepciones = async () => {
    try {
      const response = await axios.get(`https://localhost:5555/api/Recepcion`);
      setRecepciones(response.data);
    } catch (error) {
      console.error("Error al obtener recepciones:", error);
    }
  };



  // Obtener almacenamientos desde la API
  const fetchAlmacenamientos = async () => {
    try {
      const response = await axios.get(API_URL);
      setAlmacenamientos(response.data);
    } catch (error) {
      console.error("Error al obtener los almacenamientos:", error);
    }
  };




  // Manejar envío del formulario (Crear/Actualizar)
  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!ubicacionID || !recepcionID || !cantidadAlmacenada) {
      alert("Por favor, complete todos los campos.");
      return;
    }

    const almacenamientoData = {
      ubicacionID: parseInt(ubicacionID),
      recepcionID: parseInt(recepcionID),
      cantidadAlmacenada: parseInt(cantidadAlmacenada),
    };



    setLoading(true);
    try {
      if (editId) {
        // Actualizar (PUT)
        const response = await axios.put(`${API_URL}/${editId}, almacenamientoData`);
        setAlmacenamientos(
          almacenamientos.map((item) =>
            item.idAlmacenamiento === editId ? response.data : item
          )
        );
        alert("Almacenamiento actualizado correctamente.");
      } else {
        // Crear nuevo (POST)
        const response = await axios.post(API_URL, almacenamientoData);
        setAlmacenamientos([...almacenamientos, response.data]);
        alert("Almacenamiento agregado correctamente.");
      }

      // Limpiar formulario
      setUbicacionID("");
      setRecepcionID("");
      setCantidadAlmacenada("");
      setEditId(null);
    } catch (error) {
      console.error("Error al guardar el almacenamiento:", error);
      alert("Hubo un problema al guardar el almacenamiento.");
    } finally {
      setLoading(false);
    }
  };





  // Manejar edición
  const handleEdit = (almacenamiento) => {
    setEditId(almacenamiento.idAlmacenamiento);
    setUbicacionID(almacenamiento.ubicacionID);
    setRecepcionID(almacenamiento.recepcionID);
    setCantidadAlmacenada(almacenamiento.cantidadAlmacenada);
  };





  // Manejar eliminación (DELETE)
  const handleDelete = async (id) => {
    if (!window.confirm("¿Está seguro de eliminar este almacenamiento?")) return;

    try {
      await axios.delete(`${API_URL}/${id}`);
      setAlmacenamientos(
        almacenamientos.filter((item) => item.idAlmacenamiento !== id)
      );
      alert("Almacenamiento eliminado correctamente.");
    } catch (error) {
      console.error("Error al eliminar el almacenamiento:", error);
      alert("Hubo un problema al eliminar el almacenamiento.");
    }
  };




  return (
    <div className="container">
      <h1>Gestión de Almacenamientos</h1>

      {/* Formulario */}
      <form onSubmit={handleSubmit} className="mb-3">


        <div className="row mt-3">
          <div className="col mb-3">

            {/* Carga un dropdown con los nombres de ubicaciones */}

            <label className="form-label">Ubicación ID</label>
            <select
              className="form-select"
              value={ubicacionID}
              onChange={(e) => {
                setUbicacionID(e.target.value)
              }}
            >
              <option value="">Seleccione una ubicación</option>
              {ubicaciones.map((ubicacion) => (
                <option key={ubicacion.idUbicacion} value={ubicacion.idUbicacion}>
                  ID: {ubicacion.idUbicacion} &emsp; Pasillo: {ubicacion.pasillo} &emsp; {ubicacion.estante}
                </option>
              ))}
            </select>
          </div>

          <div className="col mb-3">

            {/* Select de recepciones */}
            <label className="form-label">Recepción</label>
            <select
              className="form-select"
              value={recepcionID}
              onChange={(e) => setRecepcionID(e.target.value)}
            >
              <option value="">Seleccione un ID de recepción</option>
              {recepciones.map((recepcion) => (
                <option key={recepcion.idRecepcion} value={recepcion.idRecepcion}>
                  ID: {recepcion.idRecepcion} &emsp; Cantidad: {recepcion.cantidad} &emsp; Fecha: {recepcion.fechaRecepcion.split('T')[0]}
                </option>
              ))}
            </select>
          </div>
        </div>

        <div className="row mt-1 ">
          <div className="col">
            <label className="form-label">Cantidad Almacenada</label>
            <input
              type="number"
              className="form-control"
              value={cantidadAlmacenada}
              defaultValue={1}
              min={1}
              onChange={(e) => setCantidadAlmacenada(e.target.value)}
              placeholder="Ingrese la cantidad almacenada"
            />
          </div>

          <div className="col d-flex justify-content-center align-items-end">
            <button type="submit" className="btn btn-primary" disabled={loading}>
              {loading ? "Cargando..." : editId ? "Actualizar Almacenamiento" : "Agregar Almacenamiento"}
            </button>
          </div>
        </div>

      </form>

      {/* Lista de almacenamientos */}
      <h2 className="mt-4">Lista de Almacenamientos</h2>
      <ul className="list-group">
        {almacenamientos.map((almacenamiento) => (
          <li key={almacenamiento.idAlmacenamiento} className="list-group-item">
            <div><strong>ID:</strong> {almacenamiento.idAlmacenamiento}</div>
            <div><strong>Ubicación ID:</strong> {almacenamiento.ubicacionID}</div>
            <div><strong>Recepción ID:</strong> {almacenamiento.recepcionID}</div>
            <div><strong>Cantidad Almacenada:</strong> {almacenamiento.cantidadAlmacenada}</div>
            <button
              className="btn btn-warning btn-sm me-2"
              onClick={() => handleEdit(almacenamiento)}
            >
              Editar
            </button>
            <button
              className="btn btn-danger btn-sm"
              onClick={() => handleDelete(almacenamiento.idAlmacenamiento)}
            >
              Eliminar
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Almacenamiento;