-- Practica_87_02
-- Raúl Bueno García

USE geslibros;

-- Actividad 1. Funcion importe_bruto_venta()


DELIMITER $$
DROP FUNCTION IF EXISTS geslibros.importe_bruto_venta $$
CREATE FUNCTION geslibros.importe_bruto_venta(p_venta_id INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE v_importe_bruto DECIMAL(10,2);
    SELECT SUM(importe) INTO v_importe_bruto FROM lineasventas WHERE venta_id = p_venta_id;
    RETURN v_importe_bruto;
END $$
DELIMITER ;

-- Actividad 2. Función importe_iva_ventas()

DELIMITER $$
DROP FUNCTION IF EXISTS geslibros.importe_iva_ventas $$
CREATE FUNCTION geslibros.importe_iva(p_venta_id INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE v_importe_iva DECIMAL(10,2);
    SELECT SUM(importe * iva) INTO v_importe_iva FROM lineasventas WHERE venta_id = p_venta_id;
    RETURN v_importe_iva;
END $$
DELIMITER ;

-- Actividad 3. Estudio_stock
DELIMITER $$
DROP PROCEDURE IF EXISTS geslibros.Estudio_stock $$
CREATE PROCEDURE geslibros.Estudio_stock()
BEGIN
    SELECT
        'Rotura de Stock' AS Mensaje,id,titulo,precio_coste,stock,stock_min,stock_max,(stock_max - stock) AS Stock_Necesario
    FROM libros WHERE stock <= stock_min;
END $$
DELIMITER ;


-- Actividad 4. Procedimiento Verificar_importe_total_venta()
DELIMITER $$
DROP PROCEDURE IF EXISTS geslibros.Verificar_importe_total_venta $$
CREATE PROCEDURE geslibros.Verificar_importe_total_venta()
BEGIN
    DECLARE v_id_venta INT;
    DECLARE v_importe_bruto_tabla DECIMAL(10,2);
    DECLARE v_importe_iva_tabla DECIMAL(10,2);
    DECLARE v_importe_total_tabla DECIMAL(10,2);
    DECLARE v_importe_bruto_funcion DECIMAL(10,2);
    DECLARE v_importe_iva_funcion DECIMAL(10,2);
    DECLARE v_importe_total_funcion DECIMAL(10,2);

    DECLARE lrf BOOLEAN;
    DECLARE c_ventas CURSOR FOR
    SELECT
        id,importe_bruto,importe_iva,importe_total
    FROM ventas;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

    SET lrf = 0;

    OPEN c_ventas;

    l_cursor: LOOP

        FETCH c_ventas
        INTO
            v_id_venta,
            v_importe_bruto_tabla,
            v_importe_iva_tabla,
            v_importe_total_tabla;

        IF lrf = 1 THEN
            LEAVE l_cursor;
        END IF;

        SET v_importe_bruto_funcion = importe_bruto_venta(v_id_venta);

        SET v_importe_iva_funcion = importe_iva_ventas(v_id_venta);

        SET v_importe_total_funcion = v_importe_bruto_funcion + v_importe_iva_funcion;

        IF v_importe_bruto_tabla <> v_importe_bruto_funcion THEN

            UPDATE ventas
            SET importe_bruto = v_importe_bruto_funcion
            WHERE id = v_id_venta;
        END IF;

        IF v_importe_iva_tabla <> v_importe_iva_funcion THEN
            UPDATE ventas
            SET importe_iva = v_importe_iva_funcion
            WHERE id = v_id_venta;

        END IF;

        IF v_importe_total_tabla <> v_importe_total_funcion THEN
            UPDATE ventas
            SET importe_total = v_importe_total_funcion
            WHERE id = v_id_venta;

        END IF;
    END LOOP;
    CLOSE c_ventas;

END $$
DELIMITER ;

-- Actividad 5. TRIGGER actualizar_stock

DELIMITER $$
DROP TRIGGER IF EXISTS geslibros.actualizar_stock $$
CREATE TRIGGER geslibros.actualizar_stock AFTER INSERT ON lineasventas
FOR EACH ROW
BEGIN
    UPDATE libros SET stock = stock - NEW.cantidad WHERE id = NEW.libro_id;
END $$
DELIMITER ;


-- Actividad 6. TRIGGER fuera_de_stock

DELIMITER $$
DROP TRIGGER IF EXISTS geslibros.fuera_de_stock $$
CREATE TRIGGER geslibros.fuera_de_stock BEFORE INSERT ON lineasventas
FOR EACH ROW
BEGIN
    DECLARE v_stock INT;
    SELECT stock INTO v_stock FROM libros WHERE id = NEW.libro_id;
    IF v_stock = 0 THEN 
        SET NEW.cantidad = 0;
    ELSEIF NEW.cantidad > v_stock THEN 
        SET NEW.cantidad = v_stock;
    END IF;
END $$

DELIMITER ;

-- Actividad 7. EVENT. lineas_ventas

DELIMITER $$
DROP EVENT IF EXISTS geslibros.lineas_ventas $$
CREATE EVENT geslibros.lineas_ventas 
ON SCHEDULE EVERY 1 DAY
STARTS '2026-05-27 00:00:00'
DO
BEGIN
    SELECT * FROM lineasventas INTO OUTFILE 'c:lineasventasdia.csv' ADD
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';
END $$
DELIMITER ;

-- Actividad 8. Evento rebajas

DELIMITER $$
DROP EVENT IF EXISTS geslibros.rebajas $$
CREATE EVENT geslibros.rebajas
AT '2020-06-01 00:00:00'
DO
BEGIN
    UPDATE libros SET precio_venta = precio_venta * 0.90;
END $$
DELIMITER ;