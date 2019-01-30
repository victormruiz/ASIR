from random import randint
print("JUEGO DE MULTIPLICACIONES")
vueltas = int(input("¿Cuantas multiplicaciones quieres hacer? "))
correctas=0
for i in range(vueltas):
    num1 = randint(2, 10)
    num2 = randint(2, 10)
    resultado=num1*num2
    respuesta=int(input("¿Cuanto es %d x %d?: " % (num1,num2)))
    if respuesta==resultado:
        print("¡Correcto!")
        correctas=correctas+1
    else:
        print("¡Respuesta incorrecta!")
print("Has contestado correctamente %d preguntas de %d" % (correctas,vueltas))
nota=correctas/vueltas*10
if nota >= 5:
    print("Enhorabuena, has aprobado con un %.1f" % nota)
else:
    print("Lo siento pero has suspendido con un %.1f" % nota)
