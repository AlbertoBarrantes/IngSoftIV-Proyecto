import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar/Sidebar';
import ProductoPage from './pages/ProductoPage';
import './App.css';

function App() {
  return (
    <div className="app ">
      <Router>
        <Sidebar />
        <div className="content">
          <Routes>
            <Route path="/productos" element={<ProductoPage />} />
          </Routes>
        </div>
      </Router>
    </div>
  );
}

export default App;
