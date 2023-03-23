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