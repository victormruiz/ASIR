print("SUBCADENA")
cad=str(input("Escribe una cadena: "))
bool=False
comprobar=cad.upper()
for i in cad:
	if comprobar.count(i)>=2:
		bool=True
if bool:
	print("La cadena '%s' tiene caracteres repetidos"%cad)
else:
	print("La cadena '%s' NO contiene caracteres repetidos"%cad)
