import React from 'react';
import './Inicio.css';

function Inicio() {
    return (
        <div className="inicio-container">
            {/* Hero Section with Background Image */}
            <div className="hero-section">
                <div className="hero-content text-center text-white">
                    <h1 className="display-3 fw-bold">Sistema de Gestión de Bodega</h1>
                    <p className="lead">
                        Proyecto desarrollado para optimizar la administración de inventarios en una plataforma moderna y eficiente.
                    </p>
                </div>
            </div>

            {/* Footer */}
            <footer className="footer-section text-white text-center py-4">
                <p>&copy; 2024 Proyecto Universitario - Ingeniería de Software IV</p>
                <p>Autores: [Alberto & Mariana]</p>
                <p>Institución: [Universidad Internacional de las Americas]</p>
            </footer>
        </div>
    );
}

export default Inicio;
