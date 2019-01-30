edad = int(input("Dime tu edad: "))
if edad >= 18:
    if edad >=80:
        print("Eres mayor de edad y además estás cerca de la muerte.")
    else:
        print("Eres mayor de edad.")
else:
    if edad <= 0:
        print("Ni siquiera has nacido...")
    else:
        print("Eres menor de edad")
