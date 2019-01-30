def calcularprecio(nombre,precio,cantidad):
    rebaja=estarebajado(nombre)
    if rebaja==False:
        print("El precio del artículo es %.2f €"%(precio*cantidad))
    else:
        print("El precio del artículo es %.2f €"%((precio*cantidad)/2))

def estarebajado(nombre):
    if nombre.find("Rebajas") != -1:
        return(True)
    else:
        return(False)





bandera NUMBER;
bandera:=0
for i in tablapl loop
    if v_nombre = i.username then
        v_bandera:=1;


5. Queremos cambiar de ubicación un tablespace, pero antes debemos avisar a los usuarios que tienen acceso de lectura o escritura a cualquiera de los objetos almacenados en el mismo.
Escribe un procedimiento llamado
MostrarUsuariosAccesoTS que obtenga un listado con los nombres de dichos usuarios.

create or replace package tablapl
as
	TYPE tRegistro is RECORD
	(
		USERNAME  varchar2(55)
	);
	TYPE tTabla IS TABLE OF tRegistro INDEX BY BINARY_INTEGER;
	v_tabla tTabla;
end;
/


create or replace procedure tratartablas(V_TABLENAME VARCHAR2)
is
  cursor c_cursor
  is
  select distinct grantee
  from dba_tab_privs
  where table_name=V_TABLENAME
  and PRIVILEGE='SELECT' or PRIVILEGE='INSERT' or PRIVILEGE='DROP';
  v_bandera NUMBER:=0;
begin
tablapl.v_tabla('0').username := 'USUARIONOVALIDO00';
for i in c_cursor loop
    for nombre in tablapl.v_tabla.FIRST..tablapl.v_tabla.LAST loop
        if i.grantee = tablapl.v_tabla(nombre).USERNAME then
            v_bandera:=1;
        end if;
    end loop;
    if v_bandera=0 then
        tablapl.v_tabla(tablapl.v_tabla.LAST + 1).username :=i.grantee;
    else
        v_bandera:=0;
    end if;

end loop;
end;
/


create or replace procedure MostrarUsuariosAccesoTS(V_TABLESPACE VARCHAR2)
is
  cursor c_cursor
  is
  select table_name,owner
  from dba_tables
  where tablespace_name='USERS';
begin
  for i in c_cursor loop
    tratartablas(i.table_name);
  end loop;
  for nombre in tablapl.v_tabla.FIRST+1..tablapl.v_tabla.LAST loop
    dbms_output.put_line('Habría que avisar al usuario '||tablapl.v_tabla(nombre).USERNAME);
  end loop;
  tablapl.v_tabla.delete;
end;
/


exec MostrarUsuariosAccesoTS('USERS');
