--1. Comienza a grabar

--2. Entra al terminal

--3. Ingresa al cliente de postgreSQL desde el terminal
/Library/PostgreSQL/16/scripts/runpsql.sh         Password:Admin1234

--4. Crea una base de datos llamada desafio-tuNombre-tuApellido-3digitos
CREATE DATABASE desafio1_lolett_llanquinao_189;

--5. Ingresa a la base de datos creada.
\c desafio1_lolett_llanquinao_189;

/*6. Crea una tabla llamada clientes, con una columna llamada email de tipo
varchar(50), una columna llamada nombre de tipo varchar sin limitación, una
columna llamada teléfono de tipo varchar(16), un campo llamado empresa de
tipo varchar(50) y una columna de tipo smallint, para indicar la prioridad del
cliente. Ahí se debe ingresar un valor entre 1 y 10, donde 10 es más prioritario.
Hint: No hay que limitar el valor de la columna de prioridad, como tipo de dato se
recomienda ocupar smallint.*/

CREATE TABLE clientes(
    email varchar(50),
    nombre varchar,
    telefono varchar(16),
    empresa varchar(50),
    prioridad smallint
);

--7a. Ingresa 5 clientes distintos con distintas prioridades, el resto de los valores los puedes inventar.
INSERT INTO clientes VALUES ('a.lun@correo.com', 'Ana', '11111111', 'ENEL', 8);
INSERT INTO clientes VALUES ('Bryan@correo.com', 'Bryan', '22222222', 'SOL', 7);
INSERT INTO clientes VALUES ('Ra.ul@correo.com', 'Raul', '33333333', 'MUSTA', 3);
INSERT INTO clientes VALUES ('I.A.@correo.com', 'Italo', '44444444', 'NASA', 1);
INSERT INTO clientes VALUES ('L_ore@correo.com', 'Lorena', '55555555', 'AGUAS', 5);

--7b. Mostrar informacion de tabla
SELECT * from clientes;

--8. Selecciona los tres clientes de mayor prioridad.
SELECT *
FROM clientes
ORDER BY prioridad DESC
LIMIT 3;


--9. Selecciona, de la tabla clientes, una prioridad o una empresa, de forma que el resultado devuelva 2 registros.
--Dos clientes con la prioridad más baja
SELECT prioridad, nombre, empresa
FROM clientes
ORDER BY prioridad ASC
LIMIT 2;

--Dos clientes de la misma empresa
SELECT nombre, empresa
FROM clientes
WHERE empresa = 'SOL'
LIMIT 2;