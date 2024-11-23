import React from 'react';
import { Grid, Button, TextField, Select, MenuItem, FormControl, InputLabel } from '@mui/material';

const StorageAssignment = ({ items, onAssign }) => {
  const handleAssign = (item, location) => {
    onAssign(item, location); // Llama a la función de asignación
  };

  return (
    <Grid container spacing={2}>
      {items.map((item, index) => (
        <Grid item xs={12} key={index}>
          <h3>{item.product} (Cantidad: {item.quantity})</h3>
          <FormControl fullWidth>
            <InputLabel>Ubicación</InputLabel>
            <Select
              onChange={(e) => handleAssign(item, e.target.value)}
              defaultValue=""
            >
              <MenuItem value="Pasillo A - Estante 1">Pasillo A - Estante 1</MenuItem>
              <MenuItem value="Pasillo B - Estante 2">Pasillo B - Estante 2</MenuItem>
              <MenuItem value="Pasillo C - Estante 3">Pasillo C - Estante 3</MenuItem>
            </Select>
          </FormControl>
        </Grid>
      ))}
    </Grid>
  );
};

export default StorageAssignment;
