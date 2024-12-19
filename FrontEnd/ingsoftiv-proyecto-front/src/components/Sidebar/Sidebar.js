import React from 'react';
import { Link } from 'react-router-dom';
import './Sidebar.css';
import "bootstrap/dist/js/bootstrap.bundle.min.js";
import RTLogo from '../../assets/images/RTLogo.png';

const Sidebar = () => {
    return (
        <div className="sidebar flex-shrink-0 p-3 text-white bg-dark" style={{ width: "200px" }}>
            <Link to="/" className="d-flex align-items-center my-3 mb-md-0 me-md-auto text-white text-decoration-none d-flex justify-content-center">
                <img src={RTLogo} alt="logo" style={{ width: "200px", height: "26px" }} />
                
            </Link>
            <hr />
            <ul className="nav nav-pills flex-column mb-auto text-start">



                <li className=''>
                    <Link to="/" className="nav-link text-light btn-bg" aria-current="page">
                        <i className="bi bi-house-door me-2"></i>
                        Inicio
                    </Link>
                </li>


                {/* Inventario */}
                <li className="dropdown-item ps-1 ">
                    <button className="d-flex justify-content-start align-items-center btn btn-toggle rounded text-white btn-bg" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
                        <i className="bi bi-boxes me-2"></i>
                        Inventario
                    </button>
                    <div className="collapse" id="dashboard-collapse">
                        <ul className="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><Link to="/gestionProductos" className="text-light rounded btn-bg"><i class="bi bi-box me-2"></i>Productos</Link></li>
                            <li><Link to="/gestionUbicaciones" className="text-light rounded btn-bg"><i class="bi bi-geo-alt me-2"></i>Ubicaciones de productos</Link></li>
                        </ul>
                    </div>
                </li>


                {/* Ordenes de compra */}
                <li className="dropdown-item ps-1 ">
                    <button className="d-flex justify-content-start align-items-center btn btn-toggle rounded text-white btn-bg" data-bs-toggle="collapse" data-bs-target="#menu-collapse2" aria-expanded="false">
                        <i className="bi bi-cart-check me-2"></i>
                        Ordenes de compra
                    </button>
                    <div className="collapse" id="menu-collapse2">
                        <ul className="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><Link to="/gestionOrdenesCompra" className="nav-link text-white btn-bg"><i className="bi bi-clock-history me-2"></i>Historial de ordenes</Link></li>
                            <li><Link to="/Recepcion" className="nav-link text-white btn-bg"><i className="bi bi-box-arrow-in-down me-2"></i>Recepcion de ordenes</Link></li>
                            <li><Link to="/EstadoOrden" className="nav-link text-white btn-bg"><i className="bi bi-check-all me-2"></i>Estado de ordenes</Link></li>
                        </ul>
                    </div>
                </li>


                {/* Almacenamiento */}
                <li className="dropdown-item ps-1">
                    <button className="btn btn-toggle align-items-center rounded text-white btn-bg"
                        data-bs-toggle="collapse"
                        data-bs-target="#almacenamiento-collapse"
                        aria-expanded="false">
                        <i className="bi bi-hdd-stack me-2"></i>
                        Almacenamiento
                    </button>
                    <div className="collapse" id="almacenamiento-collapse">
                        <ul className="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><Link to="/Almacenamiento" className="text-light rounded btn-bg">Gestionar Almacen</Link></li>
                        </ul>
                    </div>
                </li>


                {/* Reportes */}
                <li className="dropdown-item ps-1">
                    <button
                        className="btn btn-toggle align-items-center rounded text-white btn-bg"
                        data-bs-toggle="collapse"
                        data-bs-target="#reportes-collapse"
                        aria-expanded="false"
                    >
                        <i className="bi bi-file-earmark-bar-graph me-2"></i>
                        Reportes

                    </button>
                    <div className="collapse" id="reportes-collapse">
                        <ul className="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li>
                                <Link to="/ReporteOrdenesCompra" className="text-light rounded btn-bg">
                                    Ordenes de Compra
                                </Link>
                            </li>
                            <li>
                                <Link to="/ReporteRecepcion" className="text-light rounded btn-bg">
                                    Recepciones
                                </Link>
                            </li>
                        </ul>
                    </div>
                </li>



            </ul>
        </div>
    );
};

export default Sidebar;
