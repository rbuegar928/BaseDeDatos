DROP DATABASE IF EXISTS  RestriccionesDefault;
CREATE DATABASE IF NOT EXISTS RestriccionesDefault;

USE RestriccionesDefault;

DROP TABLE IF EXISTS restriccionesdefault;
CREATE TABLE IF NOT EXISTS restriccionesdefault (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    poblacion VARCHAR(50) DEFAULT 'Ubrique',
    provincia VARCHAR(50) DEFAULT 'Cádiz',
    nacionalidad VARCHAR(50) DEFAULT 'España',

    precio DECIMAL(6,2) DEFAULT 10.20,
    sueldo DECIMAL(8,2) DEFAULT 1500.00,

    fecha_hora_llegada DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_llegada DATE DEFAULT CURRENT_TIMESTAMP,
    hora_llegada TIME DEFAULT CURRENT_TIMESTAMP,

    casado BOOLEAN DEFAULT 1,
    carnet_conducir BOOLEAN DEFAULT 1
);

INSERT INTO restriccionesdefault
(poblacion, provincia, nacionalidad, precio, sueldo,
 fecha_hora_llegada, fecha_llegada, hora_llegada)
 VALUES
('Prado del Rey', default, default, 12.80, 1400.00, default, default, default),
(default, default, default, 17.80, 2100.00, default, default, default),
('El Bosque', default, default, 8.80, 1000.00, default, default, default);