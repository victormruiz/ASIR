5. Añade a la tabla Actividades una columna llamada BalanceHotel. La columna contendrá la cantidad que debe pagar el hotel a la empresa
 (en cuyo caso tendrá signo positivo) o la empresa al hotel (en cuyo caso tendrá signo negativo) a causa de las Actividades Realizadas por los clientes.
 Realiza un procedimiento que rellene dicha columna y un trigger que la mantenga actualizada cada vez que la tabla ActividadesRealizadas sufra cualquier cambio.
 Te recuerdo que cada vez que un cliente realiza una actividad, hay dos posibilidades: Si el cliente está en TI el hotel paga a la empresa el coste de la actividad.
 Si no está en TI, el hotel recibe un porcentaje de comisión del importe que paga el cliente por realizar la actividad.

alter table actividades add balancehotel NUMBER(6,2);

create or replace trigger comprobarbalancehotel
after insert or update on actividadesRealizadas
for each row
DECLARE
  v_codigoregimen regimenes.codigo%type;
  v_precio  actividades.precioporpersona%type;
  v_comision  actividades.ComisionHotel%type;
begin
    select precioporpersona, ComisionHotel into v_precio, v_comision
    from actividades
    where codigo = :new.codigoactividad;
    v_codigoregimen:=sacarcodigoregimen(:new.codigoestancia);
    if v_codigoregimen = 'TI' then
      update actividades
      set balancehotel = balancehotel-(v_precio*:new.numpersonas)
      where codigo = :new.codigoactividad;
    ELSE
      update actividades
      set balancehotel = balancehotel+(v_comision*v_precio*:new.numpersonas)
      where codigo = :new.codigoactividad;
    end if;
end;
/

create or replace function sacarcodigoregimen(p_codigoestancia estancias.codigo%type)
return regimenes.codigo%type
is
  v_codigoregimen regimenes.codigo%type;
BEGIN
  select CodigoRegimen into v_codigoregimen
  from Estancias
  where codigo = p_codigoestancia;
  return v_codigoregimen;
end;
/



6.  Realiza los módulos de programación necesarios para que una actividad no sea realizada en una fecha concreta por más de 10 personas.


create or replace package Ejercicio6
as
    TYPE TRegistro is Record
    (
        Codigo          actividadesrealizadas.CodigoActividad%type,
        NumPersonas     NUMBER,
        Fecha           DATE
    );
    TYPE tTabla IS TABLE OF TRegistro INDEX BY BINARY_INTEGER;
    v_tabla tTabla;
END Ejercicio6;
/

create or replace trigger PorSentencia
before insert or update on ActividadesRealizadas
declare
    cursor c_actividades2
    is
    select Codigo, sum(NumPersonas) as NumPersonas, Fecha
    from Actividades a, ActividadesRealizadas ar
    where a.Codigo = ar.CodigoActividad
    group by Codigo, Fecha;
    i               number:=0;
    v_codigo        actividades.codigo%type;
    v_numpersonas   ActividadesRealizadas.NumPersonas%type;
    v_fecha         date;
begin
    open c_actividades2;
    fetch c_actividades2 into v_codigo,v_numpersonas,v_fecha;
    while c_actividades2%found loop
        Ejercicio6.v_tabla(i).Codigo:=v_codigo;
        Ejercicio6.v_tabla(i).NumPersonas:=v_numpersonas;
        Ejercicio6.v_tabla(i).Fecha:=v_fecha;
        i:=i + 1;
        fetch c_actividades2 into v_codigo,v_numpersonas,v_fecha;
    end loop;
    close c_actividades2;
end PorSentencia;
/

create or replace trigger PorFila
before insert or update on ActividadesRealizadas
for each row
declare
v_indicador   number:=0;
begin
    for i in Ejercicio6.v_tabla.FIRST..Ejercicio6.v_tabla.LAST loop
        if Ejercicio6.v_tabla(i).Fecha = :new.Fecha and Ejercicio6.v_tabla(i).Codigo = :new.CodigoActividad then
          v_indicador:=1
          if (Ejercicio6.v_tabla(i).NumPersonas + :new.numpersonas) > 10
            raise_application_error(-20030, 'No pueden estar más de 10 personas en una actividad.');
          else
              Ejercicio6.v_tabla(Ejercicio6.v_tabla.i).NumPersonas:= Ejercicio6.v_tabla(Ejercicio6.v_tabla.i).NumPersonas+:new.NumPersonas;
          end if;
        end if;
    end loop;
    if v_indicador!=1 then
      if :new.NumPersonas < 10 then
          actualizartablapl(:new.CodigoActividad,:new.NumPersonas,:new.Fecha)
      else
          raise_application_error(-20030, 'No pueden estar más de 10 personas en una actividad.');
      end if;
    end if;
end PorFila;
/

create or replace procedure actualizartablapl(v_codigo actividades.codigo%type,v_numpersonas number,v_fecha date)
declare
v_codigo  Actividades.codigo%type;
v_numpersonas NUMBER(2);
v_fecha  DATE;
BEGIN
Ejercicio6.v_tabla(Ejercicio6.v_tabla.LAST+1).Codigo:=v_CodigoActividad;
Ejercicio6.v_tabla(Ejercicio6.v_tabla.LAST).NumPersonas:=v_NumPersonas;
Ejercicio6.v_tabla(Ejercicio6.v_tabla.LAST).Fecha:=v_Fecha;
end actualizartablapl;
/
