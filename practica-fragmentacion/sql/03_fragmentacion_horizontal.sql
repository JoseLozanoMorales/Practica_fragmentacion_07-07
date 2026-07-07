-- Este script se aplica en cada nodo, pero solo se insertan
-- las filas cuya columna sede coincide con la sede del nodo.

CREATE TABLE pedidos (
    pedido_id INTEGER PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    fecha DATE NOT NULL,
    monto NUMERIC(8,2) NOT NULL,
    sede VARCHAR(20) NOT NULL
);

-- Ejemplo: en pg-babahoyo solo se insertan los pedidos con sede=’Babahoyo’.
INSERT INTO pedidos VALUES (2, 2, 3, ’2026-03-01’, 2.50, ’Babahoyo’);
INSERT INTO pedidos VALUES (6, 6, 1, ’2026-03-03’, 0.75, ’Babahoyo’);
INSERT INTO pedidos VALUES (8, 2, 2, ’2026-03-04’, 1.00, ’Babahoyo’);