-- Practica_75_02
-- Raúl Bueno
-- Descripción: Bloqueo de tablas y filas

USE geslibros;

-- 1. Creación de dos usuarios
CREATE USER ubrique_01@localhost IDENTIFIED BY 'ubrique01';
CREATE USER arcos_01@localhost IDENTIFIED BY 'arcos01';

-- Asignacción de privilegios
GRANT ALL PRIVILEGES ON *.* TO ubrique_01@localhost, arcos@localhost;

