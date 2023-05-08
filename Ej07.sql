USE `empresaclase`;
USE `ventapromoscompleta`;

-- 1

select comisem as comision, avg(salarem) as salario
from empleados
group by comisem
having count(*) > 1 or comisem is null;

-- 2

select count(*) as numero, avg(salarem) as salario, extelem as numeroTelefono
from empleados
group by extelem
having numero between 1 and 3;

-- 3

drop procedure if exists ejer_7_3;
delimiter $$
create procedure ejer_7_3(codigo int)

begin
	select categorias.nomcat
    from categorias join 
    group by categorias
    
end $$
delimiter ;