Proceso sin_titulo
	definir cad como caracter;
	definir indice como entero;
	cad <- "hola";
	para indice <- longitud(cad)-1 hasta 0 con paso -1 hacer
		escribir sin saltar subcadena(cad,indice,indice);
	FinPara
	escribir "";
FinProceso