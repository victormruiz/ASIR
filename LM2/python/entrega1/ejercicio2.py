print("COMPARADOR DE AÑOS")
ano1=int(input("Escribe el año acutal: "))
ano2=int(input("Escribe el un año cualquiera: "))

if ano1 > ano2:
    if ano1-ano2 == 1:
        print("desde el ano %d hasta el %d ha pasado %d año" % (ano2,ano1,ano1-ano2))
    else:
        print("desde el ano %d hasta el %d han pasado %d años" % (ano2,ano1,ano1-ano2))
elif ano1==ano2:
    print("Los 2 años introducidos son el mismo")
else:
    if ano2-ano1==1:
        print("Falta %d año para llegar al %d"%(ano2-ano1,ano2))
    else:
        print("Faltan %d años para llegar al %d"%(ano2-ano1,ano2))
