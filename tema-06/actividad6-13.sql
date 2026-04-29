-- Actividad 6.13
-- Raúl Bueno

use geslibros;

-- 1.Mostrar aquellos clientes de la población 
-- de Ubrique que tiene como servidor email "ieslosremedios.org", es decir que en email contengan 
-- el nombre del servidor. 
SELECT 
    id, nombre, direccion, nif, telefono, email
FROM
    clientes
WHERE
    poblacion LIKE '%Ubrique%'
        AND email LIKE '%ieslosremedios.org'
ORDER BY nombre;

-- 2 Mostrar las 3 mejores ventas realizadas en el año 2014.
SELECT 
    v.id,
    c.nombre cliente,
    v.fecha,
    v.importe_bruto,
    v.importe_iva,
    v.importe_total
FROM
    ventas AS v
        INNER JOIN
    clientes AS c ON v.cliente_id = c.id
WHERE
    YEAR(v.fecha) = 2014
ORDER BY v.importe_total DESC
LIMIT 3;

-- 3
-- Mostrar detalles de todos los libros editados en 
-- 2011 cuyo stock esté entre 10 y 20 unidades.
SELECT 
    l.id,
    l.titulo,
    a.nombre AS autor,
    e.nombre AS editorial,
    l.stock,
    l.precio_coste,
    l.precio_venta
FROM
    (libros AS l
    INNER JOIN autores AS a ON l.autor_id = a.id)
        INNER JOIN
    editoriales AS e ON l.editorial_id = e.id
WHERE
    YEAR(fecha_edicion) = 2011
        AND stock BETWEEN 10 AND 20
ORDER BY id;

-- 4 
--  libros relacionadas con la temática PHP y Bases de Datos

SELECT 
    l.id,
    l.titulo,
    a.nombre AS autor,
    e.nombre AS editorial,
    l.stock,
    l.precio_coste,
    l.precio_venta
FROM
    (libros AS l
    INNER JOIN autores AS a ON l.autor_id = a.id)
        INNER JOIN
    editoriales AS e ON l.editorial_id = e.id
WHERE
    (titulo LIKE '%PHP%'
        OR titulo LIKE '%base de datos%')
        AND precio_venta < 30
ORDER BY id;

-- 5
-- libros junto con el margen de beneficios, es decir, la diferencia 
-- entre el precio_venta y el precio_coste.
SELECT 
    l.id,
    l.titulo,
    a.nombre AS autor,
    e.nombre AS editorial,
    l.stock,
    l.precio_coste,
    l.precio_venta,
    l.precio_venta - l.precio_coste AS margen
FROM
    (libros AS l
    INNER JOIN autores AS a ON l.autor_id = a.id)
        INNER JOIN
    editoriales AS e ON l.editorial_id = e.id
WHERE
    e.nombre LIKE '%Anaya%'
        OR e.nombre LIKE '%Alfaguara%'
ORDER BY margen DESC;

-- Versión 2
SELECT 
    l.id,
    l.titulo,
    a.nombre AS autor,
    e.nombre AS editorial,
    l.stock,
    l.precio_coste,
    l.precio_venta,
    l.precio_venta - l.precio_coste AS margen_beneficio
FROM
    (libros AS l
    INNER JOIN autores AS a ON l.autor_id = a.id)
        INNER JOIN
    editoriales AS e ON l.editorial_id = e.id
WHERE
    e.nombre IN ('Anaya' , 'Alfaguara')
ORDER BY margen_beneficio DESC;

-- 6
-- precio_coste sea igual al precio_coste del libro titulado 'Camboya'.
SELECT 
    l.id,
    l.titulo,
    a.nombre AS autor,
    e.nombre AS editorial,
    l.stock,
    l.precio_coste,
    l.precio_venta
FROM
    (libros AS l
    INNER JOIN autores AS a ON l.autor_id = a.id)
        INNER JOIN
    editoriales AS e ON l.editorial_id = e.id
WHERE
    e.nombre IN ('Anaya' , 'Alfaguara')
        AND precio_coste = (SELECT 
            precio_coste
        FROM
            libros
        WHERE
            titulo = 'Camboya');

-- 7
-- Se desea obtener el volumen total de ventas realizadas 
-- a cada cliente en 2014.
SELECT 
    v.cliente_id,
    c.nombre AS cliente,
    COUNT(*) AS num_ventas,
    MAX(v.importe_total) AS max_venta,
    MIN(v.importe_total) AS min_venta,
    SUM(v.importe_total) AS importe_total_acumulado
FROM
    ventas AS v
        INNER JOIN
    clientes AS c ON v.cliente_id = c.id
WHERE
    YEAR(fecha) = 2014
GROUP BY cliente_id
ORDER BY importe_total_acumulado DESC;

-- 8
-- Volumen total de ventas por editorial
SELECT 
    l.editorial_id,
    e.nombre AS editorial,
    COUNT(*) AS num_ventas,
    SUM(lv.importe) AS importe_total
FROM
    (lineasventas AS lv
    INNER JOIN libros AS l ON lv.libro_id = l.id)
        INNER JOIN
    editoriales AS e ON l.editorial_id = e.id
GROUP BY l.editorial_id
ORDER BY importe_total DESC;

-- 8.2
-- Volumen total de ventas por editorial, sólo mostrar las editoriales
-- con volumen total superior a 1000.
SELECT 
    l.editorial_id,
    e.nombre AS editorial,
    COUNT(*) AS num_ventas,
    SUM(lv.importe) AS importe_total
FROM
    (lineasventas AS lv
    INNER JOIN libros AS l ON lv.libro_id = l.id)
        INNER JOIN
    editoriales AS e ON l.editorial_id = e.id
GROUP BY l.editorial_id
HAVING importe_total > 1000
ORDER BY importe_total DESC;

-- 9 CREATE VIEW
-- 
CREATE OR REPLACE VIEW ventas_editoriales AS
    SELECT 
        l.editorial_id,
        e.nombre AS editorial,
        COUNT(*) AS num_ventas,
        SUM(lv.importe) AS importe_total
    FROM
        (lineasventas AS lv
        INNER JOIN libros AS l ON lv.libro_id = l.id)
            INNER JOIN
        editoriales AS e ON l.editorial_id = e.id
    GROUP BY l.editorial_id
    ORDER BY importe_total DESC;
    
-- Editoriales que hayan vendido más de 10 libros
SELECT 
    *
FROM
    ventas_editoriales
WHERE
    num_ventas > 10;
    
-- 10. Insertar libros
-- 
INSERT INTO libros VALUES 
(null, '9788448180833', '9788888199586', 'El toro que viene', 1, 5, 12.00, 29.00, 12, 4, 20, '2010/11/01', default, default);

-- 11. Insertar libros_temas
INSERT INTO libros_temas VALUES
(20 , 3),
(20 , 9),
(20 , 7);

-- 12 Insertar Venta
INSERT INTO ventas VALUES
(null, 3, '2019/11/25', 200, 42, 242, default, default);

INSERT INTO lineasventas VALUES
(null, 11, 1, 10, 0.21, 2, 20, 40),
(null, 11, 1, 8, 0.21, 4, 15, 60),
(null, 11, 1, 5, 0.21, 5, 20, 100);

-- 13 Update libros
-- subir los libros de la editorial anaya un 10%
UPDATE libros 
SET 
    precio_venta = precio_venta * 1.1
WHERE
    editorial_id = (SELECT 
            id
        FROM
            editoriales
        WHERE
            nombre LIKE '%Anaya%')
LIMIT 1;

-- 14  
-- Reducir el precio del los libros que no se vendieron en 2014 en un 30%
UPDATE libros 
SET 
    precio_venta = precio_venta * 0.7
WHERE
    libros.id NOT IN (SELECT 
            libro_id
        FROM
            lineasventas
                INNER JOIN
            ventas ON lineasventas.venta_id = ventas.id
        WHERE
            YEAR(ventas.fecha) = 2014);

-- 15 
DELETE FROM libros 
WHERE
    id IN (SELECT DISTINCT
        libro_id
    FROM
        libros_temas
    
    WHERE
        tema_id = 5);