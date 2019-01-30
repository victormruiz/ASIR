print("TEMPERATURAS")
temperaturas='''
	Utrera,29,12
	Dos Hermanas,32,14
	Sevilla,30,15
	Alcalá de Guadaíra,31,14
'''
bool=False
temperaturas=temperaturas.split('\n\t')
temperaturas.pop(0)
for i in temperaturas:
	resultado=int(i.split(',')[1])+int(i.split(',')[2])//2
	print("La temperatura media de",i.split(',')[0], "es %d grados" % resultado)
ciudad=str(input("Dime el nombre de una ciudad: "))
for i in temperaturas:
	if i.split(',')[0] == ciudad:
		print ("La temperatura máxima es", i.split(',')[1], "grados y la mínima de", i.split(',')[2])
		bool=True
if bool==False:
	print("No hay ninguna ciudad con ese nombre en nuestra base de datos")
