-- Actividad: 5.11
-- Tema: Lenguaje SQL - DDL
-- Módulo: Base de Datos
-- Curso: 25/26
-- Nombre: Raúl Bueno

USE restricciones_check;

DROP TABLE IF EXISTS operadorLike;
CREATE TABLE IF NOT EXISTS operadorLike(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT CHECK (descripcion LIKE 'a%'),
    nombre VARCHAR(20) CHECK (nombre LIKE 'ju%'),
    email VARCHAR(255) CHECK (email LIKE '%@%'),
    clave_acceso VARCHAR(255) CHECK (clave_acceso LIKE '__M____%'),
    cpostal CHAR(5) CHECK (cpostal LIKE '11___'),
    codigo CHAR(7) CHECK (codigo LIKE 'ES____9')
); 
