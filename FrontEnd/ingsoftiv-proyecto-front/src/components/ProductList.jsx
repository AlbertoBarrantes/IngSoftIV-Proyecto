import React from 'react';
import { Table, TableBody, TableCell, TableHead, TableRow, Paper } from '@mui/material';

const ProductList = ({ products }) => {
  return (
    <Paper>
      <Table>
        <TableHead>
          <TableRow>
            <TableCell>Código de Barras</TableCell>
            <TableCell>Descripción</TableCell>
            <TableCell>Stock</TableCell>
            <TableCell>Ubicación</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {products.map((product, index) => (
            <TableRow key={index}>
              <TableCell>{product.barcode}</TableCell>
              <TableCell>{product.description}</TableCell>
              <TableCell>{product.stock}</TableCell>
              <TableCell>{product.location}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </Paper>
  );
};

export default ProductList;
