-- practica_83_02
-- Raúl Bueno

-- ACTIVIDAD 1
-- FUNCIÓN Categoria()
-- Devuelve el id de la categoría según la edad

USE maratoon;

DELIMITER $$

DROP FUNCTION IF EXISTS Categoria $$

CREATE FUNCTION Categoria(p_edad INT)
RETURNS INT
BEGIN
    DECLARE v_categoria INT;

    IF p_edad < 12 THEN SET v_categoria = 1;
    ELSEIF p_edad BETWEEN 12 AND 14 THEN SET v_categoria = 2;
    ELSEIF p_edad BETWEEN 15 AND 17 THEN SET v_categoria = 3;
    ELSEIF p_edad BETWEEN 18 AND 29 THEN SET v_categoria = 4;
    ELSEIF p_edad BETWEEN 30 AND 39 THEN SET v_categoria = 5;
    ELSEIF p_edad BETWEEN 40 AND 49 THEN SET v_categoria = 6;
    ELSEIF p_edad BETWEEN 50 AND 60 THEN SET v_categoria = 7;
    ELSE SET v_categoria = 8;
    END IF;

    RETURN v_categoria;

END$$

-- ACTIVIDAD 2
-- PROCEDIMIENTO ActualizarCategoria
-- Actualiza categoria_id usando la función Categoria()

DELIMITER $$

DROP PROCEDURE IF EXISTS ActualizarCategoria $$

CREATE PROCEDURE ActualizarCategoria()
BEGIN
    UPDATE Corredores SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, CURDATE());
    UPDATE Corredores SET categoria_id = Categoria(Edad);
END$$

-- ACTIVIDAD 3
-- PROCEDIMIENTO ProximosCumpleaños
-- Muestra corredores que cumplen años en la próxima semana

DELIMITER $$

DROP PROCEDURE IF EXISTS ProximosCumpleaños $$

CREATE PROCEDURE ProximosCumpleaños()
BEGIN
    SELECT id, Nombre, Apellidos, FechaNacimiento, DATE_FORMAT(FechaNacimiento,'%d/%m') AS Cumpleaños
    FROM Corredores
    WHERE
        DAYOFYEAR(
            STR_TO_DATE(
                CONCAT(YEAR(CURDATE()), '-', MONTH(FechaNacimiento), '-', DAY(FechaNacimiento)),
                '%Y-%m-%d'
            )
        )
        BETWEEN DAYOFYEAR(CURDATE())
        AND DAYOFYEAR(DATE_ADD(CURDATE(), INTERVAL 7 DAY));

END$$

-- ACTIVIDAD 4
-- FUNCIÓN NumerosPrimos
-- Base de datos: test
-- Devuelve la suma de números primos desde 1 hasta n

USE test;

DELIMITER $$

DROP FUNCTION IF EXISTS NumerosPrimos $$

CREATE FUNCTION NumerosPrimos(n INT)
RETURNS INT
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT;
    DECLARE esPrimo BOOLEAN;
    DECLARE suma INT DEFAULT 0;

    WHILE i <= n DO

        SET esPrimo = TRUE;

        IF i > 1 THEN

            SET j = 2;

            WHILE j < i DO

                IF i MOD j = 0 THEN
                    SET esPrimo = FALSE;
                END IF;

                SET j = j + 1;

            END WHILE;

        END IF;

        IF esPrimo = TRUE THEN
            SET suma = suma + i;
        END IF;

        SET i = i + 1;

    END WHILE;

    RETURN suma;
END $$

-- ACTIVIDAD 5
-- FUNCIÓN Factorial
-- Base de datos: test
-- Devuelve el factorial de un número

DELIMITER $$

DROP FUNCTION IF EXISTS Factorial $$

CREATE FUNCTION Factorial(n INT)
RETURNS BIGINT
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE resultado BIGINT DEFAULT 1;

    IF n < 0 THEN
        RETURN NULL;
    END IF;

    WHILE i <= n DO
        SET resultado = resultado * i;
        SET i = i + 1;

    END WHILE;

    RETURN resultado;

END$$

DELIMITER ;