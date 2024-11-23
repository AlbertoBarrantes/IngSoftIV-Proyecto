import React, { useState, useEffect } from 'react';

const OrdenCompraForm = ({ ordenCompra, onSave }) => {
  const [formData, setFormData] = useState({
    numero: '',
    proveedor: '',
    fecha: ''
  });

  useEffect(() => {
    if (ordenCompra) {
      setFormData({
        numero: ordenCompra.numero,
        proveedor: ordenCompra.proveedor,
        fecha: ordenCompra.fecha
      });
    }
  }, [ordenCompra]);

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
        <label>Número:</label>
        <input
          type="text"
          name="numero"
          value={formData.numero}
          onChange={handleChange}
          required
        />
      </div>
      <div>
        <label>Proveedor:</label>
        <input
          type="text"
          name="proveedor"
          value={formData.proveedor}
          onChange={handleChange}
          required
        />
      </div>
      <div>
        <label>Fecha:</label>
        <input
          type="date"
          name="fecha"
          value={formData.fecha}
          onChange={handleChange}
          required
        />
      </div>
      <button type="submit">{ordenCompra ? 'Actualizar' : 'Crear'} Orden de Compra</button>
    </form>
  );
};

export default OrdenCompraForm;
