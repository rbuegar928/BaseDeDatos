-- ubrique_01.sql
-- conexion ubrique_01

-- 2
USE geslibros;

-- 3. Bloquear tabla clientes para lectura
LOCK TABLE clientes READ;

-- Intentar acceder a otra tabla (falla porque tengo clientes bloqueado)
SELECT * FROM libros;

-- 5. Desbloquear tabla clientes
UNLOCK TABLES;

-- 7. acceder a libros (falla porque está bloqueado por arcos)
SELECT * FROM libros;

-- bloquear libros (fallará porque está bloqueada)
LOCK TABLE libros READ;

-- 9. TRANSACCIÓN
START TRANSACTION;

-- Reducir precios un 30%
UPDATE libros
SET precio_venta = precio_venta * 0.7;

COMMIT;