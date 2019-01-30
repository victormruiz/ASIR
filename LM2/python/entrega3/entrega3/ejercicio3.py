from crypt import crypt
from getpass import getpass
usuario=input("Escribe el nombre de usuario: ")
contraseña=getpass("Escribe la contraseña del usuario: ")
banderausuario=False
banderacontraseña=False
contraseñaencriptada=None
with open("shadow","r") as fichero:
   for linea in fichero:
       if usuario == linea.split(":")[0]:
           banderausuario=True
           encriptadacompleta=linea.split(":")[1]
           sal=encriptadacompleta[0:12]
           solucion=crypt(contraseña,sal)
           if solucion == encriptadacompleta:
               banderacontraseña=True
if banderausuario==True and banderacontraseña==False:
    print("Contraseña equivocada intentando aplicar un diccionario para averiguarla...")
    forzada=False
    with open("diccionario","r") as diccionario:
        lineas=diccionario.readlines()

    for i in lineas:
        i=i.replace("\n","")
        intentocontraseña=crypt(i,sal)
        if intentocontraseña == encriptadacompleta:
            passwd=i
            forzada=True
    if forzada == True:
        print("¡Contraseña encontrada! es: %s" % (passwd))
    else:
        print("La contraseña no se encuentra en nuestra base de datos")
elif banderausuario==False:
    print ("El usuario", usuario, "no existe en el sistema")
elif banderausuario==True and banderacontraseña==True:
    print("¡Has accedido al sistema!")
