print("MAYORES QUE EL PRIMERO")
vuelta=int(input("¿Cuantos números vas a introducir? "))
control=0
while vuelta < 0:
    print("Mal... piensa un poco y lee la pregunta.")
    vuelta=int(input("¿Cuantos números vas a introducir? "))
num1=int(input("Escribe un número: "))
for i in range(vuelta):
    num2=int(input("Escribe un número mayor que %d: " % num1))
    if num1 > num2:
        print("%d no es mayor que %d!" % (num2,num1))
    elif num1 == num2:
        print("Has escrito el mismo número")
    else:
        num1=num2
