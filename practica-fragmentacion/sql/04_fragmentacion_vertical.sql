-- Se ejecuta en pg-campus (guarda los datos publicos):
CREATE TABLE clientes_publicos (
    cliente_id INTEGER PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ciudad VARCHAR(40) NOT NULL
);

INSERT INTO clientes_publicos VALUES
(1, ’Maria Alvarado’, ’Quevedo’),
(2, ’Luis Cedeno’, ’Babahoyo’),
(3, ’Ana Vera’, ’Quevedo’),
(4, ’Jose Mendoza’, ’Ventanas’),
(5, ’Carla Zambrano’, ’Ventanas’),
(6, ’Pedro Suarez’, ’Babahoyo’);

-- Se ejecuta en pg-babahoyo (guarda los datos de contacto):
CREATE TABLE clientes_contacto (
    cliente_id INTEGER PRIMARY KEY, -- misma PK que en el otro fragmento
    email VARCHAR(120) NOT NULL,
    telefono VARCHAR(20)
);

INSERT INTO clientes_contacto VALUES
 (1, ’maria@uteq.edu.ec’, ’0991111111’),
 (2, ’luis@uteq.edu.ec’, ’0992222222’),
 (3, ’ana@uteq.edu.ec’, ’0993333333’),
 (4, ’jose@uteq.edu.ec’, ’0994444444’),
 (5, ’carla@uteq.edu.ec’, ’0995555555’),
 (6, ’pedro@uteq.edu.ec’, ’0996666666’);