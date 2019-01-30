base = int(input("Dime el número del que quieres saber la tabla: "))
for i in range(0,11):
    print (base," x ",i, " = ", i*base )





CREATE DATABASE LINK linkprueba
CONNECT TO SCOTT
IDENTIFIED BY TIGER
USING 's1';

Select * from  dblink(
'dbname=prueba host=172.29.1.75 user=usuario password=usuario',
'select * from entrada1')
as (persona varchar);
