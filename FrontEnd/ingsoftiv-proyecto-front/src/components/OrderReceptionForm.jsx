import React from 'react';
import { useForm } from 'react-hook-form';
import { TextField, Button, Grid } from '@mui/material';

const OrderReceptionForm = ({ onReceive }) => {
  const { register, handleSubmit, reset } = useForm();

  const submitHandler = (data) => {
    onReceive(data); // Llama a la función de recepción
    reset(); // Limpia el formulario
  };

  return (
    <form onSubmit={handleSubmit(submitHandler)}>
      <Grid container spacing={2}>
        <Grid item xs={12}>
          <TextField
            label="Orden de Compra"
            fullWidth
            {...register('purchaseOrder', { required: 'La orden de compra es obligatoria' })}
          />
        </Grid>
        <Grid item xs={6}>
          <TextField
            label="Producto (ID o Nombre)"
            fullWidth
            {...register('product', { required: 'El producto es obligatorio' })}
          />
        </Grid>
        <Grid item xs={6}>
          <TextField
            label="Cantidad Recibida"
            fullWidth
            type="number"
            {...register('quantity', { required: 'La cantidad es obligatoria' })}
          />
        </Grid>
        <Grid item xs={12}>
          <Button type="submit" variant="contained" color="primary">
            Registrar Recepción
          </Button>
        </Grid>
      </Grid>
    </form>
  );
};

export default OrderReceptionForm;
