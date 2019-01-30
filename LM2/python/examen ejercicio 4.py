limiteinf=int(input("Escribe el límite inferior: "))
limitesup=int(input("Escribe el limite superior: "))
sumatorio=0
contfuera=0
contdentro=0
activador=False
while limitesup < limiteinf:
    print("El límite superior debe ser mayor que el límite inferior")
    limitesup=int(input("Escribe el limite superior: "))
    limiteinf=int(input("Escribe el límite inferior: "))
positivo=int(input("Escribe un número positivo: "))
while positivo != 0:
    while positivo < 0:
        print("El número escrito no es positivo")
        positivo=int(input("Escribe un número positivo: "))
    if positivo > limiteinf and positivo < limitesup:
        contdentro = contdentro+1
    elif positivo < limiteinf or positivo > limitesup:
        sumatorio=sumatorio+positivo
        contfuera=contfuera+1
    elif positivo == limitesup or positivo == limiteinf:
        activador=True
    positivo=int(input("Escribe un numero positivo: "))
if contfuera > 0:
    resultado=sumatorio/contfuera
    print("La media de los números fuera del intervalo es %.2f" % resultado)
if contdentro > 0:
    print("La cantidad de números introducidos estrictamente dentro del intervalo es %d" %  contdentro)
if activador:
    print("Se ha introducido al menos un número igual a uno de los extremos")
