Proceso ejercicio2
	definir a como real;
	definir b Como Real;
	definir solucion como real;
	escribir "Escribe el coeficiente a";
	leer a;
	escribir "escribe el coeficiente b";
	leer b;
		si a=0 y b=0 Entonces
			escribir "tiene infinitas soluciones";
		SiNo
			si a = 0 Entonces
				escribir "No tiene solucion";
			SiNo
				solucion <- -b/a;
				escribir "La solucion es ",solucion;
		FinSi
		
	FinSi
FinProceso
