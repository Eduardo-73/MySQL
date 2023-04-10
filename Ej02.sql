-- Ejercicios relaciones de datos 2

use empresaclase;

-- 3
select empleados.*, nomde
from empleados join departamentos
				on empleados.numde = departamentos.numde;

-- 4
drop procedure if exists ej04;
delimiter $$
create procedure ej04(
					in nombre varchar(60),
						out extelce int(9),
                        out nomcentro varchar(150))
begin 
select empleados.extelem, centros.nomce into extelce, nomcentro
from empleados join departamentos
				on empleados.numde = departamentos.numde
					join centros 
						on departamentos.numce = centros.numce
where concat(nomem, ' ', 
					ape1em, ' ',
							ifnull(ape2em, ' ')) = nombre;
end $$
delimiter ;

-- 5
select nomde, concat_ws(' ', nomem, ape1em, ape2em) as nombreCompleto
from empleados join departamentos 
					on empleados.numde = departamentos.numde
where departamentos.nomde = 'Finanzas' or departamentos.nomde = 'Personal'
order by nombreCompleto;

-- 6

select empleados.nomem, dirigir.fecinidir, dirigir.fecfindir
from empleados join dirigir
				on empleados.numem = dirigir.numempdirec
                join departamentos on dirigir.numdepto = departamentos.numde
where departamentos.numde = 'Personal' and 
		fecinidir <= curdate() and (fecfindir is null or fecfindir >= curdate());

-- 7

drop procedure if exists ej07;
delimiter $$
create procedure ej07()
begin 
	select departamentos.nomde , departamentos.presude
    from departamentos join centros
							on departamentos.numce = centros.numce
	where trim(centros.numce) = 'SEDE CENTRAL';				
end $$
delimiter ;
call ej07();

-- 8

drop procedure if exists ej08;
delimiter $$
create procedure ej08()

begin
	select centros.nomce
    from centros join departamentos
					on centros.numce = departamentos.numce
	where departamentos.presude between '100000' and '150000';
end $$
delimiter ;
call ej08();

-- 9

select distinct empleados.extelem
from empleados join departamentos
						on empleados.numde = departamentos.numde
where departamentos.nomde = 'Finanzas';

-- 10

drop procedure if exists ej10;
delimiter $$
create procedure ej10(
					in nombredepto varchar(60))
begin 
	select concat(nomem, ' ', 
					ape1em, ' ', 
						ifnull(ape2em, ' ')) as nombreCompleto
    from departamentos join dirigir 
					on departamentos.numde = dirigir.numdepto
                    join empleados
						on empleados.numem = dirigir.numempdirec
	where nomde = nombredepto and ifnull(dirigir.fecfindir, curdate()) >= curdate();
end $$
delimiter ;

call ej10('Finanzas');

-- 12

drop procedure if exists ej12;
delimiter $$
create procedure ej12(
					nombre varchar(60))

begin 
	select empleados.nomem
    from empleados join departamentos
						on empleados.numde = departamentos.numde
	where departamentos.nomde = nombre
    order by 1 desc;
end $$	
delimiter ;
