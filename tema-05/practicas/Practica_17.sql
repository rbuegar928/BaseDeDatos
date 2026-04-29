-- Actividad: 5.17
-- Tema: Lenguaje SQL - DDL
-- Módulo: Base de Datos
-- Curso: 25/26
-- Nombre: Raúl Bueno

-- Creación de Base de Datos
DROP DATABASE IF EXISTS curtipiel;
CREATE DATABASE IF NOT EXISTS curtipiel;
USE curtipiel;

-- Creación de tablas
CREATE TABLE Departamentos (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    funcion VARCHAR(100)
);

CREATE TABLE Categorias (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)  NOT NULL,
    salarioBase DECIMAL(10,2) NOT NULL
);

CREATE TABLE Empleados (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    dir VARCHAR(200),
    poblacion VARCHAR(60),
    email VARCHAR(100) UNIQUE,
    telefono CHAR(9),
    dni CHAR(9) UNIQUE NOT NULL,
    nss CHAR(11) UNIQUE,
    departamento_id INT UNSIGNED,
    categoria_id INT UNSIGNED,
    FOREIGN KEY (departamento_id) REFERENCES Departamentos(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Almacen (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ubicacion VARCHAR(150) NOT NULL,
    idEmpleado INT UNSIGNED,
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Estante (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    idAlmacen INT UNSIGNED NOT NULL,
    descripcion VARCHAR(255),
    FOREIGN KEY (idAlmacen) REFERENCES Almacen(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Familias (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE Articulos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigoInterno VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    precioCoste DECIMAL(10,2) NOT NULL,
    precioVenta DECIMAL(10,2) NOT NULL,
    unidades INT UNSIGNED DEFAULT 0,
    idAlmacen INT UNSIGNED,
    idEstante INT UNSIGNED,
    idFamilia INT UNSIGNED,
    FOREIGN KEY (idAlmacen) REFERENCES Almacen(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idEstante) REFERENCES Estante(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idFamilia) REFERENCES Familias(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Regiones (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Provincias (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    idRegion INT UNSIGNED,
    FOREIGN KEY (idRegion) REFERENCES Regiones(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Poblaciones (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    idProvincia INT UNSIGNED,
    FOREIGN KEY (idProvincia) REFERENCES Provincias(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Clientes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    contacto VARCHAR(150),
    cif VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    web VARCHAR(200),
    direccion VARCHAR(200),
    telefono CHAR(9) UNIQUE,
    movil CHAR(9) UNIQUE,
    cpostal CHAR(5),
    idPoblacion INT UNSIGNED,
    idProvincia INT UNSIGNED,
    idRegion INT UNSIGNED,
    FOREIGN KEY (idPoblacion) REFERENCES Poblaciones(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idProvincia) REFERENCES Provincias(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idRegion) REFERENCES Regiones(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Ventas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numVenta VARCHAR(15) UNIQUE NOT NULL,
    fecha DATE NOT NULL,
    importeTotal DECIMAL(10,2),
    idCliente INT UNSIGNED,
    formaPago VARCHAR(50),
    observaciones TEXT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE DetallesVentas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    idVenta INT UNSIGNED NOT NULL,
    idArticulo INT UNSIGNED NOT NULL,
    precio DECIMAL(10,2),
    unidades INT UNSIGNED NOT NULL,
    descuento DECIMAL(5,2),
    iva DECIMAL(5,2),
    importeSinIva DECIMAL(10,2),
    importeConIva DECIMAL(10,2),
    FOREIGN KEY (idVenta) REFERENCES Ventas(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idArticulo) REFERENCES Articulos(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Modificaciones y Actualizaciones

ALTER TABLE Clientes
ADD observaciones TEXT,
ADD imagen VARCHAR(150);

ALTER TABLE Articulos
ADD stockMinimo INT UNSIGNED,
ADD stockMaximo INT UNSIGNED,
ADD CONSTRAINT chk_stock_minimo CHECK (stockMinimo <= 10),
ADD CONSTRAINT chk_stock_maximo CHECK (stockMaximo <= 1000);

-- Búsqueda de datos
CREATE INDEX idx_clientes_nombre
ON Clientes(nombre);

CREATE INDEX idx_articulos_descripcion
ON Articulos(descripcion);

CREATE INDEX idx_empleados_nombre_apellido
ON Empleados(apellidos, nombre);