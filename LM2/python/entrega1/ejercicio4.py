print("DIVISORES")
num=int(input("Escribe un número mayor que 0: "))
cont=1
while num < 0:
    print("Te he dicho un número mayor que 0!")
    num=int(input("Escribe un número mayor que 0: "))
print('los divisores de %d son ' % num ,end="")
while cont <= num/2:
    if num % cont == 0:
        print (cont,end=" ")
    cont=cont+1
print (num)
