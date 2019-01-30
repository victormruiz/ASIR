1.- Realiza una función que reciba como parámetro el DNI de un armador y nos devuelva el nombre del caladero donde han faenado más días en total sus barcos
 Debes controlar las siguientes excepciones: Armador Inexistente, Armador sin barcos, Armador sin capturas.

create or replace function barcosconmasdias (p_dni armadores.DNI%type)
return VARCHAR2
is
	cursor selectprincipal
	is
	select sum(TRUNC(FechaFin)-TRUNC(fechaInicio)) as dias, C.Nombre as nombrecaladero
	from FAENAS_BARCOS FB, CALADEROS C
	where matriculabarco IN (select matricula
							 					   from barcos
							 						 where dniarmador = p_dni)
  and FB.referenciacaladero = C.referencia
	group by c.nombre;
	v_caladeromayor caladeros.nombre%type;
	v_contador NUMBER:=0;
begin
ArmadorInexistente(p_dni);
ArmadorSinBarcos(p_dni);
ArmadorSinCapturas(p_dni);
	for i in selectprincipal loop
		if i.dias>v_contador then
		  v_contador := i.dias;
			v_caladeromayor := i.nombrecaladero;
		end if;
	end loop;
	return v_caladeromayor;
end;
/

create or replace procedure ArmadorInexistente (p_dni armadores.dni%type)
is
	v_dni NUMBER:=0;
begin
select count (*) into v_dni
from ARMADORES
where DNI = p_dni;
	if v_dni = 0 THEN
		raise_application_error(-20001,'Ese armador no existe');
	end if;
end;
/

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
		raise_application_error(-20002,'Los barcos de ese armador no tienen capturas');
	end if;
end;
/


3.- Realiza un trigger que garantice que no se insertan datos en la tabla CapturasDiarias si el barco no se encuentra faenando en dicho caladero en la fecha correspondiente.
create or replace trigger ComprobarBarcoEnCaladeroyFecha
before insert on capturas_diarias
for each row
declare
  v_contador NUMBER:=0;
  v_fechafin FAENAS_BARCOS.fechafin%type;
begin
select count(referenciacaladero ) into v_contador
from faenas_barcos
where matriculabarco = :new.matriculabarco
and (:new.fechapescainicio between fechaInicio and fechafin) or (:new.fechapescainicio > fechainicio and fechafin is NULL)
and :new.referenciacaladero = referenciacaladero;
	if v_contador = 0 then
		raise_application_error(-20005,'Ese barco no se encuentra faenando en ese caladero en esa fecha');
	end if;
end;
/


5.- Realiza los módulos de programación necesarios para que la columna Kilos de la tabla FaenaBarcos se mantenga actualizada automáticamente cuando la tabla CapturasDiarias sufra cualquier cambio.

alter table faenas_barcos add kilos NUMBER:=0;

create or replace trigger ComprobarKilos
after insert or update or delete on capturas_diarias
for each row
begin
	if inserting then
		ActualizarFaenas (:new.matriculabarco,:new.referenciacaladero,:new.kilos);
	elsif deleting then
		ActualizarFaenas (:old.matriculabarco,:old.referenciacaladero,-:old.kilos);
	elsif updating then
		ActualizarFaenas (:old.matriculabarco,:old.referenciacaladero,-:old.kilos);
		ActualizarFaenas (:new.matriculabarco,:new.referenciacaladero,:new.kilos);
	end if;
end;
/
create or replace procedure ActualizarFaenas (p_matricula barcos.matricula%type,
											  										  p_referencia capturas_diarias.referenciacaladero%type,
											  											p_kilos capturas_diarias.kilos%type)
is
begin
	update faenas_barcos
	set kilos=kilos+p_kilos
	where matriculabarco = p_matricula
	and referenciacaladero = p_referencia;
end;
/

7.- grupo bd

create or replace package ArmadoresEnCaladeros
as
	TYPE tRegistro is RECORD
	(
		DNIArmador ARMADORES.dni%type,
		ReferenciaCaladero CALADEROS.referencia%TYPE,
		fechaInicio FAENAS_BARCOS.Fechainicio%TYPE,
   	 	FechaFin FAENAS_BARCOS.Fechainicio%TYPE
	);

	TYPE tTabla IS TABLE OF tRegistro INDEX BY BINARY_INTEGER;

	v_tabla tTabla;
end ArmadoresEnCaladeros;
/


create or replace trigger RellenaTablaPL
before insert or update on FAENAS_BARCOS
declare
	cursor c_ArmadoresEnCaladeros
	is
  select B.DNIarmador, F.ReferenciaCaladero, F.FechaInicio, F.FechaFin
  from FAENAS_BARCOS F, BARCOS B
  WHERE B.Matricula = F.MatriculaBarco
  order by B.DNIarmador;
	i NUMBER := 0;
begin
	for v_ArmadoresEnCaladeros in c_ArmadoresEnCaladeros loop
		ArmadoresEnCaladeros.v_tabla(i).DNIArmador := v_ArmadoresEnCaladeros.DNIArmador;
		ArmadoresEnCaladeros.v_tabla(i).ReferenciaCaladero := v_ArmadoresEnCaladeros.ReferenciaCaladero;
		ArmadoresEnCaladeros.v_tabla(i).FechaInicio := v_ArmadoresEnCaladeros.FechaInicio;
  	  	ArmadoresEnCaladeros.v_tabla(i).FechaFin := v_ArmadoresEnCaladeros.FechaFin;
		i := i + 1;
	end loop;
end RellenaTablaPL;
/

CREATE OR REPLACE PROCEDURE ACTUALIZARTABLAPL(P_DNIArmador ARMADORES.dni%type, P_ReferenciaCaladero CALADEROS.referencia%TYPE, P_fechaInicio FAENAS_BARCOS.Fechainicio%TYPE, P_FechaFin FAENAS_BARCOS.Fechainicio%TYPE)
IS
    I NUMBER;
BEGIN
        I:=ArmadoresEnCaladeros.V_TABLA.LAST+1;
        ArmadoresEnCaladeros.V_TABLA(I).DNIArmador:=P_DNIArmador;
        ArmadoresEnCaladeros.V_TABLA(I).ReferenciaCaladero:=P_ReferenciaCaladero;
        ArmadoresEnCaladeros.V_TABLA(I).FECHAFIN:=P_FECHAFIN;
        ArmadoresEnCaladeros.V_TABLA(I).FechaFin := P_FechaFin;
END;
/


create or replace function sacardni(p_matricula barcos.matricula%type)
return armadores.dni%type
is
v_dni armadores.dni%type;
begin
select dniarmador into v_dni
from barcos
where matricula = p_matricula;
return v_dni;
end;
/


create or replace trigger FilaArmadoresEnCaladeros
before insert or update on FAENAS_BARCOS
for each row
declare
v_contador Number := 0;
v_dni armadores.dni%type;
begin
v_dni:=sacardni(:new.matriculabarco);
FOR X IN TO_NUMBER(TO_CHAR(:NEW.FECHAINicio,'J'))..TO_NUMBER(TO_CHAR(:NEW.FECHAFIN,'J')) LOOP
        FOR I IN ArmadoresEnCaladeros.V_TABLA.FIRST..ArmadoresEnCaladeros.V_TABLA.LAST LOOP
            IF X BETWEEN TO_NUMBER(TO_CHAR(ArmadoresEnCaladeros.V_TABLA(I).FechaInicio,'J')) AND TO_NUMBER(TO_CHAR(ArmadoresEnCaladeros.V_TABLA(I).Fechafin,'J')) AND ArmadoresEnCaladeros.V_TABLA(I).ReferenciaCaladero = :new.ReferenciaCaladero AND V_DNI = ArmadoresEnCaladeros.V_TABLA(I).DNIArmador THEN
              v_contador := v_contador +1;
              if v_contador=3 THEN 
                RAISE_APPLICATION_ERROR(-20001,'Un armador no puede tener mas de 3 barcos en un mismo caladero.');
              end if;
            ELSE
                ACTUALIZARTABLAPL(v_dni, :new.ReferenciaCaladero, TO_CHAR(:new.FechaInicio,'YYYY/MM/DD'), TO_CHAR(:new.FechaFin,'YYYY/MM/DD'));
            END IF;
        END LOOP;
    END LOOP;
end FilaArmadoresEnCaladeros;
/














8.- Realiza los módulos de programación necesarios para asegurar que un barco no faena en el mismo caladero más de 20 días en total durante el mismo año natural.


create or replace package tablaplbarcos20dias
as
type tbarcos is record
(
  MatriculaBarco barcos.matricula%type,
  referenciacaladero faenas_barcos.ReferenciaCaladero%type,
  totaldias NUMBER,
  ano VARCHAR2
);

type ttablabarcos is table of tbarcos
index by binary_integer;

v_tablabarcos ttablabarcos;

end;
/

create or replace trigger porsentenciaej8
before insert or update on FAENAS_BARCOS
declare

  cursor c_cursor
  is
  select matriculabarco, referenciacaladero, sum(fechafin - fechainicio), TO_CHAR(fechainicio,'YYYY')
  from FAENAS_BARCOS
  group by matriculabarco, referenciacaladero,TO_CHAR(fechainicio,'YYYY');
  indice NUMBER := 0;
  v_matricula faenas_barcos.matriculabarco%type;
  v_referencia faenas_barcos.ReferenciaCaladero%type;
  v_totaldias NUMBER;
  v_ano VARCHAR2;
begin
  open c_cursor;
  fetch c_cursor into v_matricula, v_referencia, v_totaldias, v_ano;
  while c_cursor%FOUND loop
    tablaplbarcos20dias.v_tablabarcos(indice).matriculabarco := v_matricula;
    tablaplbarcos20dias.v_tablabarcos(indice).referenciacaladero := v_referencia;
    tablaplbarcos20dias.v_tablabarcos(indice).totaldias := v_totaldias;
    tablaplbarcos20dias.v_tablabarcos(indice).ano := v_ano;
    indice:=indice+1;
    fetch c_cursor into v_matricula, v_referencia, v_totaldias, v_ano;
  end loop;
  close c_cursor;
end;
/

create or replace trigger porfilaej8
before insert on FAENAS_BARCOS
for each row
declare
begin
  for i in tablaplbarcos20dias.v_tablabarcos.first..tablaplbarcos20dias.v_tablabarcos.last loop
    if tablaplbarcos20dias.v_tablabarcos(i).matriculabarco = :new.matriculabarco and tablaplbarcos20dias.v_tablabarcos(i).referenciacaladero = :new.referenciacaladero and  tablaplbarcos20dias.v_tablabarcos(i).ano = TO_CHAR(:new.fechainicio,'YYYY') THEN
        comprobardias(tablaplbarcos20dias.v_tablabarcos(i).totaldias, :new.fechaInicio, :new.FechaFin);
    end if;
  end loop;
end;
/


create or replace procedure comprobardias (p_totaldias  NUMBER,
                                           p_fechainicio FAENAS_BARCOS.fechaInicio%type,
                                           p_fechafin  FAENAS_BARCOS.fechafin%type)
is
begin
	if p_totaldias+(p_fechafin-p_fechainicio) > 20 THEN
		raise_application_error(-20010,'Ese barco ya lleva 20 dias faenando en ese caladero');
  else
    tablaplbarcos20dias.v_tablabarcos(i).matriculabarco := :new.matriculabarco;
    tablaplbarcos20dias.v_tablabarcos(i).referenciacaladero := :new.referenciacaladero;
    tablaplbarcos20dias.v_tablabarcos(i).totaldias := tablaplbarcos20dias.v_tablabarcos(i).totaldias + (:new.fechafin-:new.fechainicio);
	end if;
end;
/
