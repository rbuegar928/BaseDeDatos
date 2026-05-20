-- practica_83_02
-- Raúl Bueno

USE bancos;

-- ACTIVIDAD 1 - parte 1
-- FUNCIÓN saldo_cuenta()
-- Devuelve el saldo calculado de una cuenta

DELIMITER $$

DROP FUNCTION IF EXISTS saldo_cuenta $$

CREATE FUNCTION saldo_cuenta(p_id_cuenta INT)
RETURNS DECIMAL(10,2)
BEGIN

    DECLARE v_saldo DECIMAL(10,2);
    SELECT SUM(cantidad) INTO v_saldo FROM movimientos WHERE cuenta_id = p_id_cuenta;
    RETURN IFNULL(v_saldo,0);

END$$


-- ACTIVIDAD 1
-- PROCEDIMIENTO actualizar_saldo()
-- Actualiza el saldo de las cuentas usando saldo_cuenta()

DROP PROCEDURE IF EXISTS actualizar_saldo $$

CREATE PROCEDURE actualizar_saldo()
BEGIN

    DECLARE v_fin INT DEFAULT 0;

    DECLARE v_id INT;
    DECLARE v_iban CHAR(24);

    DECLARE v_saldo_tabla DECIMAL(10,2);
    DECLARE v_saldo_funcion DECIMAL(10,2);

    DECLARE v_descuadre DECIMAL(10,2);

    DECLARE c_cuentas CURSOR FOR
        SELECT id, iban, saldo FROM cuentas;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_fin = 1;

    OPEN c_cuentas;

    bucle: LOOP

        FETCH c_cuentas INTO v_id, v_iban, v_saldo_tabla;

        IF v_fin = 1 THEN
            LEAVE bucle;
        END IF;

        SET v_saldo_funcion = saldo_cuenta(v_id);

        SET v_descuadre = v_saldo_funcion - v_saldo_tabla;

        IF v_descuadre <> 0 THEN

            SELECT CONCAT(
                'Cuenta ', v_id,
                ' - ', v_iban,
                ' - saldo tabla: ', v_saldo_tabla,
                ' - saldo función: ', v_saldo_funcion,
                ' - descuadre: ', v_descuadre
            ) AS Resultado;

            UPDATE cuentas
            SET saldo = v_saldo_funcion WHERE id = v_id;
        END IF;
    END LOOP;
    CLOSE c_cuentas;
END$$


-- ACTIVIDAD 2
-- PROCEDIMIENTO mantenimiento()
-- Aplica una cuota anual a todas las cuentas

DROP PROCEDURE IF EXISTS mantenimiento $$

CREATE PROCEDURE mantenimiento(p_cuota DECIMAL(10,2))
BEGIN

    DECLARE v_fin INT DEFAULT 0;

    DECLARE v_id INT;

    DECLARE c_cuentas CURSOR FOR
        SELECT id
        FROM cuentas;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_fin = 1;

    OPEN c_cuentas;

    bucle: LOOP

        FETCH c_cuentas
        INTO v_id;

        IF v_fin = 1 THEN
            LEAVE bucle;
        END IF;

        INSERT INTO movimientos(cuenta_id, fechahora, concepto, tipo, cantidad)
        VALUES(
            v_id,
            NOW(),
            'Cuota mantenimiento 2026',
            'R',
            -ABS(p_cuota)
        );

        UPDATE cuentas
        SET saldo = saldo - ABS(p_cuota)
        WHERE id = v_id;
    END LOOP;
    CLOSE c_cuentas;
END$$


-- ACTIVIDAD 3
-- PROCEDIMIENTO cuota_mantenimiento_2()
-- Aplica cuota según el saldo de cada cuenta

DROP PROCEDURE IF EXISTS cuota_mantenimiento_2 $$

CREATE PROCEDURE cuota_mantenimiento_2()
BEGIN

    DECLARE v_fin INT DEFAULT 0;

    DECLARE v_id INT;
    DECLARE v_saldo DECIMAL(10,2);

    DECLARE v_cuota DECIMAL(10,2);

    DECLARE c_cuentas CURSOR FOR
        SELECT id, saldo
        FROM cuentas;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_fin = 1;

    OPEN c_cuentas;

    bucle: LOOP

        FETCH c_cuentas
        INTO v_id, v_saldo;

        IF v_fin = 1 THEN
            LEAVE bucle;
        END IF;

        IF v_saldo < 2000 THEN
            SET v_cuota = -20;

        ELSEIF v_saldo BETWEEN 2000 AND 10000 THEN
            SET v_cuota = -10;

        ELSE
            SET v_cuota = -5;

        END IF;

        INSERT INTO movimientos(
            cuenta_id,
            fechahora,
            concepto,
            tipo,
            cantidad
        )
        VALUES(
            v_id,
            NOW(),
            'Cuota mantenimiento 2026',
            'R',
            v_cuota
        );

        UPDATE cuentas
        SET saldo = saldo + v_cuota
        WHERE id = v_id;

    END LOOP;

    CLOSE c_cuentas;

END$$

DELIMITER ;