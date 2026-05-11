-- practica_81_02
-- Raúl Bueno

USE bancos;

-- Ejercicio 1
-- Nombre: clientes_por_ciudad
-- Parámetros: ciudad VARCHAR(20)
-- Descripción: Devuelve una lista de clientes que reside en una ciudad específica

DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_por_ciudad $$
CREATE PROCEDURE clientes_por_ciudad(IN p_ciudad VARCHAR(20))
BEGIN
    SELECT * FROM clientes WHERE ciudad = p_ciudad;
END $$

-- Ejercicio 2
-- Nombre: movimientos_cuentas
-- Parámetros: cuenta_id INT UNSIGNED
-- Descripción: Crear un procedimiento que devuelva todos los movimientos de una determinada cuenta. 

DELIMITER $$
DROP PROCEDURE IF EXISTS movimientos_cuentas $$
CREATE PROCEDURE movimientos_cuentas(IN p_cuenta_id INT UNSIGNED)
BEGIN
    SELECT * FROM movimientos WHERE cuenta_id = p_cuenta_id ORDER BY fechahora DESC;
END $$

-- Ejercicio 3
-- Nombre: clientes_cuentas
-- Parámetros: cliente_id INT UNSIGNED
-- Descripción: Crear un procedimiento que devuelva las cuentas de un determinado cliente 

DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_cuentas $$
CREATE PROCEDURE clientes_cuentas(IN p_cliente_id INT UNSIGNED)
BEGIN
    SELECT * FROM cuentas WHERE cliente_id = p_cliente_id;
END $$

-- Ejercicio 4
-- Nombre: clientes_cuentas
-- Parámetros: cliente_id INT UNSIGNED
-- Descripción: Se desea crear un procedimiento llamado SaldosBajos sobre la base de datos bancos,
-- que me devuelva un listado de aquellas cuentas que tienen un saldo inferior o igual a 200 € 

DELIMITER $$
DROP PROCEDURE IF EXISTS SaldosBajos $$
CREATE PROCEDURE SaldosBajos()
BEGIN
    SELECT cuentas.id, cuentas.iban, clientes.nombre, clientes.apellidos, clientes.dni, cuentas.saldo 
    FROM bancos.clientes INNER JOIN bancos.cuentas WHERE clientes.id = cuentas.cliente_id AND cuentas.saldo <= 200;
END $$

-- Ejercicio 5 
-- Nombre: clientes_cuentas
-- Parámetros: cliente_id INT UNSIGNED
-- Descripción: Se desea crear un procedimiento llamado SaldosBajos sobre la base de datos bancos,
-- que me devuelva un listado de aquellas cuentas que tienen un saldo inferior o igual a 200 € 
DELIMITER $$
DROP PROCEDURE IF EXISTS saldo_total_clientes $$
CREATE PROCEDURE saldo_total_clientes()
BEGIN
    SELECT 
        clientes.id AS id_cliente, clientes.nombre, clientes.apellidos, clientes.dni, clientes.ciudad, SUM(cuentas.saldo) AS saldo_total
    FROM clientes INNER JOIN cuentas ON clientes.id = cuentas.cliente_id
    GROUP BY 
        clientes.id;
END $$