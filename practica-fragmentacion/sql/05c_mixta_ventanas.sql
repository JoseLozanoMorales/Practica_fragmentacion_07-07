DROP TABLE IF EXISTS clientes_otros_publicos;

CREATE TABLE clientes_otros_publicos (
    cliente_id INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ciudad VARCHAR(40) NOT NULL,
    CHECK (ciudad IN ('Babahoyo', 'Ventanas'))
);

INSERT INTO clientes_otros_publicos VALUES
(2, 'Luis Cedeno', 'Babahoyo'),
(4, 'Jose Mendoza', 'Ventanas'),
(5, 'Carla Zambrano', 'Ventanas'),
(6, 'Pedro Suarez', 'Babahoyo');

SELECT * FROM clientes_otros_publicos;