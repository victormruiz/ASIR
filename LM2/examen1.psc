Proceso ejercicio1
	definir resistencia1 como entero;
	definir resistencia2 como entero;
	definir voltaje como entero;
	definir resultado Como Real;
	escribir "Escribe el voltaje de la fuente";
	leer voltaje;
	escribir "escribe el valor de la resistencia 1";
	leer resistencia1;
	escribir "escribe el valor de la resistencia 2";
	leer resistencia2;
	resultado <- resistencia1+resistencia2;
	escribir "La resistencia equivalente en serie es ", resultado;
	escribir "la intensidad de corriente que pasa por el circuito en serie es ", voltaje/resultado;
	resultado <- 1/(resistencia1/1+resistencia2/1);
	escribir "La resistencia equivalente en serie es ", resultado;
	escribir "la intensidad de corriente que pasa por el circuito en serie es ", voltaje/resultado;
FinProceso
 