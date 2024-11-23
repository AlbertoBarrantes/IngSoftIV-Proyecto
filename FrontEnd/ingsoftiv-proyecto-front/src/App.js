import React, { useState } from 'react';
import ProductForm from './components/ProductForm';
import ProductList from './components/ProductList';
import OrderReceptionForm from './components/OrderReceptionForm';
import StorageAssignment from './components/StorageAssignment';
import ReceivedItemsList from './components/ReceivedItemsList';

const App = () => {
  const [products, setProducts] = useState([]);
  const [receivedItems, setReceivedItems] = useState([]);

  // Agregar un nuevo producto al catálogo
  const handleAddProduct = (newProduct) => {
    setProducts((prevProducts) => [...prevProducts, newProduct]);
  };

  // Registrar la recepción de un producto
  const handleReceive = (item) => {
    setReceivedItems((prevItems) => [...prevItems, { ...item, location: null }]);
  };

  // Asignar una ubicación a un producto recibido
  const handleAssign = (item, location) => {
    setReceivedItems((prevItems) =>
      prevItems.map((i) => (i === item ? { ...i, location } : i))
    );
  };

  return (
    <div style={{ padding: '20px' }}>
      <h1>Gestión de Inventario</h1>

      {/* Formulario para agregar nuevos productos */}
      <h2>Agregar Producto al Catálogo</h2>
      <ProductForm onSubmit={handleAddProduct} />

      {/* Lista de productos del catálogo */}
      <h2>Catálogo de Productos</h2>
      <ProductList products={products} />

      <hr />

      {/* Recepción de mercancías */}
      <h2>Recepción de Mercancías</h2>
      <OrderReceptionForm onReceive={handleReceive} />

      {/* Asignación de ubicaciones */}
      <h2>Asignación de Ubicaciones</h2>
      <StorageAssignment
        items={receivedItems.filter((item) => !item.location)}
        onAssign={handleAssign}
      />

      {/* Listado de productos recibidos */}
      <h2>Productos Recibidos</h2>
      <ReceivedItemsList receivedItems={receivedItems} />
    </div>
  );
};

export default App;

