DROP TABLE IF EXISTS clientes_quevedo_contacto;
DROP TABLE IF EXISTS clientes_otros_contacto;

CREATE TABLE clientes_quevedo_contacto (
    cliente_id INTEGER PRIMARY KEY,
    email VARCHAR(120) NOT NULL,
    telefono VARCHAR(20)
);

CREATE TABLE clientes_otros_contacto (
    cliente_id INTEGER PRIMARY KEY,
    email VARCHAR(120) NOT NULL,
    telefono VARCHAR(20)
);

INSERT INTO clientes_quevedo_contacto VALUES
(1, 'maria@uteq.edu.ec', '0991111111'),
(3, 'ana@uteq.edu.ec', '0993333333');

INSERT INTO clientes_otros_contacto VALUES
(2, 'luis@uteq.edu.ec', '0992222222'),
(4, 'jose@uteq.edu.ec', '0994444444'),
(5, 'carla@uteq.edu.ec', '0995555555'),
(6, 'pedro@uteq.edu.ec', '0996666666');

SELECT * FROM clientes_quevedo_contacto;
SELECT * FROM clientes_otros_contacto;