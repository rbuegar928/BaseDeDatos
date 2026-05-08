-- Active: 1777278237175@@127.0.0.1@3306@loteriaprimitiva
-- variable global
SET @nombre = 'Juan Carlos';
SELECT @nombre;

SET @numero_1 = 1;
SET @numero_2 = 2;
SELECT @numero_1 + @numero_2;

USE maratoon;
SET @ciudad = 'Villamartín';

-- Corredores de Villamartín
SELECT nombre FROM corredores WHERE ciudad = @ciudad;