DROP DATABASE IF EXISTS horarios;
CREATE DATABASE IF NOT EXISTS horarios;
USE horarios;

DROP TABLE IF EXISTS departamentos;
CREATE TABLE departamentos (
    id INT UNSIGNED AUTO_INCREMENT NULL,
    nombre VARCHAR(50) NOT NULL,
    cod_departamento CHAR(3) NOT NULL,

    CONSTRAINT departamentos_id PRIMARY KEY (id),
    CONSTRAINT departamentos_cod UNIQUE (cod_departamento)
);

DROP TABLE IF EXISTS profesor;
CREATE TABLE profesor (
    id INT UNSIGNED AUTO_INCREMENT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    fecha_ingreso DATE NOT NULL,
    especialidad VARCHAR(50) NOT NULL,
    nrp VARCHAR(20) NOT NULL,
    departamento_id INT NOT NULL,

    CONSTRAINT profesor_id PRIMARY KEY (id),
    CONSTRAINT profesor_email UNIQUE (email),
    CONSTRAINT profesor_nrp UNIQUE (nrp),
    CONSTRAINT profesor_departamento
        FOREIGN KEY (departamento_id)
        REFERENCES departamentos(id)
);

DROP TABLE IF EXISTS asignatura;
CREATE TABLE asignatura (
    id INT UNSIGNED AUTO_INCREMENT NULL,
    nombre VARCHAR(50) NOT NULL,
    nivel CHAR(4) NOT NULL,
    cod_asignatura CHAR(7) NOT NULL,
    horas INT NOT NULL,
    departamento_id INT NOT NULL,

    CONSTRAINT asignatura_id PRIMARY KEY (id),
    CONSTRAINT asignatura_cod UNIQUE (cod_asignatura),
    CONSTRAINT asignatura_departamento
        FOREIGN KEY (departamento_id)
        REFERENCES departamentos(id)
);

DROP TABLE IF EXISTS horario;
CREATE TABLE horario (
    id INT NOT NULL,
    profesor_id INT NOT NULL,
    dia INT NOT NULL,
    tramo INT NOT NULL,
    turno INT NOT NULL,
    asignatura_id INT NOT NULL,
    horas INT NOT NULL,

    CONSTRAINT horario_id PRIMARY KEY (id),
    CONSTRAINT horario_profesor
        FOREIGN KEY (profesor_id)
        REFERENCES profesor(id),
    CONSTRAINT horario_asignatura
        FOREIGN KEY (asignatura_id)
        REFERENCES asignatura(id)
);