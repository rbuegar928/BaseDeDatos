-- actualizar edad de los corredores
DELIMITER $$
DROP PROCEDURE IF EXISTS maratoon.actualizar_edad_corredorres$$
CREATE PROCEDURE IF NOT EXISTS maratoon.actualizar_edad_corredorres()
BEGIN
    UPDATE maratoon.corredores
    SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, CURDATE());
END$$