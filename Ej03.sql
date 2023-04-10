use empresaclase;

-- 1
drop procedure if exists ej01;
delimiter $$
create procedure ej01()
begin 
	select max(salarem)
    from empleados;
end $$
delimiter ;
-- call ej01();

-- 2

drop function if exists ej02;
delimiter $$
create function ej02()
returns decimal(7,2)

begin
declare minsalario decimal(7,2);
	
    set minsalario = (select min(salarem)
					from empleados);
end $$
delimiter ;
-- call ej02();

-- 3

drop procedure if exists ej03;
delimiter $$
create procedure ej03()
begin 
	select avg(salarem)
	from empleados;
end $$
delimiter ;
-- call ej03();

-- 4
drop procedure if exists ej04;
delimiter $$
create procedure ej04(
						out maxSal decimal(7,2), 
                        out minSal decimal(7,2),
                        out avgSal decimal(7,2))

begin 
	select max(empleados.salarem), min(empleados.salarem), avg(empleados.salarem) into maxSal, minSal, avgSal
	from empleados join departamentos 
		on empleados.numde = departamentos.numde
	where departamentos.nomde = 'Organización';
end $$
delimiter ;

-- call ej04(@maxSal, @minSal, @avgSal);

-- 5
drop procedure if exists ej05;
delimiter $$
create procedure ej05(
						in cualquiera varchar(60),
						out maxSal decimal(7,2), 
                        out minSal decimal(7,2),
                        out avgSal decimal(7,2))
begin 
	select max(empleados.salarem), min(empleados.salarem), avg(empleados.salarem) into maxSal, minSal, avgSal
	from empleados join departamentos 
		on empleados.numde = departamentos.numde
	where departamentos.nomde = cualquiera;
end $$
delimiter ;
-- call ej05(@maxSal, @minSal, @avgSal);
-- call ej05('Organización', @maxSal, @minSal, @avgSal);

-- 6

drop procedure if exists ej06;
delimiter $$
create procedure ej06(
					total_salario decimal(7,2))
begin
	set total_salario = (select sum(empleados.salarem + ifnull(empleados.comisem, 0))
    from empleados);
end $$
delimiter ;

-- call ej06(@total_salario);

-- 7

drop function if exists ej07;
delimiter $$
create function ej07()
returns decimal(7,2)

begin 
	declare total_empresa decimal(7,2);
    set total_empresa = (select sum(departamentos.presude)
							from departamentos);
end $$
delimiter ;

-- 8

drop procedure if exists ej08;
delimiter $$
create procedure ej08()
begin 
	select max(salarem) as maxSal,
			min(salarem) as minSal,
				avg(salarem) as avgSa
	from empleados join departamentos
					on empleados.numde = departamentos.numde
	group by departamentos.nomde;
end $$
delimiter ;

call ej08();

-- 9

drop procedure if exists ej09;
delimiter $$
create procedure ej09()

begin 	
	select count(distinct empleados.extelem) as numerosEmpleados
    from empleados 
	order by extelem;
end $$
delimiter ;

-- call ej09();

-- 10

drop procedure if exists ej10;
delimiter $$
create procedure ej10(in numdepto int)
begin 
	select count(distinct empleados.extelem) as numeros
    from empleados
	where departamentos.numde = numdepto;
end $$
delimiter ;

call ej10(110);