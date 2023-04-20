use empresaclase;
-- buscar el numempleados de cada depto,
-- pero no me interesan los deptos de menos de tres miembros
select numde, count(*) -- (5)
from empleados -- (1)
-- where count(*) >= 3 -- (2)
group by numde -- (3)
having count(*) >= 3; -- (4) 

-- buscar el numempleados de cada depto con salario mayor de 900
select numde, count(*) as numEmpleado
from empleados 
where salarem > 900
group by numde 
having count(*) >= 3
-- order by count(*) desc; -- (6)
-- order by 2 desc; -- (6)
order by numEmpleado desc; -- (6)

-- subselect

set @depto = (select numde 
			 from empleados 
			 where  numde = 120);
             
insert into empleados
				(numem, numde, nomem, ape1em, ......)
value
	(1999, @depto, 'pepe', 'del campo', ......):
    
insert into empleados
				(numem, numde, nomem, ape1em, ......)
value
	(1999,(select numde 
			 from empleados 
			 where  numde = 120)
	, 'pepe', 'del campo', ......);
             
             
create table centros_new
	(numce int primary key,
    nomce varchar(60));
    
insert into centros_new
	(numce, nomce)
(select numce, nomce
from centros);

select *
from centros_new;

update empleados 
set numde = (select numde
		from empleados
        where salarem = 1200)
where numem = 280; 
             
-- buscar los empleados que ganan más que todos los empleados del depto. 110

select numem, nomem, salarem
from empleados 
where salarem > all (select salarem
				from empleados
				where numde = 110);

select numem, nomem, salarem
from empleados 
where salarem > (select max(salarem)
				from empleados
				where numde = 110); 
/*
Primero van los OPERADORES LÓGICOS(<, >, <>, >=, <=)
Y luego las EXPRESIONES =>
SOME|ANY 
ALL
IN 
EXISTS
*/
             
-- buscar empleados que ganan lo mismo que alguno de los del departamento 110

select numem, nomem, salarem
from empleados 
where salarem > some (select salarem
					 from empleados)
	and numde <> 110; 
    
select numem, nomem, salarem
from empleados 
where salarem in (select salarem
					 from empleados)
	and numde <> 110; 

-- buscar empleados que ganen diferente a los del depto 110

select numem, nomem, salarem
from empleados 
where salarem not in (select salarem
					 from empleados);

select numem, nomem, salarem
from empleados 
where salarem <> all (select salarem
					 from empleados); 
             
             