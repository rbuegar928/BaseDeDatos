-- Actividad: 5.16
-- Tema: Lenguaje SQL - DDL
-- Módulo: Base de Datos
-- Curso: 25/26
-- Nombre: Raúl Bueno

USE libros_almacen;

-- 1. Creamos la tabla autores

CREATE TABLE Autores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    nacionalidad VARCHAR(100),
    fechaNac DATE,
    estilo VARCHAR(100)
);

-- 2. Modificamos la tabla libros

-- Eliminar columna autor
ALTER TABLE Libros
DROP COLUMN autor;

-- Añadir columna autor_id
ALTER TABLE Libros
ADD COLUMN autor_id INT;

-- Añadir foreign key autor_id en autores
ALTER TABLE Libros
ADD CONSTRAINT fk_libros_autores
    FOREIGN KEY (autor_id)
    REFERENCES Autores(id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- Añadir nuevas columnas
ALTER TABLE Libros
ADD COLUMN ISBN CHAR(13) UNIQUE,
ADD COLUMN EAN CHAR(13) UNIQUE,
ADD COLUMN categorias SET('DRAMA','NOVELA','COMEDIA'),
ADD COLUMN tipo_lector ENUM('infantil','juvenil','adulto','mayor'),
ADD COLUMN fecha_edicion DATE;

-- 3. Modificamos la tabla socios

-- UNIQUE  teléfono
ALTER TABLE Socios
ADD CONSTRAINT uq_socios_telefono UNIQUE (telefono);

-- Añadir nuevas columnas
ALTER TABLE Socios
ADD COLUMN direccion VARCHAR(255),
ADD COLUMN poblacion VARCHAR(100),
ADD COLUMN c_postal CHAR(10),
ADD COLUMN provincia VARCHAR(100),
ADD COLUMN nacionalidad VARCHAR(100),
ADD COLUMN valoracion DECIMAL(3,1);

-- Restricción valoracion 0–10
ALTER TABLE Socios
ADD CONSTRAINT chk_valoracion
CHECK (valoracion BETWEEN 0 AND 10);

-- Modificar columna nombre en socio
ALTER TABLE Socios
CHANGE nombre socio VARCHAR(255) NOT NULL;

-- 4. Modificamos la tabla LibrosPedidos

ALTER TABLE LibrosPedidos
ADD COLUMN descuento DECIMAL(4,3),
ADD COLUMN importe DECIMAL(10,2);

-- Restricción descuento 0–1
ALTER TABLE LibrosPedidos
ADD CONSTRAINT chk_descuento
CHECK (descuento BETWEEN 0 AND 1);

-- 5. Creación de índices

-- Índice titulo de Libros
CREATE INDEX idx_libros_titulo
ON Libros(titulo);

-- Índice fecha de Pedidos
CREATE INDEX idx_pedidos_fecha
ON Pedidos(fecha);

-- Índice nombre de Almacenes
CREATE INDEX idx_almacenes_nombre
ON Almacenes(nombre);

-- Índice socio de Socios
CREATE INDEX idx_socios_nombre
ON Socios(socio);
