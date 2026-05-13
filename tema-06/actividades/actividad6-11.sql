-- Actividad 6.11
-- Raúl Bueno

-- 1
USE empresa;
SELECT 
    empleados.departamento_id,
    departamentos.nombre departamento,
    COUNT(*) NumEmpleados
FROM
    empleados
        INNER JOIN
    departamentos ON empleados.departamento_id = departamentos.id
    group by empleados.departamento_id;

-- 2
SELECT 
    empleados.departamento_id,
    departamentos.nombre departamento,
    COUNT(*) NumEmpleados
FROM
    empleados
        INNER JOIN
    departamentos ON empleados.departamento_id = departamentos.id
WHERE
    empleados.salario > 30000
GROUP BY empleados.departamento_id;

-- 3 
SELECT 
    empleados.departamento_id,
    departamentos.nombre departamento,
    COUNT(*) NumEmpleados
FROM
    empleados
        INNER JOIN
    departamentos ON empleados.departamento_id = departamentos.id
WHERE
    empleados.salario BETWEEN 20000 AND 50000
GROUP BY empleados.departamento_id;

-- 4 
SELECT 
    YEAR(fecha_nac), COUNT(*)
FROM
    empleados
GROUP BY YEAR(fecha_nac);

-- 5 
SELECT 
    empleados_proyectos.proyecto_id,
    proyectos.descripcion proyecto,
    SUM(horas) horas
FROM
    empleados_proyectos
        INNER JOIN
    proyectos ON empleados_proyectos.proyecto_id = proyectos.id
GROUP BY empleados_proyectos.proyecto_id;

-- 6 
SELECT 
    supervisores.id,
    concat_ws(', ',supervisores.apellidos,  supervisores.nombre) Supervisor,
    COUNT(*) NumEmpleados
FROM
    empleados
        INNER JOIN
    empleados supervisores ON empleados.supervisor_id = supervisores.id
GROUP BY empleados.supervisor_id;

-- 7
SELECT 
    departamentos.id,
    departamentos.nombre departamento,
    CONCAT_WS(', ',
            jefe_departamentos.apellidos,
            jefe_departamentos.nombre) Jefe,
    COUNT(*) NumEmpleados,
    AVG(empleados.salario) SalarioMedio,
    MIN(empleados.salario) Min,
    MAX(empleados.salario) max,
    SUM(empleados.salario) suma
FROM
    empleados
        INNER JOIN
    departamentos ON empleados.departamento_id = departamentos.id
        INNER JOIN
    empleados jefe_departamentos ON departamentos.jefe_departamento_id = jefe_departamentos.id
GROUP BY empleados.departamento_id;

-- 8
SELECT 
    empleados.id,
    empleados.nss,
    CONCAT_WS(', ',
            empleados.apellidos,
            empleados.nombre) empleado,
    COUNT(*) NumBeneficiarios
FROM
    beneficiarios
        INNER JOIN
    empleados ON beneficiarios.empleado_id = empleados.id
GROUP BY beneficiarios.empleado_id;

-- 9
SELECT 
    departamentos.id,
    departamentos.nombre departamento,
    COUNT(*) NumBeneficiarios
FROM
    beneficiarios
        INNER JOIN
    empleados ON beneficiarios.empleado_id = empleados.id
        INNER JOIN
    departamentos ON empleados.departamento_id = departamentos.id
GROUP BY empleados.departamento_id;

-- 10
SELECT 
    proyectos.id,
    proyectos.descripcion proyecto,
    departamentos.nombre departamento,
    SUM(empleados_proyectos.horas) horas
FROM
    empleados_proyectos
        INNER JOIN
    proyectos ON empleados_proyectos.proyecto_id = proyectos.id
        INNER JOIN
    departamentos ON proyectos.departamento_id = departamentos.id
GROUP BY empleados_proyectos.proyecto_id;

-- 11
SELECT 
    empleado_id, SUM(horas)
FROM
    empleados_proyectos
GROUP BY empleado_id;

-- 12
SELECT 
    empleado_id, proyecto_id, SUM(horas)
FROM
    empleados_proyectos
GROUP BY empleado_id, proyecto_id;

-- 13/14. 
SELECT 
    empleados_proyectos.empleado_id,
    CONCAT_WS(', ',
            empleados.apellidos,
            empleados.nombre) empleado,
    empleados_proyectos.proyecto_id,
    proyectos.descripcion proyecto,
    SUM(horas) horas
FROM
    empleados_proyectos
        INNER JOIN
    empleados ON empleados_proyectos.empleado_id = empleados.id
        INNER JOIN
    proyectos ON empleados_proyectos.proyecto_id = proyectos.id
GROUP BY empleado_id, proyecto_id;

-- 15 
SELECT 
    departamento_id, AVG(salario)
FROM
    empleados
WHERE
    departamento_id = 3;

-- 16 
SELECT 
    departamento_id, AVG(salario)
FROM
    empleados
GROUP BY departamento_id
HAVING departamento_id = 3;

-- 17
SELECT 
    departamento_id, AVG(salario) Media, MAX(salario) Max, MIN(salario) Min
FROM
    empleados
GROUP BY departamento_id
HAVING departamento_id IN (1 , 2);

-- 18 
SELECT 
    departamentos.id,
    departamentos.nombre departamento,
    SUM(horas) horas
FROM
    empleados_proyectos
        INNER JOIN
    proyectos ON empleados_proyectos.proyecto_id = proyectos.id
        INNER JOIN
    departamentos ON proyectos.departamento_id = departamentos.id
GROUP BY departamentos.id
HAVING horas >= 50;

-- 19 
SELECT 
    departamento_id, AVG(salario) salarioMedio
FROM
    empleados
GROUP BY departamento_id
HAVING salarioMedio > 40000;

-- 20  
SELECT 
    YEAR(fecha_nac) Año,
    AVG(salario) salarioMedio,
    COUNT(*) NumEmpleados
FROM
    empleados
GROUP BY YEAR(fecha_nac)
HAVING salarioMedio > 45000;

-- 21 Número de beneficiarios por sexo.
SELECT 
    genero, COUNT(*) NumBeneficiarios
FROM
    beneficiarios
GROUP BY genero;


