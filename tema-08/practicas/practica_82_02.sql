-- Active: 1777278237175@@127.0.0.1@3306@bancos
-- practica_82_02
-- Raúl Bueno

USE Bancos;

DELIMITER $$

-- ACTIVIDAD 1 - FUNCIÓN saldo_total
-- Devuelve la suma total del saldo de todas las cuentas
DROP FUNCTION IF EXISTS saldo_total $$
CREATE FUNCTION saldo_total()
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(saldo) INTO total
    FROM cuentas;
    RETURN total;
END$$


-- ACTIVIDAD 2 - FUNCIÓN mejor_cliente
-- Devuelve el id del cliente con la cuenta de mayor saldo
DROP FUNCTION IF EXISTS mejor_cliente $$
CREATE FUNCTION mejor_cliente()
RETURNS INT
BEGIN
    DECLARE idCliente INT;

    SELECT cliente_id
    INTO idCliente
    FROM cuentas
    ORDER BY saldo DESC
    LIMIT 1;

    RETURN idCliente;
END$$

-- ACTIVIDAD 3 - FUNCIÓN saldo_cuentas
-- Calcula el saldo real a partir de los movimientos
DROP FUNCTION IF EXISTS saldo_cuentas $$
CREATE FUNCTION saldo_cuentas(p_cuenta_id INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE saldo_total DECIMAL(10,2);

    SELECT 
        SUM(cantidad)
    INTO saldo_total
    FROM movimientos
    WHERE cuenta_id = p_cuenta_id;

    RETURN (saldo_total);
END$$

-- ACTIVIDAD 4 - PROCEDIMIENTO verificar_saldo
-- Comprueba si el saldo almacenado coincide
DROP FUNCTION IF EXISTS verificar_saldo $$
CREATE PROCEDURE verificar_saldo(IN p_cuenta_id INT UNSIGNED)
BEGIN
    DECLARE saldo_tabla DECIMAL(10,2);
    DECLARE saldo_verificado DECIMAL(10,2);

    SELECT saldo
    INTO saldo_tabla
    FROM cuentas
    WHERE id = p_cuenta_id;

    SET saldo_verificado = saldo_cuentas(p_cuenta_id);

    IF saldo_tabla <> saldo_verificado THEN

        SELECT * FROM cuentas
        WHERE id = p_cuenta_id;
    END IF;
END $$

-- ACTIVIDAD 5 - PROCEDIMIENTO auditar_saldo
-- Corrige el saldo si no coincide
DROP PROCEDURE IF EXISTS auditar_saldo $$
CREATE PROCEDURE auditar_saldo(IN p_cuenta_id INT UNSIGNED)
BEGIN
    DECLARE saldo_tabla DECIMAL(10,2);
    DECLARE saldo_real DECIMAL(10,2);

    SELECT saldo
    INTO saldo_tabla
    FROM cuentas
    WHERE id = p_cuenta_id;

    SET saldo_real = saldo_cuentas(p_cuenta_id);

    IF saldo_tabla <> saldo_real THEN

        UPDATE cuentas
        SET saldo = saldo_real
        WHERE id = p_cuenta_id;
    END IF;
END $$