--QUE ES SQL?
Lenguaje de consultas estructuradas (Structured Query Language)
--Está diseñado para el uso específico de administración y consulta de información en
--sistemas de gestión de bases de datos como PostgreSQL.
--● Se utiliza para definir, manipular y controlar los datos.
--● Con la sintaxis estructural del lenguaje podemos:
    --○ Crear registros.
    --○ Leer la información.
    --○ Actualizar los datos
    --○ Eliminar uno o un conjunto de datos.

 -- lo primero a realizar es conectarse a la base de datos desde la terminal
-- ctrl L -- para limpiar la terminal
--● Paso 1: Accedemos al cliente de postgresql via el terminal.
psql -U postgres // /Library/PostgreSQL/16/scripts/runpsql.sh  Password:Admin1234 

--● Paso 2: Crea una base de datos llamada prueba1.
CREATE DATABASE prueba1;
--PRUEBA2

-- que es una base de datos??
--Una base de datos es una recopilación de datos sistemática y almacenada electrónicamente. Puede contener cualquier tipo de datos, incluidos palabras, números, imágenes, vídeos y archivos. Puede usar un software denominado sistema de administración de bases de datos (DBMS) para almacenar, recuperar y editar datos. En los sistemas informáticos, la palabra base de datos también puede referirse a cualquier DBMS, al sistema de base de datos o a una aplicación asociada con la base de datos.

--● Paso 3: Lista las bases de datos creadas. 
\l

--● Paso 4: Conéctate a la base de datos. 
\c prueba1

--● Paso 5: para salir de la base de datos
\q 


-- CREACION DE UNA TABLA 
-- VARCHAR --> STRING (CADENA DE TEXTO) 
--(30) -->  TAMAÑO DEL CAMPO NO SUPERA LOS 30 CARACTERES
create table clientes(
    nombre varchar(30),
    apellido varchar(30)
);

-- listar las tablas de una base de datos
\d 
--describe o detalla una tabla
\d clientes
\d+ clientes

-- INSERTAR VALORES A UNA TABLA
insert into clientes (nombre, apellido) values ('Lolett','Llanquinao');
insert into clientes (nombre, apellido) values ('Carlos','Villagra');
insert into clientes values ('Ana','Peso');
insert into clientes (apellido, nombre) values ('Llanquinao','Manuel');


-- CONSULTAR REGISTROS EN UNA TABLA
select * from clientes;
select * from clientes order by nombre desc;

-- BORRAR UNA BASE DE DATOS
DROP DATABASE nombre_de_la_base_de_datos

--AÑADIR UNA COLUMNA A UNA TABLA
ALTER TABLE nombre_tabla 
ADD nueva_columna tipo_de_Dato;

--ELIMINAR UNA COLUMNA 
ALTER TABLE nombre_tabla
DROP nueva_columna tipo_de_Dato;

-- LISTAR TODAS LAS TABLAS
\dt 

--DESCRIBIR UNA TABLA 
\d nombre_tabla

--BORRAR DATOS
    --Borrar todo
        DELETE FROM tabla
    --Borrar algunos datos
        DELETE FROM tabla 
        WHERE campo=VALOR
        --DELETE FROM clientes WHERE apellido='palma' (no sirve)
    --REGISTRO DUPLICADO (Lolett Llanquinao)se deben eliminar todos los registros duplicados e ingresar nuevamente el regitro eliminado    
        --DELETE FROM clientes WHERE nombre='Lolett' and apellido='llanquinao'
--ELIMINAR TABLA 
DROP TABLE nombre_tabla;
--INSERTAR DATOS 
    --Especificando todas las columnas
        INSERT INTO tabla
        VALUES (valor1,valor2,valor3)  
    --Especificando algunas columnas
        INSERT INTO tabla(columna1,columna2)   
        VALUES (valor1,valor2)           

-- Insertar 5 registros a la base de datos
insert into clientes (nombre, apellido) values ('Jose','Maria');
insert into clientes (nombre, apellido) values ('Esteban','Perez');
insert into clientes (nombre, apellido) values ('Josefina','Matus');
insert into clientes (nombre, apellido) values ('Pedro','Pe');
insert into clientes (nombre, apellido) values ('Marcio','Macalister');
--DUPLICAR REGISTRO
insert into clientes (nombre, apellido) values ('Lolett','Llanquinao');
--ELIMINAR REGISTROS
DELETE FROM clientes WHERE nombre='Lolett' and apellido='Llanquinao';
--Consultar registros en la nueva tabla
select * from clientes;
--Volver a crear registro
insert into clientes (nombre, apellido) values ('Lolett','Llanquinao');   

SELECT *, LENGTH(nombre_producto) FROM productos order by LENGTH(nombre_producto) limit 2;
-- LENGTH -- LO QUE HACE LENGTH ES CONTAR LA CANTIDAD DE CARACTEREES QUE VA A TENER UNA COLUMNA
--*, ADICIONANDO TEMPORALMENTE UNA COLUMNA, despues de la , son temporales.

-- FUNCIONES DE AGREGADO 
--SUMA
SELECT SUM(columna) FROM tabla;
--PROMEDIO
SELECT AVG(columna) FROM tabla;
--MAXIMO
SELECT MAX(columna) FROM tabla;
--MINIMO
SELECT MIN(columna) FROM tabla;
--contar (especial)
SELECT COUNT(*) FROM tabla;


SELECT * 
from productos
WHERE id_producto IN (20,1,55,3)-- IN() filtrar o comprobar si un valor existe en una lista especificada

LAS TABLAS SE ACOSTUMBRAN A ESCRIBIR EN PLURAL (matriculaS)
--Primary key = PK = (es un identificador unico)es una columna o un conjunto de columnas en una tabla cuyos valores identifican de forma exclusiva una fila de la tabla
--Foreign key =FK = SE UTILIZA PARA VINCULAR DOS TABLAS DE LA BASE DE DATOS
