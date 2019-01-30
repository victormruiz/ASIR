print("DIVISOR DE NÚMEROS")
dividendo=int(input("Escribe el dividendo: "))
divisor=int(input("Escribe el divisor: "))
if divisor==0:
    print("No se puede divir por 0")
elif dividendo%divisor==0:
    print("la división es exacta. cociente %d" % (dividendo/divisor))
else:
    print("La división no es exacta. cociente %d, resto %d" % (dividendo/divisor,dividendo%divisor))
