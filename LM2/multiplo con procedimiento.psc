funcion comprobador <- esmultiplo(num1,num2)
	definir comprobador como logico;
	si num2%num1=0 Entonces
		comprobador <- Verdadero;
	SiNo
		comprobador <- falso;
	FinSi
FinFuncion
Proceso multiplo
	definir num1 como entero;
	definir num2 como entero;
	escribir "Escribe el primer número";
	leer num1;
	escribir "Escribe el segundo número";
	leer num2;
	si esmultiplo(num1,num2) = verdadero Entonces
		escribir num1," es multiplo de ",num2;
	SiNo
		escribir num1," no es multiplo de ",num2; 
	FinSi
FinProceso