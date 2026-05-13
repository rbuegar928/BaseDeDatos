-- Proyecto de fase de formación en empresas
-- Curso: 1 DAW
-- Alumno: Raúl Bueno García

DROP DATABASE IF EXISTS estudio_tatuajes;
CREATE DATABASE estudio_tatuajes;
USE estudio_tatuajes;

-- Creamos todas las tablas

-- 1. Tabla Clientes
DROP TABLE IF EXISTS clientes;
CREATE TABLE IF NOT EXISTS clientes(
 id_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(50) NOT NULL,
 apellidos VARCHAR(100) NOT NULL,
 email VARCHAR(100) UNIQUE,
 telefono CHAR(9)
);

-- 2. Tabla Tatuadores
DROP TABLE IF EXISTS tatuadores;
CREATE TABLE IF NOT EXISTS tatuadores(
 id_tatuador INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(50) NOT NULL,
 apellidos VARCHAR(100) NOT NULL,
 especialidad VARCHAR(100),
 telefono CHAR(9)
);

-- 3. Tabla Citas
DROP TABLE IF EXISTS citas;
CREATE TABLE IF NOT EXISTS citas(
 id_cita INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 fecha DATE NOT NULL,
 hora TIME NOT NULL,
 estado VARCHAR(50),
 cliente_id INT UNSIGNED NOT NULL,
 tatuador_id INT UNSIGNED NOT NULL
);

-- 4. Tabla Tatuajes
DROP TABLE IF EXISTS tatuajes;
CREATE TABLE IF NOT EXISTS tatuajes(
 id_tatuaje INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 descripcion TEXT,
 zona_cuerpo VARCHAR(100),
 precio DECIMAL(10,2) NOT NULL,
 cita_id INT UNSIGNED NOT NULL
);

-- 5. Tabla Pagos
DROP TABLE IF EXISTS pagos;
CREATE TABLE IF NOT EXISTS pagos(
 id_pago INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 fecha_pago DATE NOT NULL,
 cantidad DECIMAL(10,2) NOT NULL,
 metodo_pago VARCHAR(50),
 tatuaje_id INT UNSIGNED NOT NULL
);

-- Claves ajenas (Sin CASCADE para proteger la integridad)

ALTER TABLE citas
ADD CONSTRAINT fk_citas_cliente
FOREIGN KEY (cliente_id) REFERENCES clientes(id_cliente);

ALTER TABLE citas
ADD CONSTRAINT fk_citas_tatuador
FOREIGN KEY (tatuador_id) REFERENCES tatuadores(id_tatuador);

ALTER TABLE tatuajes
ADD CONSTRAINT fk_tatuajes_cita
FOREIGN KEY (cita_id) REFERENCES citas(id_cita);

ALTER TABLE pagos
ADD CONSTRAINT fk_pagos_tatuaje
FOREIGN KEY (tatuaje_id) REFERENCES tatuajes(id_tatuaje);
