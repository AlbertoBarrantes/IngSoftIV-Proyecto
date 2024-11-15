import React from 'react';
import { Link } from 'react-router-dom';
import './Sidebar.css';

const Sidebar = () => {
    return (
        <div className="sidebar flex-shrink-0 p-3 text-white bg-dark" style={{ width: "200px" }}>
            <Link to="/" className="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                <i className="bi bi-bootstrap me-2" style={{ fontSize: "1.5rem" }}></i>
                <span className="fs-4">Sidebar</span>
            </Link>
            <hr />
            <ul className="nav nav-pills flex-column mb-auto justify-items-start">
                <li className="nav-item">
                    <Link to="#" className="nav-link text-white btn-bg" aria-current="page">
                        <i className="bi bi-house-door me-2"></i>
                        Inicio
                    </Link>
                </li>
                <li>
                    <button className="btn btn-toggle align-items-center rounded text-white btn-bg" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
                        <i className="bi bi-boxes me-2"></i>
                        Inventario
                    </button>
                    <div className="collapse" id="dashboard-collapse">
                        <ul className="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><Link to="/productos" className="text-light rounded btn-bg">Gestión Productos</Link></li>
                            <li><Link to="#" className="text-light rounded btn-bg">Weekly</Link></li>
                            <li><Link to="#" className="text-light rounded btn-bg">Monthly</Link></li>
                            <li><Link to="#" className="text-light rounded btn-bg">Annually</Link></li>
                        </ul>
                    </div>
                </li>
                <li>
                    <Link to="#" className="nav-link text-white btn-bg">
                        <i className="bi bi-table me-2"></i>
                        Orders
                    </Link>
                </li>
                <li>
                    <Link to="#" className="nav-link text-white btn-bg">
                        <i className="bi bi-grid me-2"></i>
                        Products
                    </Link>
                </li>
                <li>
                    <Link to="#" className="nav-link text-white btn-bg">
                        <i className="bi bi-clipboard-data me-2"></i>
                        Reportes
                    </Link>
                </li>
            </ul>
            <hr />
            <div className="dropdown">
                <Link to="#" className="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                    <img src="https://github.com/mdo.png" alt="" width="32" height="32" className="rounded-circle me-2" />
                    <strong>mdo</strong>
                </Link>
                <ul className="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
                    <li><Link className="dropdown-item" to="#">New project...</Link></li>
                    <li><Link className="dropdown-item" to="#">Settings</Link></li>
                    <li><Link className="dropdown-item" to="#">Profile</Link></li>
                    <li><hr className="dropdown-divider" /></li>
                    <li><Link className="dropdown-item" to="#">Sign out</Link></li>
                </ul>
            </div>
        </div>
    );
};

export default Sidebar;
