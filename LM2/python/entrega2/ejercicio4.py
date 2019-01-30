print("CREA TU LISTA EN PYTHON")
num=int(input("¿Cuántas palabras quieres que tenga tu lista?: "))
cont=1
contador=0
palabra=""
lista=[]
for i in range(num):
	palabra=str(input("Escribe la palabra %d: " % cont))
	cont=cont+1
	lista.append(palabra)
print ("Tu lista queda así: ", lista)
print("¿Que quieres hacer?")
print("1. Contar")
print("2. Modificar")
print("3. eliminar")
print("0. Salir")
opcion=int(input("Elige una opción: "))
while opcion == int(opcion):
	if opcion==1:
		buscar=str(input("Escribe la palabra que quieres buscar en tu lista: "))
		print("La palabra %s"%buscar, "aparece",lista.count(buscar),"veces en la lista")
	elif opcion==2:
		sustituir1=str(input("¿Que palabra quieres sustituir?: "))
		sustituir2=str(input("¿Por cual: "))
		for i in lista:
			if i == sustituir1:
				lista.pop(contador)
				lista.insert(contador,sustituir2)
				print("La lista queda así: ",lista)
			else:
				contador=contador+1
	elif opcion==3:
		eliminar=str(input("¿Qué palabra quieres eliminar?: "))
		for i in lista:
			if i == eliminar:
				lista.pop(contador)
				print("La lista queda así",lista)
			else:
				contador=contador+1
	elif opcion==0:
		print("Saliendo del programa")
		break
	else:
		print("Opción incorrecta")
	print ("Tu lista queda así: ", lista)
	print("¿Que quieres hacer?")
	print("1. Contar")
	print("2. Modificar")
	print("3. eliminar")
	print("0. Salir")
	opcion=int(input("Elige una opción: "))
