funcion esmultiplo(num1,num2)
	si num2%num1=0 Entonces
		escribir num1," es múltiplo de ",num2;
	SiNo
		escribir num1," no es múltiplo de ",num2;
	FinSi
FinFuncion
Proceso multiplo
	definir num1 como entero;
	definir num2 como entero;
	escribir "Escribe el primer número";
	leer num1;
	escribir "Escribe el segundo número";
	leer num2;
	esmultiplo(num1,num2);
FinProceso