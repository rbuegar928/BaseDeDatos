-- Practica 7.2
-- Raúl Bueno

-- 1
GRANT ALL PRIVILEGES ON *.* TO juan@localhost;

-- 2
GRANT SELECT ON *.* TO pedro@localhost;

-- 3
GRANT ALTER, CREATE, UPDATE, SELECT ON gestlibros.* TO maria@localhost;
GRANT ALTER, CREATE, UPDATE, SELECT ON maratoon.* TO maria@localhost;

-- 4
SELECT PASSWORD('roberto_67')
GRANT ALL PRIVILEGES ON *.* TO roberto@localhost
IDENTIFIED BY '*2CB6C49482DD8DF7E3E3AE449124FB204AED0B60' WITH GRANT OPTION;

-- 5
SELECT PASSWORD('rocio_69');
GRANT ALL PRIVILEGES ON geslibros.* TO rocio@localhost
IDENTIFIED BY '*0A84C19C8F32CDA6CF277B04E6B9914A0CDB6861';

-- 6
SELECT PASSWORD('carlos_90');
GRANT SELECT, UPDATE ON geslibros.libros TO carlos@localhost
IDENTIFIED BY '*183FCBA8D467B44FC730C7E855D1E449173B7953';

GRANT SELECT, UPDATE ON geslibros.editoriales TO carlos@localhost;
GRANT SELECT, UPDATE ON geslibros.clientes TO carlos@localhost;

-- 7
SELECT PASSWORD('anamari_2000');
GRANT SELECT (titulo, ean, isbn, precio_venta)
ON geslibros.libros TO anamari@localhost
IDENTIFIED BY '*0F1CAA38ACA63FC76B441DDD3C92DF6238817833';

-- 8
GRANT SELECT (nombre, telefono, email),
      UPDATE (nombre, telefono, email)
ON geslibros.clientes TO anamari@localhost;

-- Aplicar cambios
FLUSH PRIVILEGES;