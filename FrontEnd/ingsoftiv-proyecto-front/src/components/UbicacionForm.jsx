import React, { useState, useEffect } from 'react';

const UbicacionForm = ({ ubicacion, onSave }) => {
  const [formData, setFormData] = useState({
    pasillo: '',
    estante: '',
    productoId: ''
  });

  useEffect(() => {
    if (ubicacion) {
      setFormData({
        pasillo: ubicacion.pasillo,
        estante: ubicacion.estante,
        productoId: ubicacion.productoId
      });
    }
  }, [ubicacion]);

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
        <label>Pasillo:</label>
        <input
          type="text"
          name="pasillo"
          value={formData.pasillo}
          onChange={handleChange}
          required
        />
      </div>
      <div>
        <label>Estante:</label>
        <input
          type="text"
          name="estante"
          value={formData.estante}
          onChange={handleChange}
          required
        />
      </div>
      <div>
        <label>ID Producto:</label>
        <input
          type="number"
          name="productoId"
          value={formData.productoId}
          onChange={handleChange}
          required
        />
      </div>
      <button type="submit">{ubicacion ? 'Actualizar' : 'Crear'} Ubicación</button>
    </form>
  );
};

export default UbicacionForm;
