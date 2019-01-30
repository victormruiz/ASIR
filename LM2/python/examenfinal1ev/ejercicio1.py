print("ejercicio 1")
numeros=[]
max=0
index=0
vueltas=int(input("¿Cuántos números vas a ibtroducir?: "))
for i in range(vueltas):
    index=index+1
    num=int(input("Escribe el %d número: "%index))
    numeros.append(num)
for i in numeros:
    if i > max:
        max=i
sum=sum(numeros)
print ("La cantidad de números introducidos son %d"%vueltas)
print ("El número mayor introducido es %d"%max)
numeros.sort()
print ("La lista ordenada es ",numeros)
print ("La media de los numeros es:",sum/vueltas)
