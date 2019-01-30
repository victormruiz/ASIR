print("TEMPERATURAS")
from urllib.request import urlopen
import re
provincia=input("Escribe la provincia que quieras buscar: ")
localidad=input("Escribe la localidad que quieras buscar: ")
provincia=provincia.replace(" ","-")
localidad=localidad.replace(" ","-")
bandera=False
response = urlopen("http://tiempoytemperatura.es/espana/%s/%s.html"%(provincia,localidad))
localidad=localidad.replace("-"," ")
lineas=response.readlines()
lista=[]
contador=0
for i in lineas:
    conversion=str(i)
    if conversion.find("Ahora") != -1:
        contador=contador+1
    if contador == 3:
        contador=-1
        lista.append(conversion)
        bandera=True
        lista.pop(0)
    if bandera==True:
        lista.append(conversion)
temperatura=re.findall('\d+', lista[2])
presion=re.findall('\d+', lista[8])
humedad=re.findall('\d+', lista[7])

print("La temperatura actual de %s es: %s°" % (localidad,int(temperatura[0])))
print("La presión actual en %s es: %s hPa" % (localidad,int(presion[0])))
print("La humedad relativa actual en %s es: %s" % (localidad,int(humedad[0]))+"%")
