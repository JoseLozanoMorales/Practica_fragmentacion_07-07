INSERT INTO clientes (nombre, ciudad, email, telefono) VALUES
('Maria Alvarado', 'Quevedo', 'maria@uteq.edu.ec', '0991111111'),
('Luis Cedeno', 'Babahoyo', 'luis@uteq.edu.ec', '0992222222'),
('Ana Vera', 'Quevedo', 'ana@uteq.edu.ec', '0993333333'),
('Jose Mendoza', 'Ventanas', 'jose@uteq.edu.ec', '0994444444'),
('Carla Zambrano', 'Ventanas', 'carla@uteq.edu.ec', '0995555555'),
('Pedro Suarez', 'Babahoyo', 'pedro@uteq.edu.ec', '0996666666');

INSERT INTO productos (nombre, categoria, precio) VALUES
('Cafe negro', 'bebida', 0.75),
('Cafe con leche', 'bebida', 1.00),
('Sanduche pollo', 'comida', 2.50),
('Jugo natural', 'bebida', 1.25),
('Empanada', 'comida', 1.00);

INSERT INTO pedidos (cliente_id, producto_id, fecha, monto, sede) VALUES
(1, 1, '2026-03-01', 0.75, 'Campus'),
(2, 3, '2026-03-01', 2.50, 'Babahoyo'),
(3, 2, '2026-03-02', 1.00, 'Campus'),
(4, 4, '2026-03-02', 1.25, 'Ventanas'),
(5, 5, '2026-03-03', 1.00, 'Ventanas'),
(6, 1, '2026-03-03', 0.75, 'Babahoyo'),
(1, 3, '2026-03-04', 2.50, 'Campus'),
(2, 2, '2026-03-04', 1.00, 'Babahoyo');