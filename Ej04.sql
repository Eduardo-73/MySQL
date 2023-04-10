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
 