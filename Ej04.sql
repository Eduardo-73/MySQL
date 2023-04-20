USE empresaclase;

-- 1

select empleados.nomem, empleados.salarem
from empleados
where empleados.numhiem > 3
order by empleados.nomem;

-- 2

select ifnull(empleados.comisem, 0), empleados.numde, empleados.nomem
from empleados join departamentos
								on empleados.numde = departamentos.numde
where empleados.salarem <= 19000.00
order by departamentos.numde asc, empleados.comisem desc;

-- 3

select departamentos.nomde 
from departamentos join dirigir 
								on departamentos.numde = dirigir.numdepto
where dirigir.tipodir between 'funciones' and 'propiedad'
order by departamentos.nomde;

-- 4

select empleados.nomem, empleados.numem, empleados.extelem
from empleados join departamentos
								on empleados.numde = departamentos.numde
where departamentos.numde = 121
order by departamentos.numde;

-- 26 

select numem
from empleados
where salarem >= (select avg(salarem)
					from empleados as e
					where e.numde = empleados.numde);

set @autocommit = 0;
update empleados
set salarem = salarem*1.1
where empleados.salarem >= (select avg(e.salarem)
					from empleados as e
					where e.numde = empleados.numde);

-- start transaction;
set @nuevocentro = (select max(numce)+1 from centros);

insert into centros 
	(numce, nomce, dirce)
values
	(@nuevocentro, 'prueba', 'dirce');
-- commit;        

start transaction;
create temporary table if not exists temp
	(numde int,
    media decimal(12,2));

insert into temp
	(numde,media)

select numde, round(avg(empleados.salarem),2) as media
from empleados
group by numde;

delete from empleados
where empleados.salarem >= (select avg(e.salarem)
					from empleados as e
					where e.numde = empleados.numde);
                    
-- 27
 
select numem 
from empleados 
where salarem > 0.50*(select max(salarem)
				from empleados as e
                where e.numde = empleados.numde);
                
update empleados 
set salarem = salarem*0.95
where salario > 0.50*(select max(salarem)
					from empleados as e
					where e.numde = empleados.numde);
            
USE `GBDturRural2015`;

-- 40

drop procedure if exists ejer_4_40;
delimiter $$
create procedure ejer_4_40(
							numero int,
                            fec1 date,
                            fec2 date)
begin 
	select casas.codcasa, casas.nomcasa
	from casas 
	where casas.codcasa not in 
								(select codcasa
								from reservas
								where fecanulacion is null and ((feciniestancia between fec1 and fec2)or
										(date_add(feciniestancia, interval numdiasestancia day) between fec1 and fec2)))
			and codzona = numero;
end $$
delimiter ;

call ejer_4_40(1,'2012/3/22','2012/3/30');
