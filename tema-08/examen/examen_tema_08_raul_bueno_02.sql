-- examen_tema_08_raul_bueno_02

-- Ejercicio 1. resumen_cliente() — Función · BD: bancos
-- Tipo: Función
-- Nombre: resumen_cliente()
-- Parámetro de entrada: id de un cliente (INT UNSIGNED)
-- Devuelve: El número total de cuentas que tiene ese cliente (INT)
-- Descripción: Dada la id de un cliente, la función deberá devolver cuántas cuentas tiene registradas en la base de datos.
USE bancos;
DELIMITER $$
DROP FUNCTION IF EXISTS resumen_cliente() $$
CREATE FUNCTION IF NOT EXISTS resumen_cliente(p_id_cliente INT UNSIGNED)
RETURNS INT
BEGIN
    DECLARE total_cuentas INT;
    SELECT COUNT(*) INTO total_cuentas FROM cuentas WHERE id_cliente = p_id_cliente;
    RETURN (total_cuentas);
END $$
DELIMITER ;
-- Ejercicio 2. saldo_medio_ciudad() — Función · BD: bancos
-- Tipo: Función
-- Nombre: saldo_medio_ciudad()
-- Parámetro de entrada: nombre de una ciudad (VARCHAR(50))
-- Devuelve: El saldo medio de todas las cuentas pertenecientes a clientes de esa ciudad (DECIMAL(10,2))
-- Descripción: Calcular el saldo medio de las cuentas cuyos titulares residen en la ciudad indicada. Si no hay clientes en esa ciudad, devolver 0.00.
USE bancos;
DELIMITER $$
DROP FUNCTION IF EXISTS saldo_medio_ciudad() $$
CREATE FUNCTION IF NOT EXISTS saldo_medio_ciudad(p_nombre_ciudad VARCHAR(50))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE saldo_medio DECIMAL(10,2);
    SELECT AVG(cuentas.saldo) INTO saldo_medio
    FROM cuentas INNER JOIN clientes ON cuentas.id_cliente = clientes.id WHERE clientes.ciudad = p_nombre_ciudad;
    RETURN (saldo_medio);
END $$
DELIMITER ;
-- Ejercicio 3. clientes_saldo_negativo() — Procedimiento · BD: bancos
-- Tipo: Procedimiento
-- Nombre: clientes_saldo_negativo()
-- Parámetros de entrada: ninguno
-- Descripción: El procedimiento deberá devolver un listado con todos los clientes que tienen al menos una cuenta con saldo negativo (menor que 0).
-- El listado mostrará:
-- id del cliente
-- nombre
-- apellidos
-- email
-- iban de la cuenta en rojo
-- saldo de esa cuenta
USE bancos;
DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_saldo_negativo()$$
CREATE PROCEDURE IF NOT EXISTS clientes_saldo_negativo()
BEGIN
    SELECT clientes.id, clientes.nombre, clientes.apellidos, clientes.email, cuentas.iban, cuentas.saldo 
    FROM clientes INNER JOIN cuentas WHERE clientes.id = cuentas.cliente_id AND cuentas.saldo < 0;
END $$
DELIMITER ;
-- Ejercicio 4. aplicar_interes() — Procedimiento con cursor · BD: bancos
-- Tipo: Procedimiento
-- Nombre: aplicar_interes()
-- Parámetro de entrada: porcentaje de interés (DECIMAL(5,2))
-- Cursor: deberá recorrer todas las cuentas con saldo mayor que 0.
-- Descripción: Para cada cuenta con saldo positivo, insertar un nuevo movimiento en la tabla movimientos con:
-- Fecha y hora actual
-- Concepto: 'Abono de intereses'
-- Tipo: 'I' (ingreso)
-- Importe: saldo de la cuenta × (porcentaje / 100)
-- Después de insertar el movimiento, actualizar el saldo de la cuenta sumando el importe abonado.
USE bancos;
DELIMITER $$
DROP PROCEDURE IF EXISTS aplicar_interes()$$
CREATE PROCEDURE IF NOT EXISTS aplicar_interes(p_porcentaje DECIMAL(5,2))
BEGIN
    DECLARE BOOLEAN hecho; 
    DECLARE v_id_cuenta INT;
    DECLARE v_saldo DECIMAL(10,2);
    DECLARE v_importe DECIMAL(10,2);
   
    DECLARE cur CURSOR FOR SELECT id, saldo FROM cuentas WHERE saldo > 0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET hecho = TRUE;

    OPEN cur 
    LOOP
        IF hecho THEN
            LEAVE LOOP;
        END IF;
        SET v_importe = v_saldo * (p_porcentaje);
        INSERT INTO movimientos (fechahora, concepto, tipo, cantidad, cuenta_id) VALUES (NOW(), 'Abono de intereses', 'I', v_importe, v_id_cuenta);
        UPDATE cuentas SET saldo = saldo + v_importe WHERE id = v_id_cuenta;
    END LOOP;
    CLOSE cur;

END $$

DELIMITER ;
-- Ejercicio 5. actualizar_stock_venta — Trigger · BD: geslibros
-- Tipo: Trigger
-- Nombre: actualizar_stock_venta
-- Momento: AFTER
-- Evento: INSERT
-- Tabla: lineasventas
-- Descripción: Cada vez que se inserte una línea de venta, se deberá decrementar el stock del libro correspondiente en la tabla libros según la cantidad indicada en la línea de venta.
-- Ejemplo: Si se venden 4 unidades del libro con id = 7, el campo stock del libro 7 debe reducirse en 4 unidades.
USE geslibros;
DELIMITER $$
DROP TRIGGER IF EXISTS actualizar_stock_venta $$
CREATE TRIGGER IF NOT EXISTS actualizar_stock_venta AFTER INSERT ON geslibros.lineasventas FOR EACH ROW 
SET libros.stock = (libros.stock - lineasventas.cantidad) WHERE lineasventas.libro_id = libros.id $$
DELIMITER ;
-- Ejercicio 6. control_precio_libro — Trigger · BD: geslibros
-- Tipo: Trigger
-- Nombre: control_precio_libro
-- Momento: BEFORE
-- Evento: UPDATE
-- Tabla: libros
-- Descripción: Antes de actualizar un libro, comprobar que el nuevo precio de venta (precio_venta) no sea inferior al precio de coste (precio_coste). Si el nuevo precio_venta fuera menor o igual al precio_coste, se deberá asignar automáticamente como precio_venta el valor de precio_coste multiplicado por 1.10 (es decir, con un margen mínimo del 10%).
-- Observaciones: El alumno debe identificar correctamente las referencias NEW y OLD.
USE geslibros;
DELIMITER $$
DROP TRIGGER IF EXISTS control_precio_libro $$
CREATE TRIGGER IF NOT EXISTS control_precio_libro BEFORE UPDATE ON geslibros.libros
IF NEW libros.precio_venta >= OLD libros.precio_venta THEN UPDATE libros.precio_venta
END IF; 
DELIMITER ;
-- Ejercicio 7. verificar_importes_ventas() — Procedimiento con cursor · BD: geslibros
-- Tipo: Procedimiento
-- Nombre: verificar_importes_ventas()
-- Parámetros de entrada: ninguno
-- Cursor: deberá recorrer todas las ventas de la tabla ventas.
-- Descripción: Para cada venta, comparar el valor almacenado en la columna importe_bruto con la suma real de la columna importe de sus registros en lineasventas. Si los importes no coinciden, actualizar importe_bruto con el valor correcto y mostrar por pantalla:
-- id de la venta
-- importe almacenado
-- importe calculado
-- diferencia
USE geslibros;
DELIMITER $$
DROP PROCEDURE IF EXISTS verificar_importes_ventas()$$
CREATE PROCEDURE IF NOT EXISTS verificar_importes_ventas()
BEGIN
    DECLARE hecho BOOLEAN; 
    DECLARE v_id_venta INT;
    DECLARE v_importe_bruto DECIMAL(10,2);
    DECLARE v_importe_calculado DECIMAL(10,2);
    DECLARE v_diferencia DECIMAL(10,2);
   
    DECLARE cur CURSOR FOR SELECT id, importe_bruto FROM ventas;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET hecho = TRUE;

    OPEN cur 
    LOOP 
        IF hecho THEN
            LEAVE LOOP;
        END IF;
        SELECT SUM(importe) INTO v_importe_calculado FROM lineasventas WHERE venta_id = v_id_venta;
        IF v_importe_bruto != v_importe_calculado THEN
            UPDATE ventas SET importe_bruto = v_importe_calculado WHERE id = v_id_venta;
        END IF;
    END LOOP;

END $$
DELIMITER ;
-- Ejercicio 8. exportar_movimientos_diarios — Evento · BD: bancos
-- Tipo: Evento
-- Nombre: exportar_movimientos_diarios
-- Tipo de planificación: periódico, con frecuencia diaria
-- Inicio: mañana a las 00:00:00
-- Duración máxima: 1 año desde la fecha de inicio
-- Descripción: Al final de cada día, generar un fichero CSV llamado movimientos_dia.csv con todos los movimientos registrados durante ese día (fecha igual a CURDATE()).
-- El fichero incluirá las columnas:
-- id del movimiento
-- fecha
-- concepto
-- tipo
-- importe
-- iban de la cuenta asociada
-- Separador de columnas: ;
USE bancos;
DELIMITER $$
DROP EVENT IF EXISTS exportar_movimientos_diarios $$
CREATE EVENT IF NOT EXISTS exportar_movimientos_diarios ON SCHEDULE EVERY DAY STARTS (02-06-2026 00:00:00) ENDS CURDATE + 1 YEAR
DO SELECT movimientos.fechahora, movimientos.concepto, movimientos.tipo, movimientos.cantidad, cuentas.iban FROM bancos.movimientos INNER JOIN bancos.cuentas
WHERE movimientos.cuenta_id = cuentas.id AND DAY(fechahora = DAY(CURDATE)) INTO OUTFILE movimientos_dia.csv FIELDS TERMINATED BY '\t' ENCLOSED BY '';

DELIMITER ;