def calcularprecio(nombre,precio,cantidad):
    rebaja=estarebajado(nombre)
    if rebaja==True:
        print("El precio del artículo es %f"%(precio*cantidad))

def estarebajado(nombre):
    if nombre.find("Rebajas") != -1:
        return(True)
    else:
        return(False)


nombre=input("Escribe el nombre del artículo: ")
precio=float(input("Escribe el precio del artículo: "))
cantidad=int(input("Escribe la cantidad del artículo: "))

calcularprecio(nombre,precio,cantidad)
