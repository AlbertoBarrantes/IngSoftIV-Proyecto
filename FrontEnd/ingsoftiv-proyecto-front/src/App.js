// App.js
import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar/Sidebar';
import Inicio from './pages/Inicio/Inicio';
import ProductoPage from './pages/GesProductos/ProductoPage';
import UbicacionPage from './pages/GesUbicaciones/UbicacionPage';
import OrdenesCompraPage from './pages/GesOrdenesCompra/OrdenesCompraPage';
import ReporteOrdenesCompra from './pages/RepOrdenesCompra/ReporteOrdenes';
import RecepcionApp from './pages/Recepcion/RecepcionApp';
import Almacenamiento from './pages/Almacenamiento/Almacenamiento';
import EstadoOrdenesPage from './pages/GesOrdenesCompra/EstadoOrdenesPage';
import ReporteRecepcion from './pages/RepOrdenesCompra/ReporteRecepcion'; // Agregado
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
          <Route path="/gestionOrdenesCompra" element={<OrdenesCompraPage />} />
          <Route path="/ReporteOrdenesCompra" element={<ReporteOrdenesCompra />} />
          <Route path="/Recepcion" element={<RecepcionApp />} />
          <Route path="/Almacenamiento" element={<Almacenamiento />} />
          <Route path="/EstadoOrden" element={<EstadoOrdenesPage />} />
          <Route path="/ReporteRecepcion" element={<ReporteRecepcion />} /> {/* Nueva ruta agregada */}
        </Routes>
      </div>
    </div>
  );
}

export default App;
