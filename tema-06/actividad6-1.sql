-- Actividad 6-1
-- Tema 6 Lengauje SQL DML
-- Base de Datos 25/26
-- Alumno: Raúl Bueno

-- Descripción: mina de datos de la bbdd futbol
USE futbol;

-- Tabla equipos
INSERT INTO equipos VALUES
(NULL, 'Athletic Club', 'San Mamés', 53289, 1898, 'Bilbao'),
(NULL, 'Getafe CF', 'Coliseum Alfonso Pérez', 17000, 1983, 'Getafe'),
(NULL, 'Real Sociedad', 'Reale Arena', 39500, 1909, 'San Sebastián'),
(NULL, 'RCD Espanyol', 'RCDE Stadium', 40000, 1900, 'Barcelona'),
(NULL, 'RC Celta de Vigo', 'Abanca Balaídos', 24791, 1923, 'Vigo');

-- Tabla jugadores
INSERT INTO jugadores VALUES
(16, 'Nico Williams', '2002-09-12', 6),
(17, 'Iñaki Williams', '1994-06-15', 6),
(18, 'Adrián Liso', '2005-04-02', 7),
(19, 'Mauro Arambarri', '1995-10-30', 7),
(20, 'Mikel Oyarzabal', '1997-04-21', 8),
(21, 'Sergio Gómez', '2000-09-04', 8),
(22, 'Raúl de Tomás', '1994-08-17', 9),
(23, 'Pol Lozano', '1999-10-06', 9),
(24, 'Iago Aspas', '1987-08-01', 10),
(25, 'Fran Beltrán', '1999-05-19', 10);
      
-- Tabla partidos
INSERT INTO partidos VALUES
(NULL, 6, 7, '2024-02-20 18:00:00', 2, 1, 'Victoria ajustada del Athletic sobre Getafe'),
(NULL, 8, 9, '2024-02-25 20:00:00', 2, 1, 'La Real Sociedad gana al Espanyol en casa'),
(NULL, 10, 6, '2024-03-01 21:00:00', 2, 2, 'Empate vibrante entre Celta y Athletic'),
(NULL, 7, 8, '2024-03-05 19:00:00', 0, 1, 'Victoria de la Real Sociedad fuera de casa'),
(NULL, 9, 10, '2024-03-10 18:30:00', 2, 2, 'Empate entre Espanyol y Celta'),
(NULL, 6, 8, '2024-03-15 21:00:00', 1, 0, 'Athletic vence a la Real Sociedad en San Mamés'),
(NULL, 7, 9, '2024-03-20 20:30:00', 3, 1, 'Getafe gana a Espanyol con gran actuación de Arambarri'),
(NULL, 10, 8, '2024-03-25 19:00:00', 2, 2, 'Celta y Real empatan en un partido emocionante'),
(NULL, 9, 6, '2024-03-30 21:00:00', 1, 2, 'Espanyol pierde frente al Athletic fuera de casa'),
(NULL, 8, 7, '2024-04-05 18:30:00', 3, 0, 'Real Sociedad golea al Getafe en su estadio');

-- Tabla goles
INSERT INTO goles VALUES
(NULL, 1, 15, 'Gol de Nico Williams tras gran pase', 16),
(NULL, 1, 50, 'Iñaki Williams define de cabeza', 17),
(NULL, 1, 78, 'Gol de Arambarri para Getafe', 19),
(NULL, 2, 10, 'Mikel Oyarzabal abre el marcador para la Real Sociedad', 20),
(NULL, 2, 35, 'Sergio Gómez amplía la ventaja', 21),
(NULL, 2, 78, 'Raúl de Tomás acorta distancias para el Espanyol', 22),
(NULL, 3, 10, 'Iago Aspas marca para Celta', 24),
(NULL, 3, 55, 'Nico Williams empata para Athletic', 16),
(NULL, 3, 70, 'Iñaki Williams adelanta al Athletic', 17),
(NULL, 4, 65, 'Mikel Oyarzabal marca el único gol', 20);
