import React, { useState, useEffect } from 'react';

const RecepcionForm = ({ recepcion, onSave }) => {
  const [formData, setFormData] = useState({
    numero: '',
    proveedor: '',
    fechaRecepcion: '',
    ordenCompraId: ''
  });

  useEffect(() => {
    if (recepcion) {
      setFormData({
        numero: recepcion.numero,
        proveedor: recepcion.proveedor,
        fechaRecepcion: recepcion.fechaRecepcion,
        ordenCompraId: recepcion.ordenCompraId
      });
    }
  }, [recepcion]);

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
        <label>Fecha de Recepción:</label>
        <input
          type="date"
          name="fechaRecepcion"
          value={formData.fechaRecepcion}
          onChange={handleChange}
          required
        />
      </div>
      <div>
        <label>ID Orden de Compra:</label>
        <input
          type="number"
          name="ordenCompraId"
          value={formData.ordenCompraId}
          onChange={handleChange}
          required
        />
      </div>
      <button type="submit">{recepcion ? 'Actualizar' : 'Crear'} Recepción</button>
    </form>
  );
};

export default RecepcionForm;
