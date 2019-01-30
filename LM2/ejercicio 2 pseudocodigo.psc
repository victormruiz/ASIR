Proceso ejercicio2
	definir base Como Entero;
	definir altura Como Entero;
	definir opcion como caracter;
	definir resultado Como Entero;
	escribir "Dime la base";
	leer base;
	escribir "Dime la altura";
	leer altura;
	escribir "Si quieres calcular el area escribe a, si quieres calcular el perímetro escribe p";
	leer opcion;
	Si opcion = "a" Entonces
		resultado <- base * altura;
		escribir "el area del rectángulo es ",resultado;
	SiNo
		resultado <- 2*base+2*altura;
		escribir "el perimetro del rectángulo es ",resultado;
		
	FinSi
FinProceso
