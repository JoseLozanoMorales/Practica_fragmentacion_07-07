-- Se ejecuta en pg-campus (guarda los datos publicos):
CREATE TABLE clientes_publicos (
    cliente_id INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ciudad VARCHAR(40) NOT NULL
);

INSERT INTO clientes_publicos VALUES
(1, 'Maria Alvarado', 'Quevedo'),
(2, 'Luis Cedeno', 'Babahoyo'),
(3, 'Ana Vera', 'Quevedo'),
(4, 'Jose Mendoza', 'Ventanas'),
(5, 'Carla Zambrano', 'Ventanas'),
(6, 'Pedro Suarez', 'Babahoyo');