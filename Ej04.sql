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

-- 5

select comisem as Comision, concat_ws('',nomem,ape1em,ape2em) as nombreCompleto, salarem as Salario
from empleados
where numhiem >= 3
order by Comision and nombreCompleto;

-- 6

drop procedure if exists ejer_4_6;
delimiter $$
create procedure ejer_4_6()

begin 
	select numem as NumeroEmpleado, concat_ws('',nomem,ape1em,ape2em) as nombreCompleto, salarem + ifnull(comisem, 0) as Salario
    from empleados
    where salarem + ifnull(comisem, 0) > 300.000
    order by numem; 
end $$
delimiter ;

-- call ejer_4_6();

-- 7

select distinct departamentos.numde 
from departamentos join empleados 
								on departamentos.numde = empleados.numde
where ifnull(empleados.comisem,0) > 0.20*empleados.salarem;

-- 8

select concat_ws('',nomem,ape1em,ape2em) as nombreCompleto, numhiem
from empleados  
where numhiem > 0 and numhiem*100 <= salarem/10
order by nombreCompleto;

-- 9

drop procedure if exists ejer_4_9;
delimiter $$
create procedure ejer_4_9()

begin 
	select nomde, (presude/12*9) + (presude/12*3*1.1) as total
    from departamentos
    where presude/12*9 > 50000
    order by nomde;
end $$
delimiter ;

-- 10

select concat_ws('',nomem,ape1em,ape2em) as nombreCompleto, salarem*1.06 as Año1, salarem*1.06*1.06 as Año2, salarem*1.06*1.06*1.06 as Año3
from empleados 
where numhiem > 4
order by nombreCompleto;

-- 16












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
