USE `empresaclase`;
USE `GBDturRural2015`;
/*
Sabiendo que los dos primeros dígitos del código postal se corresponden con la provincia y los 3 siguientes a la población dentro de esa provincia. 
--    Busca los clientes (todos sus datos) de las 20 primeras poblaciones de la provincia de Málaga (29001 a 29020). ¿?
*/

select *
from clientes
where codpostalcli rlike '^290[1-20]';