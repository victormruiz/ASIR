from ejercicio1 import calcularprecio



nombre=input("Escribe el nombre del artículo: ")
precio=float(input("Escribe el precio del artículo: "))
cantidad=int(input("Escribe la cantidad del artículo: "))

while nombre != "*":
    calcularprecio(nombre,precio,cantidad)
    nombre=input("Escribe el nombre del artículo: ")
    precio=float(input("Escribe el precio del artículo: "))
    cantidad=int(input("Escribe la cantidad del artículo: "))
