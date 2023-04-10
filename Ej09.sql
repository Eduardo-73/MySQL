use empresaclase;

/*
1º) 
Queremos obtener un listado en el que se muestren los nombres de departamento y el número de empleados de cada uno. 
Ten en cuenta que algunos departamentos no tienen empleados, queremos que se muestren también estos departamentos sin empleados. 
En este caso, el número de empleados se mostrará como null.
2º)
Queremos averiguar si tenemos algún departamento sin dirección, para ello queremos mostrar el nombre de cada departamento y el nombre del director actual, 
para aquellos departamentos que en la actualidad no tengan director, queremos mostrar el nombre del departamento y el nombre de la dirección como null.
*/

-- 1

select departamentos.nomde, departamentos.numde, count(departamentos.numde), count(empleados.numde) as 'Número de empleados por departamentos'
from departamentos left join empleados
						on departamentos.numde = empleados.numde
group by departamentos.numde;

-- 2

select departamentos.nomde, departamentos.numde, empelados.nomem
from departamentos left join dirigir 
							on departamentos.numde = dirigir.numdepto
								left join empleado on dirigir.numemdirec = empleados.numem
where ifnull(dirigir.fecfindir, curdate()) >= curdate()
union  
select distinct departamentos.numde, departamentos.nomde, null
from departamentos left join dirigir 
							on departamentos.numde = dirigir.numdepto
                            left join empleados on dirigir.numemdirec = empleados.numem
where ifnull(dirigir.fecfindir,curdate()) < curdate() 
	and departamentos.numde not in (select numde
									from departamentos join dirigir on departamentos.numde = dirigir.numdepto
									where ifnull(dirigir.fecfindir,curdate()) >= curdate());
			
/*
3ª)
Queremos saber el código de las reservas hechas y anuladas este año, el código de casa reservada, 
la fecha de inicio de estancia y la duración de la misma. 
También queremos que se muestre el importe de la devolución en aquellas que hayan producido dicha devolución.
4º)
Queremos mostrar un listado de todas las casas de la zona 1 en el que se muestre el nombre de casa y 
el número de reservas que se han hecho para cada casa. Si una casa nunca se ha reservado, deberá aparecer en el listado.
5º)
Queremos elaborar un listado de casas en el que se muestre el nombre de zona y el nombre de la casa. 
Ten en cuenta que de algunas zonas no tenemos todavía ninguna casa en el sistema, queremos que se muestren estas zonas también. 
*/

use GBDturRural2015;

-- 3
select reservas.codreserva, reservas.codcasa, reservas.feciniestancia, 
						date_add(reservas.feciniestancia, interval reservas.numdiasestancia day),
                        reservas.numdiasestancia,
                        ifnull(devoluciones.importedevol, 0)
from reservas left join devoluciones
						on reservas.codreserva = devoluciones.codreserva
where year(reservas.fecreserva) = year(curdate()) and reservas.fecanulacion is not null;

-- 4

select casas.codcasa, casas.nomcasa, count(*), count(reservas.codreserva)
from reservas right join casas
					on reservas.codcasa = casas.codcasa
						join zonas on casas.codzona = zonas.numzona
where zonas.numzona = 1
group by casas.codcas;

-- 5

select zonas.nomzona, casas.nomcasa
from zonas left join casas 
							on zonas.numzona = casas.codzona
order by zonas.nomzona;