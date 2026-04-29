-- Muestra los juegos de caracteres dispponibles mysql
SHOW CHARACTER SET;

-- Muestra los cotejamientos diponibles en mysql
SHOW COLLATION;

-- Crear la Base de Datos EJEMPLO con el cotejamiento establecido por defecto en MYSQL
CREATE DATABASE ejemplo;

-- Crear la Base de Datos EJEMPLO solo si no existe
CREATE DATABASE IF NOT EXISTS ejemplo;

-- Crear la Base de Datos BANCO Multilingüe con UTF8
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Crear la Base de Datos BANCO Español con UTF8
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET utf8 COLLATE utf8_spanish_ci;

-- Crear la Base de Datos BANCO Español con UTF8MB4
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;

-- Crear la Base de Datos BANCO Español con LATIN1
CREATE DATABASE IF NOT EXISTS BANco
CHARACTER SET latin1 COLLATE latin1_spanish_ci;

-- Crear la Base de Datos BANCO Multilingüe con LATIN1
CREATE DATABASE IF NOT EXISTS BANCo
CHARACTER SET latin1 COLLATE latin1_general_ci;

-- Crear Base de datos geslibros español multilingüe con juego de caracteres utf8mb4
-- Opciones por defecto
CREATE DATABASE IF NOT EXISTS GESLIBros
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;