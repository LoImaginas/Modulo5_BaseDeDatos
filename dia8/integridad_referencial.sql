

\c descripciones;

● Paso 1: Creamos la tabla clientes create table clientes;

create table clientes (id integer unique not null, name varchar(25) not null, email
varchar(50));

\dt;
         List of relations
 Schema |   Name   | Type  |  Owner   
--------+----------+-------+----------
 public | clientes | table | postgres
(1 row)

● Paso 2: Insertamos al menos 3 registros, todos sin ingresar el campo email.

insert into clientes(id, name) values (1, 'Nombre 1');
insert into clientes(id, name) values (2, 'Nombre 2');
insert into clientes(id, name) values (3, 'Nombre 3');
insert into clientes(id, name, email) values (4, 'Nombre 4','lu@gmail.cl');

SELECT * FROM CLIENTES;
 id |   name   |    email    
----+----------+-------------
  1 | Nombre 1 | 
  2 | Nombre 2 | 
  3 | Nombre 3 | 
  4 | Nombre 4 | lu@gmail.cl
(4 rows)

● Paso 3: Modificamos el campo email a not null con alter table.

ALTER TABLE clientes ALTER COLUMN email SET NOT NULL;

Con esto modificamos el campo email, sin embargo nuestra tabla clientes ya tiene
registros y al correr el comando veremos el siguiente error.
ERROR: column "email" of relation "clientes" contains null values
Veamos entonces cómo solucionar este inconveniente muy común en las bases de
datos.
-- ERROR:  column "email" of relation "clientes" contains null values

● Paso 4: Debemos actualizar la tabla con el comando UPDATE, seguidamente
debemos indicar la columna a modificar y por último con WHERE definir la
condición cuando el campo sea nulo.

UPDATE clientes set email =''  --- error
UPDATE clientes set email ='' where email is null; 


 id |   name   |    email    
----+----------+-------------
  4 | Nombre 4 | lu@gmail.cl
  1 | Nombre 1 | 
  2 | Nombre 2 | 
  3 | Nombre 3 | 
(4 rows)


● Paso 5: Corremos nuevamente el comando de alteración de la columna

ALTER TABLE clientes ALTER COLUMN email SET NOT NULL;

En la tabla clientes del ejercicio anterior, crearemos un campo fecha.
Para esto, modifica la tabla y asigna la restricción.

ALTER TABLE clientes ADD COLUMN fecha DATE NOT NULL;
---ERROR:  column "fecha" of relation "clientes" contains null values

ALTER TABLE clientes ADD COLUMN fecha DATE NOT NULL DEFAULT now();
SELECT * FROM CLIENTES;
id |   name   |    email    |   fecha    
----+----------+-------------+------------
  4 | Nombre 4 | lu@gmail.cl | 2024-05-10
  1 | Nombre 1 |             | 2024-05-10
  2 | Nombre 2 |             | 2024-05-10
  3 | Nombre 3 |             | 2024-05-10
(4 rows)

DELETE FROM CLIENTES;
--DELETE 4
 id | name | email | fecha 
----+------+-------+-------
(0 rows)


COALESCE: permite seleccionar campos que sean nulos en una tabla y modificarlos por un valor determinado

● Paso 6: Agregamos un nuevo campo a la tabla de clientes pero los registros
que ya existen no tienen dicha fecha incorporada. Asignemos una fecha a esos
registros con COALESCE.

UPDATE clientes SET fecha = COALESCE(email, '2024-01-01');

-- quitar una restriccion 
ALTER TABLE IF EXISTS public.clientes ALTER COLUMN email DROP NOT NULL;

insert into clientes(id, name) values (1, 'Nombre 1');
insert into clientes(id, name) values (2, 'Nombre 2');
insert into clientes(id, name) values (3, 'Nombre 3');

SELECT * FROM CLIENTES;
 id |   name   | email |   fecha    
----+----------+-------+------------
  1 | Nombre 1 |       | 2024-05-10
  2 | Nombre 2 |       | 2024-05-10
  3 | Nombre 3 |       | 2024-05-10
(3 rows)

insert into clientes(id, name, email) values (4, 'Nombre 4','lu@gmail.cl');
 id |   name   |    email    |   fecha    
----+----------+-------------+------------
  1 | Nombre 1 |             | 2024-05-10
  2 | Nombre 2 |             | 2024-05-10
  3 | Nombre 3 |             | 2024-05-10
  4 | Nombre 4 | lu@gmail.cl | 2024-05-10
(4 rows)

UPDATE clientes SET email = COALESCE(email, 'sin email');
SELECT * FROM CLIENTES;
 id |   name   |    email    |   fecha    
----+----------+-------------+------------
  1 | Nombre 1 | sin email   | 2024-05-10
  2 | Nombre 2 | sin email   | 2024-05-10
  3 | Nombre 3 | sin email   | 2024-05-10
  4 | Nombre 4 | lu@gmail.cl | 2024-05-10
(4 rows)

\d clientes;

ALTER TABLE clientes ALTER COLUMN email SET NOT NULL;

\D clientes;
                     Table "public.clientes"
 Column |         Type          | Collation | Nullable | Default 
--------+-----------------------+-----------+----------+---------
 id     | integer               |           | not null | 
 name   | character varying(25) |           | not null | 
 email  | character varying(50) |           | not null | 
 fecha  | date                  |           | not null | now()
Indexes:
    "clientes_id_key" UNIQUE CONSTRAINT, btree (id)