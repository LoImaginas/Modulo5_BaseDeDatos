--Accedemos al cliente de postgresql via el terminal.
/Library/PostgreSQL/16/scripts/runpsql.sh  Password:Admin1234
--Generamos la base de datos con el nombre registro_viajeros
create database registro_viajeros;
--Nos conectamos a la base de datos.
\c registro_viajeros;

-- Crear la tabla Viajeros
CREATE TABLE Viajeros (
    viajero_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    genero CHAR(5) NOT NULL,
    email VARCHAR(250),
    telefono CHAR(50) NOT NULL,
    rut CHAR(10) NOT NULL UNIQUE
);

\d viajeros;
                                          Table "public.viajeros"
   Column   |          Type          | Collation | Nullable |                   Default                    
------------+------------------------+-----------+----------+----------------------------------------------
 viajero_id | integer                |           | not null | nextval('viajeros_viajero_id_seq'::regclass)
 nombre     | character varying(50)  |           | not null | 
 genero     | character(5)           |           | not null | 
 email      | character varying(250) |           |          | 
 telefono   | character(50)          |           | not null | 
 rut        | character(10)          |           | not null | 
Indexes:
    "viajeros_pkey" PRIMARY KEY, btree (viajero_id)
    "viajeros_rut_key" UNIQUE CONSTRAINT, btree (rut)

-- Crear la tabla Destinos
CREATE TABLE Destinos (
    destino_id SERIAL PRIMARY KEY,
    nombre_destino VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50),
    pais VARCHAR(50)
);

\d destinos;
                                            Table "public.destinos"
     Column     |          Type          | Collation | Nullable |                   Default                    
----------------+------------------------+-----------+----------+----------------------------------------------
 destino_id     | integer                |           | not null | nextval('destinos_destino_id_seq'::regclass)
 nombre_destino | character varying(100) |           | not null | 
 ciudad         | character varying(50)  |           |          | 
 pais           | character varying(50)  |           |          | 
Indexes:
    "destinos_pkey" PRIMARY KEY, btree (destino_id)



-- Crear la tabla Tickets
CREATE TABLE Tickets (
    ticket_id SERIAL PRIMARY KEY,
    destino_id INT REFERENCES DESTINOS (destino_id),
    viajero_id INT REFERENCES Viajeros(viajero_id),
    numero_boleto VARCHAR(50) NOT NULL UNIQUE,
    fecha_emision DATE,
    fecha_salida DATE,
    fecha_retorno DATE
);

\d Tickets;
                                         Table "public.tickets"
    Column     |         Type          | Collation | Nullable |                  Default                   
---------------+-----------------------+-----------+----------+--------------------------------------------
 ticket_id     | integer               |           | not null | nextval('tickets_ticket_id_seq'::regclass)
 destino_id    | integer               |           |          | 
 viajero_id    | integer               |           |          | 
 numero_boleto | character varying(50) |           | not null | 
 fecha_emision | date                  |           |          | 
 fecha_salida  | date                  |           |          | 
 fecha_retorno | date                  |           |          | 
Indexes:
    "tickets_pkey" PRIMARY KEY, btree (ticket_id)
    "tickets_numero_boleto_key" UNIQUE CONSTRAINT, btree (numero_boleto)
Foreign-key constraints:
    "tickets_destino_id_fkey" FOREIGN KEY (destino_id) REFERENCES destinos(destino_id)
    "tickets_viajero_id_fkey" FOREIGN KEY (viajero_id) REFERENCES viajeros(viajero_id)



-- Inserts para la tabla Viajeros
INSERT INTO Viajeros (nombre, genero, email, telefono, rut) VALUES
('Juan Perez', 'M', 'juan@email.com', '123456789', '1111111111'),
('Maria Rodriguez', 'F', 'maria@email.com', '987654321', '2222222222'),
('Carlos Gonzalez', 'M', 'carlos@email.com', '111222333', '3333333333'),
('Luisa Martinez', 'F', 'luisa@email.com', '444555666', '4444444444'),
('Pedro Hernandez', 'M', 'pedro@email.com', '777888999', '5555555555'),
('Ana Lopez', 'F', 'ana@email.com', '333444555', '6666666666'),
('Jorge Ramirez', 'M', 'jorge@email.com', '666777888', '7777777777'),
('Sofia Torres', 'F', 'sofia@email.com', '999000111', '8888888888'),
('Daniel Castro', 'M', 'daniel@email.com', '222333444', '9999999999'),
('Laura Garcia', 'F', 'laura@email.com', '555666777', '0000000000'),
('Manuel Silva', 'M', 'manuel@email.com', '888999000', '1231231231'),
('Elena Vargas', 'F', 'elena@email.com', '111222333', '4564564564'),
('Gabriel Morales', 'M', 'gabriel@email.com', '444555666', '7897897897'),
('Isabel Rios', 'F', 'isabel@email.com', '777888999', '0120120120'),
('Hector Mendoza', 'M', 'hector@email.com', '333444555', '9876543210');
select * from viajeros;
 viajero_id |     nombre      | genero |       email       |                      telefono                      |    rut     
------------+-----------------+--------+-------------------+----------------------------------------------------+------------
          1 | Juan Perez      | M      | juan@email.com    | 123456789                                          | 1111111111
          2 | Maria Rodriguez | F      | maria@email.com   | 987654321                                          | 2222222222
          3 | Carlos Gonzalez | M      | carlos@email.com  | 111222333                                          | 3333333333
          4 | Luisa Martinez  | F      | luisa@email.com   | 444555666                                          | 4444444444
          5 | Pedro Hernandez | M      | pedro@email.com   | 777888999                                          | 5555555555
          6 | Ana Lopez       | F      | ana@email.com     | 333444555                                          | 6666666666
          7 | Jorge Ramirez   | M      | jorge@email.com   | 666777888                                          | 777777
7777
          8 | Sofia Torres    | F      | sofia@email.com   | 999000111                                          | 888888
8888
          9 | Daniel Castro   | M      | daniel@email.com  | 222333444                                          | 999999
9999
         10 | Laura Garcia    | F      | laura@email.com   | 555666777                                          | 000000
0000
         11 | Manuel Silva    | M      | manuel@email.com  | 888999000                                          | 123123
1231
         12 | Elena Vargas    | F      | elena@email.com   | 111222333                                          | 456456
4564
         13 | Gabriel Morales | M      | gabriel@email.com | 444555666                                          | 789789
7897
         14 | Isabel Rios     | F      | isabel@email.com  | 777888999                                          | 012012
0120
         15 | Hector Mendoza  | M      | hector@email.com  | 333444555                                          | 987654
3210
(15 rows)




-- Inserts para la tabla Destinos
INSERT INTO Destinos (nombre_destino, ciudad, pais) VALUES
('Playa del Carmen', 'Playa del Carmen', 'México'),
('Machu Picchu', 'Cuzco', 'Perú'),
('Torres del Paine', 'Puerto Natales', 'Chile'),
('Gran Barrera de Coral', 'Queensland', 'Australia'),
('Monte Everest', 'Khumbu', 'Nepal'),
('Santorini', 'Santorini', 'Grecia'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Kioto', 'Kioto', 'Japón'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos');
select * from Destinos;
 destino_id |    nombre_destino     |      ciudad      |   pais    
------------+-----------------------+------------------+-----------
          1 | Playa del Carmen      | Playa del Carmen | México
          2 | Machu Picchu          | Cuzco            | Perú
          3 | Torres del Paine      | Puerto Natales   | Chile
          4 | Gran Barrera de Coral | Queensland       | Australia
          5 | Monte Everest         | Khumbu           | Nepal
          6 | Santorini             | Santorini        | Grecia
          7 | Marrakech             | Marrakech        | Marruecos
          8 | Kioto                 | Kioto            | Japón
          9 | Marrakech             | Marrakech        | Marruecos
         10 | Marrakech             | Marrakech        | Marruecos
         11 | Marrakech             | Marrakech        | Marruecos
         12 | Marrakech             | Marrakech        | Marruecos
         13 | Marrakech             | Marrakech        | Marruecos
         14 | Marrakech             | Marrakech        | Marruecos
         15 | Marrakech             | Marrakech        | Marruecos
(15 rows)


-- Inserts para la tabla Tickets
INSERT INTO Tickets (viajero_id, destino_id, numero_boleto, fecha_emision, fecha_salida, fecha_retorno) VALUES
(1, 1, 'T111111', '2024-01-04', '2024-01-10', '2024-01-20'),
(2, 2, 'T222222', '2024-01-05', '2024-02-01', '2024-02-15'),
(2, 3, 'T333333', '2024-01-06', '2024-03-05', '2024-03-20'),
(4, 4, 'T444444', '2024-01-07', '2024-04-12', '2024-05-01'),
(5, 5, 'T555555', '2024-01-08', '2024-06-02', '2024-06-20'),
(6, 1, 'T666666', '2024-01-09', '2024-07-15', '2024-08-01'),
(4, 2, 'T777777', '2024-01-10', '2024-09-03', '2024-09-20'),
(8, 3, 'T888888', '2024-01-11', '2024-10-18', '2024-11-01'),
(9, 4, 'T999999', '2024-01-12', '2024-12-05', '2024-12-20'),
(10, 5, 'T101010', '2024-01-13', '2025-01-02', '2025-01-20'),
(15, 1, 'T1111111', '2024-01-14', '2025-02-10', '2025-02-25'),
(12, 2, 'T121212', '2024-01-15', '2025-03-15', '2025-04-01'),
(13, 3, 'T131313', '2024-01-16', '2025-05-02', '2025-05-20'),
(14, 4, 'T141414', '2024-01-17', '2025-06-12', '2025-06-30'),
(15, 5, 'T151515', '2024-01-18', '2025-07-20', '2025-08-05');

select * from tickets;
 ticket_id | destino_id | viajero_id | numero_boleto | fecha_emision | fecha_salida | fecha_retorno 
-----------+------------+------------+---------------+---------------+--------------+---------------
         1 |          1 |          1 | T111111       | 2024-01-04    | 2024-01-10   | 2024-01-20
         2 |          2 |          2 | T222222       | 2024-01-05    | 2024-02-01   | 2024-02-15
         3 |          3 |          2 | T333333       | 2024-01-06    | 2024-03-05   | 2024-03-20
         4 |          4 |          4 | T444444       | 2024-01-07    | 2024-04-12   | 2024-05-01
         5 |          5 |          5 | T555555       | 2024-01-08    | 2024-06-02   | 2024-06-20
         6 |          1 |          6 | T666666       | 2024-01-09    | 2024-07-15   | 2024-08-01
         7 |          2 |          4 | T777777       | 2024-01-10    | 2024-09-03   | 2024-09-20
         8 |          3 |          8 | T888888       | 2024-01-11    | 2024-10-18   | 2024-11-01
         9 |          4 |          9 | T999999       | 2024-01-12    | 2024-12-05   | 2024-12-20
        10 |          5 |         10 | T101010       | 2024-01-13    | 2025-01-02   | 2025-01-20
        11 |          1 |         15 | T1111111      | 2024-01-14    | 2025-02-10   | 2025-02-25
        12 |          2 |         12 | T121212       | 2024-01-15    | 2025-03-15   | 2025-04-01
        13 |          3 |         13 | T131313       | 2024-01-16    | 2025-05-02   | 2025-05-20
        14 |          4 |         14 | T141414       | 2024-01-17    | 2025-06-12   | 2025-06-30
        15 |          5 |         15 | T151515       | 2024-01-18    | 2025-07-20   | 2025-08-05
(15 rows)



--El cliente nos solicita un pequeño reporte de pruebas donde se registren el nombre de todos los viajeros con y sin boletos, 
--el número de boleto (para los casos que correspondan) y el nombre del destino.
SELECT viajeros.nombre, tickets.numero_boleto, destinos.nombre_destino
FROM viajeros
LEFT JOIN tickets ON viajeros.viajero_id = tickets.viajero_id
LEFT JOIN destinos ON tickets.destino_id = destinos.destino_id;
RESULTADO:
     nombre      | numero_boleto |    nombre_destino     
-----------------+---------------+-----------------------
 Juan Perez      | T111111       | Playa del Carmen
 Maria Rodriguez | T222222       | Machu Picchu
 Maria Rodriguez | T333333       | Torres del Paine
 Luisa Martinez  | T444444       | Gran Barrera de Coral
 Pedro Hernandez | T555555       | Monte Everest
 Ana Lopez       | T666666       | Playa del Carmen
 Luisa Martinez  | T777777       | Machu Picchu
 Sofia Torres    | T888888       | Torres del Paine
 Daniel Castro   | T999999       | Gran Barrera de Coral
 Laura Garcia    | T101010       | Monte Everest
 Hector Mendoza  | T1111111      | Playa del Carmen
 Elena Vargas    | T121212       | Machu Picchu
 Gabriel Morales | T131313       | Torres del Paine
 Isabel Rios     | T141414       | Gran Barrera de Coral
 Hector Mendoza  | T151515       | Monte Everest
 Manuel Silva    |               | 
 Carlos Gonzalez |               | 
 Jorge Ramirez   |               | 
(18 rows)

--Mostrar la información del boleto T123456 junto con los detalles del viajero y destino correspondiente a ese boleto.

SELECT viajeros.nombre, viajeros.genero, viajeros.email, viajeros.telefono,
    destinos.nombre_destino, destinos.ciudad, destinos.pais,
    tickets.numero_boleto, tickets.fecha_emision, tickets.fecha_salida, tickets.fecha_retorno
FROM tickets
JOIN viajeros ON tickets.viajero_id = viajeros.viajero_id
JOIN destinos ON tickets.destino_id = destinos.destino_id
WHERE tickets.numero_boleto = 'T123456';    ----no existe ese boleto
RESULTADO:
 nombre | genero | email | telefono | nombre_destino | ciudad | pais | numero_boleto | fecha_emision | fecha_salida | fecha_retorno 
--------+--------+-------+----------+----------------+--------+------+---------------+---------------+--------------+---------------
(0 rows)


--Listar todos los viajeros que tienen fecha de salida o de retorno el '2024-01-10'

SELECT viajeros.nombre, tickets.fecha_salida, tickets.fecha_retorno
FROM tickets
JOIN viajeros ON tickets.viajero_id = viajeros.viajero_id
JOIN destinos ON tickets.destino_id = destinos.destino_id
WHERE tickets.fecha_salida = '2024-01-10' OR tickets.fecha_retorno = '2024-01-10';
RESULTADO:
   nombre   | fecha_salida | fecha_retorno 
------------+--------------+---------------
 Juan Perez | 2024-01-10   | 2024-01-20
(1 row)

-- Obtener el número total de boletos por cada género
SELECT viajeros.genero, COUNT(*) AS total_boletos
FROM tickets
JOIN viajeros ON tickets.viajero_id = viajeros.viajero_id
GROUP BY viajeros.genero;
RESULTADO:
 genero | total_boletos 
--------+---------------
 M      |             6
 F      |             9
(2 rows)

-- Obtener un listado de todos los viajeros que han viajado a Playa del Carmen
SELECT viajeros.nombre, viajeros.genero, viajeros.email, viajeros.telefono, viajeros.rut
FROM tickets
JOIN viajeros ON tickets.viajero_id = viajeros.viajero_id
JOIN destinos ON tickets.destino_id = destinos.destino_id
WHERE destinos.nombre_destino = 'Playa del Carmen';
RESULTADO:
     nombre     | genero |      email       |                      telefono                      |    rut     
----------------+--------+------------------+----------------------------------------------------+------------
 Juan Perez     | M      | juan@email.com   | 123456789                                          | 1111111111
 Ana Lopez      | F      | ana@email.com    | 333444555                                          | 6666666666
 Hector Mendoza | M      | hector@email.com | 333444555                                          | 9876543210
(3 rows)


--Ingresa tres nuevos tickets con la siguiente información:
INSERT INTO Tickets (viajero_id, destino_id, numero_boleto, fecha_emision, fecha_salida, fecha_retorno) VALUES
(4, 3, 'T171717', null, '2024-03-28', '2024-04-01'),
(10, 5, 'T888888', null, '2024-03-28', '2024-04-01'),        --ERROR:  llave duplicada viola restricción de unicidad «tickets_numero_boleto_key» DETAIL:  Ya existe la llave (numero_boleto)=(T888888).
(null, 4, 'T202020', null, '2024-03-28', '2024-04-01');
RESULTADO:
--ERROR:  duplicate key value violates unique constraint "tickets_numero_boleto_key"
--DETAIL:  Key (numero_boleto)=(T888888) already exists.
