Proceso sin_titulo
	definir cad como caracter;
	definir cad2 como caracter;
	definir indice como entero;
	cad2<-"";
	cad <- "hola";
	para indice <- longitud(cad)-1 hasta 0 con paso -1 hacer
		cad2 <-Concatenar(cad2,subcadena(cad,indice,indice));
	FinPara
	escribir cad2;
FinProceso
