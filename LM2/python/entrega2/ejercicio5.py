print("MISMAS PALABRAS")
num=int(input("¿Cuántas palabras quieres que tenga la primera lista?: "))
cont=1
lista1=[]
lista2=[]
encontrado=[]
primera=[]
segunda=[]
contador=0
for i in range(num):
	palabra=str(input("Escribe la palabra %d: " % cont))
	cont=cont+1
	lista1.append(palabra)
print("La primera lista es:", lista1)
num=int(input("¿Cuántas palabras quieres que tenga la segunda lista?: "))
cont=1
for i in range(num):
	palabra=str(input("Escribe la palabra %d: " % cont))
	cont=cont+1
	lista2.append(palabra)
print("La segunda lista es:", lista2)
for i in lista1:
	if i in lista2:
		if i not in encontrado:
			encontrado.append(i)
	elif i not in lista2:
		if i not in primera:
			primera.append(i)
for i in lista2:
	if i not in lista1:
		if i not in segunda:
			segunda.append(i)


print("Palabras que aparecen en la 2 listas: ", encontrado)
print("Palabras que aparecen solo en la primera lista: ", primera)
print("Palabras que solo aparecen en la segunda lista: ", segunda)
print("Todas las palabras: ", encontrado+primera+segunda)
