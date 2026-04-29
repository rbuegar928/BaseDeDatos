-- Actividad: 5.15
-- Tema: Lenguaje SQL - DDL
-- Módulo: Base de Datos
-- Curso: 25/26
-- Nombre: Raúl Bueno

-- CREACIÓN BASE DE DATOS
DROP DATABASE IF EXISTS libros_almacen;
CREATE DATABASE libros_almacen;
USE libros_almacen;

-- Creación de tablas
CREATE TABLE Provincias (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_almacen INT
);

CREATE TABLE Poblaciones (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    habitantes INT,
    id_provincia INT NOT NULL,
CONSTRAINT fk_poblaciones_provincias FOREIGN KEY (id_provincia) REFERENCES Provincias(id)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Almacenes (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha DATE,
    id_provincia INT NOT NULL,
CONSTRAINT fk_almacenes_provincias FOREIGN KEY (id_provincia) REFERENCES Provincias(id)
ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE Provincias
ADD CONSTRAINT fk_provincias_almacenes FOREIGN KEY (id_almacen) REFERENCES Almacenes(id)
ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE Libros (
    id INT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(150),
    precio DECIMAL(8,2)
);

CREATE TABLE Socios (
    id INT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    codsocio VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    dni VARCHAR(15),
    id_poblacion INT NOT NULL,
    id_socio_avalista INT,
CONSTRAINT fk_socios_poblaciones FOREIGN KEY (id_poblacion) REFERENCES Poblaciones(id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_socios_avalista FOREIGN KEY (id_socio_avalista) REFERENCES Socios(id)
ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Pedidos (
    id INT PRIMARY KEY,
    fecha DATE,
    envio VARCHAR(100),
    id_socio INT NOT NULL,
CONSTRAINT fk_pedidos_socios FOREIGN KEY (id_socio) REFERENCES Socios(id)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Educacion (
    id_libro INT PRIMARY KEY,
    curso VARCHAR(50),
    asignatura VARCHAR(100),
CONSTRAINT fk_educacion_libros FOREIGN KEY (id_libro) REFERENCES Libros(id)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Lectura (
    id_libro INT PRIMARY KEY,
    tipo VARCHAR(50),
    genero VARCHAR(50),
CONSTRAINT fk_lectura_libros FOREIGN KEY (id_libro) REFERENCES Libros(id)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE LibrosPedidos (
    id_pedido INT,
    id_libro INT,
    unidades INT,
    precio DECIMAL(8,2),
    PRIMARY KEY (id_pedido, id_libro),
CONSTRAINT fk_librospedidos_pedidos FOREIGN KEY (id_pedido) REFERENCES Pedidos(id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_librospedidos_libros FOREIGN KEY (id_libro) REFERENCES Libros(id)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE AlmacenesLibros (
    id_almacen INT,
    id_libro INT,
    stock INT,
    PRIMARY KEY (id_almacen, id_libro),
CONSTRAINT fk_almaceneslibros_almacenen FOREIGN KEY (id_almacen) REFERENCES Almacenes(id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_almaceneslibros_libros  FOREIGN KEY (id_libro) REFERENCES Libros(id)
ON DELETE CASCADE ON UPDATE CASCADE
);