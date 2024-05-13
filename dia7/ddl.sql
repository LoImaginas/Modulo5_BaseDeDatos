--DELETE FROM: eliminar registros
--DROP TABLE: eliminar tabla completa

/Library/PostgreSQL/16/scripts/runpsql.sh  Password:Admin1234

● Paso 1: Crear una base de datos
create database nombre_base_de_datos;
● Paso 2: Mostrar todas las tablas de una base de datos.
\dt;
● Paso 3: Mostrar una tabla en específica.
\dt nombre_tabla;
● Paso 4: Modificar un campo de una tabla.
ALTER TABLE cuentas ADD fecha date;
● Paso 5: Eliminar una tabla de la base de datos.
delete from cuentas; -- eliminar registros
drop table cuentas; -- eliminar tabla completa
--● Paso 5: Modificar un campo de una tabla.
--ALTER TABLE nombre tabla ADD column_name datatype;



-- creacion de tabla
create table clientes (
    id int primary key, 
    nombre varchar not null, 
    rut int unique not null, -- 77777777
    dv char not null
);

drop table clientes;

select concat(rut,dv) as rut_completo from clientes;

select concat('77777777','-','7') as rut_completo;

'2024-05-09'
'2023-11-08'

'09-05-2024 00:00:00'
'08-11-2023'
byte
null != ""

CREATE TABLE products (
    id integer PRIMARY KEY,
    name text not null default '',
    price numeric default 0
);

insert into products values(012,'producto 1',0100);
insert into products values(013,'producto 2');
insert into products values(014,'producto 3', null);

drop table products;

CREATE TABLE orders (
    id serial PRIMARY KEY,
    product_id integer REFERENCES products(id),
    quantity integer check(quantity >=0)
);

ALTER TABLE IF EXISTS public.orders
ADD CONSTRAINT check_quantity CHECK (quantity >=0)
NOT VALID;


crear una tabla para clientes con los campos
a. ID          int  serial primary key
b. Nombre      varchar(50) not null
c. Apellido    varchar(50) not null
d. Rut         varchar(12) not null unique
e. Telefono    varchar(20) default ''
f. Email       varchar     unique

CREATE SEQUENCE public.products_id_seq
    INCREMENT 1
    START 100
    MINVALUE 100
    MAXVALUE 999999
    CACHE 1
    OWNED BY products.id;

ALTER SEQUENCE public.products_id_seq
    OWNER TO postgres;
