Proceso subcadenadecadena
	definir cad como caracter;
	definir cad2 como caracter;
	definir indicador como logico;
	definir indice como entero;
	indicador <- verdadero;
	escribir "dime una palabra";
	leer cad;
	escribir "dime la segunda palabra";
	leer cad2;
	para indice <- 0 hasta longitud(cad2)-1 Hacer
		Si subcadena(cad,indice,indice) != subcadena(cad2,indice,indice) entonces
			indicador <- falso;
		FinSi
	FinPara
	si indicador = falso Entonces
		escribir cad2," Si es una subcadena de ",cad;
	sino 
		escribir cad2," No es una subcadena de ",cad;
	FinSi
FinProceso
