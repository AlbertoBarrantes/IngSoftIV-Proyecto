import React from 'react';

const UbicacionList = ({ ubicaciones, onEdit, onDelete }) => {
  return (
    <div>
      <h3>Lista de Ubicaciones</h3>
      <table>
        <thead>
          <tr>
            <th>Pasillo</th>
            <th>Estante</th>
            <th>Producto ID</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          {ubicaciones.map((ubicacion) => (
            <tr key={ubicacion.idUbicacion}>
              <td>{ubicacion.pasillo}</td>
              <td>{ubicacion.estante}</td>
              <td>{ubicacion.productoId}</td>
              <td>
                <button onClick={() => onEdit(ubicacion)}>Editar</button>
                <button onClick={() => onDelete(ubicacion.idUbicacion)}>Eliminar</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default UbicacionList;
