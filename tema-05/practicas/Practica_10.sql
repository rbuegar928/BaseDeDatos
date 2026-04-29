-- Actividad: 5.10
-- Tema: Lenguaje SQL - DDL
-- Módulo: Base de Datos
-- Curso: 25/26
-- Nombre: Raúl Bueno

DROP DATABASE IF EXISTS restricciones_check ;
CREATE DATABASE IF NOT EXISTS restricciones_check  CHAR SET utf8 COLLATE utf8_general_ci;

USE restricciones_check;

DROP TABLE IF EXISTS comparacion;
CREATE TABLE IF NOT EXISTS comparacion(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    importe DECIMAL(10,2) UNSIGNED CHECK (importe > 400),
    saldo DECIMAL(10,2) UNSIGNED CHECK (saldo < 0),	
    nombre VARCHAR(20),
    apellidos VARCHAR(40),
    NBeneficiarios TINYINT UNSIGNED CHECK (NBeneficiarios >= 5),
    NAsignatura TINYINT UNSIGNED CHECK (NAsignatura < 5),
    Beca BOOLEAN,
    ImporteBeca DECIMAL(10,2) UNSIGNED CHECK  (ImporteBeca < 2500),
    NGoles TINYINT UNSIGNED CHECK (NGoles > 20),
    AnnoNacimiento YEAR CHECK (AnnoNacimiento > 1970),
    FechaNacimiento DATE CHECK (FechaNacimiento < '2000/02/21'),
    HoraLlegada TIME CHECK (HoraLlegada < 12)
    );
    
DROP TABLE IF EXISTS checkbetween;
CREATE TABLE IF NOT EXISTS checkbetween(    
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ngoles TINYINT UNSIGNED CHECK (ngoles BETWEEN 20 AND 30),
    sueldo DECIMAL(10,2) UNSIGNED CHECK (sueldo BETWEEN 2000 AND 3000),
    importe DECIMAL(10,2) UNSIGNED CHECK (importe BETWEEN 400 AND 600),
    cantidad TINYINT UNSIGNED CHECK (cantidad BETWEEN 5 AND 20),
    valor TINYINT UNSIGNED CHECK (valor NOT BETWEEN 4 AND 7),
    tipodescuento FLOAT(5,4) UNSIGNED CHECK (tipodescuento BETWEEN 0.0525 AND 0.2050),
    precio DECIMAL UNSIGNED CHECK (precio BETWEEN 20 and 30)
    );

-- chekin(#id, provincia, poblacion, cicloEstudio, valores, nacionalidad)

DROP TABLE IF EXISTS chekin;
CREATE TABLE IF NOT EXISTS chekin(   
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    provincia VARCHAR(10) CHECK (provincia IN ('Lima', 'Arequipa', 'Sevilla')),
    poblacion VARCHAR(15) CHECK (poblacion IN ('Ubrique', 'San Martín', 'Miraflores', 'Olvera')),
    CiclosEstudio VARCHAR(10) CHECK (CiclosEstudio IN ('ESO', 'BACH', 'MEDIO', 'SUPERIOR', 'ADULTOS')),
    Valores TINYINT CHECK (Valores IN (1,2,5,8,9)),
    Nacionalidad VARCHAR(20) CHECK (Nacionalidad IN ('España', 'Peru', 'Alemania', 'Argentina', 'Italia')),
    CodEmpleado VARCHAR(9) CHECK (CodEmpleado LIKE '_AB%'),
    NRP CHAR(9) CHECK (NRP LIKE '%Z'),
    DNI CHAR(9) CHECK (DNI LIKE '25%')
);
    