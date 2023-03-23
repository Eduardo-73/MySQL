-- Ejercicio 1º Relaciones Base de Datos

use empresaclase;

-- 1 
/* seleciono todos los datos de la tabla empleado con el * */
select * from empleados;

-- 2
/*Seleccionar el número de tlf del empleado Juan López, también se puede hacer de la siguiente forma
where concat (empleados.nomem, ' ', empleados.ape1em) = Juan López; | where concat_ws(' ', empleados.nomem, empleados.ape1em) = 'Juan López';*/
select empleados.extelem  from empleados
where nomem = 'Juan' and ape1em = 'López';

-- 3
/*Utilizamos las expresiones como >< = >= <= para buscar el número de hijos del empleado y asi sacar su nombre completo*/
select empleados.nomem, empleados.ape1em, empleados.ape2em 
from empleados
where numhiem > 1;

-- 4
-- where ifnull(numhiem,0) not between 1 and 3; -- nos quedamos con todos los que el numhiem esté fuera del rango (1,3)
-- where ifnull(numhiem,0) <1 or numhiem >3;
select empleados.nomem, empleados.ape1em, empleados.ape2em from empleados
where numhiem between 1 and 3; 
/*CONCAT(nomem, ' ',ape1em, ' ',ape2em) as nomcompleto_concat_null_sin_tratar,
		CONCAT(nomem, ' ',
			  ape1em, ' ',
			 ifnull(ape2em,'')
			) as nomcompleto_concat_null_tratados, 
        concat_ws(' ', nomem, ape1em, ape2em) as nomcompleto_concat_ws*/
        
-- 5
/*para obtener los empleados en una sola columna*/
select concat(nomem, ' ', 
				ape1em, ' ',
                 ifnull(ape2em, ' ')) as nombrecompleto, comisem
from empleados
where ifnull(comisem,0) = 0;

-- 6
/*rtrim y ltrim quitan los espacios en blanco*/
select dirce from centros
where rtrim(ltrim (centros.nomce)) = 'Sede Central';

-- 7
-- El nombre de todos los departamentos que tenga un presupuesto de mayor de 6000€
select nomde from departamentos
where presude > 6000;

-- 8

select nomde 
from departamentos
where presude >= 6000; 
        
-- 9

select concat(nomem,' ',
				ape1em, ' ',
					ifnull(ape2em,' ')) as nombrecompleto, fecinem
	from empleados
		where fecinem <= '2022/3/21';
-- where fecinem <= date_sub(curdate(), interval 1 year);
-- where fecinem <= subdate(curdate(), interval 1 year);
-- where fecinem <= adddate(curdate(), interval -1 year);
-- where fecinem <= date_add(curdate(), interval -1 year);

-- 10

select concat(nomem,' ',
				ape1em, ' ',
					ifnull(ape2em,' ')) as nombrecompleto, fecinem
	from empleados
		where fecinem between date_sub(curdate(), interval 1 year) and date_sub(curdate(), interval 3 year);

-- 11

drop procedure if exists ej11_1;
delimiter $$
create procedure ej11_1()

begin 
	select * from empleados;
end $$
delimiter ;

drop procedure if exists ej11_5;
delimiter $$
create procedure ej11_5()
begin
	select concat(nomem, ' ', 
				ape1em, ' ',
                 ifnull(ape2em, ' ')) as nombrecompleto, comisem
	from empleados
	where ifnull(comisem,0) = 0;
end $$
delimiter ;

-- 12 

drop procedure if exists ej12;

delimiter $$
create procedure ej12(in nombre varchar(60),
								in apellido varchar(60))

begin
	select empleados.extelem  
	from empleados
	where nomem = nombre and ape1em = apellido;
end $$
delimiter ;

-- 13

drop procedure if exists ej13;
delimiter $$
create procedure ej13(
					in numHijosEmpleado int(11))
begin 
	
    select concat(nomem, ' ', 
					ape1em, ' ', 
						ifnull(ape2em, ' ')) as nombreCompleto
	from empleados
    where numhiem > numHijosEmpleados;
end $$
delimiter ;

-- 14

drop procedure if exists ej14;
delimiter $$
create procedure ej14(
					in nombre varchar(60))
begin 
	select dirce 
    from centros 
    where rtrim(ltrim(centros.nomce)) = nombre;
end $$
delimiter ;

-- 15

drop procedure if exists ej15;
delimiter $$
create procedure ej15(
						in cantidad decimal(10,2))
begin 
-- en el select no se pueden poner terminaciones como and o or, se separan los atributos cun una "," 
    select presude as presupuesto, nomde as nombreDepartamento
    from departamentos
    where presude > cantidad;-- cuando te pide comparar casi siempre la procedure tiene que se > que el atributo de clase
end $$
delimiter ;

-- 16

drop procedure if exists ej16;
delimiter $$
create procedure ej16(
					in cantidadmin decimal(10,2),
                    in cantidadmax decimal(10,2))
begin 
select nomde as NOMBRE_DEPARTAMENTO, presude as PRESUPUESTO
from departamento
where presude between canidadmin and cantidadmax;
end $$
delimiter ;

-- 17

drop procedure if exists ej17;
delimiter $$
create procedure ej17(
				fechaDada date)
begin 
select concat_ws(' ', nomem, ape1em, ape2em) as nombreCompleto
from empleados
where fecinem > fechaDada;
end $$
delimiter ;

-- 18

drop procedure if exists ej18;
delimiter $$
create procedure ej18(
					fecha1 date,
                     fecha2 date) 
begin 
select concat(nomem, ' ', 
				ape1em, ' ', 
					ifnull(ape2em, ' ')) as nombreCompleto
from empleados
where fecinem >= fecha1 and fecinem <= fecha2;
end $$
delimiter ;

-- 19

drop procedure if exists ej19;
delimiter $$
create procedure ej19(
					fecha1 date,
                     fecha2 date)
begin 
select concat(nomem, ' ', 
				ape1em, ' ', 
					ifnull(ape2em, ' ')) as nombreCompleto
from empleados
where fecinem not between fecha1 and fecha2
-- para ordenar mediante algo se utiliza el order by
order by fecinem;
end $$
delimiter ;