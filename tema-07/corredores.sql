-- 
SELECT 
    id, CONCAT_WS(' , ', apellidos, nombre) AS corredor
FROM
    maratoon.corredores;
    
-- funcion LEFT
SELECT 
    id,
    CONCAT_WS(', ', apellidos, nombre) AS corredor,
    LEFT(apellidos, 3)
FROM
    maratoon.corredores;
    
-- funcioon LOCATE
CREATE VIEW corredores_2 AS SELECT 
    id,
    CONCAT_WS(', ', apellidos, nombre) AS corredor,
    LEFT(apellidos, 3)
FROM
    maratoon.corredores;
    
-- funcion LOCATE
SELECT LOCATE(', ', corredor) FROM corredores_2;

-- lower
SELECT 
    id,
    CONCAT_WS(', ', apellidos, nombre) AS corredor,
    LOWER(LEFT(apellidos, 3))
FROM
    maratoon.corredores;
    
-- REVERSE
SELECT 
    id,
    CONCAT_WS(', ', apellidos, nombre) AS corredor,
    REVERSE(LOWER(LEFT(apellidos, 3)))
FROM
    maratoon.corredores;
    
-- RIGHT
SELECT RIGHT(corredor, 10) FROM corredores_2;

-- SUBSTRING
-- obtener el nombre
SELECT SUBSTRING(corredor, LOCATE(', ', corredor)+ 2) AS nombre FROM corredores_2;

-- SUBSTRING_INDEX
-- obtener apellido
SELECT SUBSTRING_INDEX(corredor, ', ', 1) as apellidos FROM corredores_2;

-- obtener el nombre
SELECT SUBSTRING_INDEX(corredor, ', ', -1) as nombre FROM corredores_2;

-- UPPER
SELECT UPPER(corredor) FROM corredores_2;