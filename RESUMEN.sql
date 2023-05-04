
/*crear , insertar , delete y update tablas*/

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
);

/*INSERT*/

INSERT INTO clientes
		(codcli,nomcli, ape1cli, ape2cli,dnicli, tlf_contacto)
	VALUES
		(899,'Juan','del Campo', 'Sánchez','07000000W','607000001');


/*DELETE*/
DELETE FROM compras

where cliente = ‘manolo’;  

DELETE  clientes FROM compras;


/*UPDATE*/
UPDATE estudiantes SET edad = 21 WHERE nombre = 'Juan Pérez';


/*SUBSTRING: Obtiene una subcadena de caracteres de una cadena. En este caso, se obtienen los caracteres 3, 4 y 5 de la columna "email".*/
  substring(email, 3,1);
  
  /*: Obtiene la longitud de una cadena. En este caso, se obtiene la longitud de la concatenación de las columnas "nomcli", "ape1cli" y "ape2cli"
  después de aplicar la función TRIM y la función IFNULL para manejar posibles valores nulos en "ape2cli".*/
  
  select concat(left(trim(nomcli),1), 
						  substring(email, 3,1),
						  substring(email, 4,1),
						  substring(email, 5,1), 
						  length(concat(trim(nomcli), trim(ape1cli), ifnull(trim(ape2cli),'')))
						)
			from clientes
			where email = correo and tlfcli = telefono
            
/*Sabemos que de nuestros vendedores almacenamos en nomvende su nombre y su primer apellido y su segundo apellido, no hay vendedores con nombres ni apellidos compuestos.
 Obten su contraseña formada por la inicial del nombre, las 3 primeras letras del primer apellido y las 3 primeras letras del segundo apellido*/
 
 
 
 /*LOCATE: Busca la posición de una subcadena dentro de otra cadena. En este caso, se utiliza para encontrar la posición 
 de un espacio en blanco dentro del valor de la columna "nomvende", lo cual se utiliza para delimitar las subcadenas que se obtendrán.

+1: Se suma 1 al resultado de la función LOCATE para obtener la posición del primer carácter después del espacio en blanco encontrado. 
Esto se utiliza como punto de inicio para obtener las subcadenas deseadas.

3: Es el número de caracteres que se obtendrán a partir de la posición encontrada. En este caso, 
se obtendrán tres caracteres después del espacio en blanco.*/

select nomvende, concat(
						substring(nomvende,1,1),
						substring(nomvende,
								  locate(' ',nomvende)+1,3), 
						substring(nomvende,locate(' ',nomvende,locate(' ',nomvende) + 1)+1,3)
					)
from vendedores;

/*obtiene el mes , año , dia y dia de la semana de la fecha q pase*/
date_format(fecventa, '%M - %Y, %d (%W)')



/*
SOME / ANY:
El operador SOME o ANY se utiliza para comparar un valor con un conjunto de valores devueltos por una subconsulta.
 Al menos uno de los valores de la subconsulta debe cumplir con la condición para que la comparación sea verdadera. Aquí hay un ejemplo:
En este ejemplo, se seleccionan los nombres de productos cuyos precios sean mayores que al menos uno de los precios de los productos de la categoría "Electrónicos".
*/

SELECT nombre
FROM productos
WHERE precio > SOME (SELECT precio FROM productos WHERE categoria = 'Electrónicos');

/*
ALL:
El operador ALL se utiliza para comparar un valor con un conjunto de valores devueltos por una subconsulta.
 Todos los valores de la subconsulta deben cumplir con la condición para que la comparación sea verdadera. Aquí hay un ejemplo:
 En este ejemplo, se seleccionan los nombres de productos cuyos precios sean mayores que todos los precios de los productos de la categoría "Electrónicos".
*/


SELECT nombre
FROM productos
WHERE precio > ALL (SELECT precio FROM productos WHERE categoria = 'Electrónicos');

/*
IN:
El operador IN se utiliza para comparar un valor con un conjunto de valores especificados en una lista. Aquí hay un ejemplo:
En este ejemplo, se seleccionan los nombres de productos cuya categoría sea "Electrónicos", "Muebles" o "Ropa".
*/

SELECT nombre
FROM productos
WHERE categoria IN ('Electrónicos', 'Muebles', 'Ropa');

/*
EXISTS:
El operador EXISTS se utiliza para verificar si una subconsulta devuelve algún resultado.
 Si la subconsulta devuelve al menos un resultado, la condición EXISTS se considera verdadera. Aquí hay un ejemplo:
En este ejemplo, se seleccionan los nombres de productos que han sido vendidos al menos una vez,
 utilizando una subconsulta que verifica si hay registros en la tabla "ventas" que coinciden con el ID de producto en la tabla "productos".
*/
SELECT nombre
FROM productos
WHERE EXISTS (SELECT * FROM ventas WHERE ventas.id_producto = productos.id);



/*TRANSACTION*/

start transaction;
update casas
			set preciobase= (preciobase + (preciobase*0.10));
			where numbanios=3     and     m2=200;
commit; 

/*Buscar el número de empleados de cada departamento, pero no queremos los de menos de 3 empleados.*/

select numde, count(*) as NumEmple
from empleados
group by numde
having count(*) >=3
order by count(*) DESC;
-- order by 2 (segunda columna que es count) DESC;
-- order by NumEm DESC;


/*SUBSELECT*/

/*Imaginamos que queremos añadir un empleado en el departamento del empleado 120*/

set @depto =  (select numde
from empleados
where numen = 120) ;

insert into empleados
	(numem, numde, nomem…)
value 
(199, @depto, ‘pepe’);

/*Otra forma de hacerlo sería:*/

/*Creamos una tabla y queremos pasar los datos de la otra de centro*/
insert into empleados
	(numem, numde, nomem…)
value 
(199, (select numde
from empleados
where numen = 120),  
‘pepe’, ‘del_campo’, …);

create table centros_new
	(numce int primary key,
	nomce varchar (60));

insert into centros_new
	(numce, nomce)
(select numce, nomce
from centros);


/*Al empleado 280 vamos a cambiarle al departamento del empleado 120*/
update empleados
set numde = (select numde
		from empleados
		where numem = 120)
where numem = 280 ;

/*Operadores cuantificados
SOME / ANY
ALL
IN
EXISTS

expresion - operadores cuantificados - operador lógico - conjunto datos
Vamos a buscar los empleados que ganan más que todos los empleados del depto 110*/

select numem, nomem, salarem
from empleados
where salarem > all    (select salarem
			from empleados
			where numde=110);

/*Buscar empleados que ganan lo mismo que algunos de los departamentos*/

select numem, nomem, salarem
from empleados
where salarem =  some	(select salarem
				from empleados)
and numde <> 110;

/*Esto es lo mismo que:*/

SELECT numem, nomem, salarem
FROM empleados
WHERE salarem IN (SELECT salarem FROM empleados WHERE numde <> 110);

/*Aquellos que ganen diferente que los empleados del departamentos del 110:*/

select numem, nomem, salarem from empleados where salarem  not in	(select salarem from empleados);

select numem, nomem, salarem from empleados where salarem  <> all	(select salarem from empleados);


/*Supongamos que queremos añadir un centro nuevo pero no sabemos qué número le corresponde, usamos transacción porque el programa no puede modificar y hacer una consulta a la vez.*/
start transaction; 


START TRANSACTION;

SET @nuevocentro = (SELECT MAX(numce) + 1 FROM centros);

INSERT INTO centros (numce, lomce, dirce)
VALUES (@nuevocentro, 'prueba', 'dirce');

COMMIT;


/*EXPLICACION UNION
Queremos hallar el correo de los clientes y proveedores en la misma busqueda:*/

select numcli, concat_ws(‘ ‘, nomcli. ap1cli, ape2cli), email
from clientes
union /*(all- sale todos hasta los que se repiten) (distinct- no saldrá repetidos)*/
select numen, concat_ws(‘ ‘, nomen, ape1em, ape2em), email
from empleados;

/*USO DE VISTAS*/

drop view if exists invitados;
create view invitados
	(numinvitado, nombreinvitado, emailinvitado) /*No es obligatorio ni tiene que coincidir con el nombre de los datos*/
as
select numcli, concat_ws(‘ ‘, nomcli. ap1cli, ape2cli), email
from clientes
union /*(all- sale todos hasta los que se repiten) (distinct- no saldrá repetidos)*/
select numen, concat_ws(‘ ‘, nomen, ape1em, ape2em), email
from empleados;

/*Para verlo:*/
Select * from invitados ;


/*Algunas funciones*/
ABS → Devuelve el valor absoluto de un número.

select abs(-10); ⇒ Devuelve 10
EXP → Devuelve el resultado de la función exponencial e^x.

select 1000 * exp(0.05 * 1); -- Devuelve 1051.27
SQRT → Devuelve la raíz cuadrada de un número.

select sqrt(25); -- Devuelve 5
SQUARE → Devuelve el cuadrado de un número.

select square(4); -- Devuelve 16
RADIANS → Convierte un valor de grado en radianes. (45º a radianes)

select radians(45); -- Devuelve 0.7853981633974483
ROUND → Redondea un número al número de decimales especificado.

select round(3.14159, 2); -- Devuelve 3.14
RAND → Devuelve un número aleatorio entre 0 y 1.

select rand(); -- Devuelve un número aleatorio entre 0 y 1
select(rand() * 9) + 1; -- Devuelve un número aleatorio entre 1 y 10
SIGN → Devuelve el signo de un número (1 para positivo, -1 para negativo, 0 para cero).

select sign(10); -- Devuelve 1, ya que 10 es un número positivo
select sign(-5); -- Devuelve -1, ya que -5 es un número negativo
select sign(0); -- Devuelve 0, ya que 0 es un número cero
FLOOR → Devuelve el valor entero más grande menor o igual que un número.

select floor(3.7); -- Devuelve 3, ya que el entero más grande menor o igual a 3.7 es 3
select floor(-2.8); -- Devuelve -3, ya que el entero más grande menor o igual a -2.8 es -3
CEILING → Devuelve el valor entero más pequeño mayor o igual que un número.

select floor(3.7); -- Devuelve 4,
select floor(-2.8); -- Devuelve -2
POWER → Devuelve la potencia de un número o valor en concreto.

select power(2,5) -- 2^5 = 32
ROUND → Sirve para limitar los resultados de una cadena de números, como puede ser un precio.

select round(precioVenta,2) -- Devuelve 12.50 y no 12.50000. (limita a 2 decimales)