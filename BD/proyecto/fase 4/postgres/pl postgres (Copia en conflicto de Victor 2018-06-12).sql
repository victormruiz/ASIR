 1.- Realiza una función que reciba como parámetro el DNI de un armador y nos devuelva el nombre del caladero donde han faenado más días en total sus barcos.X
 Debes controlar las siguientes excepciones: Armador Inexistente, Armador sin barcos, Armador sin capturas.

create or replace function barcosconmasdias (p_dni armadores.DNI%type)
return VARCHAR2
is
	cursor selectprincipal
	is
	select sum(FechaFin-fechaInicio) as dias, C.Nombre as nombrecaladero
	from FAENAS_BARCOS FB, CALADEROS C
	where matriculabarco IN (select matricula
							 					   from barcos
							 						 where dniarmador = p_dni)
  and FB.referenciacaladero = C.referencia
	group by c.nombre;
	v_selectprincipal caladeros.nombre%type;
	v_contador NUMBER:=0;
begin
ArmadorInexistente(p_dni);
ArmadorSinBarcos(p_dni);
ArmadorSinCapturas(p_dni);
	for i in selectprincipal loop
		if i.dias>v_contador then
		  v_contador := i.dias;
			v_selectprincipal := i.nombrecaladero;
		end if;
	end loop;
	return v_selectprincipal;
end;
/

create or replace function ArmadorInexistente (p_dni armadores.dni%type)
is
	v_dni NUMBER:=0;
begin
select count(*) into v_dni
from ARMADORES
where DNI = p_dni;
	if (v_dni = 0) THEN
		RAISE unique_violation USING MESSAGE = 'Ese armador no existe';
	end if
end;

create or replace procedure armadorsinbarcos (p_dni armadores.dni%type)
is
	v_dni NUMBER:=0;
begin
select count (*) into v_dni
from barcos
where DNIarmador = p_dni;
	if v_dni = 0 THEN
		raise_application_error(-20002,'Ese armador no tiene barcos');
	end if;
end;
/

create or replace procedure ArmadorSinCapturas (p_dni armadores.dni%type)
is
	v_dni NUMBER:=0;
begin
select count (*) into v_dni
from capturas_diarias
where DNIarmador = p_dni;
	if v_dni = 0 THEN
		raise_application_error(-20002,'Ese armador no ha capturado nada');
	end if;
end;
/

3.- Realiza un trigger que garantice que no se insertan datos en la tabla CapturasDiarias si el barco no se encuentra faenando en dicho caladero en la fecha correspondiente.
create or replace trigger ComprobarBarcoEnCaladeroyFecha
before insert on capturas_diarias
for each row
declare
	v_contador NUMBER:=0;
begin

select count(referenciacaladero ) into v_contador
from faenas_barcos
where matriculabarco = :new.matriculabarco
and :new.fechapescainicio between fechaInicio and fechafin
and :new.referenciacaladero = referenciacaladero;

	if v_contador = 0 then
		raise_application_error(-20005,'Ese barco no se encuentra faenando en ese caladero en esa fecha');
	end if;
end;
/
