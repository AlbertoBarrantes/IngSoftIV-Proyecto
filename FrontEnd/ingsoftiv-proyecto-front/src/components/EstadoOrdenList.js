import React from 'react';

const EstadoOrdenList = ({ estados, onEdit, onDelete }) => {
  return (
    <div>
      <h3>Lista de Estados de Orden</h3>
      <table>
        <thead>
          <tr>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          {estados.map((estado) => (
            <tr key={estado.idEstadoOrden}>
              <td>{estado.nombre}</td>
              <td>{estado.descripcion}</td>
              <td>
                <button onClick={() => onEdit(estado)}>Editar</button>
                <button onClick={() => onDelete(estado.idEstadoOrden)}>Eliminar</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default EstadoOrdenList;
