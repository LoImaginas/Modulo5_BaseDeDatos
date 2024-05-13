-- paso 1: ingresar a la terminal
/Library/PostgreSQL/16/scripts/runpsql.sh         Password:Admin1234

--paso 2: Crea una base de datos llamada desafio2-tuNombre-tuApellido-3digitos
CREATE DATABASE desafio2_lolett_llanquinao_189;

--paso 3: Ingresa a la base de datos creada.
\c desafio2_lolett_llanquinao_189;

--paso 4: Crear una base de datos
CREATE TABLE IF NOT EXISTS INSCRITOS(
    cantidad INT, 
    fecha DATE, 
    fuente VARCHAR
    );

-- paso 5: ingresar datos a la tabla
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );

--paso 6:  Mostrar informacion de tabla
SELECT * from INSCRITOS;

Descripción
Aplicando los conceptos y herramientas aprendidas hasta ahora, crea las querys SQL
necesarias que contesten las siguientes preguntas.

1. ¿Cuántos registros hay?

SELECT COUNT(*) AS total_registros
FROM INSCRITOS;

2. ¿Cuántos inscritos hay en total?

SELECT SUM(cantidad) AS total_inscritos
FROM INSCRITOS;


3. ¿Cuál o cuáles son los registros de mayor antigüedad?
HINT: ocupar subconsultas

SELECT *
FROM INSCRITOS
WHERE fecha = (SELECT MIN(fecha) FROM INSCRITOS);

4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de
ahora en adelante)

SELECT fecha, SUM(cantidad) AS inscritos_por_dia
FROM INSCRITOS
GROUP BY fecha;

5. ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se
inscribieron en ese día?

SELECT fecha, SUM(cantidad) AS total_inscritos
FROM INSCRITOS
GROUP BY fecha
ORDER BY total_inscritos DESC
LIMIT 1;