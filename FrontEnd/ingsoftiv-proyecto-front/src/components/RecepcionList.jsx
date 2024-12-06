import React from 'react';

const RecepcionList = ({ recepciones, onEdit, onDelete }) => {
  return (
    <div>
      <h3>Lista de Recepciones</h3>
      <table>
        <thead>
          <tr>
            <th>Número</th>
            <th>Proveedor</th>
            <th>Fecha de Recepción</th>
            <th>Orden de Compra ID</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          {recepciones.map((recepcion) => (
            <tr key={recepcion.idRecepcion}>
              <td>{recepcion.numero}</td>
              <td>{recepcion.proveedor}</td>
              <td>{recepcion.fechaRecepcion}</td>
              <td>{recepcion.ordenCompraId}</td>
              <td>
                <button onClick={() => onEdit(recepcion)}>Editar</button>
                <button onClick={() => onDelete(recepcion.idRecepcion)}>Eliminar</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default RecepcionList;
