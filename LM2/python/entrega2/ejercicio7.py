print("ALUMNOS Y EDADES V2")
numalumnos=0
bandera=False
mayores=[]
lista=[]
l2=[]
listaedades=[]
max=0
edad=0
media=0
nombre=str(input("Escribe el nombre del alumno: "))
while nombre != "*":
	numalumnos=numalumnos+1
	edad=int(input("Escribe la edad del alumno %s: " % nombre))
	lista.append(nombre)
	lista.append(edad)
	l2.append(lista)
	lista=[]
	nombre=str(input("Escribe el nombre del alumno: "))
print("La lista queda así: ",l2)
for i in l2:
	if i[1] >= 18:
		mayores.append(i)
	if i[1]>max:
		max=i[1]
	media=media+i[1]/len(l2)
for i in l2:
	if i[1]==max:
		listaedades.append(i[0])
#descomenta la linea de abajo para imprimir la lista de los mayores de edad
#print(mayores)
if mayores:
	print ("Los alumnos mayores de edad son:")
	for i in mayores:
		print(" -",i[0],"con",i[1],"años")
else:
	print("No hay alumnos mayores de edad")
if len(listaedades)<=1:
	alumno=''.join(listaedades)
	print("El alumno mayor es:",alumno)
else:
	varlistaedades=', '.join(listaedades)
	print("Los alumnos mayores son:",varlistaedades)
print("La media de edad de la clase es %.2f: "%media)
nombre=str(input("Escribe el alumno que quieres buscar: "))
for i in l2:
	if i[0]==nombre:
		print(i[0],"tiene",i[1],"años")
		bandera=True
if not bandera:
	print("No hay ningún alumno con ese nombre en nuestra base de datos")
