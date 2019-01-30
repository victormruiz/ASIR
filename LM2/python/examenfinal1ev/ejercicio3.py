print("ejercicio3")
lista=[]
cont=0
bandera=False
cadena=str(input("Escribe una cadena: "))
while cadena!= "*":
	lista.append(cadena)
	cadena=str(input("Escribe una cadena: "))
lista.sort(key = str.lower)
print("La lista ordenada alfabeticamente es: ",lista)
for i in lista:
	if len(i)>5:
		print("la cadena con mas de 5 caracteres es: ",i)
	for x in i:
		if x == " ":
			bandera=True
if bandera==True:
	print("Hay cadenas con espacios")
else:
	print("No hay cadenas con espacios")
cad2=str(input("Dime una cadena por la que quieres comprobar que empiece: "))
for i in lista:
	if i.startswith(cad2):
		print(i," Empieza por ",cad2)
