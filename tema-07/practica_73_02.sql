-- Practica 7.3
-- Raúl Bueno

-- 1
REVOKE ALL PRIVILEGES, GRANT OPTION  FROM juan@localhost;

-- 2
REVOKE SELECT ON geslibros.* FROM pedro@localhost;

-- 3
REVOKE ALTER, CREATE, UPDATE ON geslibros.* FROM maria@localhost;
REVOKE ALTER, CREATE, UPDATE ON maratoon.* FROM maria@localhost;

-- 4
REVOKE GRANT OPTION ON *.* FROM roberto@localhost;

-- 5
REVOKE INSERT ON geslibros.* FROM rocio@localhost;

-- 6
REVOKE ALL PRIVILEGES ON geslibros.editoriales FROM carlos@localhost;
REVOKE ALL PRIVILEGES ON geslibros.clientes FROM carlos@localhost;
REVOKE UPDATE ON geslibros.* FROM carlos@localhost;

-- 7
REVOKE SELECT (titulo, ean, isbn, precio_venta)
ON geslibros.libros
FROM anamari@localhost;

-- 8
REVOKE SELECT (nombre, telefono, email)
ON geslibros.clientes
FROM anamari@localhost;

-- Aplicar cambios
FLUSH PRIVILEGES;