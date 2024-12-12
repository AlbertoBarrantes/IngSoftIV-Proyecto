import React, { useState, useEffect } from "react";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";

const OrdenesCompraPage = () => {

    // Estados
    const [ordenesCompra, setOrdenesCompra] = useState([]);
    const [estadoOrden, setEstadoOrden] = useState([]);
    const [ordenCompra, setOrdenCompra] = useState({
        estadoOrdenID: "",
        proveedor: "",
        fechaOrden: "",
    });

    // Modal
    const [showModal, setShowModal] = useState(false);
    const [isEditing, setIsEditing] = useState(false);

    // Filtros
    const [search, setSearch] = useState("");
    const [idOrdenCompra, setIdOrdenCompra] = useState("");
    const [estadoOrdenID, setEstadoOrdenID] = useState("");
    const [proveedor, setProveedor] = useState("");
    const [fechaOrden, setFechaOrden] = useState("");

    // Paginación
    const itemsPerPage = 6;
    const [currentPage, setCurrentPage] = useState(1);
    const indexOfLastItem = currentPage * itemsPerPage;
    const indexOfFirstItem = indexOfLastItem - itemsPerPage;
    const currentItems = ordenesCompra
        .filter(
            (ordenCompra) =>
                ordenCompra.idOrdenCompra.toString().includes(search) ||
                ordenCompra.estadoOrdenID.includes(search) ||
                ordenCompra.proveedor.toLowerCase().includes(search) ||
                ordenCompra.fechaOrden.includes(search)
        )
        .slice(indexOfFirstItem, indexOfLastItem);

    const totalPages = Math.ceil(
        ordenesCompra.filter(
            (ordenCompra) =>
                ordenCompra.idOrdenCompra.toString().includes(search) ||
                ordenCompra.estadoOrdenID.includes(search) ||
                ordenCompra.proveedor.toLowerCase().includes(search) ||
                ordenCompra.fechaOrden.includes(search)
        ).length / itemsPerPage
    );




    // Cargar las ordenes de compra y los estados de orden
    useEffect(() => {
        fetchOrdenesCompra();
        fetchEstadoOrden();
    }, []);




    // Obtiene las ordenes de compra desde la API
    const fetchOrdenesCompra = async () => {
        try {
            const response = await axios.get(`https://localhost:5555/api/OrdenCompra?id=${idOrdenCompra}&estadoOrdenID=${estadoOrdenID}&proveedor=${proveedor}&fechaOrden=${fechaOrden}`);
            setOrdenesCompra(response.data);
            setCurrentPage(1);
        } catch (error) {
            console.error("Error al obtener las ordenes de compra:", error);
        }
    };




    // Obtiene los estados de orden desde la API
    const fetchEstadoOrden = async () => {
        try {
            const response = await axios.get(`https://localhost:5555/api/EstadoOrden`);
            setEstadoOrden(response.data);
        } catch (error) {
            console.error("Error al obtener los estados de orden:", error);
        }
    };




    // Paginación
    const handlePreviousPage = () => {
        if (currentPage > 1) {
            setCurrentPage(currentPage - 1);
        }
    };




    // Paginación
    const handleNextPage = () => {
        const totalPages = Math.ceil(
            ordenesCompra.filter(
                (ordenCompra) =>
                    ordenCompra.descripcion.toLowerCase().includes(search) ||
                    ordenCompra.codigoBarras.includes(search)
            ).length / itemsPerPage
        );
        if (currentPage < totalPages) {
            setCurrentPage(currentPage + 1);
        }
    };




    // Paginación
    const handlePageClick = (page) => {
        setCurrentPage(page);
    };




    // Enviar forumulario
    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            if (isEditing) {
                await axios.put(`https://localhost:5555/api/OrdenCompra/${ordenCompra.idOrdenCompra}`, ordenCompra);
            } else {
                await axios.post(`https://localhost:5555/api/OrdenCompra`, ordenCompra);
            }
            fetchOrdenesCompra();
            setShowModal(false);
        } catch (error) {
            console.error(
                `Error al ${isEditing ? "editar" : "crear"} la orden de compra:`,
                error);
        }
    };




    // Editar orden de compra
    const handleEdit = (ordenCompra) => {
        setOrdenCompra(ordenCompra);
        setIsEditing(true);
        setShowModal(true);
    };




    // Eliminar orden de compra
    const handleDelete = async (id) => {
        if (window.confirm("¿Estás seguro de que deseas eliminar esta orden de compra?")) {
            try {
                await axios.delete(`https://localhost:5555/api/OrdenCompra/${id}`);
                fetchOrdenesCompra();
            } catch (error) {
                console.error("Error al eliminar la orden de compra:", error);
            }
        }
    };




    // Limpiar filtros
    const resetFilter = () => {
        setSearch("");
        setIdOrdenCompra("");
        setEstadoOrdenID("");
        setProveedor("");
        setFechaOrden("");
    }






    return (
        <div className="container mt-4">
            <h4>Gestión de Ordenes de Compra</h4>

            {/* Agregar una nueva orden de compra y filtros de búsqueda */}
            <div className="d-flex justify-content-between my-3">

                <button
                    className="btn btn-success me-3"
                    onClick={() => {
                        setOrdenCompra({ estadoOrdenID: "", proveedor: "", fechaOrden: "" });
                        setIsEditing(false);
                        setShowModal(true);
                    }}
                >
                    Agregar Nueva Orden
                </button>

                <div className="row">

                    {/* Input para filtrar proveedor */}
                    <input
                        type="text"
                        id="Iproveedor"
                        placeholder="Proveedor"
                        className="form-control w-25 mx-1 col"
                        value={proveedor}
                        onChange={(e) => setProveedor(e.target.value)}
                    />

                    {/* Datepicker para filtrar fecha de orden */}
                    <input
                        type="date"
                        id="IfechaOrden"
                        className="form-control w-25 mx-1 col"
                        value={fechaOrden}
                        onChange={(e) => setFechaOrden(e.target.value)}
                    />

                    {/* Botón para buscar ordenes de compra */}
                    <button
                        className="btn btn-light border mx-1 col"
                        onClick={fetchOrdenesCompra}
                    >
                        Buscar
                    </button>

                    {/* Botón para limpiar filtros */}
                    <button
                        className="btn btn-light border mx-1 col-auto"
                        onClick={() => {
                            resetFilter();
                        }}
                    >
                        <i class="bi bi-eraser"></i>
                    </button>
                </div>

            </div>

            {/* Tabla de ordenes de compra */}
            <table className="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Id Orden</th>
                        <th>Id Estado</th>
                        <th>Estado</th>
                        <th>Proveedor</th>
                        <th>Fecha</th>
                        <th className="d-flex justify-content-center">Opción</th>
                    </tr>
                </thead>
                <tbody>
                    {currentItems.map((ordenCompra) => (
                        <tr key={ordenCompra.idOrdenCompra}>
                            <td>{ordenCompra.idOrdenCompra}</td>
                            <td>{ordenCompra.estadoOrdenID}</td>
                            <td>{estadoOrden.find((estado) => estado.idEstadoOrden === ordenCompra.estadoOrdenID)?.nombre}</td>
                            <td>{ordenCompra.proveedor}</td>
                            <td>{ordenCompra.fechaOrden}</td>
                            <td>
                                <div className="btn-group dropleft d-flex justify-content-center">
                                    <button
                                        className="btn p-0 border-0"
                                        type="button"
                                        id="dropdownMenu2"
                                        data-bs-toggle="dropdown"
                                        aria-haspopup="true"
                                        aria-expanded="false"
                                    >
                                        <i className="bi bi-three-dots-vertical"></i>
                                    </button>
                                    <ul className="dropdown-menu" aria-labelledby="dropdownMenu2">
                                        <li>
                                            <button
                                                className="dropdown-item "
                                                onClick={() => handleEdit(ordenCompra)}
                                            >
                                                <i className="bi bi-pencil-square me-1 text-warning"></i>
                                                Editar
                                            </button>
                                        </li>
                                        <li>
                                            <button
                                                className="dropdown-item d-flex align-items-center"
                                                onClick={() => handleDelete(ordenCompra.idOrdenCompra)}
                                            >
                                                <i className="bi bi-x-circle me-1 text-danger"></i>
                                                Eliminar
                                            </button>
                                        </li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>


            {/* Paginación */}
            <div className="d-flex justify-content-between align-items-center mt-3">
                <nav>
                    <ul className="pagination">
                        {/* Botón Anterior */}
                        <li className={`page-item ${currentPage === 1 ? "disabled" : ""}`}>
                            <button
                                className="page-link"
                                onClick={handlePreviousPage}
                                disabled={currentPage === 1}
                            >
                                Anterior
                            </button>
                        </li>

                        {/* Botones numerados */}
                        {Array.from({ length: totalPages }, (_, index) => (
                            <li
                                key={index}
                                className={`page-item ${currentPage === index + 1 ? "active" : ""
                                    }`}
                            >
                                <button
                                    className="page-link"
                                    onClick={() => handlePageClick(index + 1)}
                                >
                                    {index + 1}
                                </button>
                            </li>
                        ))}

                        {/* Botón Siguiente */}
                        <li
                            className={`page-item ${currentPage === totalPages ? "disabled" : ""
                                }`}
                        >
                            <button
                                className="page-link"
                                onClick={handleNextPage}
                                disabled={currentPage === totalPages}
                            >
                                Siguiente
                            </button>
                        </li>
                    </ul>
                </nav>
            </div>










            {/* Modal para agregar/editar orden de compra */}
            {showModal && (
                <div className="modal show d-block" tabIndex="-1">
                    <div className="modal-dialog">
                        <div className="modal-content">
                            <div className="modal-header">
                                <h5 className="modal-title">
                                    {isEditing ? "Editar Orden de Compra" : "Agregar Orden de Compra"}
                                </h5>
                                <button
                                    type="button"
                                    className="btn-close"
                                    onClick={() => setShowModal(false)}
                                ></button>
                            </div>
                            <div className="modal-body">
                                <form onSubmit={handleSubmit}>
                                    <div className="mb-3">

                                        {/* Select para elegir el estado de la orden */}
                                        <label>Estado de la Orden</label>
                                        <select
                                            className="form-control"
                                            value={ordenCompra.estadoOrdenID}
                                            onChange={(e) =>
                                                setOrdenCompra({
                                                    ...ordenCompra,
                                                    estadoOrdenID: e.target.value,
                                                })
                                            }
                                            required
                                        >
                                            <option value="">Seleccione un estado</option>
                                            {estadoOrden.map((estado) => (
                                                <option key={estado.idEstadoOrden} value={estado.idEstadoOrden}>
                                                    {estado.nombre}
                                                </option>
                                            ))}
                                        </select>
                                    </div>
                                    <div className="mb-3">
                                        {/* Input para el proveedor */}
                                        <label>Proveedor</label>
                                        <input
                                            type="text"
                                            className="form-control"
                                            value={ordenCompra.proveedor}
                                            onChange={(e) =>
                                                setOrdenCompra({ ...ordenCompra, proveedor: e.target.value })
                                            }
                                            required
                                        />
                                    </div>
                                    <div className="mb-3">
                                        {/* Datepicker para la fecha de la orden */}
                                        <label>Fecha de la Orden</label>
                                        <input
                                            type="date"
                                            className="form-control"
                                            value={ordenCompra.fechaOrden}
                                            onChange={(e) =>
                                                setOrdenCompra({ ...ordenCompra, fechaOrden: e.target.value })
                                            }
                                            required
                                        />
                                    </div>
                                    <div className="modal-footer">
                                        <button type="submit" className="btn btn-success">
                                            {isEditing ? "Guardar Cambios" : "Agregar Orden de Compra"}
                                        </button>
                                        <button
                                            type="button"
                                            className="btn btn-secondary"
                                            onClick={() => setShowModal(false)}
                                        >
                                            Cancelar
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            )}

















        </div>
    );
};

export default OrdenesCompraPage;
