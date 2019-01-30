from ejercicio1 import calcularprecio

lista=[]
with open("listacompra","r") as fichero:
    for i in fichero:
        lista.append(i.split(','))

for i in lista:
    nombre=i[0]
    precio=float(i[1])
    cantidad=int(i[2])
    calcularprecio(nombre,precio,cantidad)
