import React, { useState, useEffect } from "react";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";

const UbicacionPage = () => {

    // Estados
    const [ubicaciones, setUbicaciones] = useState([]);
    const [productos, setProductos] = useState([]);
    const [ubicacion, setUbicacion] = useState({
        productoID: "",
        pasillo: "",
        estante: "",
    });

    // Modal
    const [showModal, setShowModal] = useState(false);
    const [isEditing, setIsEditing] = useState(false);

    // Filtros
    const [search, setSearch] = useState("");
    const [productoID, setProductoID] = useState("");
    const [pasillo, setPasillo] = useState("");
    const [estante, setEstante] = useState("");

    // Paginación
    const itemsPerPage = 6;
    const [currentPage, setCurrentPage] = useState(1);
    const indexOfLastItem = currentPage * itemsPerPage;
    const indexOfFirstItem = indexOfLastItem - itemsPerPage;
    const currentItems = ubicaciones
        .filter(
            (prod) =>
                prod.pasillo.toLowerCase().includes(search) ||
                prod.estante.toLowerCase().includes(search)
        )
        .slice(indexOfFirstItem, indexOfLastItem);

    const totalPages = Math.ceil(
        ubicaciones.filter(
            (prod) =>
                prod.pasillo.toLowerCase().includes(search) ||
                prod.estante.toLowerCase().includes(search)
        ).length / itemsPerPage
    );


    // Cargar ubicaciones y productos
    useEffect(() => {
        fetchUbicaciones();
        fetchProductos();
    }, []);




    // Obtener ubicaciones desde la API
    const fetchUbicaciones = async () => {
        try {
            const response = await axios.get(`https://localhost:5555/api/Ubicacion?productoID=${productoID}&pasillo=${pasillo}&estante=${estante}`);
            setUbicaciones(response.data);
            setCurrentPage(1);
        } catch (error) {
            console.error("Error al obtener ubicaciones:", error);
        }
    };




    // Obtener productos desde la API
    const fetchProductos = async () => {
        try {
            const response = await axios.get("https://localhost:5555/api/Producto");
            setProductos(response.data);
        } catch (error) {
            console.error("Error al obtener productos:", error);
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
            productos.filter(
                (prod) =>
                    prod.descripcion.toLowerCase().includes(search) ||
                    prod.codigoBarras.includes(search)
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




    // Enviar formulario
    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            if (isEditing) {
                await axios.put(
                    `https://localhost:5555/api/Ubicacion/${ubicacion.idUbicacion}`,
                    ubicacion
                );
            } else {
                await axios.post("https://localhost:5555/api/Ubicacion", ubicacion);
            }
            fetchUbicaciones();
            setShowModal(false);
        } catch (error) {
            console.error(
                `Error al ${isEditing ? "editar" : "crear"} ubicación:`,
                error
            );
        }
    };




    // Eliminar ubicación
    const handleDelete = async (id) => {
        if (window.confirm("¿Estás seguro de que deseas eliminar esta ubicación?")) {
            try {
                await axios.delete(`https://localhost:5555/api/Ubicacion/${id}`);
                if (fetchUbicaciones()) {
                    alert("Ubicación eliminada correctamente");
                }
                else {
                    alert("No se pudo eliminar la ubicación");
                }

            } catch (error) {
                console.error("Error al eliminar ubicación:", error);
            }
        }
    }




    // Resetear filtros
    const resetFilter = () => {
        setProductoID("");
        setPasillo("");
        setEstante("");
    };










    return (
        <div className="container mt-4">
            <h4>Gestión de Ubicaciones</h4>


            <div className="d-flex justify-content-between my-3">

                <button
                    className="btn btn-success me-3"
                    onClick={() => {
                        setUbicacion({ productoID: "", pasillo: "", estante: "" });
                        setIsEditing(false);
                        setShowModal(true);
                    }}
                >
                    Agregar Ubicación
                </button>

                <div className="row">

                    <select
                        className="form-select w-25 mx-1 col"
                        value={productoID}
                        onChange={(e) => {
                            setProductoID(e.target.value)
                        }}
                    >
                        <option value="">Seleccione un producto</option>
                        {productos.map((prod) => (
                            <option key={prod.idProducto} value={prod.idProducto}>
                                {prod.descripcion}
                            </option>
                        ))}
                    </select>

                    <input
                        type="text"
                        id="Ipasillo"
                        placeholder="Pasillo"
                        className="form-control w-25 mx-1 col"
                        value={pasillo}
                        onChange={(e) => { setPasillo(e.target.value) }}

                    />

                    <input
                        type="text"
                        id="Iestante"
                        placeholder="Estante"
                        className="form-control w-25 mx-1 col"
                        value={estante}
                        onChange={(e) => setEstante(e.target.value)}
                    />


                    <button
                        className="btn btn-light border mx-1 col"
                        onClick={fetchUbicaciones}
                    >
                        Buscar
                    </button>
                    <button
                        className="btn btn-light border mx-1 col-auto"
                        onClick={resetFilter}
                    >
                        <i class="bi bi-eraser"></i>
                    </button>
                </div>

            </div>










            <table className="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Producto</th>
                        <th>Pasillo</th>
                        <th>Estante</th>
                        <th className="d-flex justify-content-center">Opción</th>
                    </tr>
                </thead>
                <tbody>
                    {currentItems.map((ubi) => (
                        <tr key={ubi.idUbicacion}>
                            <td>{ubi.idUbicacion}</td>
                            <td>
                                {productos.find((prod) => prod.idProducto === ubi.productoID)?.descripcion}
                            </td>
                            <td>{ubi.pasillo}</td>
                            <td>{ubi.estante}</td>
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
                                                onClick={() => {
                                                    setUbicacion(ubi);
                                                    setIsEditing(true);
                                                    setShowModal(true);
                                                }}
                                            >
                                                <i className="bi bi-pencil-square me-1 text-warning"></i>
                                                Editar
                                            </button>
                                        </li>
                                        <li>
                                            <button
                                                className="dropdown-item d-flex align-items-center"
                                                onClick={() => handleDelete(ubi.idUbicacion)}
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










            {showModal && (
                <div className="modal show d-block" tabIndex="-1">
                    <div className="modal-dialog">
                        <div className="modal-content">
                            <div className="modal-header">
                                <h5 className="modal-title">
                                    {isEditing ? "Editar Ubicación" : "Agregar Ubicación"}
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
                                        <label>Producto</label>
                                        <select
                                            className="form-control"
                                            value={ubicacion.productoID}
                                            onChange={(e) =>
                                                setUbicacion({
                                                    ...ubicacion,
                                                    productoID: e.target.value,
                                                })
                                            }
                                            required
                                        >
                                            <option value="">Seleccione un producto</option>
                                            {productos.map((prod) => (
                                                <option key={prod.idProducto} value={prod.idProducto}>
                                                    {prod.descripcion}
                                                </option>
                                            ))}
                                        </select>
                                    </div>
                                    <div className="mb-3">
                                        <label>Pasillo</label>
                                        <input
                                            type="text"
                                            className="form-control"
                                            value={ubicacion.pasillo}
                                            onChange={(e) =>
                                                setUbicacion({ ...ubicacion, pasillo: e.target.value })
                                            }
                                            required
                                        />
                                    </div>
                                    <div className="mb-3">
                                        <label>Estante</label>
                                        <input
                                            type="text"
                                            className="form-control"
                                            value={ubicacion.estante}
                                            onChange={(e) =>
                                                setUbicacion({ ...ubicacion, estante: e.target.value })
                                            }
                                            required
                                        />
                                    </div>
                                    <div className="modal-footer">
                                        <button type="submit" className="btn btn-success">
                                            {isEditing ? "Guardar Cambios" : "Agregar Ubicación"}
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

export default UbicacionPage;
