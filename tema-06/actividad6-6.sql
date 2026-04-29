-- Actividad 6.6
-- Raúl Bueno García

use empresa;
-- ORDER BY, LIMIT, ALL, DISTINCT
SELECT * from empleados order by salario DESC limit 3;
SELECT * from empleados order by salario asc limit 5;
SELECT * from empleados order by nombre asc;
SELECT * from departamentos limit 3;
SELECT * from empleados where departamento_id=3 order by salario DESC limit 3;


-- Función COUNT()
SELECT COUNT(*) from departamentos;
SELECT COUNT(*) FROM beneficiarios where genero='M';
SELECT COUNT(*) FROM empleados where salario BETWEEN 20000 AND 50000;
SELECT COUNT(*) FROM empleados where year(fecha_nac) > 1970;
SELECT COUNT(*) FROM proyectos where departamento_id=3;

SELECT COUNT(DISTINCT departamento_id) from proyectos;
SELECT COUNT(DISTINCT empleado_id) from empleados_proyectos;


--  Función SUM()
SELECT SUM(horas) FROM proyectos;
SELECT SUM(horas) FROM empleados_proyectos WHERE proyecto_id = "2";
SELECT SUM(salario) FROM empleados;
SELECT SUM(salario) FROM empleados WHERE departamento_id = "5";
SELECT SUM(salario) FROM empleados WHERE supervisor_id = "3";


-- Función AVG()
SELECT AVG(horas) FROM empleados_proyectos;
SELECT COUNT(*), SUM(horas), avg(horas) FROM empleados_proyectos;
select COUNT(*), SUM(salario), avg(salario) FROM empleados where departamento_id = "3";
select avg(salario) from empleados;
select COUNT(*), avg(salario), SUM(salario) from empleados;
select count(*), avg(salario), sum(salario) from empleados where year(fecha_nac) between 1960 and 1980;
select * from empleados where salario > (select avg(salario) from empleados);
SELECT 
    id, nss, nombre, apellidos
FROM
    empleados
WHERE
    id IN (SELECT DISTINCT
            empleado_id
        FROM
            empleados_proyectos
        WHERE
            horas > (SELECT 
                    AVG(horas)
                FROM
                    empleados_proyectos));



-- Función MIN() y MAX()
SELECT MAX(salario) FROM Empleados;
SELECT MIN(salario) FROM Empleados;
SELECT MAX(horas) FROM empleados_proyectos;
select * from empleados where salario = (select MAX(salario) from empleados);
select * from empleados where salario = (select MIN(salario) from empleados);
select nss, apellidos, nombre FROM empleados where id = (select empleado_id from empleados_proyectos where horas = (select MAX(horas) from empleados_proyectos));
select nss, apellidos, nombre FROM empleados where id = (select empleado_id from empleados_proyectos where horas = (select MIN(horas) from empleados_proyectos));