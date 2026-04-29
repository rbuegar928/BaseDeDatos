-- Actividad 6-10
-- Raúl Bueno

-- 1. Mostrar los detalles sobre empleados y departamentos
SELECT empleados.id,
       empleados.nombre,
       empleados.apellidos,
       empleados.salario,
       empleados.departamento_id,
       departamento.nombre AS departamento
FROM empleados
INNER JOIN departamentos
ON empleados.departamento_id = departamentos.id
ORDER BY empleados.id;

-- 2. Muestra detalles a cerca de los departamentos
SELECT d.id,
       d.nmbre,
       d.jefe_departamento_id,
       j.nombre AS jefe_nombre,
       j.apellidos AS jefe_apellidos,
       e.id AS empleado_id,
       e.nombre AS empleado_nombre,
       e.apellidos AS empleado_apellidos
FROM departamentos d
LEFT JOIN empleados j
ON d.jefe_departamento_id = j.id
LEFT JOIN empleados e
ON d.id = e.departamento_id
ORDER BY d.id;

-- 3. Mostrar los detalles sobre los empleados que hayan trabajado en algún proyecto
SELECT e.id,
       e.nombre,
       e.apellidos,
       d.nombre AS departamento,
       p.descripcion AS proyecto,
       ep.horas
FROM empleados e
LEFT JOIN departamentos d
ON e.departamento_id = d.id
LEFT JOIN empleados_proyectos ep
ON e.id = ep.empleado_id
LEFT JOIN proyectos p
ON ep.proyecto_id = p.id
ORDER BY ep.horas DESC;

-- 4. Mostrar los siguientes detalles sobre proyectos
SELECT p.id,
       p.descripcion AS proyecto,
       p.num_proyecto,
       p.fecha_inicio,
       d.nombre AS departamento,
       e.nombre,
       e.apellidos,
       ep.horas
FROM proyectos p
LEFT JOIN departamentos d
ON p.departamento_id = d.id
LEFT JOIN empleados_proyectos ep
ON p.id = ep.proyecto_id
LEFT JOIN empleados e
ON ep.empleado_id = e.id
ORDER BY ep.horas DESC;