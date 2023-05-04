select *
from empleados
where dniem regexp '[a-z]$'; -- que terminen por 

select *
from empelados 
-- where dniem regexp '[^a-z]$'; -- que no terminen por un caracter comprendido entre la a y z
where dniem regexp '[a-z]$'; -- que terminen por un caracter comprendido entre la a y la z

select * 
from empleados 
where dinem regexp '^[XY]'; -- que empiezan por X e Y

select * 
from empleados 
where dinem regexp '^[^XY]'; -- que no empiezan por X e Y

select * 
from empleados 
where dinem regexp '^[^X-Y]'; -- que no empiezan por el rango entre X e Y

select * 
from empleados 
where dinem regexp '[^X-Y]'; -- que contengan una cadena que no empieze por X e Y

select * 
from centros
where dirce regexp 'atocha'; -- que contengan la cadena


select * 
from empleados 
where nomem regexp '^[aeiou][ln]'; -- que empiecen por una vocal y que depués tenga una l o n


select * 
from empleados 
where nomem regexp '^[aeiou].*a$'; -- que empiecen por una vocal, que tengan cualquier carácter 0,1 o más y termine en a
-- where nomem regexp '^[aeiou]*a$'; -- no muestra aquellas que empiecen por una vocal y termine en a ??? No sabe por que es 

select * 
from empleados 
where nomem regexp '^[aeiou]{2}'; -- que empiecen por 2 vocales

select * 
from empleados 
where nomem regexp 'b*'; -- que contengan 0 o 1 o más de una b

SELECT *
FROM empleados
WHERE nomem REGEXP '^b*'; -- que empieze y contengan 0 o 1 o más de una b

select * 
from empleados 
where nomem regexp 'b+'; -- que contengan 1 o más de una b

select * 
from empleados 
where nomem regexp 'b?'; -- que contengan 0 o 1 b

select * 
from empleados 
where nomem regexp '^j.*b+'; -- que empiecen por j, que tengan cualquier caracter desde 0 y que contenga 1 o mas de una b

select * 
from empleados 
where dniem regexp '(a|b|c)'; -- que contengan a o b o c

select * 
from empleados 
where nomem regexp '^(au)'; -- empiecen por au

select * 
from empleados 
where nomem regexp '^a|^e'; -- que empiecen por a o e
















