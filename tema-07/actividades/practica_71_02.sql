-- practica_71_02
-- Raúl Bueno

-- 1. Crear usuarios
-- 1a - juan
SELECT PASSWORD('juan_01');
CREATE USER juan@localhost IDENTIFIED 
BY PASSWORD '*DBEA713660EAA6053C71DCAD75AFBC96A73ECA0F';
-- 1b - pedro
SELECT PASSWORD('pedro_01');
CREATE USER pedro@localhost IDENTIFIED 
BY PASSWORD '*63058EE0D2496A67E1B947A59809A732758516FF';
-- 1c - maria
SELECT PASSWORD('maria_03');
CREATE USER maria@localhost IDENTIFIED 
BY PASSWORD '*610163669DEF78BB9ABD9FF46C482F1235C7B03D';
-- 1d - miguel
SELECT PASSWORD('miguel_04');
CREATE USER miguel@localhost IDENTIFIED 
BY PASSWORD '*FD1C9AE91857DAED605342CF3B9B1EBA5B1E4A46';
-- 1e - rocio
SELECT PASSWORD ('rocio_05');
CREATE USER rocio@localhost IDENTIFIED 
BY PASSWORD '*8D4F0AFD37706EF85EE95411E70503B0C33027DF';

-- 3. Insert user
SELECT PASSWORD('roberto_79');
INSERT mysql.user (host, user, password) values
('localhost', 'roberto', '*BDED085F21F711E7B0673C5ABC5AEFE6F342FAF5');

-- Este comando de error por malas prácticas
-- Motivos: Es una tabla "protegida" y no editable, la
-- cual solo se nos permite verla pero no editarla

-- 4. Eliminar usuarios
DROP USER miguel@localhost;
DROP USER rocio@localhost;