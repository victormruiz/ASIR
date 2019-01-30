create or repace procedure calcularpotencia(p_base NUMBER, p_exponente NUMBER)
is
v_resultado NUMBER(8,4):
begin
	if p_base = 0 and p_exponente <=0 then
		dbms_output.put_line_('Datos Erroneos');
	elsif p_exponente = 0 then
		v_resultado:=1;
	elsif p_exponente < 0 then
		v_
