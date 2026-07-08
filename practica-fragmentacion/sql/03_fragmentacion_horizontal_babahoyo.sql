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
(2, 2, 3, '2026-03-01', 2.50, 'Babahoyo'),
(6, 6, 1, '2026-03-03', 0.75, 'Babahoyo'),
(8, 2, 2, '2026-03-04', 1.00, 'Babahoyo');

SELECT * FROM pedidos;