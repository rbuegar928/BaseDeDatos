-- actividad 6-12

USE gesbank;


SELECT 
    movimientos.id,
    movimientos.id_cuenta,
    cuentas.num_cuenta,
    CONCAT(clientes.apellidos, ', ', clientes.nombre) AS cliente,
    DATE(movimientos.fecha_hora) AS fecha,
    movimientos.concepto,
    movimientos.tipo,
    movimientos.cantidad,
    movimientos.saldo
FROM movimientos
JOIN cuentas ON movimientos.id_cuenta = cuentas.id
JOIN clientes ON cuentas.id_cliente = clientes.id
ORDER BY movimientos.id;


DROP VIEW IF EXISTS mov_clientes;
CREATE VIEW mov_clientes AS
SELECT 
    movimientos.id,
    movimientos.id_cuenta,
    cuentas.num_cuenta,
    CONCAT(clientes.apellidos, ', ', clientes.nombre) AS cliente,
    DATE(movimientos.fecha_hora) AS fecha,
    movimientos.concepto,
    movimientos.tipo,
    movimientos.cantidad,
    movimientos.saldo
FROM movimientos
JOIN cuentas ON movimientos.id_cuenta = cuentas.id
JOIN clientes ON cuentas.id_cliente = clientes.id;



SELECT *
FROM mov_clientes
WHERE YEAR(fecha) = 2021;



SELECT *
FROM mov_clientes
WHERE tipo = 'I';



SELECT *
FROM mov_clientes
WHERE tipo = 'R'
AND cantidad < 10;




SELECT 
    num_cuenta,
    MAX(saldo) AS saldo_actual
FROM mov_clientes
GROUP BY num_cuenta;