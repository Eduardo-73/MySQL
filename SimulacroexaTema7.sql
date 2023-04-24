USE `ventapromoscompleta`;

-- 1

select distinct clientes.nomcli, ventas.codventa 
from clientes join ventas on
			clientes.codcli = ventas.codcli
order by codventa asc;

-- 2

select articulos.refart, articulos.desart, concat('(',categorias.descat,')')
from articulos