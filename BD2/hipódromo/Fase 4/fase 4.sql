-- 1.- Realiza una función que reciba como parámetros un código de carrera y un código de caballo y
-- devuelva el importe total que tendrá que pagar el hipódromo a los apostantes suponiendo que dicha
-- carrera sea ganada por el caballo recibido como parámetro. Se deben contemplar las siguientes
-- excepciones: Carrera inexistente, Caballo inexistente, Caballo no participante en esa carrera.
create or replace procedure ComprobarExisteCarrerayCaballo (p_codcarrera carrerasprofesionales.codcarrera%type,
                                                            p_codigocaballo caballos.codigocaballo%type)
is
	v_indcarrera NUMBER;
	v_indcaballo NUMBER;
begin
	select count(*) into v_indcarrera
	from carrerasprofesionales
	where codcarrera = p_codcarrera;
	if v_indcarrera = 0 then
		raise_application_error(-20001, 'No existe ninguna carrera con el código introducido.');
	end if;
	select count(*) into v_indcaballo
	from caballos
	where codigocaballo = p_codigocaballo;
	if v_indcaballo = 0 then
		raise_application_error(-20002, 'No existe ningún caballo con el código introducido.');
	end if;
end ComprobarExisteCarrerayCaballo;
/

create or replace procedure ComprobarCaballoEnCarrera (p_codcarrera carrerasprofesionales.codcarrera%type,
                                                       p_codigocaballo caballos.codigocaballo%type)
is
	v_indcaballocarrera NUMBER;
begin
	select count(*) into v_indcaballocarrera
	from participaciones
	where codcarrera = p_codcarrera
	and codigocaballo = p_codigocaballo;
	if v_indcaballocarrera = 0 then
		raise_application_error(-20003, 'El caballo indicado no participó en la carrera introducida.');
	end if;
end ComprobarCaballoEnCarrera;
/

create or replace function CalcularImporte (p_codcarrera carrerasprofesionales.codcarrera%type,
                                            p_codigocaballo caballos.codigocaballo%type)
return NUMBER
is
	v_importe NUMBER(10, 2);
begin
	select sum(importeapostado * tantoaunoreal) into v_importe
	from apuestas
	where codcarrera = p_codcarrera
	and codigocaballo = p_codigocaballo;
	return v_importe;
end CalcularImporte;
/

-- Función principal
create or replace function TotalAPagar (p_codcarrera carrerasprofesionales.codcarrera%type,
                                        p_codigocaballo caballos.codigocaballo%type)
return NUMBER
is
	v_importe NUMBER(10, 2);
begin
	ComprobarExisteCarrerayCaballo(p_codcarrera, p_codigocaballo);
	ComprobarCaballoEnCarrera(p_codcarrera, p_codigocaballo);
	v_importe := CalcularImporte(p_codcarrera, p_codigocaballo);
	return v_importe;
end TotalAPagar;
/

-- PLPGSQL
create or replace function ComprobarExisteCarrerayCaballo (p_codcarrera carrerasprofesionales.codcarrera%type,
                                                           p_codigocaballo caballos.codigocaballo%type)
returns void as $ComprobarExisteCarrerayCaballo$
declare
	v_indcarrera INTEGER;
	v_indcaballo INTEGER;
begin
	select count(*) into strict v_indcarrera
	from carrerasprofesionales
	where codcarrera = p_codcarrera;
	if v_indcarrera = 0 then
		RAISE EXCEPTION 'No existe ninguna carrera con el código introducido.';
	end if;
	select count(*) into strict v_indcaballo
	from caballos
	where codigocaballo = p_codigocaballo;
	if v_indcaballo = 0 then
		RAISE EXCEPTION 'No existe ningún caballo con el código introducido.';
	end if;
end;
$ComprobarExisteCarrerayCaballo$ LANGUAGE plpgsql;

create or replace function ComprobarCaballoEnCarrera (p_codcarrera carrerasprofesionales.codcarrera%type,
                                                      p_codigocaballo caballos.codigocaballo%type)
returns void as $ComprobarCaballoEnCarrera$
declare
	v_indcaballocarrera INTEGER;
begin
	select count(*) into v_indcaballocarrera
	from participaciones
	where codcarrera = p_codcarrera
	and codigocaballo = p_codigocaballo;
	if v_indcaballocarrera = 0 then
		RAISE EXCEPTION 'El caballo indicado no participó en la carrera introducida.';
	end if;
end;
$ComprobarCaballoEnCarrera$ LANGUAGE plpgsql;

create or replace function CalcularImporte (p_codcarrera carrerasprofesionales.codcarrera%type,
                                            p_codigocaballo caballos.codigocaballo%type)
returns DECIMAL as $$
declare
	v_importe DECIMAL(10, 2);
begin
	select importeapostado * tantoaunoreal into v_importe
	from apuestas
	where codcarrera = p_codcarrera
	and codigocaballo = p_codigocaballo;
	return v_importe;
end;
$$ LANGUAGE plpgsql;

-- Función principal
create or replace function TotalAPagar (p_codcarrera carrerasprofesionales.codcarrera%type,
                                        p_codigocaballo caballos.codigocaballo%type)
returns DECIMAL as $$
declare
	v_existecyc VARCHAR;
	v_existecarrera VARCHAR;
	v_importe DECIMAL(10, 2);
begin
	v_existecyc := ComprobarExisteCarrerayCaballo(p_codcarrera, p_codigocaballo);
	v_existecarrera := ComprobarCaballoEnCarrera(p_codcarrera, p_codigocaballo);
	v_importe := CalcularImporte(p_codcarrera, p_codigocaballo);
	return v_importe;
end;
$$ LANGUAGE plpgsql;

-- 2.- Realizar un procedimiento llamado MostrarInformes que recibirá tres parámetros. El primero determinará
-- el tipo de informe que queremos obtener y los otros dos dependerán del tipo de informe.
create or replace function ObtenerNombreCaballo (p_codigocaballo caballos.codigocaballo%type)
return caballos.nombre%type
is
	v_nombre caballos.nombre%type;
begin
	select nombre into v_nombre
	from caballos
	where codigocaballo = p_codigocaballo;
	return v_nombre;
exception
	when NO_DATA_FOUND then
		dbms_output.put_line('No existe ningún caballo que tenga el código introducido.');
		raise;
end ObtenerNombreCaballo;
/

create or replace function ObtenerNombreJockey (p_dnijockey jockeys.dni%type)
return jockeys.nombre%type
is
	v_nombre jockeys.nombre%type;
begin
	select nombre into v_nombre
	from jockeys
	where dni = p_dnijockey;
	return v_nombre;
exception
	when NO_DATA_FOUND then
		dbms_output.put_line('No existe ningún jockey que tenga el DNI introducido.');
		raise;
end ObtenerNombreJockey;
/

create or replace procedure ObtenerHoraEImporte (p_codcarrera carrerasprofesionales.codcarrera%type)
is
	v_hora VARCHAR(7);
	v_importe carrerasprofesionales.importepremio%type;
begin
	select to_char(fechahora, 'HH24:MI'), importepremio into v_hora, v_importe
	from carrerasprofesionales
	where codcarrera = p_codcarrera;
	dbms_output.put_line('Hora: ' || rpad(v_hora, 15) || 'Importe Premio: ' || v_importe);
end ObtenerHoraEImporte;
/

create or replace procedure ObtenerClasificacion (p_codcarrera carrerasprofesionales.codcarrera%type)
is
	cursor c_clas
	is
	select *
	from participaciones
	where codcarrera = p_codcarrera;
	v_nomcaballo caballos.nombre%type;
	v_nomjockey jockeys.nombre%type;
begin
	dbms_output.put_line('Clasificación: ');
	for i in c_clas loop
		v_nomcaballo := ObtenerNombreCaballo(i.codigocaballo);
		v_nomjockey := ObtenerNombreJockey(i.dnijockey);
		dbms_output.put_line(i.posicionfinal || ': ' || rpad(v_nomcaballo, 20) || ' ' || v_nomjockey);
	end loop;
end ObtenerClasificacion;
/

create or replace procedure GenerarPrimerInforme (p_fecha DATE)
is
	cursor c_carreras
	is
	select codcarrera
	from carrerasprofesionales
	where to_char(fechahora, 'DD/MM/YYYY') = to_char(p_fecha, 'DD/MM/YYYY');
begin
	dbms_output.put_line('Fecha: ' || to_char(p_fecha, 'DD') || ' de ' || to_char(p_fecha, 'MONTH') || ' de ' || to_char(p_fecha, 'YYYY'));
	for i in c_carreras loop
		ObtenerHoraEImporte(i.codcarrera);
		ObtenerClasificacion(i.codcarrera);
	end loop;
end GenerarPrimerInforme;
/

create or replace procedure GenerarSegundoInforme(p_codcarrera carrerasprofesionales.codcarrera%type)
is
	cursor c_datos
	is
	select *
	from carrerasprofesionales
	where codcarrera = p_codcarrera;
begin
	for i in c_datos loop
		dbms_output.put_line('Código carrera: ' || i.codcarrera);
		dbms_output.put_line('Fecha: ' || to_char(i.fechahora, 'DD') || ' de ' || to_char(i.fechahora, 'MONTH') || ' de ' || to_char(i.fechahora, 'YYYY'));
		dbms_output.put_line('Hora: ' || to_char(i.fechahora, 'HH24:MI'));
		dbms_output.put_line('Importe premio: ' || rpad(i.importepremio, 15) || 'Límite apuesta: ' || i.limiteapuesta);
		dbms_output.put_line('Caballos nacidos de ' || to_char(i.fechanacmin, 'DD/MM/YYYY') || ' a ' || to_char(i.fechanacmax, 'DD/MM/YYYY'));
		ObtenerClasificacion(i.codcarrera);
	end loop;
end GenerarSegundoInforme;
/

create or replace function ObtenerJockey (p_codigocaballo caballos.codigocaballo%type,
                                          p_codcarrera carrerasprofesionales.codcarrera%type)
return jockeys.nombre%type
is
	v_dnijockey jockeys.dni%type;
begin
	select dnijockey into v_dnijockey
	from participaciones
	where codigocaballo = p_codigocaballo
	and codcarrera = p_codcarrera;
	return ObtenerNombreJockey(v_dnijockey);
end ObtenerJockey;
/

create or replace function ObtenerNumVictorias (p_codigocaballo caballos.codigocaballo%type)
return NUMBER
is
	v_numvictorias NUMBER;
begin
	select count(*) into v_numvictorias
	from participaciones
	where posicionfinal = '1'
	and codigocaballo = p_codigocaballo;
	return v_numvictorias;
end ObtenerNumVictorias;
/

create or replace function ObtenerUltimaParticipacion (p_codigocaballo caballos.codigocaballo%type)
return DATE
is
	v_ultpart DATE;
begin
	select max(fechahora) into v_ultpart
	from carrerasprofesionales
	where codcarrera IN (select codcarrera
                     	 from participaciones
                     	 where codigocaballo = p_codigocaballo);
	return v_ultpart;
end ObtenerUltimaParticipacion;
/

create or replace function ObtenerPosicionEnUltPart (p_codigocaballo caballos.codigocaballo%type)
return participaciones.posicionfinal%type
is
	v_posicion participaciones.posicionfinal%type;
begin
	select posicionfinal into v_posicion
	from participaciones
	where codcarrera = (select codcarrera
		                from carrerasprofesionales
		                where fechahora = (select max(fechahora)
	                                       from carrerasprofesionales
	                                       where codcarrera IN (select codcarrera
                     	                                        from participaciones
                     	                                        where codigocaballo = p_codigocaballo)))
	and codigocaballo = p_codigocaballo;
	return v_posicion;
end ObtenerPosicionEnUltPart;
/

create or replace procedure ObtenerInfoParticipantes (p_codcarrera carrerasprofesionales.codcarrera%type)
is
	cursor c_datos
	is
	select codigocaballo, tantoaunoreal, codcarrera
	from apuestas
	where codcarrera = p_codcarrera;
	v_nomcaballo caballos.nombre%type;
	v_nomjockey jockeys.nombre%type;
	v_numvictorias NUMBER;
	v_ultpart DATE;
	v_ultpos participaciones.posicionfinal%type;
begin
	dbms_output.put_line('Caballos participantes:');
	for i in c_datos loop
		v_nomcaballo := ObtenerNombreCaballo(i.codigocaballo);
		v_nomjockey := ObtenerJockey(i.codigocaballo, i.codcarrera);
		v_numvictorias := ObtenerNumVictorias(i.codigocaballo);
		v_ultpart := ObtenerUltimaParticipacion(i.codigocaballo);
		v_ultpos := ObtenerPosicionEnUltPart(i.codigocaballo);
		dbms_output.put_line(rpad(v_nomcaballo, 20) || rpad(v_nomjockey, 20) || rpad(i.tantoaunoreal, 5) || rpad(v_numvictorias, 5) || rpad(v_ultpart, 15) || rpad(v_ultpos, 5));
	end loop;
end ObtenerInfoParticipantes;
/

create or replace procedure GenerarTercerInforme (p_codcarrera carrerasprofesionales.codcarrera%type)
is
	cursor c_datos
	is
	select codcarrera, fechahora, limiteapuesta
	from carrerasprofesionales
	where codcarrera = p_codcarrera;
begin
	for i in c_datos loop
		dbms_output.put_line('Código carrera: ' || i.codcarrera);
		dbms_output.put_line('Fecha: ' || to_char(i.fechahora, 'DD') || ' de ' || to_char(i.fechahora, 'MONTH') || ' de ' || to_char(i.fechahora, 'YYYY'));
		dbms_output.put_line('Hora: ' || rpad(to_char(i.fechahora, 'HH24:MI'), 15) || 'Límite apuesta: ' || i.limiteapuesta);
		ObtenerInfoParticipantes(i.codcarrera);
	end loop;
end GenerarTercerInforme;
/

-- Procedimiento principal
create or replace procedure MostrarInformes (p_tipoinforme NUMBER,
                                             p_segpar DATE,
                                             p_terpar carrerasprofesionales.codcarrera%type)
is
begin
	case p_tipoinforme
	when 1 then
		GenerarPrimerInforme(p_segpar);
	when 2 then
		GenerarSegundoInforme(p_terpar);
	when 3 then
		GenerarTercerInforme(p_terpar);
	else
		dbms_output.put_line('El tipo de informe introducido es incorrecto.');
	end case;
end MostrarInformes;
/

-- 3. Realiza un trigger que controle que solo participan en una carrera caballos en el rango de
-- edades permitido. Si es necesario, cambia el modelo de datos.
create or replace function ObtenerFechaNacimiento (p_codigocaballo caballos.codigocaballo%type)
return caballos.fechanac%type
is
	v_fechanac caballos.fechanac%type;
begin
	select fechanac into v_fechanac
	from caballos
	where codigocaballo = p_codigocaballo;
	return v_fechanac;
end ObtenerFechaNacimiento;
/

-- Trigger principal
create or replace trigger CaballosEnRango
before insert or update on participaciones
for each row
declare
	cursor c_rango
	is
	select fechanacmin, fechanacmax
	from carrerasprofesionales
	where codcarrera = :new.codcarrera;
	v_fechanac caballos.fechanac%type;
begin
	for i in c_rango loop
		v_fechanac := ObtenerFechaNacimiento(:new.codigocaballo);
		if v_fechanac NOT BETWEEN i.fechanacmin AND i.fechanacmax then
			raise_application_error(-20001, 'Sólo pueden participar caballos en el rango de edades permitido.');
		end if;
	end loop;
end CaballosEnRango;
/

-- PLPGSQL
create or replace function ObtenerFechaNacimiento(p_codigocaballo caballos.codigocaballo%type)
returns caballos.fechanac%type as $$
declare
	v_fechanac caballos.fechanac%type;
begin
	select fechanac into v_fechanac
	from caballos
	where codigocaballo = p_codigocaballo;
	return v_fechanac;
end;
$$ LANGUAGE plpgsql;

-- Trigger principal
create or replace function CaballosEnRango() returns trigger as $$
declare
	c_rango cursor
	is
	select fechanacmin, fechanacmax
	from carrerasprofesionales
	where codcarrera = NEW.codcarrera;
	v_fechanac caballos.fechanac%type;
begin
	for i in c_rango loop
		v_fechanac := ObtenerFechaNacimiento(NEW.codigocaballo);
		if to_char(v_fechanac, 'DD/MM/YYYY') NOT BETWEEN to_char(i.fechanacmin, 'DD/MM/YYYY') AND to_char(i.fechanacmax, 'DD/MM/YYYY') then
			RAISE EXCEPTION 'Sólo pueden participar caballos en el rango de edades permitido.';
		end if;
	end loop;
end;
$$ LANGUAGE plpgsql;

create trigger CaballosEnRango
before insert or update on participaciones
for each row
execute procedure CaballosEnRango();

-- 4. Añade una columna email en la tabla Clientes y rellénala con datos consistentes. Realiza un trigger
-- que cuando se actualice la tabla Participaciones para introducir los resultados de la carrera
-- envíe un correo electrónico a todos los apostantes del caballo ganador informándoles del importe
-- apostado y el beneficio obtenido.


-- 5. Añade una columna a la tabla Propietarios llamada ImporteTotalPremios. Rellénala con un
-- procedimiento o una sentencia SQL considerando los premios que han conseguido los caballos de cada uno
-- de ellos por sus victorias en las carreras. Haz un trigger que la mantenga actualizada cada vez que
-- se realice cualquier cambio en la tabla Participaciones que afecte a este total.

-- 6. Realiza los módulos de programación necesarios para evitar que un mismo propietario envíe
-- dos caballos a una misma carrera.
create or replace package CaballosPorProp
as
	TYPE tRegistro is RECORD
	(
		nifpropietario propietarios.nif%type,
		codcarrera carrerasprofesionales.codcarrera%type,
		participaciones NUMBER
	);

	TYPE tTabla IS TABLE OF tRegistro INDEX BY BINARY_INTEGER;

	v_tabla tTabla;
end CaballosPorProp;
/

-- Trigger por sentencia
create or replace trigger RellenaTablaPLProp
before insert or update on participaciones
declare
	cursor c_participaciones
	is
	select count(*) as cont, nifpropietario, codcarrera
	from caballos c, participaciones p
	where c.codigocaballo = p.codigocaballo
	group by nifpropietario, codcarrera
	order by codcarrera;
	i NUMBER := 0;
begin
	for v_participacion in c_participaciones loop
		CaballosPorProp.v_tabla(i).nifpropietario := v_participacion.nifpropietario;
		CaballosPorProp.v_tabla(i).codcarrera := v_participacion.codcarrera;
		CaballosPorProp.v_tabla(i).participaciones := v_participacion.cont;
		i := i + 1;
	end loop;
end RellenaTablaPLProp;
/

create or replace function ObtenerPropietario (p_codigocaballo caballos.codigocaballo%type)
return propietarios.nif%type
is
	v_nifpropietario propietarios.nif%type;
begin
	select nifpropietario into v_nifpropietario
	from caballos
	where codigocaballo = p_codigocaballo;
	return v_nifpropietario;
end ObtenerPropietario;
/

create or replace function TratarParticipacion (p_codigocaballo caballos.codigocaballo%type,
                                                p_codcarrera carrerasprofesionales.codcarrera%type)
return NUMBER
is
	v_encontrado NUMBER;
	v_nifpropietario propietarios.nif%type;
begin
	v_nifpropietario := ObtenerPropietario(p_codigocaballo);
	for i in CaballosPorProp.v_tabla.FIRST..CaballosPorProp.v_tabla.LAST loop
		if CaballosPorProp.v_tabla(i).nifpropietario = v_nifpropietario and CaballosPorProp.v_tabla(i).codcarrera = p_codcarrera then
			v_encontrado := 1;
		end if;
	end loop;
	return v_encontrado;
end TratarParticipacion;
/

-- Procedimiento para actualizar la tabla PL
create or replace procedure InsertarParticipacionTablaPL (p_codigocaballo caballos.codigocaballo%type,
                                                          p_codcarrera carrerasprofesionales.codcarrera%type,
                                                          p_participaciones NUMBER)
is
	v_nifpropietario propietarios.nif%type;
begin
	v_nifpropietario := ObtenerPropietario(p_codigocaballo);
	CaballosPorProp.v_tabla(CaballosPorProp.v_tabla.LAST + 1).nifpropietario := v_nifpropietario;
	CaballosPorProp.v_tabla(CaballosPorProp.v_tabla.LAST).codcarrera := p_codcarrera;
	CaballosPorProp.v_tabla(CaballosPorProp.v_tabla.LAST).participaciones := p_participaciones;
end InsertarParticipacionTablaPL;
/

-- Trigger por fila
create or replace trigger TriggerParticipacionProp
before insert or update on participaciones
for each row
declare
	v_existepart NUMBER;
begin
	v_existepart := TratarParticipacion(:new.codigocaballo, :new.codcarrera);
	if v_existepart != 0 then
		raise_application_error(-20001, 'Un propietario no puede enviar a dos caballos a la misma carrera.');
	else
		InsertarParticipacionTablaPL(:new.codigocaballo, :new.codcarrera, 1);
	end if;
end TriggerParticipacionProp;
/

-- 7. Realiza los módulos de programación necesarios para evitar que un mismo jockey corra más de tres
-- carreras en el mismo día.
create or replace package PartPorJockey
as
	TYPE tRegistro is RECORD
	(
		DNIJockey jockeys.dni%type,
		Fecha VARCHAR2(10),
		Contador NUMBER
	);

	TYPE tTabla IS TABLE OF tRegistro INDEX BY BINARY_INTEGER;

	v_tabla tTabla;
end PartPorJockey;
/

-- Trigger por sentencia
create or replace trigger RellenaTablaPLJockeys
before insert or update on participaciones
declare
	cursor c_partporjockey
	is
	select count(*) as cont, dnijockey, to_char(fechahora, 'DD/MM/YYYY') as fecha
	from participaciones p, carrerasprofesionales c
	where p.codcarrera = c.codcarrera
	group by dnijockey, to_char(fechahora, 'DD/MM/YYYY')
	order by to_char(fechahora, 'DD/MM/YYYY');
	i NUMBER := 0;
begin
	for v_participacion in c_partporjockey loop
		PartPorJockey.v_tabla(i).DNIJockey := v_participacion.DNIJockey;
		PartPorJockey.v_tabla(i).Fecha := v_participacion.fecha;
		PartPorJockey.v_tabla(i).Contador := v_participacion.cont;
		i := i + 1;
	end loop;
end RellenaTablaPLJockeys;
/

create or replace function ObtenerFechaCarrera (p_codcarrera carrerasprofesionales.codcarrera%type)
return VARCHAR2
is
	v_fecha VARCHAR2(10);
begin
	select to_char(fechahora, 'DD/MM/YYYY') into v_fecha
	from carrerasprofesionales
	where codcarrera = p_codcarrera;
	return v_fecha;
end ObtenerFechaCarrera;
/

create or replace procedure ActualizarTablaPLJockeys (p_dnijockey jockeys.dni%type,
                                                      p_fecha VARCHAR2)
is
	v_contador NUMBER;
begin
	for i in PartPorJockey.v_tabla.FIRST..PartPorJockey.v_tabla.LAST loop
		PartPorJockey.v_tabla(PartPorJockey.v_tabla.LAST + 1).DNIJockey := p_dnijockey;
		PartPorJockey.v_tabla(PartPorJockey.v_tabla.LAST).Fecha := p_fecha;
		PartPorJockey.v_tabla(PartPorJockey.v_tabla.LAST).Contador := 1;
	end loop;
end ActualizarTablaPLJockeys;
/

create or replace procedure TratarParticipacionJockey (p_dnijockey jockeys.dni%type,
                                                       p_codcarrera carrerasprofesionales.codcarrera%type)
is
	v_fecha VARCHAR2(10);
begin
	v_fecha := ObtenerFechaCarrera(p_codcarrera);
	for i in PartPorJockey.v_tabla.FIRST..PartPorJockey.v_tabla.LAST loop
		if PartPorJockey.v_tabla(i).DNIJockey = p_dnijockey	and PartPorJockey.v_tabla(i).Fecha = v_fecha then
      if PartPorJockey.v_tabla(i).Contador = 3 then
			   raise_application_error(-20001, 'Un mismo jockey no puede correr más de tres carreras en el mismo día');
      else
        v_contador := PartPorJockey.v_tabla(i).Contador;
        PartPorJockey.v_tabla(i).Contador := v_contador + 1;
      end if;
		else
			ActualizarTablaPLJockeys(p_dnijockey, v_fecha);
		end if;
	end loop;
end TratarParticipacionJockey;
/

-- Trigger por fila
create or replace trigger TriggerParticipacionJockey
before insert or update on participaciones
for each row
declare
begin
	TratarParticipacionJockey(:new.DNIJockey, :new.codcarrera);
end TriggerParticipacionJockey;
/

-- 8. Realiza los módulos de programación necesarios para evitar que un propietario apueste por un caballo
-- que no sea de su propiedad si en esa misma carrera corre algún caballo suyo.
create or replace function ClienteEsProp (p_dni propietarios.nif%type)
return NUMBER
is
	v_indicador NUMBER;
begin
	select count(*) into v_indicador
	from propietarios
	where nif = p_dni;
	return v_indicador;
end ClienteEsProp;
/

create or replace function ComprobarPartPropia (p_dni propietarios.nif%type,
                                                p_codcarrera carrerasprofesionales.codcarrera%type)
return NUMBER
is
	v_indicador NUMBER;
begin
	select count(*) into v_indicador
	from participaciones
	where codcarrera = p_codcarrera
	and codigocaballo IN (select codigocaballo
		                  from caballos
		                  where nifpropietario = p_dni);
	return v_indicador;
end ComprobarPartPropia;
/

create or replace procedure ComprobarCaballo (p_encontrado NUMBER)
is
begin
	if p_encontrado = 1 then
		raise_application_error(-20001, 'Un propietario no podrá apostar a un caballo que no sea suyo si en esa carrera participa alguno de sus caballos.');
	end if;
end ComprobarCaballo;
/

-- Trigger principal
create or replace trigger EvitarApuestaPorPropietario
before insert or update on apuestas
for each row
declare
	cursor c_caballos
	is
	select distinct codigocaballo
	from participaciones
	where codcarrera = :new.codcarrera
	and codigocaballo IN (select codigocaballo
		                  from caballos
		                  where nifpropietario = :new.nifcliente);
	v_indcaballoprop NUMBER;
	v_esprop NUMBER;
	v_participa NUMBER;
	v_encontrado NUMBER := 0;
begin
	v_esprop := ClienteEsProp(:new.nifcliente);
	if v_esprop != 0 then
		v_participa := ComprobarPartPropia(:new.nifcliente, :new.codcarrera);
		if v_participa != 0 then
			for i in c_caballos loop
				if :new.codigocaballo = i.codigocaballo then
					v_encontrado := 1;
				end if;
			end loop;
			ComprobarCaballo(v_encontrado);
		end if;
	end if;
end EvitarApuestaPorPropietario;
/
