import React, { useState, useEffect } from "react";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";

const ProductoPage = () => {
    const [productos, setProductos] = useState([]);
    const [search, setSearch] = useState("");
    const [currentPage, setCurrentPage] = useState(1);
    const itemsPerPage = 6;

    const [showModal, setShowModal] = useState(false);
    const [isEditing, setIsEditing] = useState(false);
    const [producto, setProducto] = useState({
        codigoBarras: "",
        descripcion: "",
        unidadMedida: "",
        peso: 0,
        dimension: "",
        numeroLote: "",
        stock: 0,
    });

    // Filtros
    const [codigoBarras, setCodigoBarras] = useState("");
    const [descripcion, setDescripcion] = useState("");

    // Paginación
    const indexOfLastItem = currentPage * itemsPerPage;
    const indexOfFirstItem = indexOfLastItem - itemsPerPage;
    const currentItems = productos
        .filter(
            (prod) =>
                prod.descripcion.toLowerCase().includes(search) ||
                prod.codigoBarras.includes(search)
        )
        .slice(indexOfFirstItem, indexOfLastItem);

    const totalPages = Math.ceil(
        productos.filter(
            (prod) =>
                prod.descripcion.toLowerCase().includes(search) ||
                prod.codigoBarras.includes(search)
        ).length / itemsPerPage
    );




    // Cargar productos
    useEffect(() => {
        fetchProductos();
    }, []);




    // Obtener productos desde la API
    const fetchProductos = async () => {
        try {
            const response = await axios.get(`https://localhost:5555/api/Producto?codigoBarras=${codigoBarras}&descripcion=${descripcion}`);
            setProductos(response.data);
            setCurrentPage(1);
        } catch (error) {
            console.error("Error al obtener productos", error);
        }
    };




    // Manejar cambios en los inputs
    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setProducto({ ...producto, [name]: value });
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
                await axios.put(`https://localhost:5555/api/Producto/${producto.idProducto}`, producto);
                if (fetchProductos()) {
                    alert("Producto actualizado correctamente");
                }
                else {
                    alert("No se pudo actualizar el producto");
                }
            } else {
                await axios.post("https://localhost:5555/api/Producto", producto);
                if (fetchProductos()) {
                    alert("Producto agregado correctamente");
                }
                else {
                    alert("No se pudo agregar el producto");
                }
            }
            setShowModal(false);
        } catch (error) {
            console.error("Error al enviar producto", error);
        }
    };




    // Editar producto
    const handleEdit = (prod) => {
        setProducto(prod);
        setIsEditing(true);
        setShowModal(true);
    };




    // Eliminar producto
    const handleDelete = async (id) => {
        if (window.confirm("¿Estás seguro de que deseas eliminar este producto?")) {
            try {
                await axios.delete(`https://localhost:5555/api/Producto/${id}`);
                if (fetchProductos()) {
                    alert("Producto eliminado correctamente");
                }
                else {
                    alert("No se pudo eliminar el producto");
                }
            } catch (error) {
                console.error("Error al eliminar producto", error);
            }
        }
    };




    // Resetear formulario
    const resetForm = () => {
        setProducto({
            codigoBarras: "",
            descripcion: "",
            unidadMedida: "",
            peso: 0,
            dimension: "",
            numeroLote: "",
            stock: 0,
        });
        setIsEditing(false);
    };




    // Resetear filtros
    const resetFilter = () => {
        setCodigoBarras("");
        setDescripcion("");
    };




    return (
        <div className="container mt-4">
            <h4>Gestión de Productos</h4>


            <div className="d-flex justify-content-between my-3">

                <button
                    className="btn btn-success me-3"
                    onClick={() => {
                        resetForm();
                        setShowModal(true);
                    }}
                >
                    Agregar Producto
                </button>

                <div className="row">
                    <input
                        type="text"
                        id="IcodigoBarras"
                        placeholder="Código de barras"
                        className="form-control w-25 mx-1 col"
                        value={codigoBarras}
                        onChange={(e) => { setCodigoBarras(e.target.value) }}
                    />

                    <input
                        type="text"
                        id="Idescripcion"
                        placeholder="Descripción"
                        className="form-control w-25 mx-1 col"
                        value={descripcion}
                        onChange={(e) => setDescripcion(e.target.value)}
                    />


                    <button
                        className="btn btn-light border mx-1 col"
                        onClick={fetchProductos}
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
                        <th>Código de Barras</th>
                        <th>Descripción</th>
                        <th>Unidad</th>
                        <th>Peso</th>
                        <th>Stock</th>
                        <th className="d-flex justify-content-center">Opción</th>
                    </tr>
                </thead>
                <tbody>
                    {currentItems.map((prod) => (
                        <tr key={prod.idProducto}>
                            <td>{prod.idProducto}</td>
                            <td>{prod.codigoBarras}</td>
                            <td>{prod.descripcion}</td>
                            <td>{prod.unidadMedida}</td>
                            <td>{prod.peso}</td>
                            <td>{prod.stock}</td>
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
                                                onClick={() => handleEdit(prod)}
                                            >
                                                <i className="bi bi-pencil-square me-1 text-warning"></i>
                                                Editar
                                            </button>
                                        </li>
                                        <li>
                                            <button
                                                className="dropdown-item d-flex align-items-center"
                                                onClick={() => handleDelete(prod.idProducto)}
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

            {/* Modal agregar/editar */}
            {showModal && (
                <div className="modal show d-block" tabIndex="-1">
                    <div className="modal-dialog">
                        <div className="modal-content">
                            <div className="modal-header">
                                <h5 className="modal-title">
                                    {isEditing ? "Editar Producto" : "Agregar Producto"}
                                </h5>
                                <button
                                    type="button"
                                    className="btn-close"
                                    onClick={() => setShowModal(false)}
                                ></button>
                            </div>
                            <div className="modal-body">
                                <form onSubmit={handleSubmit}>
                                    <div className="row">
                                        <div className="mb-3 col-6">
                                            <label>Código de Barras</label>
                                            <input
                                                type="text"
                                                name="codigoBarras"
                                                value={producto.codigoBarras}
                                                onChange={handleInputChange}
                                                className="form-control"
                                                placeholder="1234567890"
                                                required
                                            />
                                        </div>
                                        <div className="mb-3 col-6">
                                            <label>Descripción</label>
                                            <input
                                                type="text"
                                                name="descripcion"
                                                value={producto.descripcion}
                                                onChange={handleInputChange}
                                                className="form-control"
                                                placeholder="Coca Cola 600ml"
                                                required
                                            />
                                        </div>
                                        <div className="mb-3 col-6">
                                            <label>Unidad de Medida</label>
                                            <input
                                                type="text"
                                                name="unidadMedida"
                                                value={producto.unidadMedida}
                                                onChange={handleInputChange}
                                                className="form-control"
                                                placeholder="ml, gr, kg, etc."
                                                required
                                            />
                                        </div>
                                        <div className="mb-3 col-6">
                                            <label>Peso (kg)</label>
                                            <input
                                                type="number"
                                                name="peso"
                                                value={producto.peso}
                                                onChange={handleInputChange}
                                                className="form-control"
                                                min="0.00"
                                                step="0.01"
                                                required
                                            />
                                        </div>
                                        <div className="mb-3 col-6">
                                            <label>Dimensión (cm)</label>
                                            <input
                                                type="text"
                                                name="dimension"
                                                value={producto.dimension}
                                                onChange={handleInputChange}
                                                className="form-control"
                                                placeholder="20x10x5 cm"
                                                required
                                            />
                                        </div>
                                        <div className="mb-3 col-6">
                                            <label>Número de Lote</label>
                                            <input
                                                type="text"
                                                name="numeroLote"
                                                value={producto.numeroLote}
                                                onChange={handleInputChange}
                                                className="form-control"
                                                placeholder="L1234"
                                                required
                                            />
                                        </div>
                                        <div className="mb-3 col-6">
                                            <label>Stock</label>
                                            <input
                                                type="number"
                                                name="stock"
                                                value={producto.stock}
                                                onChange={handleInputChange}
                                                className="form-control"
                                                placeholder="100"
                                                min="0"
                                                step="1"
                                                required
                                            />
                                        </div>
                                    </div>
                                    <div className="modal-footer">
                                        <button type="submit" className="btn btn-success">
                                            {isEditing ? "Guardar Cambios" : "Agregar Producto"}
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

export default ProductoPage;
