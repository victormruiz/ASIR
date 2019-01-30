print("COMPARADOR DE NÚMEROS")
num1=int(input("Escribe el primer número: "))
num2=int(input("Escribe el segundo número: "))
num3=int(input("Escribe el tercer número: "))

if num1 == num2 and num2 == num3:
    print("Has escrito 3 veces el mismo número")
elif num1 != num2 and num2 != num3 and num1 != num3:
    print ("Has escrito 3 números diferentes")
else:
    print("Has escrito un número 2 veces")
