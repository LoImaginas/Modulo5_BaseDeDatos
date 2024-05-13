/Library/PostgreSQL/16/scripts/runpsql.sh  Password:Admin1234

● Paso 1: Creamos la base de datos con el nombre Mawashi Phones.
create database mawashi_phones;
● Paso 2: Nos conectamos a la base de datos.
\c mawashi_phones;
● Paso 3: Creamos la tabla con los campos que nos solicita inicialmente el
cliente.
create table phones (id int primary key, modelo varchar(50), mac_address int unique,
fecha_fabricacion varchar(50));
● Paso 4: Insertamos un registro para probar la tabla.
insert into phones (id, modelo, mac_address, fecha_fabricacion) values (1, 'Iphone
14', '1B:2A:3C:4D:5F:6G', '2022-09-09');
--- ERROR:  invalid input syntax for type integer: "1B:2A:3C:4D:5F:6G"
---LINE 2: 14', '1B:2A:3C:4D:5F:6G', '2022-09-09');
● Este error corresponde a que no se
está cumpliendo la sintaxis de tipado
que definimos.
● Ante ese escenario, debemos
modificar el campo mac_adress.

● Paso 5: Modificamos el tipo de dato definido en el campo mac_address.

alter table phones alter column mac_address type varchar(50);
1. Seleccionamos la tabla a modificar.
2. Seleccionamos la columna.
3. Definimos el nuevo tipo de dato que tendrá dicha columna.

● Paso 6: Comprobamos que se hayan aplicado los cambios

\d phones;

                           Table "public.phones"
      Column       |         Type          | Collation | Nullable | Default 
-------------------+-----------------------+-----------+----------+---------
 id                | integer               |           | not null | 
 modelo            | character varying(50) |           |          | 
 mac_address       | character varying(50) |           |          | 
 fecha_fabricacion | character varying(50) |           |          | 
Indexes:
    "phones_pkey" PRIMARY KEY, btree (id)
    "phones_mac_address_key" UNIQUE CONSTRAINT, btree (mac_address)

● Paso 7: Insertamos nuevamente el registro.
insert into phones (id, modelo, mac_address, fecha_fabricacion) values (1, 'Iphone
14', '1B:2A:3C:4D:5F:6G', '2022-09-09');
Resultado:
INSERT 0 1

select * from phones;
 id | modelo |    mac_address    | fecha_fabricacion 
----+--------+-------------------+-------------------
  1 | Iphone+| 1B:2A:3C:4D:5F:6G | 2022-09-09
    | 14     |                   | 
(1 row)

● Paso 8: Con el alter table también podemos agregar nuevas restricciones sin
reescribir las ya existentes.
alter table phones alter column mac_address set not null;

\d phones;

                           Table "public.phones"
      Column       |         Type          | Collation | Nullable | Default 
-------------------+-----------------------+-----------+----------+---------
 id                | integer               |           | not null | 
 modelo            | character varying(50) |           |          | 
 mac_address       | character varying(50) |           | not null | 
 fecha_fabricacion | character varying(50) |           |          | 
Indexes:
    "phones_pkey" PRIMARY KEY, btree (id)
    "phones_mac_address_key" UNIQUE CONSTRAINT, btree (mac_address)

insert into phones (id, modelo, fecha_fabricacion) values (2, 'Iphone15', '2022-09-09');
---ERROR:  null value in column "mac_address" of relation "phones" violates not-null constraint
---DETAIL:  Failing row contains (2, Iphone15, null, 2022-09-09).

insert into phones (id, modelo, mac_address, fecha_fabricacion) values (2, 'Iphone15', null, '2022-09-09');
---ERROR:  null value in column "mac_address" of relation "phones" violates not-null constraint
---DETAIL:  Failing row contains (2, Iphone15, null, 2022-09-09).


Eliminación de una tabla

DROP TABLE phones;

\d phones;

-- CREACION DE USUARIO 
create USER Lolett_L WITH password 'Admin1234';
CREATE ROLE

-- CREAR BASE DE DATOS PARA EL USUARIO
CREATE DATABASE Lolett_L WITH OWNER Lolett_L; 
CREATE DATABASE

whoami, para averiguar cual es mi usuario

--- ASIGNAR PERMISOS 
ALTER USER Lolett_L WITH SUPERUSER CREATEDB CREATEROLE;

SALIR

\q

/Library/PostgreSQL/16/scripts/runpsql.sh
Server [localhost]: 
Database [postgres]: lolett_l
Port [5432]: 
Username [postgres]: lolett_l
Password for user lolett_l: 
psql (16.2)
Type "help" for help.


SELECT usename FROM pg_user;

TRUNCATE 
● Truncate tiene un comportamiento similar al delete.
● Ambos borran todos los registros de una tabla.
● Pero no afectan el schema de la base de datos.

CARACTERISTICAS DE TRUNCATE
● Reinicio de identidades: Truncate automáticamente reinicia las secuencias de
identidad en la tabla.
● Cascada: Truncate automáticamente modificará todas las tablas que estén
relacionadas mediante una clave foránea.
● Restricciones: Utilizar con cautela en caso de existir múltiples tablas relacionadas.


