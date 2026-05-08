-- Procedimiento que devuelve la clasificacion de una carrera dado su id

-- Parámetros: id de la carrera
-- Salida: clasificacion de la carrera

DELIMITER $$

DROP PROCEDURE IF EXISTS maratoon.clasificacion_carrera$$

CREATE PROCEDURE maratoon.clasificacion_carrera (IN p_id_carrera INT) 
BEGIN
    SELECT
        r.id Reg,
        co.id,
        co.apellidos,
        co.nombre,
        co.Club_id,
        cl.NombreCorto Club,
        co.Categoria_id,
        ca.NombreCorto Categoria,
        r.TiempoInvertido
    FROM maratoon.corredores co
        INNER JOIN maratoon.clubs cl ON co.Club_id = cl.id
        INNER JOIN maratoon.categorias ca ON co.categoria_id = ca.id
        INNER JOIN maratoon.registros r ON co.id = r.corredor_id
    WHERE
        r.carrera_id = p_id_carrera
    ORDER BY r.TiempoInvertido ASC;

    END$$