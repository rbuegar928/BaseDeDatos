-- Actividad 6.1
-- Tema 6 Lenguaje SQL - DDL
-- Base de Datos 25/26
-- Alumno: Raúl Bueno

USE proyectos;

-- 1. Añadir los detalles de 5 clientes oinsert values

INSERT INTO clientes VALUES
(null, 'Ayuntamiento de Ubrique','12345678T'),
(null, 'Almaceén Maderero García', '12344478G'),
(null, 'Curtisierra','12345678O'),
(null, 'Sierrapieles','87654321F'),
(null, 'Junove','87654321H');

-- 2. Añadir detalles de un cliente INSERT SET
INSERT INTO clientes set
	nombre = 'Infosama Ubrique',
    nif = '47692602';

-- 3. Añadir 5 proyectos con INSERT VALUES
INSERT INTO proyectos VALUES
(null, 'Puente Romano Puerto Serrano', 'Salida de Puerto Serrano a Sevilla', 34000.0, 1, null, 'Presupuestado'),
(null, 'Puerta en arco Villamartín', 'Salida de Villamartín a Prado del Rey', 21000.0, 1, null, 'Presupuestado'),
(null, 'Torre de Madera', 'Entrada de Ubrique', 16000.0, 1, null, 'Presupuestado'),
(null, 'Vitrina Trofeos', 'Museo de Algodonales', 1250.0, 1, null, 'Presupuestado'),
(null, 'Fuente Retro', 'Plaza de Prado del Rey', 13000.0, 1, null, 'Presupuestado');

-- 4. Añadir 1 proyecto con INSERT SET

-- 5. Añadir 5 empleados con INSERT VALUES

-- 6. Añadir 1 empleado con INSERT SET
