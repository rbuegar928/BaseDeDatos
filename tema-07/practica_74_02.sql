-- Practica 74
-- Raúl Bueno

USE geslibros;

-- 1. Incluye en una transacción un proceso que realice las siguientes actualizaciones:

-- Todos los libros de tema Novela se ponen en oferta y se decrementa el precio en un 10%
-- Los libros de la editorial Anaya se incrementa el precio en un 6% mientras que
-- el resto de editoriales se reduce en un 4,5%.

START TRANSACTION;

-- 1.1
UPDATE libros SET  precio_venta = precio_venta * 0.9 
WHERE id IN (SELECT libro_id FROM libros_temas WHERE tema_id = 3);

-- 1.2
UPDATE libros SET  precio_venta = precio_venta * 1.06
WHERE editorial_id = (SELECT id FROM editoriales WHERE nombre LIKE '%Anaya%');

-- 1.3
UPDATE libros SET precio_venta = precio_venta * 0.955
WHERE editorial_id != (SELECT id FROM editoriales WHERE nombre LIKE '%Anaya%');


-- 2. Finalizar la transacción deshaciendo las operaciones anteriores. Comprobar
-- Deshacer cambios
ROLLBACK;

-- Comprobación
SELECT titulo, precio_venta FROM libros;


-- 3. Inicia una nueva transacción que contenga las siguientes operaciones:

-- Añadir dos nuevos libros
-- Añadir una venta y 3 líneas de detalle sobre esa venta

START TRANSACTION;

-- Insertar 2 libros
INSERT INTO libros (isbn, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock)
VALUES 
('1111111111111', 'Libro Prueba 1', 1, 1, 10, 15, 10),
('2222222222222', 'Libro Prueba 2', 2, 2, 12, 18, 5);

-- Insertar una venta
INSERT INTO ventas (cliente_id, fecha, importe_bruto, importe_iva, importe_total)
VALUES (1, CURDATE(), 108, 22.68, 130.68);


-- Insertar 3 líneas de venta
INSERT INTO lineasventas (venta_id, numero_linea, libro_id, iva, cantidad, precio, importe)
VALUES
(LAST_INSERT_ID(), 1, 1, 0.21, 2, 15, 30),
(LAST_INSERT_ID(), 2, 2, 0.21, 1, 18, 18),
(LAST_INSERT_ID(), 3, 3, 0.21, 3, 20, 60);


-- 4. Finalizar la transacción confirmando las operaciones anteriores.

COMMIT;


-- 5. Incluye en una transacción las siguientes operaciones sobre la base de datos geslibros:

-- Insertar 2 libros
INSERT INTO libros (isbn, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock)
VALUES 
('3333333333333', 'El Principito', 1, 1, 10, 15, 10),
('4444444444444', 'El Señor de Los Anillos', 2, 2, 12, 18, 5);

-- Insertar 2 clientes
INSERT INTO clientes (nombre, direccion, poblacion, c_postal, provincia_id, nif)
VALUES
('Paco', 'Calle Emilio Pérez', 'Madrid', '28001', 28, '12345678A'),
('Ramón', 'Calle Adolfo Jiménez', 'Madrid', '28002', 28, '12345678B');

-- SAVEPOINT A
SAVEPOINT a;

-- Incrementar precios 10%
UPDATE libros
SET precio_venta = precio_venta * 1.10;

-- SAVEPOINT B
SAVEPOINT b;

-- Eliminar libros no vendidos
DELETE FROM libros 
WHERE
    id NOT IN (SELECT 
        libro_id
    FROM
        (SELECT DISTINCT
            libro_id
        FROM
            lineasventas) AS tabla_aux);

-- Volver al SAVEPOINT A
ROLLBACK TO a;

-- Comprobación
SELECT titulo, precio_venta FROM libros;
SELECT * FROM clientes;