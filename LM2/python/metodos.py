---------------------------------cadenas----------------------------

capitalize() nos permite devolver la cadena con el primer carácter en mayúsculas.
lower() y upper() convierte la cadena de caracteres en minúsculas y mayúsculas  respectivamente.
swapcase(): devuelve una cadena nueva con las minúsculas convertidas a mayúsculas y viceversa.
title(): Devuelve una cadena con los primeros caracteres en mayúsculas de cada palabra.
count(): Es un método al que indicamos como parámetro una subcadena y cuenta cuantas apariciones hay de esa subcadena en la cadena.
find() nos devuelve la posición de la subcadena que hemos indicado como parámetro. Sino se encuentra se devuelve -1.
startswith() nos indica con un valor lógico si la cadena empieza por la subcadena que hemos indicado como parámetro. Podemos indicar también con otro parámetro la posición donde tiene que buscar.
endswith() igual que la anterior pero indica si la cadena termina con la subcadena indicada. En este caso, se puede indicar la posición de inicio y final de búsqueda.
replace(): Devuelve una cadena donde se ha sustituido las apariciones de la primera subcadena indicada por la segunda subcadena indicada como parámetro.
strip(): Devuelve una cadena donde se han quitado los espacios del principio y del final. Si indicamos una subcadena como parámetro quitará dicha subcadena del principio y del final.
aunque todavía no lo hemos estudiado, el método split() nos permite convertir una cadena en una lista. Lo usaremos más adelante.
splitlines(): Nos permite separar las líneas que hay en una cadena (indicada con el carácter \n) en una lista.



---------------------------------listas-------------------------------

append(): añade un elemento a la lista:
extend(): Une dos listas:
insert(): Añade un elemento en un posición indicada de la lista:
pop(): elimina un elemento de la lista y lo devuelve. Se puede indicar el índice del elemento que queremos obtener como parámetro, sino se indica se devuelve y elimina el último:
remove(): Elimina el elemento de la lista indicado por la posición:
reverse(): Modifica la lista invirtiendo los elementos:
sort(): Modifica la lista ordenando los elementos, se puede indicar el sentido de la ordenación:
count(): devuelve el número de apariciones de un elemento en la lista:
index(): Nos devuelve la posición de la primera aparición del elemento indicado. Se puede indicar la posición inicial y final de búsqueda:
''.join(): Une los elementos de una lista por el elemento entre comillas.
