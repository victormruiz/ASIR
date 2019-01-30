def calcula_dc(lista):
    """Calcula el dígito de control de una CCC.
    Recibe una lista con 10 numeros enteros y devuelve el DC
    correspondiente"""

    pesos = [1, 2, 4, 8, 5, 10, 9, 7, 3, 6]
    aux = []
    for i in range(10):
        aux.append(lista[i]*pesos[i])
    resto = 11 - sum(aux)%11
    if resto == 10:
        return 1
    elif resto == 11:
        return 0
    else:
        return resto

ccc=str(input("Escribe un número de cuenta válido: "))
found=False
while len(ccc) != 20:
    print("El número introducido no tiene 20 carácteres")
    ccc=str(input("Escribe un número de cuenta válido: "))
lista=[]
secundaria=ccc[0:8]
secundaria="00"+ccc[0:8]
for i in secundaria:
    lista.append(int(i))
num1=calcula_dc(lista)
lista=[]
secundaria=ccc[10:20]
for i in secundaria:
    lista.append(int(i))
num2=calcula_dc(lista)
if int(num1) == int(ccc[8:9]) and int(num2) == int(ccc[9:10]):
    print("La Cuenta Corriente es válida",end="")
    found=True
    with open("bancos.txt","r") as fichero:
        for i in fichero:
            if int(ccc[0:4])==int(i[0:4]):
                print(", la entidad es:",i[5::])
                found=False
        if found==True:
            print(", pero la entidad no se encuentra registrada en nuestra base de datos")
else:
    print("La cuenta Corriente NO es válida")
##02370302909166764166
##20486594507485212548
