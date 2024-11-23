import React from 'react';
import { useForm } from 'react-hook-form';
import { TextField, Button, Grid } from '@mui/material';

const ProductForm = ({ onSubmit }) => {
  const { register, handleSubmit, reset } = useForm();

  const submitHandler = (data) => {
    onSubmit(data);
    reset(); // Limpiar el formulario después de enviar
  };

  return (
    <form onSubmit={handleSubmit(submitHandler)}>
      <Grid container spacing={2}>
        <Grid item xs={12}>
          <TextField
            label="Código de barras"
            fullWidth
            {...register('barcode', { required: 'Código de barras es obligatorio' })}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            label="Descripción"
            fullWidth
            {...register('description', { required: 'Descripción es obligatoria' })}
          />
        </Grid>
        <Grid item xs={6}>
          <TextField
            label="Unidades de medida"
            fullWidth
            {...register('unit')}
          />
        </Grid>
        <Grid item xs={6}>
          <TextField
            label="Peso (kg)"
            fullWidth
            type="number"
            {...register('weight')}
          />
        </Grid>
        <Grid item xs={6}>
          <TextField
            label="Dimensiones"
            fullWidth
            {...register('dimensions')}
          />
        </Grid>
        <Grid item xs={6}>
          <TextField
            label="Número de lote o serie"
            fullWidth
            {...register('lotNumber')}
          />
        </Grid>
        <Grid item xs={6}>
          <TextField
            label="Stock"
            fullWidth
            type="number"
            {...register('stock', { required: 'Stock es obligatorio' })}
          />
        </Grid>
        <Grid item xs={6}>
          <TextField
            label="Ubicación (Pasillo - Estante)"
            fullWidth
            {...register('location')}
          />
        </Grid>
        <Grid item xs={12}>
          <Button type="submit" variant="contained" color="primary">
            Registrar Producto
          </Button>
        </Grid>
      </Grid>
    </form>
  );
};

export default ProductForm;
