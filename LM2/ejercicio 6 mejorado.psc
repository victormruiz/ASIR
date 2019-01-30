Proceso ejercicio6mejorado
	definir sueldo como real;
	definir comision como entero;
	definir comisionmensual como real;
	definir contador como real;
	contador <- 1;
	comisionmensual <- 0;
	escribir "Escribe tu sueldo base";
	leer sueldo;
	escribir "Escribe cuantas ventas has hecho en el mes";
	leer comision;
	si comision > 0 entonces
		comisionmensual <- sueldo*0.1;
		mientras comision <> contador Hacer
			comisionmensual <- comisionmensual + sueldo*0.1;
			contador <- contador+1;
		FinMientras
	finsi
	escribir "tu sueldo este mes has sido de ", sueldo+comisionmensual;
FinProceso
