import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar/Sidebar';
import Inicio from './pages/Inicio/Inicio';
import ProductoPage from './pages/GesProductos/ProductoPage';
import UbicacionPage from './pages/GesUbicaciones/UbicacionPage';
import './App.css';

function App() {
  return (
    <div className="app">
      <Sidebar />
      <div className="content">
        <Routes>
          <Route path="/" element={<Inicio />} />
          <Route path="/gestionProductos" element={<ProductoPage />} />
          <Route path="/gestionUbicaciones" element={<UbicacionPage />} />
        </Routes>
      </div>
    </div>
  );
}

export default App;