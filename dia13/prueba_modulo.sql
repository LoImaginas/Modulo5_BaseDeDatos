-- MODELO 1 - Peliculas y Tags

--Paso 1 = Entramos a postgres desde la consola.
/Library/PostgreSQL/16/scripts/runpsql.sh   Password:Admin1234 

--Paso 2: Creamos una base de datos con nombre y apellido 
CREATE DATABASE Lolett_Llanquinao_Prueba;

--Paso 3: Conéctate a la base de datos. 
\c lolett_llanquinao_prueba;

--Paso 4: Creamos nuestra Tablas 

CREATE TABLE peliculas(
    id INT Primary Key,
    nombre VARCHAR(255),
    anno INT 
);

CREATE TABLE tags(
    id INT Primary Key,
    tag VARCHAR(32)
);
--Paso 5: verificar nuestras tablas
\d

--Paso 6: Creación de tabla intermedia
CREATE TABLE peliculas_tags(
pelicula_id int,
tag_id int,
FOREIGN KEY (pelicula_id) REFERENCES peliculas(id),
FOREIGN KEY (tag_id) REFERENCES tags(id),
PRIMARY KEY (pelicula_id, tag_id)
);

-- Paso 7: verificar tabla
\d

--Paso 8: Insertar 5 peliculas y 5 tags, la primera pelicula tiene que tener tres tag asociados,
--la segunda pelicula debe tener dos tag asociados.

INSERT INTO peliculas (id,nombre,anno) values
(1, 'El Señor de los Anillos: La comunidad del anillo',2001),
(2, 'El Señor de los Anillos: Las dos torres',2002),
(3, 'El Señor de los Anillos: El retorno del Rey',2003),
(4, 'El Hobbit: un viaje inesperado',2012),
(5, 'El Hobbit: La desolacion de Smaug',2013);

INSERT INTO tags (id,tag) VALUES
(1,'Acción'),
(2,'Aventura'),
(3,'Catastrofe'),
(4,'Ciencia Ficcion'),
(5,'Comedia');
-- tags en la primera pelicula (3)
INSERT INTO peliculas_tags (pelicula_id, tag_id) VALUES
(1,1),
(1,2),
(1,3),
(2,4),
(2,5);

-- Paso 9: Verificamos con SELECT 

Select * from peliculas;
select * from tags;
select * from peliculas_tags;

-- Paso 10: Contar la cantidad de tags por película:
-- realizamos consulta para contar la cantidad de tags que tiene cada pelicula,
-- mostrando 0 si no tiene tags asociados. esta consulta asegura que todas las peliculas aparezcan
-- incluidas aquellas que tienen 0 tags  (con left join)
SELECT p.nombre AS pelicula,
COUNT(pt.tag_id) AS cantidad_tags
FROM peliculas p
LEFT JOIN peliculas_tags pt ON p.id = pt.pelicula_id
GROUP BY p.nombre;



-- MODELO 2 -  Preguntas, respuestas, usuarios.

4.
--Paso 1 = nos mantenemos dentro de la misma base de datos y creamos tres tablas
-- segun las indicaciones de la guia.

--crear tabla usuarios
CREATE TABLE usuarios(
    id int PRIMARY KEY,
    nombre VARCHAR(255),
    edad INT
);

--crear tabla preguntas

CREATE TABLE preguntas(
    id int PRIMARY KEY,
    pregunta VARCHAR(255),
    respuesta_correcta VARCHAR
);

--crear tabla respuestas

CREATE TABLE respuestas(
    id int PRIMARY KEY,
    respuesta VARCHAR(255),
    usuario_id int, 
    pregunta_id int, 
    correcta boolean,
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY(pregunta_id) REFERENCES preguntas(id)
    );

5.
-- Paso 2 =
--Agrega 5 registros a la tabla preguntas, de los cuales:
--a. La primera pregunta debe ser contestada correctamente por dos usuarios distintos.
--b. La pregunta 2 debe ser contestada correctamente por un usuario.
--c. Los otros dos registros deben ser respuestas incorrectas.

--Insertar Usuarios
INSERT INTO usuarios(id,nombre,edad) VALUES
    (1, 'Gandalf',30),
    (2, 'Frodo',25),
    (3, 'Sam',23);

--Insertar Preguntas
INSERT INTO preguntas(id,pregunta) VALUES  
    (1, '¿Donde vive Frodo Bolson?'),
    (2, '¿que es Gandalf?'),
    (3, '¿Como se llama el tio de Frodo?'),
    (4, '¿Donde viven los elfos?');

Revisar tablas  
SELECT * FROM usuarios;
SELECT * FROM preguntas;
--Insertar Respuestas

--Respuestas correctas para Pregunta 1 por dos usuarios diferentes    
INSERT INTO respuestas (id, usuario_id, pregunta_id, respuesta, correcta) VALUES 
(1, 1, 1, 'Frodo vive en la comarca', TRUE), 
(2, 2, 1, 'Frodo vive en la comarca', TRUE);

-- Respuesta correcta para Pregunta 2 por un usuario
INSERT INTO respuestas (id, usuario_id, pregunta_id, respuesta, correcta) VALUES 
(3, 1, 2, 'Gandalf es un mago', TRUE);

-- Respuestas incorrectas (Los otros dos registros deben ser respuestas incorrectas)
INSERT INTO respuestas (id, usuario_id, pregunta_id, respuesta, correcta) VALUES 
(4, 3, 3, 'Se llama Joaquin', FALSE), 
(5, 3, 4, 'Los elfos viven en Temuco', FALSE);

Revisar tabla de respuestas
SELECT * FROM respuestas;

6. 
-- Paso 3 = 
--Cuenta la cantidad de respuestas correctas totales por usuario 
--(independiente de la pregunta).

SELECT u.nombre, COUNT(r.id) AS respuestas_correctas
FROM usuarios u
LEFT JOIN respuestas r ON u.id = r.usuario_id AND r.correcta = TRUE
GROUP BY u.nombre;

7.
-- Paso 4 = 
--Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios 
--tuvieron la respuesta correcta.

SELECT p.pregunta AS pregunta, COUNT(r.id) AS usuarios_correctos
FROM preguntas p
LEFT JOIN respuestas r ON p.id = r.pregunta_id AND r.correcta = TRUE
GROUP BY p.pregunta;

8.
-- Paso 5 = implementa Borrado en cascada
--Implementa borrado en cascada de las respuestas al borrar un usuario y 
--borrar el primer usuario para probar la implementación.

-- Borrar el primer usuario
--para esto, debemos agregar una restriccion a las claves foraneas
ALTER TABLE respuestas
ADD CONSTRAINT fk_usuario_respuestas FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_pregunta_respuestas FOREIGN KEY (pregunta_id) REFERENCES preguntas(id) ON DELETE CASCADE;

y posteriormente eliminamos el primer usuario.
DELETE FROM usuarios WHERE id = 1;


Revisamos la tabla usuarios
SELECT * FROM usuarios;

9.
-- paso 6 = Crea una restricción que impida insertar usuarios menores de 18 años
--en la base de datos.

ALTER TABLE usuarios ADD CONSTRAINT chk_edad CHECK (edad >= 18);

10.
-- paso 7 =  
--Altera la tabla existente de usuarios agregando el 
--campo email con la restricción de único.

ALTER TABLE usuarios ADD COLUMN email VARCHAR(255); -- (falto la restriccion UNIQUE).



