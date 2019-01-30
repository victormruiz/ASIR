print("CALCULAR DIA JULIANO")
meses={'enero':31, 'febrero':28, 'marzo':31, 'abril':30, 'mayo':31, 'junio':30, 'julio':31, 'agosto':31, 'septiembre':30, 'octubre':31, 'noviembre':30, 'diciembre':31}
def validar_fecha(dia,mes,año):
    bandera=False
    for i,x in meses.items():
        if dia==29 and mes=="febrero":
            comp=(esbisiesto(año))
            return(comp)
            break
        elif dia<=x and dia>0 and mes==i:
            return(True)
            break
    if bandera == False:
        print("Fecha incorrecta.")
        return(False)

def esbisiesto(año):
    if(año % 4 == 0 and año % 100 != 0 or año % 400 == 0):
        return(True)
    else:
        print("Ese año no es bisiesto.")
        return(False)

def calcularjuliano(dia,mes):
    sum=0
    lista=["enero","febrero","marzo","abril","mayo","junio","julio","agosto","septiembre","octubre","noviembre","diciembre"]
    for i in lista:
        if mes==i:
            break
        else:
            sum=sum+meses[i]
    sum=sum+dia
    print("el día juliano de esa fecha es",sum)



fecha=str(input("Escribe una fecha (ej: 01/julio/1992): "))
comprobarfecha=False
while comprobarfecha==False:
    fecha=fecha.split("/")
    dia=int(fecha[0])
    mes=fecha[1]
    año=int(fecha[2])
    bandera=validar_fecha(dia,mes,año)
    if bandera==True:
        calcularjuliano(dia,mes)
        comprobarfecha=True
    else:
        fecha=str(input("Escribe una fecha (ej: 01/julio/1992): "))
