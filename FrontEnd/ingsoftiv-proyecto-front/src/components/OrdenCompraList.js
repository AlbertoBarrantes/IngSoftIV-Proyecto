import React from 'react';

const OrdenCompraList = ({ ordenes, onEdit, onDelete }) => {
  return (
    <div>
      <h3>Lista de Órdenes de Compra</h3>
      <table>
        <thead>
          <tr>
            <th>Número</th>
            <th>Proveedor</th>
            <th>Fecha</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          {ordenes.map((orden) => (
            <tr key={orden.idOrdenCompra}>
              <td>{orden.numero}</td>
              <td>{orden.proveedor}</td>
              <td>{orden.fecha}</td>
              <td>
                <button onClick={() => onEdit(orden)}>Editar</button>
                <button onClick={() => onDelete(orden.idOrdenCompra)}>Eliminar</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default OrdenCompraList;
