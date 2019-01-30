Proceso contarvocales
	definir cad como caracter;
	definir contador como entero;
	definir indice como entero;
	contador <- 0;
	escribir "dime una palabra";
	leer cad;
	para indice <- 0 hasta longitud(cad)-1 Hacer
		Si subcadena(cad,indice,indice) = "a" o subcadena(cad,indice,indice) ="e" o subcadena(cad,indice,indice) ="i" o subcadena(cad,indice,indice) ="o" o subcadena(cad,indice,indice) ="u" Entonces
			contador <- contador+1;
		FinSi
	FinPara
	escribir "la cadena tiene ",contador, " vocales";
FinProceso
