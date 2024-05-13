--que es ACID;
--● Atomicidad: Las operaciones se ejecutan como una unidad completa o no se ejecutan en absoluto.
--Esto evita la corrupción de datos que puede ocurrir si solo se aplica una parte de la operación.
--● Consistencia: Las operaciones llevan la base de datos de un estado consistente a otro. Esto asegura
--que los datos siempre cumplan con las reglas de negocio y las restricciones de integridad.
--● Aislamiento: Las operaciones se ejecutan de forma independiente, sin interferirse entre sí. Esto evita
--la pérdida de datos que puede ocurrir si dos operaciones intentan modificar el mismo dato al mismo tiempo.
--● Durabilidad: Los cambios realizados por las operaciones se guardan de forma permanente, incluso en
--caso de un fallo del sistema. Esto protege la integridad de los datos contra la pérdida o corrupción.

--Accedemos al cliente de postgresql via el terminal.
/Library/PostgreSQL/16/scripts/runpsql.sh  Password:Admin1234

--● Paso 1: Creamos la base de datos transacciones y nos conectamos.
create database transacciones;
\c transacciones;
--● Paso 2: Creamos una tabla llamada cuentas con los campos numero_cuenta y balance.
create table cuentas (
    numero_cuenta int primary key,    -- cuando se agrega un primary key no se coloca not null, tampoco unique
    balance float check(balance >= 0.00)
);

\d cuentas;
                      Table "public.cuentas"
    Column     |       Type       | Collation | Nullable | Default 
---------------+------------------+-----------+----------+---------
 numero_cuenta | integer          |           | not null | 
 balance       | double precision |           |          | 
Indexes:
    "cuentas_pkey" PRIMARY KEY, btree (numero_cuenta)
Check constraints:
    "cuentas_balance_check" CHECK (balance >= 0.00::double precision)


--● Paso 3: Insertamos dos registros a la tabla.
insert into cuentas (numero_cuenta, balance) values (1, 1000);
insert into cuentas (numero_cuenta, balance) values (2, 1000);

select * from cuentas;
 numero_cuenta | balance 
---------------+---------
             1 |    1000
             2 |    1000
(2 rows)

--Paso 4: Si quisiéramos hacer una transferencia de $1000 desde nuestra cuenta 1 a la cuenta 2, 
--una forma de asegurarnos que el monto de nuestro balance disminuya en $1000 y el de la segunda cuenta aumenta en la misma cifra,
--podría escribirse de la siguiente manera:
begin transaction;--begin transaction = comenzar transaccion
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 1;
UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 2;


--Paso 5: Verificamos el estado de la tabla.
select * from cuentas;
 numero_cuenta | balance 
---------------+---------
             1 |       0
             2 |    2000
(2 rows)

--Paso 6: Confirmamos la transacción con commit.
commit;
-------------transacciones=*# commit;
-------------COMMIT
-------------transacciones=#


--***************ROLLBACK***************
--Paso 7: Continuemos con el ejercicio anterior y apliquemos el uso de ROLLBACK. Para ello haremos un nuevo insert a la base de datos.
insert into cuentas (numero_cuenta, balance) values (3, 1000);
--Paso 8: Iniciamos una transacción para transferir 1000 de la cuenta 3 a la 1.
begin transaction;
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 3;
UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 1;

select * from cuentas;
 numero_cuenta | balance 
---------------+---------
             2 |    2000
             3 |       0
             1 |    1000
(3 rows)
--paso 9: Para deshacer la transacción donde transferimos los 1000 de la cuenta 3 a la 1
ejecutamos el ROLLBACK; 
---------------------transacciones=*# ROLLBACK; 
---------------------ROLLBACK
---------------------transacciones=#
--Volvemos atrás y nuestra base de datos queda con la información del último commit.
select * from cuentas;
 numero_cuenta | balance 
---------------+---------
             1 |       0
             2 |    2000
             3 |    1000
(3 rows)

--SAVE POINT

begin transaction;
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 3;

SAVEPOINT descuento3;
--forzando error
UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 1;
select * from cuentas;
 numero_cuenta | balance 
---------------+---------
             2 |    2000
             3 |       0
             1 |    1000
(3 rows)

ROLLBACK to descuento3;
select * from cuentas;
 numero_cuenta | balance 
---------------+---------
             1 |       0
             2 |    2000
             3 |       0
(3 rows)
--volvemos al sevepoint descuento3

UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 2;



commit;

select * from cuentas;
 numero_cuenta | balance 
---------------+---------
             1 |       0
             3 |       0
             2 |    3000
(3 rows)

--En PostgreSQL, por defecto viene configurado el modo AUTOCOMMIT, es decir, que implícitamente 
--una vez que hemos realizado una acción sobre la base de datos, ésta realiza un COMMIT.
--● Podemos escribir en terminal 
\echo :AUTOCOMMIT
-- Esto retorna ON, es decir, que está activo.

--borrado fisico
delete from cuentas where numero_cuenta = 3;
select * from cuentas;
 numero_cuenta | balance 
---------------+---------
             1 |       0
             2 |    3000
(2 rows)

alter table cuentas add column activa boolean ;
select * from cuentas;
 numero_cuenta | balance | activa 
---------------+---------+--------
             1 |       0 | 
             2 |    3000 | 
(2 rows)

UPDATE cuentas set activa = true;
select * from cuentas;
 numero_cuenta | balance | activa 
---------------+---------+--------
             1 |       0 | t
             2 |    3000 | t
(2 rows)

-- borrado logico
UPDATE cuentas set activa = false where numero_cuenta = 1;
select * from cuentas;
 numero_cuenta | balance | activa 
---------------+---------+--------
             2 |    3000 | t
             1 |       0 | f
(2 rows)



