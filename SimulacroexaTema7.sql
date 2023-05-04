USE `ventapromoscompleta`;

-- 1

select distinct clientes.codcli, clientes.nomcli as nombre, sum(precioventa) as Importe 
from clientes join ventas on
			clientes.codcli = ventas.codcli join detalleventa on
					ventas.codventa = detalleventa.codventa
group by codcli
order by Importe desc;

-- 2

select articulos.desart, concat(nomart, '(',categorias.descat,')') as detalles, date_format(ventas.fecventa,'%M - %Y, %e (%W)') as fecha
from articulos join categorias on
						articulos.codcat = categorias.codcat join detalleventa
							on articulos.refart = detalleventa.refart join ventas
								on detalleventa.codventa = ventas.codventa
order by categorias.descat;

-- 3

select avg(precioartpromo), promociones.despromo
from articulos join catalogospromos
	on articulos.refart = catalogospromos.refart join promociones
		on catalogospromos.codpromo = promociones.codpromo
where year(fecinipromo) = 2012
group by promociones.codpromo;

-- 4

drop procedure if exists ejer_Exa_4;
delimiter $$
create procedure ejer_Exa_4()

begin 
	select refart, nomart, codcat
    from articulos
    where refart not in (select refart
						from catalogospromos join promociones
							on catalogospromos.codpromo = promociones.codpromo
                        where year(fecinipromo) = year(curdate())
                        );
end $$
delimiter ;

-- 5

