print("ALUMNOS Y EDADES")
bandera=False
numalumnos=0
contmax=0
mayores=[]
lista=[]
cont=0
contedad=1
contnombre=0
listaedades=[]
listaedades2=[]
max=0
suma=0
nombre=str(input("Escribe el nombre del alumno: "))
while nombre != "*":
	numalumnos=numalumnos+1
	edad=int(input("Escribe la edad del alumno %s: " % nombre))
	lista.append(nombre)
	lista.append(edad)
	nombre=str(input("Escribe el nombre del alumno: "))
print("La lista queda así: ",lista)
for i in range(numalumnos):
	num=lista[contedad]
	suma=suma+num
	nombre=lista[contedad-1]
	contedad=contedad+2
	if num > max:
		listaedades.append(nombre)
		max=num
	if num >= 18:
		mayores.append(nombre)
		mayores.append(num)
contedad=1
suma=0
for i in range(numalumnos):
	num=lista[contedad]
	suma=suma+num
	nombre=lista[contedad-1]
	contedad=contedad+2
	if num==max:
		listaedades2.append(nombre)
		contmax=contmax+1
#descomenta la linea de abajo para imprimir la lista de los mayores de edad
#print(mayores)
if mayores:
	print("los alumnos mayores de edad son: ")
	for i in range(len(mayores)//2):
		print(" -",mayores[cont], "con", mayores[cont+1], "años")
		cont=cont+2
else:
	print("No hay alumnos mayores de edad en esta clase")
cont=0
if contmax<=1:
	print ("El alumno con más edad es:",listaedades[len(listaedades)-1])
else:
	print ("Los alumnos con más edad son: ",end="")
	edades=','.join(listaedades2)
	print(edades)
print ("La media de los alumnos de la clase es %.2f" % (suma/numalumnos))
nombre=str(input("Escribe el alumno que quieres buscar: "))
for i in range(numalumnos):
	if nombre==lista[contnombre]:
		print(lista[contnombre],lista[contnombre+1],"años")
		contnombre=contnombre+2
		bandera=True
	else:
		contnombre=contnombre+2
if not bandera:
	print("Ese alumno no se encuentra en nuestra base de datos.")
