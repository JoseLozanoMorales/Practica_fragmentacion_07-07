CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ciudad VARCHAR(40) NOT NULL,
    email VARCHAR(120) NOT NULL,
    telefono VARCHAR(20)
);

CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    categoria VARCHAR(30) NOT NULL,
    precio NUMERIC(6,2) NOT NULL CHECK (precio >= 0)
);

CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES clientes(cliente_id),
    producto_id INTEGER NOT NULL REFERENCES productos(producto_id),
    fecha DATE NOT NULL,
    monto NUMERIC(8,2) NOT NULL CHECK (monto >= 0),
    sede VARCHAR(20) NOT NULL
);