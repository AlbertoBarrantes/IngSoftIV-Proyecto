import React from 'react';
import { Table, TableBody, TableCell, TableHead, TableRow, Paper } from '@mui/material';

const ReceivedItemsList = ({ receivedItems }) => {
  return (
    <Paper>
      <Table>
        <TableHead>
          <TableRow>
            <TableCell>Orden de Compra</TableCell>
            <TableCell>Producto</TableCell>
            <TableCell>Cantidad</TableCell>
            <TableCell>Ubicación</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {receivedItems.map((item, index) => (
            <TableRow key={index}>
              <TableCell>{item.purchaseOrder}</TableCell>
              <TableCell>{item.product}</TableCell>
              <TableCell>{item.quantity}</TableCell>
              <TableCell>{item.location || 'Sin asignar'}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </Paper>
  );
};

export default ReceivedItemsList;
