const apiUrl = 'http://localhost:5000/api'; // Cambia esta URL según el puerto de tu API.

const fetchData = async (endpoint) => {
  const response = await fetch(`${apiUrl}/${endpoint}`);
  const data = await response.json();
  return data;
};

const postData = async (endpoint, data) => {
  const response = await fetch(`${apiUrl}/${endpoint}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  });
  return response.json();
};

const putData = async (endpoint, data) => {
  const response = await fetch(`${apiUrl}/${endpoint}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  });
  return response.json();
};

const deleteData = async (endpoint) => {
  const response = await fetch(`${apiUrl}/${endpoint}`, {
    method: 'DELETE'
  });
  return response.json();
};

export { fetchData, postData, putData, deleteData };
