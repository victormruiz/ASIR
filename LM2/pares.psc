Proceso pares
	definir num1 Como Entero;
	definir num2 Como Entero;
	definir contador como entero;
	contador <- 0;
	escribir "dime 2 numeros pares";
	leer num1;
	mientras contador = 0 hacer
		si num1%2=0 Entonces
			escribir num1, " es par.";
			contador <- contador +1;
		SiNo
			escribir num1, " no es par, introduce otro numero";
			leer num1;
		FinSi
	FinMientras
	
FinProceso
