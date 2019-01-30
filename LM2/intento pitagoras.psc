Funcion cuadrado <- CalcularCuadrado(num)
	Definir cuadrado Como real;
	cuadrado <- num^2;
FinFuncion
funcion hipo <- CalcularHipotenusa(cateto1,cateto2)
	definir hipo como real;
	hipo <- CalcularCuadrado(cateto1) + CalcularCuadrado(cateto2);
FinFuncion

Proceso pitagoras
	definir cateto1,cateto2,hipotenusa como real;
	escribir "dime el primer cateto";
	leer cateto1;
	escribir "dime el cateto 2";
	leer cateto2;
	hipotenusa <- CalcularHipotenusa(cateto1,cateto2);
	cateto1 <- CalcularCuadrado(cateto1);
	cateto2 <- CalcularCuadrado(cateto2);
	si hipotenusa = cateto1 + cateto2 Entonces
		escribir "es un triangulo rectangulo";
	SiNo
		escribir "No es un triangulo rectangulo";
	FinSi
	
	
FinProceso