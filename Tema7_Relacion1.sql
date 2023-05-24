USE `empresaclase`;

-- 1

drop procedure if exists ejer_1;
delimiter $$
create procedure ejer_1(out anio date)

begin
	set  anio = year(current_date);
end $$
delimiter ;
call ejer_1(@anio);
-- select @anio;

-- 2

drop function if exists ejer_2;
delimiter $$
create function ejer_2()
returns date
deterministic

begin
	return year(current_date);
end $$
delimiter ;

-- 3 

drop procedure if exists ejer_3;
delimiter $$
create procedure ejer_3(in cadena varchar(50))

begin
	select upper(left(cadena,3));
end $$
delimiter ;

-- 4

drop procedure if exists ejer_4;
delimiter $$
create procedure ejer_4(in cadena1 varchar(60),
						in cadena2 varchar (60),
                        in cadena3 varchar (120))

begin 
	set cadena3 = upper(concat(cadena1,cadena2));
end $$
delimiter ; 

-- 5
 
drop function if exists ejer_5;
delimiter $$
create function ejer_5(a float, b float)
returns float
deterministic

begin
	declare c float;
    set c = sqrt(a*2 + b*2);
    return c;
end $$
delimiter ;

-- select ejer_5(3,4);

-- 6

drop function if exists ejer_6;
delimiter $$
create function ejer_6(n1 int, n2 int)
returns int 
deterministic

begin
	if n1 % n2 = 0 then
		return 1;
    else
		return 0;
	end if;
end $$
delimiter ;

select ejer_6(2, 2);

-- 7

drop function if exists ejer_7;
delimiter $$
create function ejer_7(dia int)
returns varchar(60)
deterministic

begin
	return case 
		when dia = 1 then '1: Lunes'
        when dia = 2 then '2: Martes'
        when dia = 3 then '3: Miercoles'
        when dia = 4 then '4: Jueves'
        when dia = 5 then '5: Viernes'
        when dia = 6 then '6: Sabado'
        when dia = 7 then '7: Domingo' 
        else 'Número inválido'
	end;
end $$
delimiter ;

-- select ejer_7(4);

-- 8

drop function if exists ejer_8;
delimiter $$
create function ejer_8(n1 int, n2 int, n3 int)
returns int
deterministic
 
 begin 
	declare mayor int;
    if n1 >= n2 and n1 >= n3 then
		set mayor = n1;
	elseif n2 >= n1 and n2 >= n3 then
		set mayor = n2;
	else 
		set mayor = n3;
	end if;
		return mayor;
 end $$
 delimiter ;
 
-- 9

drop function if exists ejer_9;
delimiter $$
create function ejer_9(palabra varchar(60))
returns varchar(60)
deterministic

begin
end $$
delimiter ;
-- select ejer_8(20,30,5);

-- RELACIÓN 2

-- 1

drop trigger if exists edad;
delimiter $$
create trigger edad
	before insert on empleados
for each row

begin 
	declare edad int;
    declare resultado varchar(60);
    set edad = 55;
	if new.edadUsuario <= edad then
		set resultado = concat('Entra en la edad');
    else
		signal sqlstate '45000' set message_text = 'Error';
	end if;
end $$
delimiter ;

/*
Crea un evento que, al comienzo de cada año, compruebe los empleados jubilados hace diez años o más 
y los elimine de la base de datos (haz una copia antes de ejecutar este apartado).
Deberá eliminar, también, los registros de la tabla dirigir asociados a estos empleados.
*/










