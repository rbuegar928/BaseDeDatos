USE test;

DROP TABLE IF EXISTS pacientes;
CREATE TABLE IF NOT EXISTS pacientes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    nss VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(20),
    poblacion VARCHAR(50) NOT NULL,
    expediente VARCHAR(20) NOT NULL,
    dni VARCHAR(15) NOT NULL,
    historial_clinico TEXT NOT NULL,
    fecha_nac DATE NOT NULL,
    edad INT NOT NULL
);
