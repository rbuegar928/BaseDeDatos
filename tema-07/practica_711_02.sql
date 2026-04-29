-- Active: 1777278237175@@127.0.0.1@3306@geslibros
-- Active: 1777278237175@@127.0.0.1@3306@maratoon237175@@127.0.0.1@3306@loteriaprimitiva
-- practica_711_02
-- Raúl Bueno

-- 1. Crear usuarios
-- Se pide crear un usuario mediante la sentencia SQL correspondiente a partir de los siguientes requisitos:
-- Nombre de usuario: tu propio nombre seguido del primer apellido, todo junto y en minúsculas. Por ejemplo en mi caso el nombre de usuario sería juancarlosmoreno
-- Password: el password será 1234567 pero ha de ejecutarse cifrado, por lo que deberá obtenerse la cadena cifrada.
-- Privilegios: este usuario no tendrá ningún privilegio, sólo podrá acceder a la base de datos de testeo
-- Nota: se ha de adjuntar la sentencia SQL usada para obtener la cadena encriptada del password.
SELECT PASSWORD('1234567');
CREATE USER 'raulbueno'@'localhost'
IDENTIFIED BY PASSWORD '*6A7A490FB9DC8C33C2B025A91737077A7E9CC5E5';

-- 2. Asignación de privilegios
-- Sobre el usuario creado en el apartado anterior se pide:
-- Asignar al usuario privilegios de superadministrador, es decir, todos los privilegios, sobre todas las bases de datos, incluyendo el privilegio GRANT
GRANT ALL PRIVILEGES ON geslibros.* TO 'raulbueno'@'localhost' WITH GRANT OPTION;

-- Asignar todos los privilegios sobre la base de datos geslibros.
GRANT ALL PRIVILEGES ON geslibros TO 'raulbueno'@'localhost';

-- Asignar todos los privilegios sobre las tablas libros, editoriales y clientes de la base de datos geslibros.
GRANT ALL PRIVILEGES ON geslibros.libros TO 'raulbueno'@'localhost';
GRANT ALL PRIVILEGES ON geslibros.editoriales TO 'raulbueno'@'localhost';
GRANT ALL PRIVILEGES ON geslibros.clientes TO 'raulbueno'@'localhost';

-- Asignar privilegios para que sólo pueda consultar en la tabla libros, editoriales y clientes de la base de datos geslibros
GRANT SELECT ON geslibros.libros TO 'raulbueno'@'localhost';
GRANT SELECT ON geslibros.editoriales TO 'raulbueno'@'localhost';
GRANT SELECT ON geslibros.clientes TO 'raulbueno'@'localhost';

-- Asignar privilegios para que pueda acceder a consultar y actualizar las columnas nombre, direccion, poblacion, codpostal, telefono y email de la tabla clientes 
-- correspondiente a la base de datos geslibros.
GRANT SELECT (nombre, direccion, poblacion, c_postal, telefono, email),
      UPDATE (nombre, direccion, poblacion, c_postal, telefono, email)
ON geslibros.clientes TO raulbueno@localhost;

-- Asignar privilegios de forma que sólo podrá consultar las columnas id, titulo, precio_venta, fechaedicion y actualizar la columna precio_venta y titulo
-- de la tabla libros correspondiente a la base de datos geslibros.
GRANT SELECT (id, titulo, precio_venta, fecha_edicion),
      UPDATE (titulo, precio_venta)
ON geslibros.libros TO 'raulbueno'@'localhost';

-- Asignar todos los privilegios para que pueda acceder a modo consulta a todas las tablas de la base de datos geslibros excepto a ventas y lineasventas
GRANT SELECT ON geslibros.* TO 'raulbueno'@'localhost';   -- le damos permisos en todo
REVOKE SELECT ON geslibros.ventas FROM 'raulbueno'@'localhost';   -- le quitamos los permisos en lo que no queremos que acceda
REVOKE SELECT ON geslibros.lineasventas FROM 'raulbueno'@'localhost';

-- 3. Eliminar privilegios
-- Eliminar los siguientes privilegios al usuario creado en el primer apartado
-- Quitar privilegio GRANT
REVOKE GRANT OPTION ON *.* FROM 'raulbueno'@'localhost';

-- Quitar todos los privilegios sobre todas las bases de datos
REVOKE ALL PRIVILEGES ON *.* FROM 'raulbueno'@'localhost';  

-- Quitar todos los privilegios sobre la base de datos geslibros
REVOKE ALL PRIVILEGES ON geslibros.* FROM 'raulbueno'@'localhost';

-- Quitar el privilegio de actualización (UPDATE) sobre la tabla libros de la base de datos geslibros.
REVOKE UPDATE ON geslibros.libros FROM 'raulbueno'@'localhost';

-- Quitar el privilegio de consulta sobre las columnas id, titulo, precio_venta de la tabla libros correspondiente a la base de datos geslibros.
REVOKE SELECT (id, titulo, precio_venta)
ON geslibros.libros FROM 'raulbueno'@'localhost';

-- Quitar el privilegio de acceso a todas las tablas de la base de datos geslibros excepto a las tablas libros y clientes.
REVOKE ALL PRIVILEGES ON geslibros.* FROM 'raulbueno'@'localhost';
GRANT ALL PRIVILEGES ON geslibros.libros TO 'raulbueno'@'localhost';
GRANT ALL PRIVILEGES ON geslibros.clientes TO 'raulbueno'@'localhost';

-- Quitar el privilegio de consulta, actualización y eliminación sobre las tablas libros, clientes, editoriales y autores de la base de datos geslibros.
REVOKE SELECT, UPDATE, DELETE ON geslibros.libros FROM 'raulbueno'@'localhost';
REVOKE SELECT, UPDATE, DELETE ON geslibros.clientes FROM 'raulbueno'@'localhost';
REVOKE SELECT, UPDATE, DELETE ON geslibros.editoriales FROM 'raulbueno'@'localhost';
REVOKE SELECT, UPDATE, DELETE ON geslibros.autores FROM 'raulbueno'@'localhost';

-- 4. Cambiar password
-- Se desea cambiar el password al usuario creado en el apartado 1. El nuevo password será '21436587'. Se ha de mostrar la obtención del password cifrado.
SELECT PASSWORD('21436587');
ALTER USER 'raulbueno'@'localhost'
IDENTIFIED BY PASSWORD '*1DEB27DD74919473A2C69FDFA8E46B08E9F16547';

-- 5. Sorteo lotería primitiva
-- Descargar el fichero loteriaprimitiva.sql e instalar la base de datos loteriaprimitiva.
-- Se pide incluir en una transacción una simulación de dos sorteos, es decir, añadir dos nuevos registros en la tabla sorteos de la base de datos loteriaprimitiva. 
-- Se tendrán en cuenta los siguientes requisitos:
USE loteriaprimitiva;
-- Se ha de iniciar una transacción
START TRANSACTION;

-- La fecha se ha de corresponder con la fecha y hora actual
-- Los números de la lotería primitiva (num1, num2, ...) se han de corresponder con números aleatorios entre 1 y 49. No se tendrá en cuenta si el
-- número se ha repetido.
-- El número complementario es un número aleatorio entre 1 y 49 también
-- El reintegro es un número aleatorio entre 0 y 9
INSERT INTO Sorteos 
(fecha, num1, num2, num3, num4, num5, num6, complementario, reintegro)
VALUES
(NOW(),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(RAND()*10)
),

(NOW(),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(1 + RAND()*49),
 FLOOR(RAND()*10)
);

-- Confirmar una vez finalizada la transacción
COMMIT;

-- 6. Base de datos maratoon.
-- Todos los script de esta sección se realizarán sobre la base de datos maratoon.
-- Mediante un ALTER TABLE se deben añadir a la tabla corredores las siguientes columnas:
-- apellido1
ALTER TABLE corredores
ADD apellido1 VARCHAR(40),
ADD apellido2 VARCHAR(40),
ADD codigo CHAR(11);

-- apellido2
UPDATE corredores
SET apellido1 = SUBSTRING_INDEX(Apellidos, ' ', 1),
    apellido2 = SUBSTRING_INDEX(Apellidos, ' ', -1);

-- codigo
UPDATE corredores
SET codigo = UPPER(CONCAT(
    YEAR(FechaNacimiento), '/',
    LEFT(Nombre,2),
    LEFT(apellido1,2),
    LEFT(apellido2,2)
));

-- Crear un script para actualizar la columna edad a partir de la fecha de nacimiento.
UPDATE corredores SET edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, CURDATE());

-- Actualizar la columna categoria_id a partir de la edad, teniendo en cuenta el campo descripción de la tabla categorías.
UPDATE corredores SET categoria_id = 
CASE 
	WHEN edad < 12 THEN 1 -- infantil
    WHEN edad < 15 THEN 2 -- junior
    WHEN edad < 18 THEN 3 -- juvenil
    WHEN edad < 30 THEN 4 -- senior a
    WHEN edad < 40 THEN 5 -- senior b
    WHEN edad < 50 THEN 6 -- veterano a
    WHEN edad < 60 THEN 7 -- veterano b
    ELSE 8 -- veterano c
END;

-- Ejecutar el proceso 6.4 y 6.5 dentro de una transacción en la que previamente a la actualización de la tabla corredores (edad y categoria_id) 
-- se deberá bloquear en modo UPDATE todos los registros de la tabla categorias para que no pueda ser modificada durante dicho proceso.
START TRANSACTION;

-- Bloqueo de la tabla categorias
SELECT * FROM categorias FOR UPDATE;

-- Actualizar edad
UPDATE Corredores
SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, CURDATE());

-- Actualizar categoría
UPDATE corredores SET categoria_id = 
CASE 
	WHEN edad < 12 THEN 1 -- infantil
    WHEN edad < 15 THEN 2 -- junior
    WHEN edad < 18 THEN 3 -- juvenil
    WHEN edad < 30 THEN 4 -- senior a
    WHEN edad < 40 THEN 5 -- senior b
    WHEN edad < 50 THEN 6 -- veterano a
    WHEN edad < 60 THEN 7 -- veterano b
    ELSE 8 -- veterano c
END;

COMMIT;

-- 7. Exportar/Importar datos
-- Todos los ejercicios están basados en la base de datos geslibros.
-- Exportar en el fichero clientesUbrique.csv todos los clientes de Ubrique. El fichero de exportación como se indica ha de estar en formato csv, separación de campos ';' y '\n' como separador de líneas o registros, además se usará "" para expresar los varlores no numéricos.
SELECT * FROM clientes
WHERE poblacion = 'Ubrique'
INTO OUTFILE 'C:/Users/08_1DAW_Alum/Documents/base-datos-2526/tema-07/clientesUbrique.csv'
FIELDS TERMINATED BY ';'
ENCLOSED BY '\"'
LINES TERMINATED BY '\n';

-- Exportar todos los autores en el fichero autores.xml, formato xml
mysqldump -u root -p geslibros.autores > 'C:/Users/08_1DAW_Alum/Documents/base-datos-2526/tema-07/autores.xml';

-- Realizar una copia de seguridad de la base de datos geslibros incluir tanto datos como estructura.
mysqldump -u root -p geslibros > geslibros.sql

-- Crear un fichero libros.csv donde se incluyan datos válidos de al menos 4 libros.
/*
isbn;ean;titulo;autor_id;editorial_id;precio_coste;precio_venta;stock
1111111111111;1111111111111;Libro1;1;1;10;15;5
2222222222222;2222222222222;Libro2;2;2;12;18;6
3333333333333;3333333333333;Libro3;3;3;15;20;7
4444444444444;4444444444444;Libro4;4;4;20;25;8
*/

-- Importar los datos del archivo libros.csv a la tabla libros de la base de datos.
LOAD DATA INFILE 'C:/Users/08_1DAW_Alum/Documents/base-datos-2526/tema-07/libros.csv'
INTO TABLE libros
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;