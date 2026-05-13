USE geslibros;
SELECT 
    *
FROM
    geslibros.lineasventas;
-- 4.1 Insertamos la venta
INSERT INTO ventas (id, cliente_id, fecha, importe_bruto, importe_iva, importe_total) VALUES
(11, 6, now(), 289.50, 60.80, 350.30);

-- 4.1.2 Insertamos las líneas _ventas de esa factura
INSERT INTO lineasventas (venta_id, numero_linea, libro_id, iva, cantidad, precio, importe) VALUES
(11, 1, 11, 0.21, 5, 30, 150),
(11, 2, 12, 0.21, 10, 13, 130),
(11, 3, 15, 0.21, 1, 9.50, 9.50);

-- 4.2 Realizar Updates
UPDATE clientes 
SET 
    direccion = 'Pollígono Ansu Fati, Calle Messi, Nave 20'
WHERE
    nif = '23124234G';

-- 4.2.2 Al escritor Osaar Wilde hay que añadirle también el premio planeta
UPDATE escritores
SET premios = CONCAT(premios, ', Premio Planeta')
WHERE id = 2;

-- 4.2.3 Se decrementa el precio de venta de todos los libros en un 10%
UPDATE libros 
SET 
    precio_venta = precio_venta * 0.90;

--  4.2.4 Debido a una serie de impuestos se incrementa el precio de costo de todos los libros
-- de las editoriales Alfaguara y Anaya en un 10%
UPDATE libros 
SET 
    precio_coste = precio_coste * 1.10
WHERE
    editorial_id IN (5 , 6);

-- 4.2.5 Todos los libros editados antes del año 2000 se les descuenta 2 € del precio de venta
UPDATE libros 
SET 
    precio_venta = precio_venta - 2
WHERE
    YEAR(fecha_edicion) < 2000;

-- 4.3 DELETE (Eliminar registros)
-- Se desea eliminar la editorial Alfaguara, pero antes es necesario eliminar todos los libros
-- de dicha editorial y a continuación eliminar la editorial Alfaguara.


-- Elimino todos lo libros de la editorial
DELETE FROM libros 
WHERE
    editorial_id = 5;

-- Elimino la editorial Alfaguara
DELETE FROM editoriales 
WHERE
    id = 5;