USE `GBDturRural2015`;

-- 1

select * 
from casas
where minpersonas = 4 and maxpersonas = 6 and provincia = 'Sevilla';

-- 2

select  reservas.codreserva as numReserva, 
        concat_ws('',clientes.nomcli,clientes.ape1cli,clientes.ape2cli) as nombreCli,
        ifnull(devoluciones.importedevol, 0) as importes
from reservas join clientes 
					on reservas.codcliente = clientes.codcli join devoluciones
							on reservas.codreserva = devoluciones.codreserva
	where reservas.fecanulacion >= '2021/1/1';
