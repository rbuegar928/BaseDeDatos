-- practica_85_02
-- Raúl Bueno
-- base de datos: triggers
-- curso: 25/26

USE bancos;

-- Actividad 1
-- bonificacion_apertura()
-- descripcion: Trigger para otorgar una bonificacion de 20 euros
-- a la apertur de una nueva cuenta
-- momento: after
-- tabla: cuentas

DELIMITER $$

DROP TRIGGER IF EXISTS bonificacion_apertura$$
CREATE TRIGGER bonificacion_apertura AFTER INSERT ON cuentas
FOR EACH ROW
BEGIN
    -- insertar un movimiento de bonificacion de apertura
    INSERT INTO movimientos (cuenta_id, fechahora, concepto, tipo, cantidad)
    VALUES (NEW.id, NOW(), 'Bonificación apertura', 'I', 20.00);
END$$

-- uso del trigger bonificacion_apertura
DELIMITER ;
INSERT INTO cuentas (id, iban, cliente_id, fecha, saldo) 
VALUES (null, 'ES00000000000000000002', 1, NOW(), 20.00);

-- Actividad 2
-- nombre: validar_movimiento()
-- descripcion: Crear un TRIGGERS de forma que si un usuario realiza un movimiento en su cuenta de
-- tipo R reintegro y resulta que la cantidad a retirar es superior al saldo disponible, registre finalmente ese movimiento
-- pero como no tiene saldo, la cantidad a retirar sería cero. En caso de que el cliente tenga saldo se deberá actualizar la columna saldo de la tabla cuentas. 
-- Por otro lado si el cliente va a realizar un ingreso, sólo se debe proceder actualizando la columna saldo de la tabla cuentas.

DELIMITER $$
DROP TRIGGER IF EXISTS validar_movimiento$$
CREATE TRIGGER validar_movimiento BEFORE INSERT ON movimientos
FOR EACH ROW
BEGIN
    DECLARE saldo_actual DECIMAL(10,2);

    -- obtener saldo de la cuenta
    SELECT saldo INTO saldo_actual FROM cuentas WHERE id = NEW.cuenta_id;
    -- reintegro
    IF NEW.tipo = 'R' THEN

        -- como los reintegros vienen en negativo,
        -- comprobamos el valor absoluto
        IF ABS(NEW.cantidad) > saldo_actual THEN SET NEW.cantidad = 0;

        ELSE
            -- actualizar saldo
            UPDATE cuentas SET saldo = saldo + NEW.cantidad WHERE id = NEW.cuenta_id;

        END IF;

    END IF;
    -- ingreso
    IF NEW.tipo = 'I' THEN

        -- sumar ingreso al saldo
        UPDATE cuentas SET saldo = saldo + NEW.cantidad WHERE id = NEW.cuenta_id;

    END IF;

END$$

DELIMITER ;