-- Actividad 6.7 
-- Raúl Bueno

-- Proyectos que tengan la misma localización que el proyecto "Carretera Madrid Toledo":
SELECT 
    *
FROM
    proyectos
WHERE
    localizacion = (SELECT 
            localizacion
        FROM
            proyectos
        WHERE
            descripcion LIKE '%Carretera Madrid Toledo%'
        LIMIT 1);

-- Empleados que estén en el mismo departamento que "Jennifer Wallace":
SELECT 
    *
FROM
    empleados
WHERE
    departamento_id = (SELECT 
            departamento_id
        FROM
            empleados
        WHERE
            nombre LIKE '%Jennifer%'
                AND apellidos LIKE '%Wallace%'
        LIMIT 1);

-- Empleados que tengan menor salario que "Alicia Zelaya":
SELECT 
    *
FROM
    empleados
WHERE
    salario < (SELECT 
            salario
        FROM
            empleados
        WHERE
            nombre LIKE 'Alicia%'
                AND apellidos LIKE '%Zelaya%'
        LIMIT 1);

-- Beneficiarios que hayan nacido en el mismo año que" Alice":
SELECT 
    *
FROM
    empleados
WHERE
    year(fecha_nac) = (SELECT 
            year(fecha_nac)
        FROM
            empleados
        WHERE
            nombre LIKE 'Alicia%'
        LIMIT 1);

-- Empleados más jóvenes que "James Borg":
SELECT 
    *
FROM
    empleados
WHERE
    fecha_nac > (SELECT 
            fecha_nac
        FROM
            empleados
        WHERE
            nombre LIKE 'James%'
                AND apellidos LIKE '%Borg%'
        LIMIT 1);

-- Empleados cuyo supervisor coincida alguno de los supervisores de los empleados 
-- del departamento 3:
SELECT 
    *
FROM
    empleados
WHERE
    supervisor_id = ANY (SELECT distinct
            supervisor_id
        FROM
            empleados
        WHERE
            departamento_id = 3);

-- Operador in
SELECT 
    *
FROM
    empleados
WHERE
    supervisor_id IN (SELECT distinct
            supervisor_id
        FROM
            empleados
        WHERE
            departamento_id = 3);
            
-- Empleados cuyo año de nacimiento coincida con alguno de los años de nacimiento de 
-- los empleados del departamento 3:
SELECT 
    *
FROM
    empleados
WHERE
    YEAR(fecha_nac) = ANY (SELECT DISTINCT
            YEAR(fecha_nac)
        FROM
            empleados
        WHERE
            departamento_id = 3);

SELECT 
    *
FROM
    empleados
WHERE
    YEAR(fecha_nac) IN (SELECT DISTINCT
            YEAR(fecha_nac)
        FROM
            empleados
        WHERE
            departamento_id = 3);

-- Empleados cuyo salario coincida con el salario de alguno de los empleados 
-- del departamento 2:
SELECT 
    *
FROM
    empleados
WHERE
    salario = ANY (SELECT distinct
            salario
        FROM
            empleados
        WHERE
            departamento_id = 2);

-- Añadir un departamento nuevo en la base de datos:
INSERT INTO departamentos (nombre, jefe_departamento_id, componentes, localizacion) 
VALUES ('Personal', 4, 30, 'Huelva');

-- Departamentos que no tengan empleados:
SELECT 
    *
FROM
    departamentos
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            empleados
        WHERE
            empleados.departamento_id = departamentos.id);

-- Departamentos que tengan empleados:
SELECT 
    *
FROM
    departamentos
WHERE
    EXISTS( 
		SELECT 
            *
        FROM
            empleados
        WHERE
            empleados.departamento_id = departamentos.id); 

-- Departamentos que no tengan asignado proyectos:
SELECT 
    *
FROM
    departamentos
WHERE
    NOT EXISTS( 
		SELECT 
            *
        FROM
            proyectos
        WHERE
            proyectos.departamento_id = departamentos.id);

-- Departamentos que tengan asignado algún proyecto:
SELECT 
    *
FROM
    departamentos
WHERE
    EXISTS( 
		SELECT 
            *
        FROM
            proyectos
        WHERE
            proyectos.departamento_id = departamentos.id);

-- Datos de los empleados cuyo salario sea igual a algún salario de los empleados 
-- del departamento 1 (Realizar mediante ANY):
SELECT 
    *
FROM
    empleados
WHERE
    salario = ANY (SELECT distinct
            salario
        FROM
            empleados
        WHERE
            departamento_id = 1);

-- Datos de los empleados cuyo salario sea igual a algún salario de los empleados 
-- del departamento 1 (Realizar mediante IN):
SELECT 
    *
FROM
    empleados
WHERE
    salario IN (SELECT distinct
            salario
        FROM
            empleados
        WHERE
            departamento_id = 1);

-- Datos de los empleados cuyo salario sea inferior a alguno de los salarios de los empleados del departamento 2:
SELECT 
    *
FROM
    empleados
WHERE
    salario < ANY (SELECT distinct
            salario
        FROM
            empleados
        WHERE
            departamento_id = 2);

-- Datos de los empleados cuyo salario sea superior a alguno de los salarios de los empleados cuyo supervisor_id es 1:
SELECT 
    *
FROM
    empleados
WHERE
    salario > ANY (SELECT 
            salario
        FROM
            empleados
        WHERE
            supervisor_id = 1);

-- Datos de los empleados cuyo salario sea MENOR a todos los salarios correspondientes 
-- a los empleados del departamento 1:
SELECT 
    *
FROM
    empleados
WHERE
    salario < (SELECT 
            MIN(salario)
        FROM
            empleados
        WHERE
            departamento_id = 1);

-- cuantificador ALL
SELECT 
    *
FROM
    empleados
WHERE
    salario < all (SELECT distinct
            salario
        FROM
            empleados
        WHERE
            departamento_id = 1);

-- Datos de los empleados cuyo salario sea superior al salario de todos 
-- los empleados del departamento 2:
SELECT 
    *
FROM
    empleados
WHERE
    salario > (SELECT 
            MAX(salario)
        FROM
            empleados
        WHERE
            departamento_id = 2);
-- cuantificador ALL
SELECT 
    *
FROM
    empleados
WHERE
    salario > ALL (SELECT DISTINCT
            salario
        FROM
            empleados
        WHERE
            departamento_id = 2);