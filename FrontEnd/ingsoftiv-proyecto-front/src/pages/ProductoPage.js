import React, { useState } from 'react';
import axios from 'axios';

const ProductoPage = () => {
    // Estado para los datos del producto
    const [producto, setProducto] = useState({
        codigoBarras: '111',
        descripcion: 'Coca Cola 600ml',
        unidadMedida: 'ml',
        peso: '600.00',
        dimension: '20x10x5 cm',
        numeroLote: 'A12345',
        stock: '100'
    });

    // Estado para los mensajes de respuesta
    const [respuesta, setRespuesta] = useState(null);

    // Maneja el cambio en los inputs del formulario
    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setProducto({ ...producto, [name]: value });
    };

    // Maneja el envío del formulario
    const handleSubmit = async (event) => {
        event.preventDefault();
        try {
            // Envía una solicitud POST a la API
            const response = await axios.post('https://localhost:5555/api/Producto/InsertarProducto', producto);

            // Actualiza el estado con la respuesta de la API
            setRespuesta({
                codigo: response.data.codigo,
                mensaje: response.data.mensaje
            });
        } catch (error) {
            // Manejo de errores
            if (error.response) {
                setRespuesta({
                    codigo: error.response.data.codigo,
                    mensaje: error.response.data.mensaje
                });
            } else {
                setRespuesta({
                    codigo: -1,
                    mensaje: 'Error de red o problema desconocido'
                });
            }
        }
    };

    return (
        <div>
            <h5>Agregar Producto</h5>
            <form onSubmit={handleSubmit} className="border p-4">
                <div className="mb-3">
                    <label className="form-label">Código de Barras</label>
                    <input
                        type="text"
                        name="codigoBarras"
                        value={producto.codigoBarras}
                        onChange={handleInputChange}
                        className="form-control"
                        required
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Descripción</label>
                    <input
                        type="text"
                        name="descripcion"
                        value={producto.descripcion}
                        onChange={handleInputChange}
                        className="form-control"
                        required
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Unidad de Medida</label>
                    <input
                        type="text"
                        name="unidadMedida"
                        value={producto.unidadMedida}
                        onChange={handleInputChange}
                        className="form-control"
                        required
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Peso</label>
                    <input
                        type="number"
                        name="peso"
                        value={producto.peso}
                        onChange={handleInputChange}
                        className="form-control"
                        required
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Dimensión</label>
                    <input
                        type="text"
                        name="dimension"
                        value={producto.dimension}
                        onChange={handleInputChange}
                        className="form-control"
                        required
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Número de Lote</label>
                    <input
                        type="text"
                        name="numeroLote"
                        value={producto.numeroLote}
                        onChange={handleInputChange}
                        className="form-control"
                        required
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Stock</label>
                    <input
                        type="number"
                        name="stock"
                        value={producto.stock}
                        onChange={handleInputChange}
                        className="form-control"
                        required
                    />
                </div>
                <button type="submit" className="btn btn-primary">Agregar Producto</button>
            </form>

            {/* Muestra el mensaje de respuesta */}
            {respuesta && (
                <div className={`alert mt-4 ${respuesta.codigo === 0 ? 'alert-success' : 'alert-danger'}`}>
                    {respuesta.mensaje}
                </div>
            )}
        </div>
    );
};

export default ProductoPage;
