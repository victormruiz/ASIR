print("ejercicio 4")
almacen=[]
items=[]
numobjetos=0
codigo=int(input("Escribe el codigo del articulo: "))
while codigo != 0:
	numobjetos=numobjetos+1
	nombre=str(input("Escribe el nombre del objeto: "))
	cantidad=int(input("Escribe la cantidad de %s: "%nombre))
	precio=float(input("Escribe el precio del objeto %s: " % nombre))
	items.append(codigo)
	items.append(nombre)
	items.append(cantidad)
	items.append(precio)
	almacen.append(items)
	items=[]
	codigo=int(input("Escribe el codigo del objeto: "))
print(almacen)
for i in almacen:
	print("código: ",i[0],"Nombredel articulo: ",i[1],"Precio iva incluido: ",i[3]*0.21+i[3])
	if i[2]<10:
		print("codigo: ",i[0], "Nombre: ",i[1], "!Hay menos de 10 unidades¡")

buscar=int(input("Dime el codigo del articulo que quieres buscar: "))
for i in almacen:
	if i[0]==buscar:
		print("el articulo con ese código es",i[1])
