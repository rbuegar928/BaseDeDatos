-- ejemplo
-- SELECT 

USE geslibros;
-- Muestra todos los registros de la tabla libros,
-- con todas las columnas de la tabla libros
-- Lista de columnas: *
SELECT * FROM libros;

-- Especificamos lista de columnas
SELECT 
    id, 
    titulo, 
    autor_id, 
    editorial_id, 
    precio_venta
FROM
    libros;
    
-- Lista de columnas con expresión
-- Beneficio que obtengo con cada libro: precio_venta - precio_coste
-- La cláusula as no es obligatoria
SELECT 
    id,
    titulo,
    autor_id,
    editorial_id,
    precio_coste,
    precio_venta,
    precio_venta - precio_coste  beneficio
FROM
	libros;
    
-- Uso de prefijos
-- Columnas: nombre de la base de datos, nombre de la tabla
-- Tablas: nombre de la base de datos
SELECT 
    libros.id,
    libros.titulo,
    libros.autor_id,
    libros.editorial_id,
    libros.precio_coste,
    libros.precio_venta,
    libros.precio_venta - libros.precio_coste  beneficio
FROM
	geslibros.libros;
    
-- Clausula FROM
-- las tablas a partir de la cual extraigo los datos
SELECT 
    libros.id,
    libros.titulo,
    libros.autor_id,
    autores.id as autor,
    autores.nombre as autor,
    libros.id as id_libro,
    libros.precio_venta
FROM
    libros,
    autores,
    editoriales;