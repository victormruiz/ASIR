Proceso ejercicio3
	definir minutoscal como real;
	definir contador como entero;
	definir diascal como entero;
	definir turnocal como entero;
	definir minutos como entero;
	definir dia como cadena;
	definir turno como cadena;
	contador <- 0;
	minutoscal <- 0.0;
	escribir "di la duración de la llamada";
	leer minutos;
	escribir "di el día de la semana de la llamada";
	leer dia;
	escribir "¿La llamada ha sido por la tarde o por la mañana?";
	leer turno;
	Mientras contador <= 5 y contador =! minutos Hacer
		minutoscal <- minutoscal+1;
		contador <-contador+1;
		escribir contador;
	FinMientras
	Mientras contador >=5 y contador < 8 y contador =! minutos Hacer
		minutoscal <- minutoscal+0.8;
		contador <- contador+1;
	FinMientras
	Mientras contador >=8 y contador < 10 y contador =! minutos Hacer
		minutoscal <- +0.7;
		contador <- contador+1;
	FinMientras
	Mientras contador >=10 y contador < minutos y contador =! minutos Hacer
		minutoscal <- minutoscal+0.5;
		contador <- contador+1;
	FinMientras
escribir minutoscal;
FinProceso
