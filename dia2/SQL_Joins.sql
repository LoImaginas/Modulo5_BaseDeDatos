-- INNER JOIN 
/*
SELECT * 
FROM tableA A          -- se recomienda agregar como tableA aquella tabla que tenga la PK
INNER JOIN tableB B 
ON A.KEY = B.KEY;
*/


SELECT * from productos;
SELECT * from pedidos_detalle;

SELECT * 
FROM productos A
INNER JOIN pedidos_detalle B 
ON A.id_producto = B.id_producto;

RESULTADOS
SELECT * from productos;

id_producto |   nombre   | precio 
-------------+------------+--------
           1 | Producto A |  20.99
           2 | Producto B |  15.50
           3 | Producto C |  25.75
           4 | Producto D |  18.50
           5 | Producto E |  30.25
           6 | Producto F |  12.75
           7 | Producto G |  22.99
           8 | Producto H |  15.00
           9 | Producto I |  28.50
          10 | Producto J |  19.99
          11 | Producto K |  10.50
          12 | Producto L |  24.75
          13 | Producto M |  16.50


SELECT * from pedidos_detalle;
id_pedido_detalle | id_pedido | id_producto | cantidad 
-------------------+-----------+-------------+----------
                 1 |       101 |           1 |        3
                 2 |       101 |           2 |        2
                 3 |       102 |           1 |        1
                 4 |       103 |           3 |        4
                 5 |       104 |           4 |        2
                 6 |       104 |           5 |        1
                 7 |       105 |           6 |        3
                 8 |       105 |           7 |        2
                 9 |       106 |           8 |        1
                10 |       107 |           9 |        4
                11 |       107 |          10 |        2
                12 |       108 |          11 |        3
                13 |       109 |          12 |        2
                14 |       110 |          13 |        1


SELECT * 
FROM productos A
INNER JOIN pedidos_detalle B 
ON A.id_producto = B.id_producto;
-- donde se relacionan ambas TABLAS es en el id_producto
id_producto |   nombre   | precio | id_pedido_detalle | id_pedido | id_producto | cantidad 
-------------+------------+--------+-------------------+-----------+-------------+----------
           1 | Producto A |  20.99 |                 1 |       101 |           1 |        3
           2 | Producto B |  15.50 |                 2 |       101 |           2 |        2
           1 | Producto A |  20.99 |                 3 |       102 |           1 |        1
           3 | Producto C |  25.75 |                 4 |       103 |           3 |        4
           4 | Producto D |  18.50 |                 5 |       104 |           4 |        2
           5 | Producto E |  30.25 |                 6 |       104 |           5 |        1
           6 | Producto F |  12.75 |                 7 |       105 |           6 |        3
           7 | Producto G |  22.99 |                 8 |       105 |           7 |        2
           8 | Producto H |  15.00 |                 9 |       106 |           8 |        1
           9 | Producto I |  28.50 |                10 |       107 |           9 |        4
          10 | Producto J |  19.99 |                11 |       107 |          10 |        2
          11 | Producto K |  10.50 |                12 |       108 |          11 |        3
          12 | Producto L |  24.75 |                13 |       109 |          12 |        2
          13 | Producto M |  16.50 |                14 |       110 |          13 |        1


insert into productos (id_producto, nombre, precio) 
values (14,'Producto 14',25.74);   

insert into productos (id_producto, nombre, precio) 
values (15,'Producto 15',50.74); 


-- LEFT JOIN 
/*
SELECT * 
FROM tableA A          -- se recomienda agregar como tableA aquella tabla que tenga la PK
LEFT JOIN tableB B 
ON A.KEY = B.KEY
WHERE B.KEY is NULL
;
*/

SELECT * 
FROM productos A          
LEFT JOIN pedidos_detalle B 
ON A.id_producto = B.id_producto
WHERE B.id_producto is NULL
;

-- RIGHT JOIN 
/*
SELECT * 
FROM tableA A          -- se recomienda agregar como tableA aquella tabla que tenga la PK
RIGHT JOIN tableB B 
ON A.KEY = B.KEY
WHERE A.KEY is NULL
;
*/

SELECT * 
FROM productos A          
RIGHT JOIN pedidos_detalle B 
ON A.id_producto = B.id_producto
WHERE A.id_producto is NULL
;

SELECT * 
FROM productos A          
RIGHT JOIN pedidos_detalle B   -- SE COMPORTA COMO INNER JOIN AL SACAR LA LINEA COMPLETA DEL WHERE 
ON A.id_producto = B.id_producto
;

