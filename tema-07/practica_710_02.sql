-- practica_710_02
-- Raúl Bueno

-- 1. Accede a MySQL a modo consola como usuario root. A partir de ahora todos los comandos posteriores se ejecutarán a modo consola MySQL.
mysql -h localhost -u root

-- 2. Realiza los siguientes comandos sql:
-- Muestra todas las bases de datos existentes en MySQL
SHOW DATABASES;

-- Selecciona la base de datos geslibros, como base de datos activa
USE Geslibros;

-- Muestra todas las tablas de la base de datos activa (geslibros)
SHOW TABLES;

-- Muestra la estructura de la tabla libros (usa el comando sql describe)
DESCRIBE libros;

-- Muestra las columnas host, user y password de la tabla mysql.user.
SELECT host, user, password FROM mysql.user;

-- Muestra los privilegios de dos de los usuarios mostrados en el ejercicio anterior (usar el comando sql show grants for user@localhost)
SHOW GRANTS FOR root@localhost;

-- Muestra los privilegios del usuario actual (show grants for CURRENT_USER())
SHOW GRANTS FOR CURRENT_USER();

-- Muestra todos los privilegios que se pueden asignar a un usuario (show privileges)
SHOW PRIVILEGES;

-- 3. En modo consola crea el usuario lopez asignándole el password 123456 asignándole los siguientes privilegios:
-- Create, Alter, Update, Insert sobre la tabla corredores de la base de datos maratoon.
CREATE USER lopez@localhost IDENTIFIED BY '123456';

GRANT CREATE, ALTER, UPDATE, INSERT 
ON maratoon.corredores 
TO lopez@localhost;

-- 4. En modo consola cambiar el password del usuario anterior a 654321
ALTER USER lopez@localhost IDENTIFIED BY '654321';

-- 5. En modo consola realiza la siguiente transacción sobre la base de datos geslibros: 
-- Inicia transacción
START TRANSACTION;

-- Actualiza el precio de todos los libros incrementándolo en un 10%
UPDATE libros 
SET precio_venta = precio_venta * 1.10;

-- Comprobar actualización
SELECT id, titulo, precio_venta FROM libros;

-- Terminar transacción de forma no satisfactoria 
ROLLBACK;

-- 6. En modo consola realiza las siguientes operaciones de bloqueo de tablas sobre la base de datos geslibros:
-- Bloque a modo lectura la tabla libros
LOCK TABLES libros READ;

-- Muestra todos los autores (no se debe ejecutar este comando por tener bloqueado libros)
SELECT * FROM autores;

-- Desbloquea todas las tablas
UNLOCK TABLES;

-- Muestra ahora todos los autores
SELECT * FROM autores;

-- 7. En modo consola realiza las siguientes operaciones:
-- Inicia transacción
START TRANSACTION;

-- Bloque a modo compartido todos los clientes de la provincia de Cádiz.
SELECT * FROM clientes 
WHERE provincia_id = 11
LOCK IN SHARE MODE;

-- Muestre todos los clientes excepto los que pertenecen a la provincia de Cádiz
SELECT * FROM clientes 
WHERE provincia_id NOT IN (11);

-- Termine correctamente la transacción
COMMIT;

-- 8. Igualmente en modo consola realiza las siguientes operaciones sobre la base de datos maratoon:
-- Actualiza la edad de todos los corredores
UPDATE Corredores 
SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, NOW());

-- Muestra id, apellidos, nombre, edad, club, categoria, de todos los corredores
SELECT 
corredores.id, corredores.Apellidos, corredores.Nombre, corredores.Edad, clubs.Nombre AS Club, categorias.Nombre AS Categoria 
FROM corredores 
INNER JOIN clubs ON corredores.club_id = clubs.id 
INNER JOIN categorias ON corredores.categoria_id = categorias.id;

-- 9. Crea en un fichero con formato csv a partir de un comando SELECT, los corredores sólo de villamartín.
SELECT * FROM corredores 
WHERE ciudad = 'Villamartín'
INTO OUTFILE '/ruta/corredores_villamartin.csv' 
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- 10. Salir de MySQL en modo consola
EXIT;

-- 11. Realizar una copia de seguridad de la base de datos maratoon (tanto estructura como tablas) maratoon.sql
mysqldump -u root -p maratoon > maratoon.sql

-- 12. Realizar una copia de seguridad de todas las bases de datos de mysql (alldatabases.sql)
mysqldump -u root -p --all-databases > alldatabases.sql

-- 13. Exportar la base de datos empresa en formato xml (empresa.xml)
mysqldump -u root -p --xml empresa > empresa.xml
