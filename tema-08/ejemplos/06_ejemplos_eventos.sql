-- Active: 1777278237175@@127.0.0.1@3306@bancos
-- Ejemplos de eventos en SQL

use bancos;

-- Variable global scheduler para activar el programadador de eventos
SET GLOBAL event_scheduler = ON;
SHOW VARIABLES LIKE 'event_scheduler';

-- Crear evento
-- Listado de clientes
-- Solo una vez
-- a las 9:35
DELIMITER $$
CREATE EVENT listado_clientes
ON SCHEDULE AT '2026-05-24 09:35:00'
DO
BEGIN
    SELECT * FROM bancos.clientes;
END$$