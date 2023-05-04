USE `GBDgestionaTests`;

-- 1º)

select tests.codtest as 'Número del Test', materias.nommateria as 'Nombre de la Materia'  
from materias join tests on
		materias.codmateria = tests.codmateria
where month(feccreacion) = 3 and month(fecpublic) = 3;

-- 2º)

drop function if exists ejer_Exa_2;
delimiter $$
create function ejer_Exa_2()
returns varchar(30)
deterministic 

begin 
	return (select concat(left(alumnos.nomalum,1), right(alumnos.nomalum,1),substring(alumnos.ape1alum,3,1),
																	substring(alumnos.ape1alum,4,1),
                                                                    substring(alumnos.ape1alum,5,1), month(fecnacim),'@micentro.es') as Email 
    from alumnos);
    
end $$
delimiter ;

-- 3º)

drop procedure if exists ejer_Exa_3;
delimiter $$
create procedure ejer_Exa_3(numero char(9))

begin
select preguntas.codtest, resvalida
from preguntas
where codtest = numero in (select resvalida
							from preguntas join respuestas
								on preguntas.numpreg = respuestas.numpreg
							where respuestas.numpreg = 4);
end $$
delimiter ;

call ejer_Exa_3(1);

-- 4º)

select materias.nommateria, materias.cursomateria, codtest as realizado
from materias join tests
	on materias.codmateria = tests.codmateria
having realizado >=2
order by codtest;
-- 5º)

drop procedure if exists ejer_Exa_5;
delimiter $$
create procedure ejer_Exa_5()

begin 
	select alumnos.numexped as NumeroExp, concat_ws('',nomalum,ape1alum,ape2alum) as NombreCompleto
    from alumnos join matriculas 
		on alumnos.numexped = matriculas.numexped join materias
			on matriculas.codmateria = materias.codmateria join tests
				on materias.codmateria = tests.codmateria
	where 
end $$
delimiter ;

-- 6º)

select materias.codmateria, materias.nommateria, tests.codtest, tests.descrip, preguntas.resvalida, preguntas.numpreg
from materias join tests 
	on materias.codmateria = tests.codmateria join preguntas
		on tests.codtest = preguntas.codtest;

-- 7º)