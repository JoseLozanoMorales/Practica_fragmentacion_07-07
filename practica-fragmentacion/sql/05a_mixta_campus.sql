DROP TABLE IF EXISTS clientes_quevedo_publicos;

CREATE TABLE clientes_quevedo_publicos (
    cliente_id INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ciudad VARCHAR(40) NOT NULL,
    CHECK (ciudad = 'Quevedo')
);

INSERT INTO clientes_quevedo_publicos VALUES
(1, 'Maria Alvarado', 'Quevedo'),
(3, 'Ana Vera', 'Quevedo');

SELECT * FROM clientes_quevedo_publicos;