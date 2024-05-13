--DQL: Lenguaje de Consulta de Datos
--Operaciones en DQL: SELECT

--DML: Lenguaje de Manipulacion de Datos
--Operaciones en DML: INSERT, UPDATE,DELETE

--DDL: Lenguaje de definición de datos (Data Definition Language).
--Operaciones en DDL: CREATE, ALTER, DROP -- sobre tablas y registros de una base de datos

--DCL: Lenguaje de Control de datos
--Operaciones en DCL: GRANT, REVOKE

/Library/PostgreSQL/16/scripts/runpsql.sh  Password:Admin1234 

● Paso 1: Creamos una base de datos de comidas típicas chilenas.
create database comidas_tipicas;
\c comidas_tipicas;

● Paso 2: Creamos una tabla llamada cocina chilena con los campos id y
nombre.
create table cocina_chilena(id int, nombre varchar(50));

Paso 3: Insertamos 2 registros a la tabla con sus respectivos campos.
insert into cocina_chilena (id, nombre) values ('1','Pastel de choclo');
insert into cocina_chilena (id, nombre) values ('2', 'Umitas');
El ingreso del segundo registro tiene la intencionalidad del error, se escribe humitas,
pero ¿Qué podemos realizar ahora que ya el registro se ingresó?

\d cocina_chilena
                  Table "public.cocina_chilena"
 Column |         Type          | Collation | Nullable | Default 
--------+-----------------------+-----------+----------+---------
 id     | integer               |           |          | 
 nombre | character varying(50) |           |          | 


SELECT * from cocina_chilena;
    comidas_tipicas
 id |      nombre      
----+------------------
  1 | Pastel de choclo
  2 | Umitas
(2 rows)

● Paso 4: Para actualizar un registro utilizamos update.
UPDATE cocina_chilena set nombre='Humitas' where id = 2; --- SIN el where se actualizan todos los nombres de la tabla con "humitas"
Con el código SQL anterior estamos:
1. Utilizamos la sentencia update.
2. Pasamos el nombre de la tabla en la cual se ejecutará el update
3. Utilizamos set, seleccionamos el nombre de la columna y el nuevo valor para el
registro.
4. Evaluamos condicionalmente con where la selección del registro cuyo ID sea 2.

SELECT * from cocina_chilena;

insert into cocina_chilena (id, nombre) values ('3','Cazuela');
insert into cocina_chilena (id, nombre) values ('4', 'Porots');
insert into cocina_chilena (id, nombre) values ('5', 'Chaquican');

SELECT * from cocina_chilena;
    comidas_tipicas
 id |      nombre      
----+------------------
  1 | Pastel de choclo
  2 | Humitas
  3 | Cazuela
  4 | Porots
  5 | Chaquican
(5 rows)

--CORREGIR POROTOS
UPDATE cocina_chilena set nombre='Porotos' where id = 4;

SELECT * from cocina_chilena;
    comidas_tipicas
 id |      nombre      
----+------------------
  1 | Pastel de choclo
  2 | Humitas
  3 | Cazuela
  5 | Chaquican
  4 | Porotos           --- CORREGIDO
(5 rows)
