USE `bdalmacen`;

-- 1

drop function if exists ejer_5_1;
delimiter $$
create function ejer_5_1(letra char(1))
returns char(1)
deterministic 
begin
	return (select *
	from productos 
	where descripcion like concat(letra,'%'));
end $$
delimiter ;

-- 2

drop function if exists ejer_5_2;
delimiter $$
create function ejer_5_2(numero int)
returns char(9)
deterministic

begin
	return (select proveedores.nomcontacto as 'Nombre Proveedor', concat(reverse(proveedores.telefono)) as Telefono
	from proveedores
    where proveedores.codproveedor = numero);
end $$
delimiter ;

-- select  ejer_5_2(3) as 'Contraseña Empleado';

-- 3

drop function if exists ejer_5_3;
delimiter $$
create function ejer_5_3(fec1 date, fec2 date)
returns date 
deterministic 

begin 
	return (select month(pedidos.fecentrega), categorias.codcategoria
    from pedidos join productos 
					on pedidos.codproducto = productos.codproducto join categorias
								on productos.descripcion = categorias.descripcion
    where pedidos.fecentrega between fec1 and fec2);
end $$
delimiter ;


select *
from pedidos;

-- 4

select left(productos.descripcion,3) as categorias
from productos join categorias
			on productos.descripcion = categorias.descripcion
order by categorias.codcategoria;

-- 5

select productos.codproducto, pow(preciounidad,2) as Cuadrado, pow(preciounidad,3) as Cubo
from productos;

-- 6

select datediff(now(), pedidos.fecentrega)
from pedidos;

-- 7

select replace(productos.descripcion,'tarta','pastel') as DescripcionProductos
from productos;

-- 8

drop function if exists ejer_5_8;
delimiter $$
create function ejer_5_8()
returns char(3) 
deterministic

begin 
	return (select substring(proveedores.codpostal,3) as Poblacion 
			from proveedores);
end $$
delimiter ;

-- 9

select count(*) as 'NúmeroCategoria', upper(categorias.Nomcategoria) as Nombre
from categorias
group by Nombre;

-- 10

select categorias.codcategoria, substring(categorias.Nomcategoria, 1, 10) as NombreCorto, substring(categorias.Nomcategoria, 1, 20) as NombreLargo
from categorias
order by length(NombreCorto), length(NombreLargo);

-- 11

select trim(categorias.Nomcategoria) as Nombre 
from categorias;

-- 12

-- 13

select round(productos.preciounidad*0.1,2) as 'precio unidad redondeado al 2'
from productos;

-- 14

select productos.descripcion, concat(productos.codproducto, productos.codcategoria)
from productos;