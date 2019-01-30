Proceso kilometros
	definir nombres Como Caracter;
	definir i como entero;
	definir kms como entero;
	definir total_km Como entero;
	definir resultado como caracter;
	dimension resultado[2,5];
	dimension nombres[5];
	dimension kms[5,8];
	para i<-0 hasta 4 Hacer
		escribir "Escribe el nombre del conductor ";
		leer nombres[i];
	FinPara
	para i<-0 hasta 4 Hacer
		escribir "escribe los kilometros hechos el lunes por el conductor ", nombres[i];
		leer kms[i,0];
		escribir "escribe los kilometros hechos el martes por el conductor ", nombres[i];
		leer kms[i,1];
		escribir "escribe los kilometros hechos el miercoles por el conductor ", nombres[i];
		leer kms[i,2];
		escribir "escribe los kilometros hechos el jueves por el conductor ", nombres[i];
		leer kms[i,3];
		escribir "escribe los kilometros hechos el viernes por el conductor ", nombres[i];
		leer kms[i,4];
		escribir "escribe los kilometros hechos el sabado por el conductor ", nombres[i];
		leer kms[i,5];
		escribir "escribe los kilometros hechos el domingo por el conductor ", nombres[i];
		leer kms[i,6];
	FinPara
	para i<-0 hasta 4 Hacer
		kms[i,7] <- (kms[i,0]+kms[i,1]+kms[i,2]+kms[i,3]+kms[i,4]+kms[i,5]+kms[i,6]);
	FinPara
	para i<-0 hasta 4 Hacer
		escribir "el conductor ",nombres[i]," ha realizado esta semana ",kms[i,7], " Kilómetros.";
	FinPara	
FinProceso
