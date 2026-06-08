-- practica_86_02
-- Raúl Bueno

USE bancos;

-- ACTIVIDAD 1
-- Evento: movimientos_semanales
-- Genera un CSV con los movimientos de la semana

SET GLOBAL event_scheduler = ON;

DELIMITER $$

CREATE EVENT movimientos_semanales
ON SCHEDULE
    EVERY 1 WEEK STARTS '2026/05/25 00:00:00'
DO
BEGIN

    SELECT * INTO OUTFILE '/var/lib/mysql-files/moviweek.csv'
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    FROM movimientos
    WHERE fecha_movimiento >= DATE_SUB(NOW(), INTERVAL 7 DAY);

END$$

DELIMITER ;


-- ACTIVIDAD 2
-- Evento: verificacion_saldo_diario
-- Ejecuta diariamente el procedimiento actualizar_saldo

DELIMITER $$

CREATE EVENT verificacion_saldo_diario
ON SCHEDULE 
    EVERY 1 DAY STARTS '2026/05/23 00:00:00'
DO
BEGIN

    CALL actualizar_saldo();

END$$

DELIMITER ;


-- ACTIVIDAD 3
-- Evento: verificacion_cliente_mensual
-- Genera CSV con clientes que tienen cuentas en rojo

DELIMITER $$

CREATE EVENT verificacion_cliente_mensual
ON SCHEDULE
    EVERY 1 MONTH
    STARTS CURRENT_TIMESTAMP
DO
BEGIN

    SELECT 
        clientes.id_cliente,
        clientesc.nombre,
        clientes.apellidos,
        clientes.email,
        cuentas.iban,
        cuentas.saldo
    INTO OUTFILE '/var/lib/mysql-files/clientesenrojo.csv'
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    FROM clientes
    INNER JOIN cuentas 
        ON clientes.id_cliente = cuentas.id_cliente
    WHERE cu.saldo < 0;

END$$

DELIMITER ;