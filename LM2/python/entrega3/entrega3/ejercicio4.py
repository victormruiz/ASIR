print("ALUMNOS Y NOTAS")
import os
def calcular_media(media):
    sum=0
    cont=0
    for i in media:
        sum=sum+i
        cont=cont+1
    print("%.1f" % (sum/cont))
def calcular_media_return(media):
    sum=0
    cont=0
    for i in media:
        sum=sum+i
        cont=cont+1
    resultado=str("{0:.2f}".format(sum/cont))
    return(resultado)
def porcentaje(porc):
    aprobados=0
    total=0
    for i in porc:
        if i >= 5:
            aprobados=aprobados+1
            total=total+1
        else:
            total=total+1
    total=(aprobados*100)/total
    print("%.2f"%total,"%")
alumnos=[]
with open("notas.csv","r") as fichero:
    for i in fichero:
        lista=i.split(',')
        diccionario={'Nombre':lista[1],'Apellidos':lista[0], 'Curso':lista[2],'Notas':{'FH':lista[3],'LM':lista[4],'ISO':lista[5],'FOL':lista[6],'PAR':lista[7],'SGBD':lista[8][0]}}
        alumnos.append(diccionario)
alumnos.pop(0)


print("Elige que quieres hacer")
print("1. Notas de una asignatura de un curso completo.")
print("2. Porcentaje de aprobados de un curso.")
print("3. Crear un fichero de un curso con la media de cada alumno.")
print("4. imprime la nota media de cada alumno.")
print("0. Salir del programa.")
opcion=int(input("Escribe la opción elegida: "))
while opcion >= 0:
    if opcion == 1:
        curso=input("Escribe un curso: ")
        asignatura=input("Escribe una asignatura: ")
        aprobado=0
        total=0
        for i in alumnos:
            if i['Curso']==curso:
                print("El alumno",i["Nombre"],"Tiene un",i['Notas'][asignatura])
    elif opcion == 2:
        curso=input("Escribe un curso: ")
        notaslm=[]
        notasfh=[]
        notasiso=[]
        notasfol=[]
        notaspar=[]
        notassgbd=[]
        for i in alumnos:
            if i['Curso']== curso:
                nota=i['Notas']['LM']
                notaslm.append(int(nota))
                nota=i['Notas']['FH']
                notasfh.append(int(nota))
                nota=i['Notas']['ISO']
                notasiso.append(int(nota))
                nota=i['Notas']['FOL']
                notasfol.append(int(nota))
                nota=i['Notas']['PAR']
                notaspar.append(int(nota))
                nota=i['Notas']['SGBD']
                notassgbd.append(int(nota))
        porc=notaslm
        print("El porcentaje de aprobados de la asignatura Lenguaje de marcas es: ",end="")
        porcentaje(porc)
        porc=notasfh
        print("El porcentaje de aprobados de la asignatura Fundamento de Hardware es: ",end="")
        porcentaje(porc)
        porc=notasiso
        print("El porcentaje de aprobados de la asignatura Sistemas operativos es: ",end="")
        porcentaje(porc)
        porc=notasfol
        print("El porcentaje de aprobados de la asignatura Formación y orientación al mundo laboral es: ",end="")
        porcentaje(porc)
        porc=notaspar
        print("El porcentaje de aprobados de la asignatura Planificación y administración de redes es: ",end="")
        porcentaje(porc)
        porc=notassgbd
        print("El porcentaje de aprobados de la asignatura Sistema de gestión de base de datos es: ",end="")
        porcentaje(porc)
    elif opcion ==3:
        curso=input("Escribe un curso: ")
        os.system('touch clase.txt')
        os.system("echo medias del curso "+curso+" > clase.txt")
        os.system("echo >> clase.txt")
        print("Fichero creado!")
        for i in alumnos:
            if i['Curso']==curso:
                media=[int(i['Notas']['FH']),int(i['Notas']['LM']),int(i['Notas']['ISO']),int(i['Notas']['FOL']),int(i['Notas']['PAR']),int(i['Notas']['SGBD'])]
                cadena=i["Nombre"]+" "+i["Apellidos"]+" "+calcular_media_return(media)+" >> clase.txt"
                os.system("echo "+cadena)
    elif opcion == 4:
        media=0
        for i in alumnos:
            print ("El alumno",i["Nombre"],"Tiene una media de ",end="")
            media=[int(i['Notas']['FH']),int(i['Notas']['LM']),int(i['Notas']['ISO']),int(i['Notas']['FOL']),int(i['Notas']['PAR']),int(i['Notas']['SGBD'])]
            calcular_media(media)
    elif opcion == 0:
        print("Saliendo del programa.")
        break
    else:
        print("Opción no válida")
    print("Elige que quieres hacer")
    print("1. Notas de una asignatura de un curso completo.")
    print("2. Porcentaje de aprobados de un curso.")
    print("3. crear un fichero de un curso con la media de cada alumno.")
    print("4. imprime la nota media de cada alumno.")
    print("0. Salir del programa.")
    opcion=int(input("Escribe la opción elegida: "))
