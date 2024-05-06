-- esto es un comentario 

SELECT * FROM demo;

--solo obtener la columna name 
SELECT name FROM demo;
SELECT id from demo;
select hint from demo;
--mezclar varias columnas
SELECT name,hint from demo;
SELECT hint,name from demo;

--CLAUSULA WHERE --> FILTRAR 
SELECT * FROM demo WHERE ID = 5;
SELECT * FROM demo WHERE HINT = 300; --ERROR 
SELECT * FROM demo WHERE HINT = '300';

-- WHERE CON OR 
SELECT * FROM demo where id = 5 or id = 8;
SELECT * FROM demo where id = 5 or id = 2;
SELECT * FROM demo where id = 5 or HINT = '2';

--WHERE CON AND 
SELECT * FROM demo where id < 5 AND id >= 2;

--CLAUSULA LIMIT
SELECT * FROM demo LIMIT 3;

--CLAUSULA WHERE Y LIMIT
SELECT * FROM demo WHERE ID < 6 LIMIT 3;

--CLAUSULA ORDER BY
SELECT * FROM demo order by id DESC;
SELECT * FROM demo order by name DESC;
SELECT * FROM demo order by hint DESC;
SELECT * FROM demo order by hint asc;

SELECT hint,name FROM demo order by 3 asc;-- error 
SELECT hint,name FROM demo order by 1 asc;