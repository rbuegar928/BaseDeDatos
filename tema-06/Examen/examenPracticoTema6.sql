-- Examen Práctico Tema 6. Lenguaje SQL - DML
-- Raúl Bueno García

USE geslibros;

-- 1. Insertar un nuevo libro en la base de datos con los siguientes datos:
INSERT INTO Libros (id, isbn, ean, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock, stock_min, stock_max, fecha_edicion)
VALUES (20, '9788408096528', '9788888199587', 'El Retrato de Dorian Gray', 2, 4, '18.00', '24.00', 12, 5, 25, '2015-03-15');

-- 2. Insertar los registros necesarios en la tabla libros_temas para asociar el libro insertado anteriormente con las temáticas de Novela y Ciencia.
INSERT INTO libros_temas (libro_id, tema_id) VALUES (20, 3), (20, 9);

-- 3. Insertar un nuevo registro en la tabla ventas y sus correspondientes líneas de venta:
INSERT INTO ventas (id, cliente_id, fecha, importe_bruto, importe_iva, importe_total) VALUES (12, 1, '2014-05-10', 100, 21, 121);

-- 4. Crear 2 líneas de venta con al menos 2 libros diferentes y que se pueda emparejar con la venta anterior
INSERT INTO lineasventas(id, venta_id, numero_linea, libro_id, iva, cantidad, precio, importe ) VALUES
(41,12,1,12,10.92,4,13,62.92),
(42,12,2,13,10.08,4,12,58.08);

-- 5. Actualizar el precio de venta de todos los libros de la editorial Planeta incrementándolo en un 15%.
UPDATE libros SET precio_venta = (precio_venta*1.15) WHERE editorial_id = 4;

-- 6. Reducir el stock de todos los libros cuyo stock actual sea superior a 15 unidades en un 20%.
UPDATE libros SET stock = (stock*0.8) WHERE stock > 15;

-- 7. Eliminar de la base de datos todos los libros de temática Viajes.
DELETE FROM temas WHERE id=4;

-- 8. Mostrar aquellos clientes cuya dirección de email pertenezca al dominio "gmail.com" y que estén ubicados en la provincia de Guadalajara.
SELECT 
    clientes.id,
    clientes.nombre,
    clientes.direccion,
    clientes.c_postal,
    clientes.nif,
    clientes.telefono,
    clientes.email
FROM
    clientes
WHERE
    email LIKE '%gmail.com'
        AND clientes.provincia_id = 19
ORDER BY clientes.nombre;

-- 9. Mostrar las 5 ventas con menor importe total realizadas en el año 2013.
SELECT ventas.id, clientes.nombre, ventas.fecha, ventas.importe_bruto, ventas.importe_iva, ventas.importe_total FROM ventas INNER JOIN clientes 
ON ventas.cliente_id = clientes.id AND YEAR(fecha) = 2013 ORDER BY importe_total ASC;

-- 10. Mostrar los libros publicados en el año 2014 cuyo stock sea inferior a 20 unidades.
SELECT 
    libros.id,
    libros.titulo,
    libros.autor_id,
    editoriales.nombre AS editorial,
    libros.stock,
    libros.precio_coste,
    libros.precio_venta
FROM
    libros
        INNER JOIN
    autores ON libros.autor_id = autores.id
        INNER JOIN
    editoriales ON libros.editorial_id = editoriales.id
WHERE
    YEAR(libros.fecha_edicion) = 2014
        AND libros.stock < 20
ORDER BY titulo;

-- 11. Mostrar los libros de temática Novela cuyo precio de venta sea superior a 20 €.
SELECT 
    libros.id,
    libros.titulo,
    autores.nombre AS autor,
    editoriales.nombre AS editorial,
    temas.tema,
    libros.precio_coste,
    libros.precio_venta
FROM
    libros
        INNER JOIN
    autores ON libros.autor_id = autores.id
        INNER JOIN
    editoriales ON libros.editorial_id = editoriales.id
        INNER JOIN
    libros_temas ON libros.id = libros_temas.libro_id
        INNER JOIN
    temas ON libros_temas.tema_id = temas.id
WHERE
    tema_id = 3 AND precio_venta < 20
ORDER BY titulo;

-- 12. Mostrar los libros cuyo precio de venta sea superior al precio medio de todos los libros de la base de datos.
SELECT 
    libros.id,
    libros.titulo,
    autores.nombre AS autor,
    editoriales.nombre AS editorial,
    libros.precio_venta
FROM
    libros
        INNER JOIN
    autores ON libros.autor_id = autores.id
        INNER JOIN
    editoriales ON libros.editorial_id = editoriales.id
WHERE
    libros.precio_venta > AVG(libros.precio_venta)
ORDER BY libros.precio_venta DESC;

-- 13. Mostrar el número de ventas realizadas y el importe total facturado por cada cliente.

-- 14. Mostrar estadísticas de ventas para cada libro: número de unidades vendidas, importe total vendido y precio medio de venta.
