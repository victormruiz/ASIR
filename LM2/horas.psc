funcion funcionsegundos(horas,min,seg)
	escribir "El resultado es ",min*60+seg+(horas*60*60)," Segundos";
FinFuncion

funcion funcionhorasminseg(seg)
	si seg >= 3600 Entonces
		escribir trunc(seg/3600)," horas ",trunc(seg%3600/60), " minutos ",trunc(seg%3600/60)," segundos";
	SiNo
		escribir trunc(seg/60), " minutos ", seg%60, " segundos";
	FinSi
FinFuncion

Proceso conversor
	definir horas como entero;
	definir min como entero;
	definir seg como entero;
	definir opcion como caracter;
	escribir "Elije una opción:";
	escribir "A) conversor a segundos.";
	escribir "B) Conversor a horas, minutos y segundos.";
	leer opcion;
	si opcion = "A" Entonces
		escribir "Escribe las horas.";
		leer horas;
		escribir "Escribe los minutos.";
		leer min;
		escribir "Escribe los segundos.";
		leer seg;
		funcionsegundos(horas,min,seg);
	SiNo
		si opcion = "B" Entonces
			escribir "Escribe los segundos que quieres convertir.";
			leer seg;
			funcionhorasminseg(seg);
		SiNo
			escribir "La opción elegida no es correcta. saliendo del programa.";
		FinSi
	FinSi
	
FinProceso
