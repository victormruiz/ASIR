print("SUMA ENTRE VALORES")
num1=int(input("Dime un número entero: "))
sum=0
while num1 < 0:
    print("Te he pedido un número entero")
    num1=int(input("Dime un número entero: "))
num2=int(input("Dime un número entero mayor que %d: " % num1))
while num2 < num1:
    print("Te he pedido un número entero mayor que %d"%num1)
    num2=int(input("Dime un número entero mayor que %d: " % num1))
for i in range(num1,num2):
    sum=sum+i
    print("%d + "%i,end="")
sum=sum+num2
print("%d = %d" % (num2,sum))
