pesos=[50000,20000,10000,5000,2000,1000,500,200,100,50,20,10,5,2,1]
euros=[500,200,100,50,20,10,5,2,1,0.5,0.2,0.1,0.05,0.02,0.01]
cont=0
total=float(input("Cantidad total a pagar: "))
entregada=float(input("Cantidad entregada: "))
devolver2=(entregada-total)
devolver=round((entregada-total)*100)
decimales="{0:.2f}".format(devolver2)
print("Cantidad a devolver:", decimales, "€")
print(" ")

for i in pesos:
    if devolver/i>=1:
        if cont > 11 and devolver/i < 1.9:
            centimos=str(euros[cont])
            centimos=centimos.replace("0.0","")
            if cont == 14:
                print("%d Moneda de %s centimo" % (devolver/i,centimos))
            else:
                print("%d Moneda de %s centimos" % (devolver/i,centimos))
            devolver=devolver%i
        elif cont > 11 and devolver/i > 1.9:
            if cont == 14:
                print("%d Monedas de %s centimo" % (devolver/i,centimos))
            else:
                print("%d Monedas de %s centimos" % (devolver/i,centimos))
            entimos=str(euros[cont])
            centimos=centimos.replace("0.0","")
            print("%d Monedas de %s centimos" % (devolver/i,centimos))
            devolver=devolver%i
        elif cont >= 9 and cont <= 11 and devolver/i < 1.9:
            centimos=str(euros[cont])
            centimos=centimos.replace("0.","")
            centimos=centimos+"0"
            print("%d Moneda de %s centimos" % (devolver/i,centimos))
            devolver=devolver%i
        elif cont >= 9 and cont <= 11 and devolver/i > 1.9:
            centimos=str(euros[cont])
            centimos=centimos.replace("0.","")
            centimos=centimos+"0"
            print("%d Monedas de %s centimos" % (devolver/i,centimos))
            devolver=devolver%i
        elif cont > 6 and cont < 9 and devolver/i < 1.9:
            print("%d Moneda de %s euros" % (devolver/i,euros[cont]))
            devolver=devolver%i
        elif cont > 6 and cont < 9 and devolver/i > 1.9:
            print("%d Monedas de %s euros" % (devolver/i,euros[cont]))
            devolver=devolver%i
        elif cont <= 6 and devolver/i < 1.9:
            print("%d billete de %s euros" % (devolver/i,euros[cont]))
            devolver=devolver%i
        elif cont <= 6 and devolver/i > 1.9:
            print("%d billetes de %s euros" % (devolver/i,euros[cont]))
            devolver=devolver%i
    cont=cont+1
