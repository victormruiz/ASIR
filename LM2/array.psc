Proceso prueba
	definir num como entero;
	definir indice2 como entero;
	definir array como entero;
	dimension array[10,3];
	definir indice como entero;
	para indice <-0 hasta 9 Hacer
		escribir "dime un numero";
		leer num;
		array[indice,0] <- num;
		array[indice,1] <-num^2;
		array[indice,2] <-num^3;
	FinPara
	para indice <-0 hasta 9 Hacer
		para indice2 <- 0 hasta 2 Hacer
			escribir sin saltar array[indice,indice2], " ";
		FinPara
		escribir " ";
	FinPara
	
FinProceso

