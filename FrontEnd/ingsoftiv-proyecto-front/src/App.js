import React, { useState } from 'react';
import ProductForm from './components/ProductForm';
import ProductList from './components/ProductList';

const App = () => {
  const [products, setProducts] = useState([]);

  const handleAddProduct = (newProduct) => {
    setProducts((prevProducts) => [...prevProducts, newProduct]);
  };

  return (
    <div style={{ padding: '20px' }}>
      <h1>Gestión de Inventario</h1>
      <ProductForm onSubmit={handleAddProduct} />
      <ProductList products={products} />
    </div>
  );
};

export default App;
