-- Active: 1777278237175@@127.0.0.1@3306@gesbank
-- 1. Crear usuarios
-- Se pide crear los siguientes usuarios MySQL. En todos los casos el password ha de ejecutarse cifrado, adjuntando obligatoriamente la sentencia SELECT PASSWORD(...) usada para obtener el hash.
--Crear el usuario cajero con password Caj3ro#25. Sin ningún privilegio, sólo podrá acceder a la base de datos de prueba test.
SELECT PASSWORD('Caj3ro#25');  
CREATE USER 'cajero'@'localhost' IDENTIFIED BY '*DDFD8ACBF21182DD0B01AEA05A588EBDF27438B7';
--Crear el usuario auditor con password Aud1t#2025. Sin ningún privilegio, sólo podrá acceder a la base de datos de prueba test.

SELECT PASSWORD('Aud1t#2025');
CREATE USER 'auditor'@'localhost' IDENTIFIED BY '*FF9E76E7A926ED83CF00F64AB194A325ADA8A2CC';
--Crear el usuario cuyo nombre sea tu nombre seguido del primer apellido, todo junto y en minúsculas (por ejemplo: juanmoreno), con password Recup#07. Sin ningún privilegio inicial.
SELECT PASSWORD('Recup#07');
CREATE USER 'raulbueno'@'localhost' IDENTIFIED BY '*95F547CCD0D89A7D46A7F125AD78ECFBAF45A970';
-- 2. Asignación de privilegios
-- Sobre los usuarios creados en el apartado anterior se pide:
--Asignar al usuario cajero privilegios de superadministrador: todos los privilegios sobre todas las bases de datos, incluyendo el privilegio GRANT OPTION.
GRANT ALL PRIVILEGES ON *.* TO 'cajero'@'localhost' WITH GRANT OPTION;
-- Asignar al usuario cajero todos los privilegios sobre la base de datos gesbank.
GRANT ALL PRIVILEGES ON gesbank.* TO 'cajero'@'localhost';
-- Asignar al usuario cajero todos los privilegios sobre las tablas cuentas y movimientos de la base de datos gesbank.
GRANT ALL PRIVILEGES ON gesbank.cuentas TO 'cajero'@'localhost';
GRANT ALL PRIVILEGES ON gesbank.movimientos TO 'cajero'@'localhost';
-- Asignar al usuario auditor privilegios para sólo consultar (SELECT) las tablas clientes, cuentas y movimientos de la base de datos gesbank.
GRANT SELECT ON gesbank.clientes TO 'auditor'@'localhost';
GRANT SELECT ON gesbank.cuentas TO 'auditor'@'localhost';
GRANT SELECT ON gesbank.movimientos TO 'auditor'@'localhost';
-- Asignar al usuario auditor privilegios para consultar y actualizar las columnas apellidos, nombre, telefono, ciudad y email de la tabla clientes de la base de datos gesbank.
GRANT SELECT, UPDATE (apellidos, nombre, telefono, ciudad, email) ON gesbank.clientes TO 'auditor'@'localhost';
-- Asignar al usuario auditor privilegios para sólo consultar las columnas id, num_cuenta y saldo, y actualizar únicamente la columna fecha_ul_mov de la tabla cuentas de la base de datos gesbank.
GRANT SELECT (id, num_cuenta, saldo), UPDATE (fecha_ul_mov) ON gesbank.cuentas TO 'auditor'@'localhost';
-- Asignar al usuario con tu nombre todos los privilegios para acceder en modo consulta a todas las tablas de la base de datos gesbank excepto a la tabla movimientos.
GRANT SELECT ON gesbank.* TO 'raulbueno'@'localhost';
REVOKE SELECT ON gesbank.movimientos FROM 'raulbueno'@'localhost';
-- 3. Eliminar privilegios
-- Eliminar los siguientes privilegios a los usuarios del apartado 1:

-- Quitar al usuario cajero el privilegio GRANT OPTION.
REVOKE GRANT OPTION ON *.* FROM 'cajero'@'localhost';
-- Quitar al usuario cajero todos los privilegios sobre todas las bases de datos.
REVOKE ALL PRIVILEGES ON *.* FROM 'cajero'@'localhost';
-- Quitar al usuario cajero todos los privilegios sobre la base de datos gesbank.
REVOKE ALL PRIVILEGES ON gesbank.* FROM 'cajero'@'localhost';
-- Quitar al usuario auditor el privilegio de inserción (INSERT) sobre la tabla movimientos de la base de datos gesbank.
REVOKE INSERT ON gesbank.movimientos FROM 'auditor'@'localhost';
-- Quitar al usuario auditor el privilegio de consulta sobre las columnas id, num_cuenta y saldo de la tabla cuentas de la base de datos gesbank.
REVOKE SELECT (id, num_cuenta, saldo) ON gesbank.cuentas FROM 'auditor'@'localhost';
-- Quitar al usuario auditor el privilegio de acceso a todas las tablas de la base de datos gesbank excepto a las tablas clientes y cuentas.
REVOKE SELECT ON gesbank.* FROM 'auditor'@'localhost';
GRANT SELECT ON gesbank.movimientos TO 'auditor'@'localhost';
-- Quitar al usuario con tu nombre los privilegios de consulta, actualización y eliminación sobre las tablas clientes, cuentas y roles de la base de datos gesbank.
REVOKE SELECT, UPDATE, DELETE ON gesbank.clientes FROM 'raulbueno'@'localhost';
REVOKE SELECT, UPDATE, DELETE ON gesbank.cuentas FROM 'raulbueno'@'localhost';
REVOKE SELECT, UPDATE, DELETE ON gesbank.roles FROM 'raulbueno'@'localhost';
-- 4. Renombrar usuarios y cambiar passwords

-- Renombrar el usuario cajero a cajero_admin.
RENAME USER 'cajero'@'localhost' TO 'cajero_admin'@'localhost';
-- Renombrar el usuario auditor a auditor_ro (read-only).
RENAME USER 'auditor'@'localhost' TO 'auditor_ro'@'localhost';
-- Cambiar el password del usuario cajero_admin. El nuevo password será Admin#2026. Se ha de mostrar la obtención del password cifrado.
SELECT PASSWORD('Admin#2026'); 
SET PASSWORD FOR 'cajero_admin'@'localhost' = PASSWORD('*267F2A81A523CCB3CB06531A877F953EFA45BEED');
-- Cambiar el password del usuario auditor_ro. El nuevo password será ReadOnly#99. Se ha de mostrar la obtención del password cifrado.
SELECT PASSWORD('ReadOnly#99'); 
SET PASSWORD FOR 'auditor_ro'@'localhost' = PASSWORD('*2EDC91C7CDBE57A118DD34E8A9708DE9AF6BC736');
-- Eliminar el usuario con tu nombre.
DROP USER 'raulbueno'@'localhost';
-- 5. Transacción con SAVEPOINT - Base de datos gescomercial
-- Sobre la base de datos gescomercial se pide incluir en una transacción el siguiente proceso:
USE gescomercial;
-- Iniciar la transacción.
START TRANSACTION;
-- Crear un SAVEPOINT llamado antes_cambio.
SAVEPOINT antes_cambio;
-- Insertar dos nuevos productos con datos válidos a criterio del alumno pertenecientes a la categoría 'Hardware' (id = 1) y al proveedor con id = 1.
INSERT INTO productos (nombre, descripcion, precio_coste, precio_venta, stock_actual, stock_min, estado, categoria_id, proveedor_id) VALUES
('Teclado', 'Teclado de membrana', 50.00, 70.00, 50, 10, 'Activo', 1, 1),
('Ratón', 'Ratón gaming', 15.00, 27.00, 30, 5, 'En Promoción', 1, 1);
-- Crear un SAVEPOINT llamado despues_insercion.
SAVEPOINT despues_insercion;
-- Incrementar en un 12% el precio_venta de todos los productos cuyo estado sea 'En Promoción'.
UPDATE productos SET precio_venta = precio_venta * 1.12 WHERE estado = 'En Promoción';
-- Incrementar en un 8% el precio_venta de todos los productos cuyo estado sea 'Activo'.
UPDATE productos SET precio_venta = precio_venta * 1.08 WHERE estado = 'Activo';
-- Si tras la subida algún producto del proveedor con id = 1 superase un precio_venta de 1.000 €, deshacer únicamente las actualizaciones de precios volviendo al SAVEPOINT despues_insercion, manteniendo así los dos productos insertados.
SELECT * FROM productos WHERE proveedor_id = 1 AND precio_venta > 1000;
-- SERÍA SI SE SUPERAN LOS 1000: ROLLBACK TO SAVEPOINT despues_insercion;
-- En caso contrario, confirmar la transacción completa con COMMIT.
COMMIT;
-- Nota: Para simplificar, se puede asumir que ningún producto supera ese límite y confirmar directamente con COMMIT.

-- 6. Funciones MySQL - Base de datos gescomercial
-- Todos los scripts de esta sección se realizarán sobre la base de datos gescomercial.
USE gescomercial;
-- Mostrar el nombre de cada producto en mayúsculas, junto con la longitud total del nombre y los 5 primeros caracteres del nombre como código abreviado.
SELECT UPPER(nombre) AS nombre_mayusculas, LENGTH(nombre) AS longitud, LEFT(nombre, 5) AS codigo_abreviado FROM productos;
-- Mostrar el nombre del producto, el precio_coste, el precio_venta y el margen comercial formateado con separador de miles y 2 decimales usando FORMAT. El margen se calcula como precio_venta - precio_coste. Ordenar de mayor a menor margen.
SELECT nombre, precio_coste, precio_venta, FORMAT(precio_venta - precio_coste, 2) AS margen_comercial FROM productos ORDER BY margen_comercial DESC;
-- Mostrar el nombre del cliente, la provincia y el número de días transcurridos desde que se dio de alta (create_at) hasta hoy. Usar DATEDIFF. Ordenar de mayor a menor antigüedad.

-- Mostrar los clientes dados de alta este mes. Usar MONTH(create_at) y MONTH(NOW()).

-- Mostrar el nombre del producto, el stock actual, el stock mínimo y una columna calculada llamada diferencia_stock que indique cuántas unidades faltan para alcanzar el stock_max. Ordenar de mayor a menor diferencia.
SELECT nombre, stock, stock_min, (stock - stock_min) AS diferencia_stock FROM productos ORDER BY diferencia_stock DESC;
-- Mostrar para cada cliente el nombre, la ciudad y el código postal extraídos de la columna direccion. La dirección tiene el formato 'Calle, ciudad'; extraer la ciudad usando SUBSTRING_INDEX.

-- Mostrar para cada producto un código de producto con el siguiente formato: EAN3ULTIMOS/5PRIMLETRAS_NOMBRE/ESTADO. Usar RIGHT, LEFT, UPPER, CONCAT y SUBSTRING_INDEX.
SELECT CONCAT('EAN3', RIGHT(id, 3), '/', LEFT(nombre, 5), '_', UPPER(estado)) AS codigo_producto FROM productos;
-- 7. Bloqueos de tablas - Base de datos gesbank
-- Realizar las siguientes operaciones de bloqueo sobre la base de datos gesbank:
USE gesbank;
-- Bloquear la tabla cuentas en modo lectura (READ).
LOCK TABLES cuentas READ;
-- Comprobar que se puede consultar (SELECT) la tabla cuentas (debe permitirlo).
SELECT * FROM gesbank.cuentas;
-- Intentar insertar una nueva cuenta (no debe permitirlo; indicar en un comentario el error obtenido).
INSERT INTO cuentas (id, num_cuenta, id_cliente, fecha_alta, fechaa_ul_mov, num_movtos, saldo, create_at, update_at) VALUES
('4', '210333331234567862', 4, DATETIME(NOW), DATETIME(NOW), 1, 20.00, DATETIME(NOW),DATETIME(NOW));
-- Desbloquear todas las tablas.
UNLOCK TABLES;
-- A continuación, en una transacción:

START TRANSACTION;
-- Bloquear en modo exclusivo (FOR UPDATE) el registro del cliente con id = 1 de la tabla clientes.
SELECT * FROM clientes WHERE id = 1 FOR UPDATE;
-- Dentro de la misma transacción, actualizar el telefono y el email del cliente con id = 1 con datos válidos a criterio del alumno.
UPDATE clientes SET telefono = '954345678', email = 'fran@gmail.com' WHERE id = 1;  
-- Insertar un nuevo movimiento de ingreso (tipo = 'I') para la cuenta con id = 1 con datos válidos a criterio del alumno.

-- Confirmar la transacción.
COMMIT;
-- 8. Exportar e importar datos

-- Todos los ejercicios están basados en la base de datos gescomercial.

Exportar al fichero clientes_sevilla.csv todos los clientes cuya provincia sea 'Sevilla'. El fichero ha de estar en formato CSV con las siguientes características:
Separador de campos: ;

-- Separador de registros: \n

-- Valores no numéricos entre comillas dobles ""

-- Columnas a exportar: id, nombre, direccion, poblacion, c_postal, provincia, telefono, email

-- Realizar una copia de seguridad completa (estructura y datos) de la base de datos gescomercial mediante mysqldump. Archivo de salida: gescomercial_backup.sql.

-- Realizar una copia de seguridad únicamente de las tablas productos y ventas de la base de datos gescomercial. Archivo de salida: gescomercial_productos_ventas.sql.

-- Exportar la base de datos gescomercial completa en formato XML mediante mysqldump. Archivo de salida: gescomercial.xml.

-- Crear un fichero productos_nuevos.csv con datos válidos de al menos 3 productos nuevos que no existan en la base de datos. El fichero debe respetar la estructura de la tabla productos (sin id).

-- Importar los datos del fichero productos_nuevos.csv a la tabla productos de la base de datos gescomercial.