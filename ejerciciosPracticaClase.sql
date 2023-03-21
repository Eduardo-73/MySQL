-- CUANTOS EMPLEADOS HAY


select count(*), count(numem), count(distinct numde) -- count cuenta celdas
from empleados;

-- CUANTO ME CUESTA AL MES PAGAR A MIS EMPELADOS 
select sum(salarem)
from empleados;

-- CUAL ES EL SALARIO MÁXIMO
select max(salarem)
from empleados;

-- CUAL ES EL SALARIO MINIMO 
select min(salarem)
from empleados;

-- CUAL ES LA MEDIA
select avg(salarem)
from empleados;

select count(*) as numEmpelados, sum(salarem) as totalSalar, max(salarem) as salarMax, 
	min(salarem) as salarMin, avg(salarem) as salarMedio
from empleados;


-- una rutina que devuelva el número de extensiones telefónicas de una departamento dado

delimiter $$

	drop function if exists numExtensiones;
    create function numExtensiones(
					numdepto(11))
return int
deterministic
begin 
	
return (select count(distinct extelem)
		from empleados
		where numde = numdepto);
end $$

delimiter ;

select nomde, numExtensiones(numde)
from departamentos
order by numde;


