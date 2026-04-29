-- arcos.sql
-- conexion arcos_01

-- 2
USE geslibros;

-- 4. Consulta permitida
SELECT 
    *
FROM
    clientes
WHERE
    provincia_id = 19;

-- inserto clientes con los datos que yo quiera(dará error porque ubrique lo tiene bloqueado)
INSERT INTO clientes 
(nombre, direccion, poblacion, c_postal, provincia_id, nif, telefono, movil, email)
VALUES
('Adolfo', 'Calle Juanes 123', 'Guadalajara', '19001', 19, '12345678Z', '949000000', '600000000', 'adolfito123@gmail.com');

-- 6. Comprobar inserción (tras desbloqueo)
SELECT 
    *
FROM
    clientes
WHERE
    nombre = 'Adolfo';

-- Bloquear tabla libros en escritura
LOCK TABLE libros WRITE;

-- Insertar libro (permitido)
INSERT INTO libros
(isbn, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock)
VALUES
('9999999999999', 'Principito', 1, 1, 10, 15, 5);

-- 8. Desbloquear libros
UNLOCK TABLES;

-- 9. TRANSACCIÓN
START TRANSACTION;

-- Bloqueo compartido
SELECT * FROM editoriales LOCK IN SHARE MODE;
SELECT * FROM autores LOCK IN SHARE MODE;

-- Insertar libros
INSERT INTO libros
(isbn, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock)
VALUES
('8888888888888', 'Quijote', 1, 1, 12, 18, 10),
('7777777777777', 'Señor de los Anillos', 2, 2, 14, 20, 8);

COMMIT;