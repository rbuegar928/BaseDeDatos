-- Actividad 6.9
-- Raúl Bueno

-- 1. Empleados.
-- Realizar una consulta multitabla que muestre todos los empleados ordenados por id.
SELECT 
    empleados.id,
    empleados.nombre,
    empleados.apellidos,
    empleados.salario,
    empleados.departamento_id,
    departamentos.nombre departamento
FROM
    empleados INNER JOIN
    departamentos
ON
    empleados.departamento_id = departamentos.id
ORDER BY empleados.id; 

-- 2. Departamentos.
-- Realizar una consulta multitabla que muestre los detalles de cada departamento, incluido el nombre del jefe de departamento. 
SELECT 
    departamentos.id,
    departamentos.nombre departamento,
    departamentos.localizacion,
    departamentos.componentes,
    departamentos.jefe_departamento_id,
    concat_ws(', ', empleados.apellidos, empleados.nombre) Jefe
    
FROM
    departamentos inner join
    empleados on departamentos.jefe_departamento_id = empleados.id
ORDER BY departamentos.nombre;

-- 3. Empleados con supervisor

-- Realizar una consulta multitabla que muestre los detalles de los empleados y el nombre del supervisor asignado. La consulta se mostrará ordenada por id de empleado.
SELECT 
    empleados.id,
    empleados.nombre,
    empleados.apellidos,
    empleados.nss,
    empleados.salario,
    empleados.supervisor_id,
    concat_ws(', ', supervisores.apellidos, supervisores.nombre) Supervisor
FROM
    empleados
    inner join empleados supervisores ON empleados.supervisor_id = supervisores.id
ORDER BY empleados.id;


-- 4. Beneficiarios con Empleados

-- Realizar una consulta multitabla que muestre los detalles de los beneficiarios junto con el nombre del empleado al que pertenecen:
SELECT 
    beneficiarios.id,
    beneficiarios.nombre,
    beneficiarios.genero,
    beneficiarios.parentesco,
    beneficiarios.fecha_nac,
    beneficiarios.empleado_id,
    CONCAT_WS(', ',
            empleados.apellidos,
            empleados.nombre) Empleado
FROM
    beneficiarios
        INNER JOIN
    empleados ON beneficiarios.empleado_id = empleados.id;

-- 5. Proyectos

-- Realizar una consulta multitabla que muestre los detalles de todos los proyectos junto con el nombre del departamento que lo está realizando:
SELECT 
    proyectos.id,
    proyectos.descripcion,
    proyectos.num_proyecto,
    proyectos.localizacion,
    proyectos.fecha_inicio,
    proyectos.fecha_fin,
    proyectos.departamento_id,
    departamentos.nombre departamento
FROM
    proyectos inner join 
    departamentos on proyectos.departamento_id = departamentos.id;

-- 6. Proyectos con Jefe de Departamento

-- Realizar una consulta multitabla que muestre los detalles de todos los proyectos junto con el nombre del departamento que lo está realizando y el nombre del jefe del departamento.
SELECT 
    proyectos.id,
    proyectos.descripcion,
    proyectos.num_proyecto,
    proyectos.localizacion,
    proyectos.fecha_inicio,
    proyectos.fecha_fin,
    proyectos.departamento_id,
    departamentos.nombre,
    CONCAT_WS(', ',
            empleados.apellidos,
            empleados.nombre) Jefe
FROM
    ((proyectos
    INNER JOIN departamentos ON proyectos.departamento_id = departamentos.id)
    INNER JOIN empleados ON departamentos.jefe_departamento_id = empleados.id);


-- 7. Informe empleados_proyectos

-- Genera informe de horas trabajadas en cada proyecto a partir de la tabla empleados_proyectos, en dicho informe se deberá mostrar ordenado alfabéticamente por empleados, y mostrará las siguientes columnas:

SELECT 
	empleados_proyectos.empleado_id,
    empleados.nombre,
    empleados.apellidos,
    empleados_proyectos.proyecto_id,
    proyectos.descripcion,
	empleados_proyectos.horas
FROM
    ((empleados_proyectos
        INNER JOIN
    empleados ON empleados_proyectos.empleado_id = empleados.id)
        INNER JOIN
    proyectos ON empleados_proyectos.proyecto_id = proyectos.id)
ORDER BY empleados.nombre;