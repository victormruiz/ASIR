funcion valido <- leer_numero(num3)
	definir valido Como Logico;;	
	mientras num3 < 0 Hacer
		escribir "El número indicado no es positivo, escribe un numero positivo";
		leer num3;
	FinMientras
	valido <- verdadero;
FinFuncion

funcion dentro <- estadentrodeintervalo(num1,num2,num3)
	definir dentro como logico;
	si num3 > num1 y num3 < num2 Entonces
		dentro <- verdadero;
	SiNo
		dentro <- falso;
	FinSi
FinFuncion

funcion limite <- esunlimite(num1,num2,num3)
	definir limite como logico;
	si num3=num1 o num3=num2 entonces
		limite <- verdadero;
	SiNo
		limite <- falso;
	FinSi
FinFuncion


Proceso ejercicio4
	definir num1 como real;
	definir num2 como real;
	definir num3 como real;
	definir resultado1 como real;
	definir resultado2 como real;
	definir resultado3 como real;
	definir contador como entero;
	resultado1 <-0;
	resultado2 <-0;
	resultado3 <-0;
	contador <-0;
	escribir "Escribe el extremo inferior del intervalo";
	leer num1;
	escribir "Escribe el extremo superior del intervalo";
	leer num2;
	escribir "Escribe un numero dentro del intervalo";
	leer num3;
	si leer_numero(num3) = verdadero entonces
		mientras num3 <> 0 hacer
			si leer_numero(num3) = verdadero entonces
				si estadentrodeintervalo(num1,num2,num3) = verdadero Entonces
					resultado1 <- resultado1+1;
				SiNo
					resultado3 <- resultado3+num3;
					contador <- contador+1;
				FinSi
				si esunlimite(num1,num2,num3) = verdadero entonces
					resultado2 <- resultado2+1;
				FinSi
				escribir "Escribe el número dentro del intervalo";
				leer num3;
			FinSi
		FinMientras
	finsi
	resultado3 <- resultado3/contador;
	escribir resultado3," Es la media de los números fuera del intervalo";
	si resultado2 > 0 entonces
		escribir "SI se ha introducido al menos un número igual a algunos de los intervalos";
	SiNo
		escribir  "NO se ha introducido al menos un número igual a algunos de los intervalos";
	finsi
	escribir resultado1," Es la cantidad de números dentro del intervalo";

FinProceso
