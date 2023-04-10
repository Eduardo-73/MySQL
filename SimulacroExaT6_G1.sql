USE `GBDturRural2015`;

-- 1

select *
from casas
where minpersonas = 4 and maxpersonas = 6 and provincia = 'Sevilla';

-- 2

select ifnull(devoluciones.importedevol, 0) as Numero_Importes, 
			reservas.codreserva as Numero_Reservas, 
				concat_ws('',clientes.nomcli,clientes.ape1cli,clientes.ape2cli) as NombreCompleto
from devoluciones join reservas
		on devoluciones.codreserva = reservas.codreserva join clientes
				on reservas.codcliente = clientes.codcli
where reservas.fecanulacion = '2020/5/14';
																			
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
    order by casas.poblacion, casas.preciobase desc;
end $$
delimiter ;

-- call ej03(1);

-- 4

delimiter $$
drop procedure if exists ej04;
create procedure ej04(
					in zona int)
begin 
	select casas.nomcasa, casas.poblacion
    from casas 
    where codzona = zona;
end $$
delimiter ;

-- call ej04(1);

-- 6

delimiter $$
drop procedure if exists ej06;
create procedure ej06(
						in codigo int,
						out extTlf char(9))
begin 
	select clientes.tlf_contacto into extTlf
    from clientes join reservas 
			on clientes.codcli = reservas.codcliente
	where reservas.codreserva = codigo;
end $$
delimiter ;

call ej06(1, @extTlf);

select concat('El número de télefono del cliente es: ', ifnull(@extTlf,'null')) as conuslta;