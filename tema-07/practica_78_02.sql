-- practia_78_02
-- funciones fecha hora
-- Raúl Bueno

USE maratoon;

-- 1. Añadir 3 corredores
INSERT INTO Corredores (Nombre, Apellidos, Ciudad, FechaNacimiento, Sexo, Club_id) VALUES
('Luis', 'Martín Gómez', 'Jerez', '1995-03-15', 'H', 5),
('Ana', 'López Ruiz', 'Jerez', '2002-07-22', 'M', 5),
('Carlos', 'Sánchez Torres', 'Jerez', '1988-11-10', 'H', 5);

-- 2. Actualizar edad
UPDATE Corredores
SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, NOW());

-- 3. Actualizar categoría
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

-- 3. Mostrar todos los corredores
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Corredores.FechaNacimiento,
    Corredores.Edad,
    Categorias.Nombrecorto AS Categoria,
    Clubs.NombreCorto AS Club
FROM
    Corredores
        JOIN
    Categorias ON Corredores.categoria_id = Categorias.id
        JOIN
    Clubs ON Corredores.club_id = Clubs.id;

-- Corredores que cumplen años el mes que viene
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Corredores.FechaNacimiento,
    Corredores.Edad,
    Categorias.Nombrecorto AS Categoria,
    Clubs.NombreCorto AS Club
FROM
    Corredores
        JOIN
    Categorias ON Corredores.categoria_id = Categorias.id
        JOIN
    Clubs ON Corredores.club_id = Clubs.id
WHERE
    MONTH(Corredores.FechaNacimiento) = MONTH(DATE_ADD(NOW(), INTERVAL 1 MONTH));

-- Corredores que cumplen años la semana que viene
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Corredores.FechaNacimiento,
    Corredores.Edad,
    Categorias.Nombrecorto AS Categoria,
    Clubs.NombreCorto AS Club
FROM
    Corredores
        JOIN
    Categorias ON Corredores.categoria_id = Categorias.id
        JOIN
    Clubs ON Corredores.club_id = Clubs.id
WHERE
    WEEK(Corredores.FechaNacimiento) = WEEK(DATE_ADD(NOW(), INTERVAL 1 WEEK));

-- Nacidos en el segundo cuatrimestre
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Corredores.FechaNacimiento,
    Corredores.Edad,
    Categorias.Nombrecorto AS Categoria,
    Clubs.NombreCorto AS Club
FROM
    Corredores
        JOIN
    Categorias ON Corredores.categoria_id = Categorias.id
        JOIN
    Clubs ON Corredores.club_id = Clubs.id
WHERE
    MONTH(Corredores.FechaNacimiento) BETWEEN 5 AND 8;

-- 4. Insertar registros
INSERT INTO Registros VALUES
(NULL, 2, 2, '2019-12-02 09:00:00', '2019-12-02 11:12:00', NULL),
(NULL, 2, 3, '2019-12-02 09:00:00', '2019-12-02 11:15:30', NULL),
(NULL, 2, 4, '2019-12-02 09:00:00', '2019-12-02 11:20:10', NULL),
(NULL, 2, 5, '2019-12-02 09:00:00', '2019-12-02 11:25:45', NULL),
(NULL, 2, 6, '2019-12-02 09:00:00', '2019-12-02 11:30:00', NULL);

-- 5. Actualizar tiempo
UPDATE Registros
SET TiempoInvertido = TIMEDIFF(Llegada, Salida)
WHERE carrera_id = 2;

-- Clasificación general
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Clubs.Nombre AS Club,
    Categorias.Nombre AS Categoria,
    Registros.TiempoInvertido
FROM
    Registros
        JOIN
    Corredores ON Registros.corredor_id = Corredores.id
        JOIN
    Clubs ON Corredores.club_id = Clubs.id
        JOIN
    Categorias ON Corredores.categoria_id = Categorias.id
WHERE
    Registros.carrera_id = 2
ORDER BY Registros.TiempoInvertido ASC;

-- Clasificación con segundos
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Clubs.Nombre AS Club,
    Categorias.Nombre AS Categoria,
    Registros.TiempoInvertido,
    TIME_TO_SEC(Registros.TiempoInvertido) AS Segundos
FROM
    Registros
        JOIN
    Corredores ON Registros.corredor_id = Corredores.id
        JOIN
    Clubs ON Corredores.club_id = Clubs.id
        JOIN
    Categorias ON Corredores.categoria_id = Categorias.id
WHERE
    Registros.carrera_id = 2
ORDER BY Registros.TiempoInvertido ASC;

-- Diferencia con récord mundial
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Clubs.Nombre AS Club,
    Categorias.Nombre AS Categoria,
    Registros.TiempoInvertido,
    SEC_TO_TIME(TIME_TO_SEC(Registros.TiempoInvertido) - TIME_TO_SEC('02:01:39')) AS DiferenciaRecord
FROM
    Registros
        JOIN
    Corredores ON Registros.corredor_id = Corredores.id
        JOIN
    Clubs ON Corredores.club_id = Clubs.id
        JOIN
    Categorias ON Corredores.categoria_id = Categorias.id
WHERE
    Registros.carrera_id = 2
ORDER BY Registros.TiempoInvertido ASC;

-- Clasificación categoría SNA
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Clubs.Nombre AS Club,
    Categorias.Nombre AS Categoria,
    Registros.TiempoInvertido
FROM
    Registros
        JOIN
    Corredores ON Registros.corredor_id = Corredores.id
        JOIN
    Clubs ON Corredores.club_id = Clubs.id
        JOIN
    Categorias ON Corredores.categoria_id = Categorias.id
WHERE
    Registros.carrera_id = 2
        AND Categorias.id = 4
ORDER BY Registros.TiempoInvertido ASC;