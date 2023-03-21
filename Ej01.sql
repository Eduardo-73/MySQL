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
select empleados.nomem, empleados.ape1em, empleados.ape2em from empleados
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
