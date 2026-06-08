-- Active: 1777278238524@@127.0.0.1@3306
-- Ejercicio 1. clasificar_cuenta() — Función · BD: bancos
-- Tipo: Función
-- Nombre: clasificar_cuenta()
-- Parámetro de entrada: iban de una cuenta (CHAR(34))
-- Devuelve: Una cadena VARCHAR(20) con la clasificación de la cuenta según su saldo:
-- 'Descubierto' si el saldo es menor que 0
-- 'Básica' si el saldo está entre 0 y 999.99
-- 'Premium' si el saldo está entre 1000 y 9999.99
-- 'Elite' si el saldo es mayor o igual a 10000
-- Observaciones: Usar la instrucción CASE con evaluación de condiciones.

USE bancos;
DROP FUNCTION IF EXISTS clasificar_cuenta;
DELIMITER $$
CREATE FUNCTION clasificar_cuenta(p_iban CHAR(34)) 
RETURNS VARCHAR(20)
BEGIN
    DECLARE v_saldo DECIMAL(10,2);
    
    SELECT saldo INTO v_saldo FROM cuentas WHERE iban = p_iban;
    
    RETURN CASE 
        WHEN v_saldo < 0 THEN 'Descubierto'
        WHEN v_saldo >= 0 AND v_saldo < 1000 THEN 'Básica'
        WHEN v_saldo >= 1000 AND v_saldo < 10000 THEN 'Premium'
        ELSE 'Elite'
    END;
END$$
DELIMITER;

-- Ejercicio 2. saldo_total_cliente() — Función · BD: bancos
-- Tipo: Función
-- Nombre: saldo_total_cliente()
-- Parámetro de entrada: id de un cliente (INT UNSIGNED)
-- Devuelve: La suma de los saldos de todas las cuentas del cliente (DECIMAL(10,2))
-- Descripción: Dado el id de un cliente, devolver la suma total de los saldos de todas sus cuentas. Si el cliente no tiene cuentas, devolver 0.00 mediante IFNULL().
USE bancos;
DROP FUNCTION IF EXISTS saldo_total_cliente;
DELIMITER $$
CREATE FUNCTION saldo_total_cliente(p_cliente_id INT UNSIGNED)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE v_total DECIMAL(10,2);
    
    SELECT INFULL(SUM(saldo), 0.00) INTO v_total FROM cuentas WHERE cliente_id = p_cliente_id;
    RETURN v_total;
END$$
DELIMITER;

-- Ejercicio 3. movimientos_periodo() — Procedimiento · BD: bancos
-- Tipo: Procedimiento
-- Nombre: movimientos_periodo()
-- Parámetros de entrada:
-- fecha_inicio (DATE)
-- fecha_fin (DATE)
-- Descripción: Devolver un listado de todos los movimientos registrados entre las dos fechas indicadas (ambas incluidas).
-- El listado mostrará:
-- id del movimiento
-- fecha
-- concepto
-- tipo
-- cantidad
-- iban de la cuenta asociada
-- nombre y apellidos del cliente titular de esa cuenta

USE bancos;
DROP PROCEDURE IF EXISTS movimientos_periodo;
DELIMITER $$
CREATE PROCEDURE movimientos_periodo(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT movimientos.id, DATE(movimientos.fechahora) AS fecha, movimientos.concepto, movimientos.tipo, movimientos.cantidad, cuentas.iban, CONCAT(clientes.nombre, ' ', clientes.apellidos) AS cliente
    FROM movimientos INNER JOIN cuentas ON movimientos.cuenta_id = cuentas.id
    INNER JOIN clientes ON cuentas.cliente_id = clientes.id
    WHERE DATE(movimientos.fechahora) BETWEEN fecha_inicio AND fecha_fin;
END$$
DELIMITER;

-- Ejercicio 4. comision_descubierto() — Procedimiento con cursor · BD: bancos
-- Tipo: Procedimiento
-- Nombre: comision_descubierto()
-- Parámetros de entrada: ninguno
-- Cursor: deberá recorrer todas las cuentas con saldo negativo (menor que 0).
-- Descripción: Para cada cuenta en descubierto, realizar las siguientes acciones:
-- Insertar un nuevo movimiento en la tabla movimientos con:
-- Fecha y hora actual
-- Concepto: 'Comisión por descubierto'
-- Tipo: 'R' (reintegro)
-- Cantidad: -5.00
-- Actualizar el saldo de la cuenta restando 5.00.
-- Observaciones: Usar la estructura LOOP para recorrer el cursor.

USE bancos;
DROP PROCEDURE IF EXISTS comision_descubierto;
DELIMITER $$
CREATE PROCEDURE comision_descubierto()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_cuenta_id INT UNSIGNED;
    DECLARE v_saldo DECIMAL(10,2);

    DECLARE cur_cuentas_descubierto CURSOR FOR SELECT id, saldo FROM cuentas WHERE saldo < 0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_cuentas_descubierto;
    bucle_recorrer: LOOP
        FETCH cur_cuentas_descubierto INTO v_cuenta_id, v_saldo;
        IF done THEN LEAVE bucle_recorrer;
        END IF;

        INSERT INTO movimientos (cuenta_id, concepto, tipo, cantidad) 
        VALUES (v_cuenta_id, 'Comisión por descubierto', 'R', -5.00);

        UPDATE cuentas SET saldo = saldo - 5.00 WHERE id = v_cuenta_id;
    END LOOP;

    CLOSE cur_cuentas_descubierto;
END$$
DELIMITER;

-- Ejercicio 5. validar_importe_reintegro — Trigger · BD: bancos
-- Tipo: Trigger
-- Nombre: validar_importe_reintegro
-- Momento: BEFORE
-- Evento: INSERT
-- Tabla: movimientos
-- Descripción: Antes de insertar un movimiento, comprobar que si el tipo es 'R' (reintegro), la cantidad introducida sea negativa. Si se introduce un valor positivo para un reintegro, convertir automáticamente dicha cantidad a negativa (multiplicar por -1).
-- Observaciones: El alumno debe usar correctamente la referencia NEW.

USE bancos;
DROP TRIGGER IF EXISTS validar_importe_reintegro;
DELIMITER $$
CREATE TRIGGER validar_importe_reintegro BEFORE INSERT ON movimientos FOR EACH ROW
BEGIN
    IF NEW.tipo = 'R' AND NEW.cantidad > 0 THEN SET NEW.cantidad = NEW.cantidad * -1;
    END IF;
END$$
DELIMITER;

-- Ejercicio 6. historial_saldo — Trigger · BD: bancos
-- Tipo: Trigger
-- Nombre: historial_saldo
-- Momento: AFTER
-- Evento: UPDATE
-- Tabla: cuentas
-- Descripción: Cada vez que se actualice el saldo de una cuenta, registrar el cambio en una tabla de auditoría llamada historial_saldos con las siguientes columnas:
-- id (AUTO_INCREMENT PRIMARY KEY)
-- cuenta_id (INT UNSIGNED)
-- saldo_anterior (DECIMAL(10,2))
-- saldo_nuevo (DECIMAL(10,2))
-- fecha_cambio (TIMESTAMP, valor por defecto CURRENT_TIMESTAMP)
-- Observaciones: El alumno deberá crear previamente la tabla historial_saldos antes de definir el trigger. Usar correctamente las referencias OLD y NEW.
-- CREATE TABLE IF NOT EXISTS historial_saldo( id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, cuenta_id INT UNSIGNED, saldo_anterior DECIMAL(10,2), saldo_nuevo DECIMAL(10,2), fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (cuenta_id) REFERENCES cuentas(id) ON DELETE RESTRICT ON UPDATE RESTRICT );
 
USE bancos;
DROP TRIGGER IF EXISTS historial_saldo;
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS historial_saldo AFTER UPDATE ON cuentas FOR EACH ROW
BEGIN
    IF OLD.saldo <> NEW.saldo THEN INSERT INTO historial_saldos (cuenta_id, saldo_anterior, saldo_nuevo, fecha_cambio) 
        VALUES (OLD.id, OLD.saldo, NEW.saldo, CURRENT_TIMESTAMP);
    END IF;
END$$
DELIMITER ;

-- Ejercicio 7. resumen_movimientos_cliente() — Procedimiento con cursor · BD: bancos
-- Tipo: Procedimiento
-- Nombre: resumen_movimientos_cliente()
-- Parámetro de entrada: p_cliente_id (INT UNSIGNED)
-- Descripción: El procedimiento deberá recorrer con un cursor todos los movimientos de todas las cuentas pertenecientes al cliente indicado, mostrando para cada movimiento: iban de la cuenta, fechahora, concepto, tipo y cantidad. Al finalizar el recorrido, mostrar también:
-- El total acumulado de ingresos (tipo = 'I')
-- El total acumulado de reintegros (tipo = 'R')
-- Observaciones:
-- El cursor deberá obtener los datos mediante un JOIN entre las tablas cuentas y movimientos, filtrando por cliente_id.
-- Usar la estructura LOOP para recorrer el cursor.
-- Acumular los totales en variables locales durante el recorrido.
-- No se modifican datos: el procedimiento es de solo lectura.

USE bancos;
DROP PROCEDURE IF EXISTS resumen_movimientos_cliente;
DELIMITER $$
CREATE PROCEDURE resumen_movimientos_cliente(IN p_cliente_id INT UNSIGNED)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_iban CHAR(34);
    DECLARE v_fechahora DATETIME;
    DECLARE v_concepto VARCHAR(255);
    DECLARE v_tipo CHAR(1);
    DECLARE v_cantidad DECIMAL(10,2);
    DECLARE v_total_acomulado_ingresos DECIMAL(10,2) DEFAULT 0.00;
    DECLARE v_total_acomulado_reintegros DECIMAL(10,2) DEFAULT 0.00;

    DECLARE cur_movimientos CURSOR FOR 
        SELECT cuentas.iban, movimientos.fechahora, movimientos.concepto, movimientos.tipo, movimientos.cantidad FROM cuentas
        INNER JOIN movimientos ON cuentas.id = movimientos.cuenta_id
        WHERE cuentas.cliente_id = p_cliente_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_movimientos;
    bucle_recorrer: LOOP
        FETCH cur_movimientos INTO v_iban, v_fechahora, v_concepto, v_tipo, v_cantidad;
        IF done THEN LEAVE bucle_recorrer;
        END IF;

        SELECT v_iban, v_fechahora, v_concepto, v_tipo, v_cantidad;

        IF v_tipo = 'I' THEN SET v_total_ingresos = v_total_ingresos + v_cantidad;
        ELSEIF v_tipo = 'R' THEN SET v_total_reintegros = v_total_reintegros + v_cantidad;
        END IF;
    END LOOP;

    CLOSE cur_movimientos;

    SELECT v_total_ingresos;
    SELECT v_total_reintegros;
END$$
DELIMITER;

-- Ejercicio 8. recalcular_saldos — Evento · BD: bancos
-- Tipo: Evento
-- Nombre: recalcular_saldos
-- Tipo de planificación: periódico, con frecuencia semanal
-- Inicio: el próximo lunes a las 03:00:00
-- Duración máxima: 1 año desde la fecha de inicio
-- Descripción: Cada lunes a las 3:00 AM, actualizar el campo saldo de todas las cuentas recalculándolo como la suma real de todas las cantidad de sus movimientos registrados en la tabla movimientos.
-- Observaciones:
-- Usar un UPDATE con subconsulta que aplique SUM() sobre movimientos, agrupando por cuenta_id.
-- El alumno deberá asegurarse de que el planificador de eventos esté activo (SET GLOBAL event_scheduler = ON).
-- Para calcular la fecha del próximo lunes se puede usar: 2026-05-08 03:00:00
SET GLOBAL event_scheduler = ON;
USE bancos;
DROP EVENT IF EXISTS recalcular_saldos;
CREATE EVENT recalcular_saldos ON SCHEDULE EVERY 1 WEEK STARTS '2026-05-08 03:00:00' ENDS '2027-05-08 03:00:00'
DO
BEGIN
    UPDATE cuentas
    SET saldo = (SELECT SUM(movimientos.cantidad) FROM movimientos WHERE movimientos.cuenta_id = cuentas.id);
END;