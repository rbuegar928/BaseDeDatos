-- poner base de datos activa tipo_datos
USE tipo_datos;

-- 1. Borrar la tabla si existe
DROP TABLE IF EXISTS tipos_datos_string;

-- 2. Crear la tabla si no existe
CREATE TABLE IF NOT EXISTS tipos_datos_string (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo_postal CHAR(5),
    telefono CHAR(11),
    apellidos VARCHAR(50),
    nombre VARCHAR(20),
    nombre_acronimo VARCHAR(20),
    historial TEXT,
    direccion VARCHAR(170),
    provincia VARCHAR(40),
    observaciones TEXT,
    contenido_libro LONGTEXT,
    categoria ENUM('Primera', 'Segunda', 'Tercera', 'Regional'),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Insertar 3 registros
INSERT INTO tipos_datos_string VALUES
(
	NULL,
    '28001',
	'+34 600123123',
    'García López',
    'María',
    'MGL',
	'Historial médico básico del paciente...',
    'Calle Mayor 10',
    'Madrid',
    'Buen rendimiento académico.',
    'Contenido simulado del libro 1...',
    'Primera'
),
(
	NULL,
    '08002',
    '+34 611222333',
    'Pérez Sánchez',
    'Luis',
    'LPS',
    'Paciente sin antecedentes relevantes.',
    'Avenida Diagonal 200',
    'Barcelona',
    'Necesita seguimiento.',
    'Contenido simulado del libro 2...',
    'Segunda'
),
(
	NULL,
    '41003',
    '+34 622333444',
    'Ramírez Ortega',
    'Ana',
    'ARO',
    'Alergia leve registrada.',
    'Calle Feria 25',
    'Sevilla',
    'Participativa en clase.',
    'Contenido simulado del libro 3...',
    'Regional'
);
