DROP TABLE IF EXISTS pedidos;

CREATE TABLE pedidos (
    pedido_id INTEGER PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    fecha DATE NOT NULL,
    monto NUMERIC(8,2) NOT NULL,
    sede VARCHAR(20) NOT NULL
);

INSERT INTO pedidos VALUES
(4, 4, 4, '2026-03-02', 1.25, 'Ventanas'),
(5, 5, 5, '2026-03-03', 1.00, 'Ventanas');

SELECT * FROM pedidos;