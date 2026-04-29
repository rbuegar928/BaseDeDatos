-- ejemplo 5.2
-- Creación de tabla

-- 1.alter-- Seleciionar Base de Datos activa
USE geslibros;

-- 2.
-- Crear la tbala libros
-- id, titulo, precio, autor, editorial, paginas

DROP TABLE IF EXISTS libros;
CREATE TABLE IF NOT EXISTS libros (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(40),
    autor VARCHAR(50),
    editorial VARCHAR(20),
    pagina SMALLINT UNSIGNED,
    fecha_edicion DATE,
    precio DECIMAL(10,2)
);

-- 3.
-- insertar un libro
INSERT INTO libros VALUES (
	null,
    'La historia Interminable',
    'Mikel Ende',
    'Somosagua',
    340,
    '2025/12/12',
    37.80
);