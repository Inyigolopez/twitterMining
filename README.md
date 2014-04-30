twitterMining
=============


El script principal lee los diccionarios de la carpeta dictionary.
Posteriormente recoge un numero n de tweets que contengan una determinada palabra (configurable)

Se hace una limpieza de los tweets y posteriormente se cruza cada tweets con cada una de las palabras de los distintos
diccionarios ayudandonos de la funcion sapply.

Se construye un dataframe con los resultados obtenidos donde tendremos el usuario de twitter y el numero de veces que
ha escrito cada palabra de un determinado diccionario en un unico tweet
