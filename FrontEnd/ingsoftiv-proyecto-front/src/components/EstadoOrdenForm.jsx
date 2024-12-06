import React, { useState, useEffect } from 'react';

const EstadoOrdenForm = ({ estadoOrden, onSave }) => {
  const [formData, setFormData] = useState({
    nombre: '',
    descripcion: ''
  });

  useEffect(() => {
    if (estadoOrden) {
      setFormData({
        nombre: estadoOrden.nombre,
        descripcion: estadoOrden.descripcion
      });
    }
  }, [estadoOrden]);

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSave(formData);
  };

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label>Nombre:</label>
        <input
          type="text"
          name="nombre"
          value={formData.nombre}
          onChange={handleChange}
          required
        />
      </div>
      <div>
        <label>Descripción:</label>
        <input
          type="text"
          name="descripcion"
          value={formData.descripcion}
          onChange={handleChange}
          required
        />
      </div>
      <button type="submit">{estadoOrden ? 'Actualizar' : 'Crear'} Estado Orden</button>
    </form>
  );
};

export default EstadoOrdenForm;
