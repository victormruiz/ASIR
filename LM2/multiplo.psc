funcion esmultiplo(num1,num2)
	si num2%num1=0 Entonces
		escribir num1," es m�ltiplo de ",num2;
	SiNo
		escribir num1," no es m�ltiplo de ",num2;
	FinSi
FinFuncion
Proceso multiplo
	definir num1 como entero;
	definir num2 como entero;
	escribir "Escribe el primer n�mero";
	leer num1;
	escribir "Escribe el segundo n�mero";
	leer num2;
	esmultiplo(num1,num2);
FinProceso