 1.- Realiza una función que reciba como parámetro el DNI de un armador y nos devuelva el nombre del caladero donde han faenado más días en total sus barcos.X
 Debes controlar las siguientes excepciones: Armador Inexistente, Armador sin barcos, Armador sin capturas.

create or replace function barcosconmasdias (p_dni armadores.DNI%type)
returns VARCHAR as $$
declare
	c_selectprincipal
	cursor for
	select sum(TRUNC(FechaFin)-TRUNC(fechaInicio)) as dias, C.Nombre as nombrecaladero
	from FAENAS_BARCOS FB, CALADEROS C
	where matriculabarco IN (select matricula
							 					   from barcos
							 						 where dniarmador = p_dni)
  and FB.referenciacaladero = C.referencia
	group by c.nombre;
	v_selectprincipal caladeros.nombre%type;
	v_contador INTEGER:=0;
begin
select * from ArmadorInexistente(p_dni);
select * from ArmadorSinBarcos(p_dni);
select * from ArmadorSinCapturas(p_dni);
	for i in c_selectprincipal loop
		if i.dias>v_contador then
		  v_contador := i.dias;
			v_selectprincipal := i.nombrecaladero;
		end if;
	end loop;
	return v_selectprincipal;
end
$$ language plpgsql;

create or replace function ArmadorInexistente (p_dni armadores.dni%type)
returns varchar as $$
declare
	v_dni INTEGER:=0;
begin
select count (*) into v_dni
from ARMADORES
where DNI = p_dni;
	if v_dni = 0 THEN
		raise notice 'Ese armador no existe';
	end if;
end
$$ language plpgsql;

create or replace function armadorsinbarcos (p_dni armadores.dni%type)
returns varchar as $$
declare
	v_dni INTEGER:=0;
begin
select count (*) into v_dni
from barcos
where DNIarmador = p_dni;
	if v_dni = 0 THEN
		raise notice 'Ese armador no tiene barcos';
	end if;
end
$$ language plpgsql;

create or replace function ArmadorSinCapturas (p_dni armadores.dni%type)
returns varchar as $$
declare
	v_dni INTEGER:=0;
begin
select count (*) into v_dni
from capturas_diarias
where DNIarmador = p_dni;
	if v_dni = 0 THEN
		raise notice 'Ese armador no ha capturado nada';
	end if;
end
$$ language plpgsql;

3.- Realiza un trigger que garantice que no se insertan datos en la tabla CapturasDiarias si el barco no se encuentra faenando en dicho caladero en la fecha correspondiente.
CREATE TRIGGER BarcoNoFaenandoEnCaladero
before insert on capturas_diarias
for each row
execute procedure procedimientoej3();


create or replace function procedimientoej3() returns trigger as $$
declare
	v_contador INTEGER:=0;
begin
select count(referenciacaladero ) into v_contador
from faenas_barcos
where matriculabarco = new.matriculabarco
and (new.fechapescainicio between fechaInicio and fechafin) or (new.fechapescainicio > fechainicio and fechafin is NULL)
and new.referenciacaladero = referenciacaladero;
	if v_contador = 0 then
		raise notice 'Ese barco no se encuentra faenando en ese caladero en esa fecha';
	end if;
end
$$ language plpgsql;
