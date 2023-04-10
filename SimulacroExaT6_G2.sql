USE `GBDturRural2015`;

-- 1

select *
from reservas
where fecreserva between '2021/1/1' and '2021/3/30' and numdiasestancia >= 3;

-- 2

select reservas.codreserva as Codigo, 
		concat('',clientes.nomcli,clientes.ape1cli,clientes.ape2cli) as nombreCompleto,
			ifnull(devoluciones.importedevol,0) as Importe
from reservas join clientes
				on reservas.codcliente = clientes.codcli join devoluciones
					on reservas.codreserva = devoluciones.codreserva
where reservas.fecanulacion = '2021/1/1';
		
-- 3

delimiter $$
drop procedure if exists ej03;
create procedure ej03(
						in caracteristicas int)

begin 
	select casas.codcasa, casas.nomcasa, casas.poblacion, tiposcasa.nomtipo
    from casas join tiposcasa 
					on casas.codtipocasa = tiposcasa.numtipo join caracteristicasdecasas
						on casas.codcasa = caracteristicasdecasas.codcasa
	where caracteristicasdecasas.codcaracter = caracteristicas
    order by casas.poblacion, casas.m2 desc;
end $$
delimiter ;

-- call ej03(1);

-- 4

delimiter $$
drop procedure if exists ej04;
create procedure ej04(in codigoCasa int)

begin 
	 select nomcaracter 
     from caracteristicas join caracteristicasdecasas
			on caracteristicas.numcaracter = caracteristicasdecasas.codcaracter
     where caracteristicasdecasas.codcasa = codigoCasa and caracteristicasdecasas.tiene = 1;
end $$
delimiter ;

-- call ej04(1);

-- 6

delimiter $$
drop procedure if exists ej06;
create procedure ej06(in codigo int,
						out nombre varchar(60),
                        out tlf_correo varchar(70)
						)
begin
	select propietarios.nompropietario,
    concat_ws('//',propietarios.tlf_contacto, propietarios.correoelectronico) into nombre, tlf_correo
    from propietarios join casas 
		on propietarios.codpropietario = casas.codpropi join reservas
			on casas.codcasa = reservas.codcasa
	where reservas.codreserva = codigo;
end $$
delimiter ;

call ej06(1, @nombre, @tlf_correo);

select concat('El teléfono y correo del propietario ', @nombre,' son: ',
	ifnull(@tlf_correo,'el propietario no tiene teléfono/email')) as consulta;