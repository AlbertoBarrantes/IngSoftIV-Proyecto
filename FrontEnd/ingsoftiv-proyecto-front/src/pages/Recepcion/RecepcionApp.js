
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';

function RecepcionApp() {
    const [recepciones, setRecepciones] = useState([]);
    const [formData, setFormData] = useState({
        productoID: '',
        ordenCompraID: '',
        cantidad: '',
        fechaRecepcion: ''
    });
    const [editId, setEditId] = useState(null);
    const apiUrl = 'https://localhost:5555/api/Recepcion';
    const [productos, setProductos] = useState([]);
    const [ordenesCompra, setOrdenesCompra] = useState([]);



    // Obtener recepciones desde la API
    const fetchRecepciones = async () => {
        try {
            const response = await axios.get(apiUrl);
            setRecepciones(response.data);
        } catch (error) {
            console.error('Error al obtener las recepciones:', error);
        }
    };



    // Obtener productos desde la API
    const fetchProductos = async () => {
        try {
            const response = await axios.get('https://localhost:5555/api/Producto');
            setProductos(response.data);
        } catch (error) {
            console.error('Error al obtener los productos:', error);
        }
    };



    // Obtener ordenes de compra desde la API
    const fetchOrdenesCompra = async () => {
        try {
            const response = await axios.get(`https://localhost:5555/api/OrdenCompra`);
            setOrdenesCompra(response.data);
        } catch (error) {
            console.error("Error al obtener las ordenes de compra:", error);
        }
    };



    // Cargar datos al inicio
    useEffect(() => {
        try {
            fetchRecepciones();
            fetchProductos();
            fetchOrdenesCompra();
        } catch (error) {
            alert('Error al cargar datos desde la API:', error);
        }
    }, []);



    // Manejar cambios en el formulario
    const handleChange = (e) => {
        setFormData({ ...formData, [e.target.name]: e.target.value });
    };



    // Crear o actualizar recepción
    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            if (editId) {
                await axios.put(`${apiUrl}/${editId}`, formData);
            } else {
                await axios.post(apiUrl, formData);
            }
            setFormData({ productoID: '', ordenCompraID: '', cantidad: '', fechaRecepcion: '' });
            setEditId(null);
            fetchRecepciones();
        } catch (error) {
            console.error('Error al guardar la recepción:', error);
        }
    };



    // Eliminar recepción
    const handleDelete = async (id) => {
        try {
            await axios.delete(`${apiUrl}/${id}`);
            fetchRecepciones();
            alert('Recepción eliminada correctamente');
        } catch (error) {
            console.error('Error al eliminar la recepción:', error);
        }
    };



    // Editar recepción
    const handleEdit = (recepcion) => {
        setFormData({
            productoID: recepcion.productoID,
            ordenCompraID: recepcion.ordenCompraID,
            cantidad: recepcion.cantidad,
            fechaRecepcion: recepcion.fechaRecepcion.split('T')[0]
        });
        setEditId(recepcion.idRecepcion);
    };



    return (
        <div className="container mt-4">
            <h1>Gestor de Recepciones</h1>

            {/* Formulario */}
            <form onSubmit={handleSubmit} className="mb-4">
                <div className="row mt-3">
                    <div className="form-group col">
                        {/* Select de productos */}
                        <label>Producto</label>
                        <select
                            name="productoID"
                            className="form-select"
                            value={formData.productoID}
                            onChange={handleChange}
                            required
                        >
                            <option value="">Seleccione un producto</option>
                            {productos.map((producto) => (
                                <option key={producto.idProducto} value={producto.idProducto}>
                                    ID: {producto.idProducto}&emsp;{producto.descripcion}
                                </option>
                            ))}
                        </select>
                    </div>
                    <div className="form-group col">
                        {/* Select de ordenes de compra */}
                        <label>Orden de Compra</label>
                        <select
                            name="ordenCompraID"
                            className="form-select"
                            value={formData.ordenCompraID}
                            onChange={handleChange}
                            required
                        >
                            <option value="">Seleccione una orden de compra</option>
                            {ordenesCompra.map((orden) => (
                                <option key={orden.idOrdenCompra} value={orden.idOrdenCompra}>
                                    ID: {orden.idOrdenCompra}&emsp;Fecha: {orden.fechaOrden}
                                </option>
                            ))}
                        </select>
                    </div>
                </div>

                <div className="row mt-3">
                    <div className="form-group col">
                        <label>Cantidad</label>
                        <input
                            type="number"
                            name="cantidad"
                            min={1}
                            defaultValue={1}
                            className="form-control"
                            value={formData.cantidad}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <div className="form-group col">
                        <label>Fecha Recepción</label>
                        <input
                            type="date"
                            name="fechaRecepcion"
                            className="form-control"
                            value={formData.fechaRecepcion}
                            onChange={handleChange}
                            required
                        />
                    </div>
                </div>
                <button type="submit" className="btn btn-primary mt-3">
                    {editId ? 'Actualizar' : 'Crear'} Recepción
                </button>
            </form>

            {/* Lista de recepciones */}
            <table className="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Producto ID</th>
                        <th>Orden Compra ID</th>
                        <th>Cantidad</th>
                        <th>Fecha Recepción</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    {recepciones.map((recepcion) => (
                        <tr key={recepcion.idRecepcion}>
                            <td>{recepcion.idRecepcion}</td>
                            <td>{recepcion.productoID}</td>
                            <td>{recepcion.ordenCompraID}</td>
                            <td>{recepcion.cantidad}</td>
                            <td>{new Date(recepcion.fechaRecepcion).toLocaleDateString()}</td>
                            <td>
                                <button
                                    className="btn btn-warning btn-sm mr-2"
                                    onClick={() => handleEdit(recepcion)}
                                >
                                    Editar
                                </button>
                                <button
                                    className="btn btn-danger btn-sm"
                                    onClick={() => handleDelete(recepcion.idRecepcion)}
                                >
                                    Eliminar
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default RecepcionApp;
