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
(1, 1, 1, '2026-03-01', 0.75, 'Campus'),
(3, 3, 2, '2026-03-02', 1.00, 'Campus'),
(7, 1, 3, '2026-03-04', 2.50, 'Campus');

SELECT * FROM pedidos;