print("CODIGOS POSTALES")
cont=0
lista=[]
estados=[]
comp=""
l2=[]
coordenadas=[]
l3=[]
l4=[]
ciudades=[]
dic={}
ciudadycoord=[]

with open("zips.json","r") as fichero:
    for i in fichero:
        lista.append(i.split(','))

for i in lista:
    estados.append(i[5][12:14])
    cadena=i[2]
    slide=(i[2])
    ciudad=i[1]
    ciudades.append(ciudad.split(':')[1])
    l2.append(slide.split('[ '))
for i in l2:
    l3.append(i[1])
for i in lista:
    slide=(i[3])
    l4.append(slide.split(' ')[1])
for i in zip(l3,l4):
    coordenadas.append(i)
for i in zip(ciudades,coordenadas):
    ciudadycoord.append(i)
cont=0
for i in estados:
    if i not in dic:
        dic[i]=1
    else:
        dic[i]= dic[i]+1
for y,z in dic.items():
    print("El estado %s se repite %i veces"%(y,z))

print("¿De que ciudad quieres ver el mapa?")
mapa=input("")
mapa=mapa.replace(" ","")
mapa=mapa.upper()
bandera=False
for i in ciudadycoord:
    quitar=i[0].replace('"','')
    quitar=quitar.replace(" ","")
    if mapa==quitar:
        print("http://www.openstreetmap.org/#map=14/%s/%s"%(i[1][1],i[1][0]))
        bandera=True
if bandera==False:
    print("No se ha encontrado una ciudad con ese nombre.")
