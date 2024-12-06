import React from 'react';
import './Inicio.css';

function Inicio() {
    return (
        <div className="inicio-container">
            {/* Header Section */}
            <header className="inicio-header text-center text-white py-5">
                <div className="container">
                    <h1 className="display-4 fw-bold text-shadow">Sistema de Gestión de Bodega</h1>
                    <p className="lead mb-4 text-shadow">Gestiona tu inventario, órdenes y reportes de manera eficiente y ágil.</p>
                    
                </div>
            </header>

            {/* Navbar Section */}
            <nav className="inicio-nav navbar navbar-expand-lg navbar-dark fixed-top py-3">
                <div className="container">
                    <a className="navbar-brand" href="/">Bodega Pro</a>
                    <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span className="navbar-toggler-icon"></span>
                    </button>
                    <div className="collapse navbar-collapse" id="navbarNav">
                        <ul className="navbar-nav ms-auto">
                            <li className="nav-item">
                                <a className="nav-link" href="/inventario">Inventario</a>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link" href="/ordenes">Órdenes</a>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link" href="/reportes">Reportes</a>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link" href="/configuracion">Configuración</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            {/* Hero Section */}
            <section className="hero-section text-center py-5 mt-5">
                <div className="container">
                    <h2 className="display-5 mb-4 fw-bold">Bienvenido a tu Centro de Gestión de Bodega</h2>
                    <p className="lead mb-4">Una plataforma diseñada para facilitar la administración de tu inventario, agilizar el proceso de órdenes y generar reportes detallados.</p>
                </div>
            </section>

            {/* Dashboard Overview Section */}
            <section className="overview-section py-5 bg-light">
                <div className="container">
                    <div className="row text-center">
                        <div className="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div className="card shadow border-0 rounded-lg">
                                <div className="card-body">
                                    <h3 className="card-title text-primary">Productos en Inventario</h3>
                                    <p className="display-4">1200</p>
                                </div>
                            </div>
                        </div>
                        <div className="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div className="card shadow border-0 rounded-lg">
                                <div className="card-body">
                                    <h3 className="card-title text-warning">Órdenes Pendientes</h3>
                                    <p className="display-4">45</p>
                                </div>
                            </div>
                        </div>
                        <div className="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div className="card shadow border-0 rounded-lg">
                                <div className="card-body">
                                    <h3 className="card-title text-success">Reportes Generados</h3>
                                    <p className="display-4">320</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Bodega Image Section */}
            <section className="bodega-image-section py-5">
                <div className="container text-center">
                    <img src="https://media.istockphoto.com/id/1138429558/es/foto/hileras-de-estantes.jpg?s=612x612&w=0&k=20&c=JHGeEoZIrY9MrSBcX7CGLU9TLjeoJz9mEtW7Mhk6Iuw=" alt="Bodega" className="img-fluid rounded-3 shadow-lg"/>
                </div>
            </section>

            {/* Call to Action Section */}
            <section className="cta-section bg-dark text-white py-5">
                <div className="container text-center">
                    <h3 className="fw-bold text-uppercase mb-4">Transforma la Gestión de Tu Bodega</h3>
                    <p className="lead mb-4">Nuestra plataforma te permite optimizar la logística, mejorar el seguimiento de inventarios y generar reportes eficientemente.</p>
                    
                </div>
            </section>

            {/* Footer Section */}
            <footer className="footer-section bg-dark text-white py-4 text-center">
                <p>&copy; 2024 Sistema de Gestión de Bodega | Todos los derechos reservados</p>
            </footer>
        </div>
    );
}

export default Inicio;



