USE `empresaclase`;

-- Ejercicio de la Relación 4

-- 1 Obtener por orden alfabético el nombre y los sueldos de los empleados con más de tres hijos.

select empleados.nomem, empleados.salarem
from empleados
where empleados.numhiem > 3
order by empleados.nomem;

-- 2 Obtener la comisión, el departamento y el nombre de los empleados cuyo salario es inferior a 190.000 u.m., 
-- clasificados por departamentos en orden creciente y por comisión en orden decreciente dentro de cada departamento.

select empleados.comisem as Comision, departamentos.nomde as 'Nombre Departamento', empleados.nomem as 'Nombre Empleados'
from empleados join departamentos
				on empleados.numde = departamentos.numde
where empleados.salarem < 190000;

-- 3 Hallar por orden alfabético los nombres de los deptos cuyo director lo es en funciones y no en propiedad.

select departamentos.nomde
from departamentos join dirigir
				on departamentos.numde = dirigir.numdepto
where dirigir.tipodir = 'funciones' and dirigir.tipodir != 'propiedad'
order by departamentos.nomde;

-- 4 Obtener un listín telefónico de los empleados del departamento 121 incluyendo 
-- el nombre del empleado, número de empleado y extensión telefónica. Ordenar alfabéticamente.

select empleados.nomem as Nombre, empleados.numem as Número, empleados.extelem as Teléfono
from empleados join departamentos
					on empleados.numde = departamentos.numde
where departamentos.numde = 121
order by Nombre;

-- 5 Hallar la comisión, nombre y salario de los empleados con más de tres hijos, clasificados por comisión y dentro de comisión por orden alfabético.

select empleados.comisem as Comisión, empleados.nomem as Nombre, empleados.salarem
from empleados 
where empleados.numhiem > 3
order by Comisión asc, Nombre asc;



-- 6 Hallar por orden de número de empleado, el nombre y salario total (salario más comisión) de los empleados cuyo salario total supere las 300.000 u.m. mensuales.

select empleados.nomem as Nombre, empleados.salarem + ifnull(empleados.comisem,0) as Salario_Total
from empleados
where empleados.salarem + ifnull(empleados.comisem,0) > 300000
order by empleados.numem asc;

-- 7 Obtener los números de los departamentos en los que haya algún empleado cuya comisión supere al 20% de su salario.

select departamentos.numde as Número
from departamentos join empleados
					on departamentos.numde = empleados.numde
where ifnull(empleados.comisem,0) > 0.20*salarem;

-- 8 Hallar por orden alfabético los nombres de los empleados tales que si se les da una gratificación de 100 u.m. 
-- por hijo el total de esta gratificación no supere a la décima parte del salario.

select empleados.nomem     
from empleados
where empleados.numhiem*100 <= empleados.salarem/10;   

-- 9 Llamaremos presupuesto medio mensual de un depto. al resultado de dividir su presupuesto anual por 12. 
-- Supongamos que se decide aumentar los presupuestos medios de todos los deptos en un 10% a partir del mes de octubre inclusive. 
-- Para los deptos. cuyo presupuesto mensual anterior a octubre es de más de 500.000 u.m. Hallar por orden alfabético el nombre de departamento 
-- y su presupuesto anual total después del incremento.

select departamentos.nomde as Nombre, (presude/12*9) + (presude/12*3*1.1) as Total
from departamentos
where departamentos.presude/12*9 > 500000
order by Nombre asc;

-- 10 Suponiendo que en los próximos tres años el coste de vida va a aumentar 
-- un 6% anual y que se suben los salarios en la misma proporción. 
-- Hallar para los empleados con más de cuatro hijos, su nombre y sueldo anual, 
-- actual y para cada uno de los próximos tres años, clasificados por orden alfabético.

select empleados.nomem as Nombre, empleados.salarem as Salario_Total, (empleados.salarem*1.06) as salario1A,  (empleados.salarem*1.06*1.06) as Salario2A, (empleados.salarem*1.06*1.06*1.06) as Salario3A
from empleados 
where empleados.numhiem > 4
order by Nombre;

-- Ejercicio de la Relación 5
USE `bdalmacen`;

-- 1 Obtener todos los productos que comiencen por una letra determinada.


select *
from productos
where lower(productos.descripcion) regexp '^a';

-- 2 Se ha diseñado un sistema para que los proveedores puedan 
-- acceder a ciertos datos, la contraseña que se les da es el 
-- teléfono de la empresa al revés. Se pide elaborar un procedimiento 
-- almacenado que dado un proveedor obtenga su contraseña y la muestre en los resultados.

drop procedure if exists ejer_2;
delimiter $$
create procedure ejer_2(proveedor int, 
						out contraseña char(9))

begin 
	select reverse(proveedores.telefono) into contraseña
    from proveedores
    where proveedores.codproveedor = proveedor;
end $$
delimiter ; 

call ejer_2(2);

-- 3 Obtener el mes previsto de entrega para los pedidos que no se han recibido aún y para una categoría determinada.

select month(date_add(pedidos.fecpedido, interval 30 day))
from pedidos join productos
		on pedidos.codproducto = productos.codproducto join categorias
			on productos.codcategoria = categorias.codcategoria	
where categorias.codcategoria = 1 and
pedidos.fecentrega is null or pedidos.fecentrega >= curdate() ;
		
-- 4 Obtener un listado con todos los productos, ordenados por categoría, en el que se muestre solo las tres primeras letras de la categoría.

select left(productos.descripcion, 3) as Productos
from productos join categorias
	on productos.codcategoria = categorias.codcategoria	
order by categorias.codcategoria;


-- 5 Obtener el cuadrado y el cubo de los precios de los productos.

select pow(productos.preciounidad,2) as Cuadrado, pow(productos.preciounidad,3) as Cubo
from productos;

-- 6 Devuelve la fecha del mes actual.

select date_format(curdate(), '%Y-%m-%d') as Fecha_Actual;


-- 7 Para los pedidos entregados el mismo mes que el actual, obtener cuantos días hace que se entregaron.

select pedidos.fecentrega, datediff(curdate(),pedidos.fecentrega), datediff(pedidos.fecentrega, curdate())
from pedidos 
where month(pedidos.fecentrega) = month(curdate()) and year(pedidos.fecentrega) = year(curdate());

-- 8 En el nombre de los productos, sustituir “tarta” por “pastel”.

update productos
set descripcion = replace (descripcion, 'Tarta', 'pastel');
-- where descripcion like ('%Tarta%');

-- 9 Obtener la población del código postal de los proveedores 
-- (los primeros dos caracteres se refieren a la provincia y los tres últimos a la población).

select right(proveedores.codpostal, 3) as Poblacion, substring(proveedores.codpostal,3,3) as Poblacion -- Dos formas de hacerlo
from proveedores;

-- 10 Obtén el número de productos de cada categoría, haz que el nombre de la categoría se muestre en mayúsculas.

select upper(categorias.Nomcategoria) as Nombre, count(*) as Núm_Productos
from productos join categorias 
	on categorias.codcategoria = productos.codcategoria
group by Nombre;

-- 11 Obtén un listado de productos por categoría y dentro de cada categoría del nombre de producto más corto al más largo.

select categorias.Nomcategoria, productos.descripcion
from productos join categorias 
	on categorias.codcategoria = productos.codcategoria
order by Nomcategoria, length(productos.descripcion);

-- 12 Asegúrate de que los nombres de los productos no tengan espacios en blanco al principio o al final de dicho nombre.

select trim(productos.descripcion)
from productos;

-- 13 Lo mismo que en el ejercicio 2, pero ahora, además, 
-- sustituye el 4 y 5 número del resultado por las 2 últimas letras del nombre de la empresa.

select telefono, reverse(telefono),
	   substring(reverse(telefono), 4,2),
		right(nomempresa,2),
		replace(reverse(telefono),
				substring(reverse(telefono), 4,2),
				right(nomempresa,2))
from proveedores;

-- 14 Obtén el 10 por ciento del precio de los productos redondeados a dos decimales.

select round(productos.preciounidad*1.01,2)
from productos;

-- 15 Muestra un listado de productos en que aparezca el nombre del producto y 
-- el código de producto y el de categoría repetidos 
-- (por ejemplo para la tarta de azucar se mostrará “623623”).

select descripcion, convert(repeat(concat(codproducto, codcategoria),2),char(12)) as Resultado
from productos;

/*select descripcion, convert(repeat(concat(codproducto, codcategoria),2), char(12)) as resultado,
	repeat(concat(codproducto, codcategoria),2) as SinFormato
from productos;*/

-- Ejercicio de la Relación 6

-- 1 
/*
Para la base de datos “empresa_clase” obtener, dado el código de un empleado, la contraseña de acceso formada por:
Inicial del nombre + 10 caracteres.
Tres primeras letras del primer apellido + 5 caracteres.
Tres primeras letras del segundo apellido (o “LMN” en caso de no tener 2º apellido) + 5 caracteres.
El último dígito del dni (sin la letra).
*/

drop procedure if exists ejer_6_1;
delimiter $$
create procedure ejer_6_1(cod int)

begin
	select reverse(concat(ascii(left(empleados.nomem,1)+10),
				ascii(left(empleados.nomem,3)+5),
					ascii(left(empleados.nomem,3)+5)))
	from empleados
    where numem = cod;
end $$
delimiter ;

-- call ejer_6_1(2);

-- 2 Para la base de datos “BDAlmacen” obtener por separado el nombre, 
-- el primer apellido y el segundo apellido de los proveedores.

select substring_index2(nomem, '',   )

-- 3 Obtener un procedimiento que obtenga el salario de los empleados incrementado en un 5%. 
-- El formato de salida del salario incrementado debe ser con dos decimales.

drop procedure if exists ejer_6_3;
delimiter $$
create procedure ejer_6_3()

begin
	select round(empleados.salarem*1.05,2)
    from empleados;
end $$
delimiter ;

call ejer_6_3();

-- 4 Prepara una función que determine si un valor que se pasa como parámetro es una fecha correcta o no.

drop function if exists ejer_6_4;
delimiter $$
create function ejer_6_4(fecha char(15))
returns date 
deterministic

begin
	declare resultado bit;
	if str_to_date(fecha,'%Y-%m-%d') is null then
		set resultado = 'falso';
	else 
		set resultado = 'verdadero';
	end if;
    return resultado;
end $$
delimiter ;

select ejer_6_4('2023-05-17');

-- 5 Para la base de datos “Empresa_clase” prepara un procedimiento que devuelva la edad de un empleado.

drop procedure if exists ejer_6_5;
delimiter $$
create procedure ejer_6_5(codEmp int,
							out edad int)

begin
	select timestampdiff(year,curdate(),empleados.fecnaem) into edad -- Te devulve la diff de años
    from empleados
    where numem = codEmp;
end $$
delimiter ;

call ejer_6_5(110, @edad);
select @edad;

-- 6 Para la base de datos “EMPRESA_CLASE” obtener el día que termina el periodo de prueba de un empleado, 
-- dado su código de empleado. El periodo de prueba será de 3 meses.

drop procedure if exists ejer_6_6;
delimiter $$
create procedure ejer_6_6(cod int)

begin
	select date_add(ifnull(fecinem, curdate()), interval 3 month) as Periodo
    from empleados
    where numem = cod;
end $$
delimiter ;

call ejer_6_6(110);

-- 7 Nuestro sistema MS Sql Server tiene como primer día de la semana el domingo. 
-- Cámbialo al lunes. Obtén el nombre del primer día de la semana del sistema.

drop function if exists ejer_6_7;
delimiter $$
create function ejer_6_7(fecha date)
returns int
deterministic

begin 
	declare resultado int;
	set resultado = if(dayofweek(fecha)=1, 7,dayofweek(fecha)-1);
    return resultado;
end $$
delimiter ;

select ejer_6_7('2020/3/22');

-- 8
/*
Obtener el nombre completo de los empleados y la fecha de nacimiento con los siguientes formatos:
“05/03/1978”
5/3/1978
5/3/78
05-03-78
05 Mar 1978
*/

select date_format(curdate(),'"%d/%m/%Y"');
select date_format(curdate(),'%e/%c/%Y');
select date_format(curdate(),'%d/%m/%y');
select date_format(curdate(),'%d-%m-%Y');
select date_format(curdate(), '%e de %M de %Y');
select date_format(curdate(), '%W, %2 de %M de %Y');

-- Ejercicios Relacion 7

/** ejer 1 */

/*
Hallar el salario medio para cada grupo de empleados con igual comisión y para los que no
la tengan, pero solo nos interesan aquellos grupos de comisión en los que haya más de un
empleado.
*/

select ifnull(comisem,0), avg(salarem)
from empleados
group by ifnull(comisem,0)
having count(*) >1;


/* ejer 2 **/
/*
Para cada extensión telefónica, hallar cuantos empleados la usan y el salario medio de éstos.
Solo nos interesan aquellos grupos en los que hay entre 1 y 3 empleados.
*/
select extelem, count(*), avg(salarem)
from empleados
group by extelem
having count(*) between 1 and 3;
/* ejerc 3 al 6 */

select nomcat
from categorias join articulos 
		on categorias.codcat = articulos.codcat
		join catalogospromos 
			on articulos.refart = catalogospromos.refart
where catalogospromos.codpromo = 1
group by nomcat
having count(*) > 1;


/*
Prepara un procedimiento que, dado un precio, 
obtenga un listado con el nombre de las
categorías en las que el precio medio de sus 
productos supera a dicho precio
*/

select nomcat, avg(precioventa)
from categorias join articulos 
		on categorias.codcat = articulos.codcat
group by nomcat
having avg(precioventa) > 3;

/*
Prepara un procedimiento que muestre el importe 
total de las ventas por meses de un año
dado
*/

select sum(precioventa)
from ventas join detalleVenta 
	on ventas.codventa = detalleVenta.codventa
where year(fecventa) = parametro -- year(curdate)
group by month(fecventa)


/* ejer 6 añadimos: */
having sum(precioventa) > (select avg(precioventa)
							from ventas join detalleVenta 
								on ventas.codventa = detalleVenta.codventa
									where year(fecventa) = parametro; -- year(curdate)

-- Examen Tema 7 

USE `GBDgestionaTests`;

-- P1 Queremos saber el código de test y la materia a la que pertenece (su nombre) 
-- de aquellos tests en los que la diferencia entre la fecha de creación y publicación 
-- es de 3 meses o más. Ten en cuenta que puede que haya tests no pulicados aún, 
-- estos también deben ser tenidos en cuenta.

select tests.codtest as CodTest, materias.nommateria
from tests join materias 
	on tests.codmateria = materias.codmateria
where date_add(tests.feccreacion, interval 3 month) < ifnull(tests.fecpublic, curdate());  

-- P2 Queremos asignar al alumnado una cuenta de email del
-- dominio del centro (“micentro.es”). El nombre de usuario estará formado por: 
-- la primera y la última letra de su nombre, 
-- las 3 letras centrales de su primer apellido y su mes de nacimiento. 
-- Prepara una función que, dado el número de expediente de un alumno/a, 
-- nos devuelva su nombre de usuario.

drop function if exists ejer_p2;
delimiter $$
create function ejer_p2(numero int)
returns varchar(100)
deterministic

begin
	declare cuenta varchar(100);
	select concat(left(nomalum,1), 
				 	right(nomalum,1),
						substring(ape1alum, (length(ape1alum) div 2), 3), 
							month(fecnacim)) into cuenta
	from alumnos
    where numexped = numero;
    return concat(cuenta,'@micentro.es');
end $$
delimiter ;

select ejer_p2(2);

-- P3 dado el número de expediente de un alumno o alumna, 
-- obtener el número de respuestas acertadas en cada test 
-- y cada repetición. Queremos descartar aquellos tests y o 
-- repeticiones en los que el alumno haya contestado  
-- menos de 4 preguntas acertadamente.

drop procedure if exists ejer_p3;
delimiter $$
create procedure ejer_p3(exp int)

begin
	select count(*), respuestas.codtest, numrepeticion
    from alumnos join respuestas
		on alumnos.numexped = respuestas.numexped join preguntas
			on respuestas.numpreg = preguntas.numpreg
	where respuestas.numexped = exp 
			and respuestas.respuesta = preguntas.resvalida
	group by respuestas.codtest, respuestas.numrepeticion
	having count(*) >= 4;
end $$
delimiter ;

call ejer_p3(3);

-- P4 Obtén un listado en el que se muestre para cada materia 
-- (su nombre y curso) el número de tests que han realizado más de 2 alumnos o alumnas.

select materias.nommateria, materias.cursomateria, respuestas.codtest, respuestas.numexped -- , count(distinct respuestas.codtest)
from materias join tests on materias.codmateria = tests.codmateria
	join respuestas on tests. codtest = respuestas.codtest
group by materias.nommateria
having count(distinct respuestas.numexped) > 2;

-- P5 Hemos detectado errores en el sistema de selección de tests a alumnos/as y se han dado casos de alumnos/as 
-- que han resuelto tests de materias de las que no están matriculados. 
-- Prepara un procedimiento que nos de un listado con estos alumnos/as. 
-- Queremos que se muestre su número de expediente y su nombre completo (en una sola columna).

select numexped, codtest, codmateria
from respuestas join tests on respuestas.codtest = tests.codtest
    join materias on tests.codmateria = materias.codmateria;
/* por tanto: */    
select alumnos.numexped, concat_ws(nomalum,ape1alum, ape2alum)
from alumnos join respuestas on alumnos.numexped = respuestas.numexped
    join tests on respuestas.codtest = tests.codtest
    join materias on tests.codmateria = materias.codmateria
where materias.codmateria not in
    (select codmateria
     from matriculas
     where matriculas.numexped = alumnos.numexped);

-- P6 Prepara una vista que nos sirva de catálogo de tests y preguntas y en el que no se muestren 
-- los nombres reales de las columnas. Los datos que queremos que se muestren son: el código y nombre 
-- de la materia, el código y la descripción del test, la respuesta valida (el texto de la respuesta válida),  
-- el número de preguntas que tiene dicho test y si se puede repetir 
-- (debe mostrarse el texto ‘repetible’ o ‘no repetible’). (Pista.- Flow control function).

drop view if exists catalogoTests;
create view catalogoTests
	(codMateria, NombreMateria, codTest, descripTest, respuestaValida, repetible, numPreguntas)
AS
	select materias.codmateria, materias.nommateria,
		tests.codtest, tests.descrip, 
        if(resvalida='a',resa, if(resvalida ='b',resb,resc)),
        if(repetible > 0,'repetible','no repetible'), count(*)
    from materias join tests on materias.codmateria = tests.codmateria
		join preguntas on tests.codtest = preguntas.codtest
	
	group by materias.codmateria, tests.codtest;

select * from catalogoTests;

-- P7
/*
Prepara una función que, dado un alumno/a y una materia, nos devuelva la nota de dicho alumno/a en dicha materia. 
La nota se calculará obteniendo la media entre el número de respuestas correctas y el num. de preguntas de cada test 
de la materia. Solo se utilizarán los tests no repetibles (estos tendrán en el campo repetible de la tabla 
tests el valor 1, indicando así que solo se puede hacer una vez). 
Los alumnos que no hayan hecho alguno de los tests no repetibles de la materia, 
obtendrán una puntuación de cero en dicho test y esta nota entrará en la media..
*/

drop function if exists obtenNota;
delimiter $$
create function obtenNota
	(numeroExpediente int, codMateria int)
returns decimal(4,2)
deterministic
begin
	declare nota decimal(4,2);
	select count(*)/count(distinct respuestas.codtest) into nota
    from respuestas join preguntas on respuestas.codtest = preguntas.codtest and respuestas.numpreg = preguntas.numpreg
		join tests on tests.codtest = preguntas.codtest
    where numexped = numeroExpediente and tests.codmateria = codMateria
		and tests.repetible = 0 and respuestas.respuesta = preguntas.resvalida;
 
    return nota;
end $$
delimiter ;
select obtenNota(1,1);









