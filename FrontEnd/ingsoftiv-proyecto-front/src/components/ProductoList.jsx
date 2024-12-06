import React from 'react';

const ProductoList = ({ productos, onEdit, onDelete }) => {
  return (
    <div>
      <h3>Lista de Productos</h3>
      <table>
        <thead>
          <tr>
            <th>Código</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Precio</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          {productos.map((producto) => (
            <tr key={producto.idProducto}>
              <td>{producto.codigo}</td>
              <td>{producto.nombre}</td>
              <td>{producto.descripcion}</td>
              <td>{producto.precio}</td>
              <td>
                <button onClick={() => onEdit(producto)}>Editar</button>
                <button onClick={() => onDelete(producto.idProducto)}>Eliminar</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default ProductoList;
