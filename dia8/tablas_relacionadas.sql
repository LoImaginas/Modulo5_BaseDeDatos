● Paso 1: Creamos las tablas libros y autores con el siguiente código.
Ignorar la restricción de clave foránea
CREATE TABLE libros (
 id INT NOT NULL,
 titulo VARCHAR(255) NOT NULL,
 autor_id INT NOT NULL,
 PRIMARY KEY (id),
 FOREIGN KEY (autor_id) REFERENCES autores (id)
);
CREATE TABLE autores (
 id INT NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 PRIMARY KEY (id)
);
Tabla padre
Tabla hija

● Paso 2: Insertamos algunos datos en ambas tablas
Ignorar la restricción de clave foránea
INSERT INTO autores (id, nombre)
VALUES
 (1, 'Juan Pérez'),
 (2, 'María García'),
 (3, 'Pedro Rodríguez');
INSERT INTO libros (id, titulo, autor_id)
VALUES
 (1, 'El Quijote', 1),
 (2, 'La Divina Comedia', 2),
 (3, 'Hamlet', 3);

 ● Paso 3: Consultamos los datos de ambas tablas
Ignorar la restricción de clave foránea
SELECT libros.titulo, autores.nombre
FROM libros
INNER JOIN autores
ON libros.autor_id = autores.id;
titulo | nombre
------- | --------
El Quijote | Juan Pérez
La Divina Comedia | María García
Hamlet | Pedro Rodríguez
Resultado de la consulta


● Paso 4: Comprobación de la restricción de clave foránea.
Ignorar la restricción de clave foránea
delete from autores;
ERROR: update or delete on table "autores" violates foreign key constraint
"libros_autor_id_fkey" on table "libros"
DETAIL: Key (id)=(1) is still referenced from table "libros".
El error se debe a que los registros de autores no pueden ser
eliminados porque están referenciados con los registros de la
tabla libros y estos no pueden quedar sin su referencia.

En el ejercicio borramos la tabla hija libros. ¿Qué pasaría si eliminamos la tabla hija?
delete from libros;
DELETE 3

En este caso, sí es posible eliminar los registros de libros dado que la restricción se aplica
del lado de la referencia (la tabla padre).


-- BORRADO EN CASCADA 

DROP TABLE autores CASCADE;

SELECT * FROM autores;
