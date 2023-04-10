USE `bdmuseo2021`;

-- 1

select *
from obras
where obras.codsala in (1,3);

-- 2  

select concat('', obras.nombreobra,'(',artistas.nomartista, ')') as 'Nombre obra y del autor', obras.codsala as 'Salas', ifnull(obras.valoracion, 0) as 'Valoraciones' 
from obras join artistas on obras.codartista = artistas.codartista
order by valoracion desc;

-- 3

drop procedure if exists ejercicio3;
delimiter $$
create procedure ejercicio3(in fechaIni date,
								in fechaFin date)
begin
	select obras.nombreobra as Nombre_Obra, concat_ws('',restaurador.nomres, restaurador.ape1res, ifnull(restaurador.ape1res, '')) as Nombre 
	from obras join restauraciones
									on obras.codobra = restauraciones.codobra join restaurador	
																							on restauraciones.codrestaurador = restaurador.codres
	where restauraciones.fecinirest <= fechaFin and restauraciones.fecinirest >= fechaIni;
end $$
delimiter ;

call ejercicio3('2019/01/01', '2019/12/31');

-- 4

drop procedure if exists ejercicio4;
delimiter $$ 
create procedure ejercicio4(in NombreObra varchar(60))
begin 
	select obras.nombreobra as NombreaObra, ifnull(artistas.nomartista, 'obra anonima') as NombreArt, obras.valoracion 
    from obras left join artistas
							on obras.codartista = artistas.codartista
	where trim(obras.nombreobra) = NombreObra;
end $$
delimiter ;
 
call ejercicio4('TÉ POR LA TARDE');

-- 5

drop procedure if exists ejercicio5;
delimiter $$
create procedure ejercicio5(in fechaIni date,
								in fechaFin date)
begin
	select obras.nombreobra as Nombre_Obra, artistas.nomartista as Nombre 
	from obras 
		join artistas on obras.codartista = artistas.codartista 
			join restauraciones on restauraciones.codobra = obras.codobra
	where restauraciones.fecinirest <= fechaFin and restauraciones.fecinirest >= fechaIni;
end $$
delimiter ;

call ejercicio5('2019/01/01', '2019/12/31');


-- 6

drop procedure if exists ejercicio6;
delimiter $$
create procedure ejercicio6()
begin 
	select obras.valoracion, obras.codsala, obras.nombreobra, salas.nomsala
    from obras left join salas
								on obras.codsala = salas.codsala
	order by salas.nomsala;
end $$
delimiter ;

call ejercicio6();