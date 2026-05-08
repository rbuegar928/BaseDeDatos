DELIMITER $$
DROP PROCEDURE IF EXISTS test.hola_mundo$$
CREATE PROCEDURE test.hola_mundo()
BEGIN 
    SELECT "Hola mundo: PL/SQL";
END $$
