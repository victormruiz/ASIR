from funciones import pasar_a_segundos,calcular_coste,convertir_a_euros

lista=[]
with open("comunicaciones.txt","r") as fichero:
    for i in fichero:
        if ":" not in i:
            tarifa=int(i[len(i)-2])
        else:
            lista.append(i)
coste=0
acu=0
cont=1
for i in lista:
    comm=i.split(":")
    segundos=pasar_a_segundos(int(comm[0]),int(comm[1]),int(comm[2]))
    coste=calcular_coste(segundos,tarifa)
    euros=convertir_a_euros(coste)
    print("El coste de la comunicación numero %i es de %s segundos y un coste de %s€ en total" % (cont,segundos,euros))
    acu=acu+euros
    cont=cont+1
print("El precio total de todas las comunicaciones es de %.2f€"%acu)
