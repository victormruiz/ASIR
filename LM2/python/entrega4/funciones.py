def pasar_a_segundos(horas,minutos,segundos):
    segundos=(horas*60)*60+minutos*60+segundos
    return(segundos)

def calcular_coste(segundos,tarifa):
    tarifa=int(tarifa)
    centimos=segundos*tarifa
    return(centimos)

def convertir_a_euros (centimos):
    euros=centimos//100
    centimos=centimos%100
    cadena=str(euros)+"."+str(centimos)
    cadena=float(cadena)
    return(cadena)
