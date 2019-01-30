import math
print("ejercicio2")
a=int(input("Escribe el coeficiente a: "))
b=int(input("Escribe el coeficiente b: "))
c=int(input("Escribe el coeficiente c: "))
x=0
if a == 0:
	x=-c/b
	print("La solucion es ",x)
elif b*b-(4*a*c)<0:
	print("Raices complejas")
else:
	print(-b+math.sqrt(b*b-(4*a*c))/2*a)
	print(-b-math.sqrt(b*b-(4*a*c))/2*a)
