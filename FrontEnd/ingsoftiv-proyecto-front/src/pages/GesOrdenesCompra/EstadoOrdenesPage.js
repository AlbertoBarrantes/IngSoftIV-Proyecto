import React, { useState, useEffect } from "react";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";

const EstadoOrdenesPage = () => {
  const [estadosOrden, setEstadosOrden] = useState([]);

  const [idEstadoOrden, setidEstadoOrden] = useState("");
  const [estadoOrden, setEstadoOrden] = useState({ nombre: "", descripcion: "" });

  const [showModal, setShowModal] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");

  const API_URL = "https://localhost:5555/api/EstadoOrden";




  const fetchEstadosOrden = async () => {
    try {
      const response = await axios.get(API_URL);
      setEstadosOrden(response.data);
      setErrorMessage("");
    } catch (error) {
      console.error(error);
      setErrorMessage("Error al cargar los datos.");
    }
  };




  useEffect(() => {
    fetchEstadosOrden();
  }, []);




  const handleSubmit = async (e) => {
    e.preventDefault();
    try {

      if (isEditing) {
        if( await axios.put(`${API_URL}/${idEstadoOrden}`, estadoOrden) ){
          alert("Estado actualizado");
        } else {
          alert("Error al actualizar el estado");
        }
      } else {
        if (await axios.post(API_URL, estadoOrden) ){
          alert("Estado guardado");
        }
        else {
          alert("Error al guardar el estado");
        }
      }
      fetchEstadosOrden();
      setShowModal(false);

    } catch (error) {
      console.error(error);
      setErrorMessage("Error al guardar el estado.");
    }
  };




  const handleDelete = async (id) => {
    if (window.confirm("¿Estás seguro?")) {
      try {
        if ( await axios.delete(`${API_URL}/${id}`) ){
          fetchEstadosOrden();
          alert("Estado eliminado");
        } else {
          alert("Error al eliminar el estado");
        }
      } catch (error) {
        console.error(error);
        setErrorMessage("Error al eliminar el estado.");
      }
    }
  };




  return (
    <div className="container mt-4">
      <h4>Estados de Ordenes de Compra</h4>
      {errorMessage && <div className="alert alert-danger">{errorMessage}</div>}
      <button
        className="btn btn-success mb-3"
        onClick={() => {
          setEstadoOrden({ idEstadoOrden: "", nombre: "" });
          setIsEditing(false);
          setShowModal(true);
        }}
      >
        Nuevo Estado
      </button>
      <table className="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          {estadosOrden.map((estado) => (
            <tr key={estado.idEstadoOrden}>
              <td>{estado.idEstadoOrden}</td>
              <td>{estado.nombre}</td>
              <td>{estado.descripcion}</td>
              <td>
                <button
                  className="btn btn-warning me-2"
                  onClick={() => {
                    setidEstadoOrden(estado.idEstadoOrden);
                    setEstadoOrden(estado);
                    setIsEditing(true);
                    setShowModal(true);
                  }}
                >
                  Editar
                </button>
                <button className="btn btn-danger" onClick={() => handleDelete(estado.idEstadoOrden)}>
                  Eliminar
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      {showModal && (
        <div className="modal show d-block">
          <div className="modal-dialog">
            <div className="modal-content">
              <div className="modal-header">
                <h5 className="modal-title">{isEditing ? "Editar Estado" : "Nuevo Estado"}</h5>
                <button className="btn-close" onClick={() => setShowModal(false)}></button>
              </div>
              <div className="modal-body">
                <form onSubmit={handleSubmit}>
                  <div className="mb-3">
                    <label>Nombre</label>
                    <input
                      type="text"
                      className="form-control"
                      value={estadoOrden.nombre}
                      onChange={(e) =>
                        setEstadoOrden({ ...estadoOrden, nombre: e.target.value })
                      }
                      required
                    />
                    <label>Descripción</label>
                    <input
                      type="text"
                      className="form-control"
                      value={estadoOrden.descripcion}
                      onChange={(e) =>
                        setEstadoOrden({ ...estadoOrden, descripcion: e.target.value })
                      }
                      required
                    />
                  </div>
                  <div className="modal-footer">
                    <button type="submit" className="btn btn-success">
                      {isEditing ? "Guardar Cambios" : "Agregar"}
                    </button>
                    <button
                      type="button"
                      className="btn btn-secondary"
                      onClick={() => setShowModal(false)}
                    >
                      Cancelar
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default EstadoOrdenesPage;
