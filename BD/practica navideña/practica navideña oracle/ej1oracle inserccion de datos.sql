INSERT INTO Clientes (Codigo,NIF,Nombre,Direccion,Ciudad,Telefono) VALUES ('1','49584521X','Pepe','C/ avila 13','Sevilla','658365214');
INSERT INTO Clientes (Codigo,NIF,Nombre,Direccion,Ciudad,Telefono) VALUES ('2','58536254E','Maria','C/ lara 85','Cordoba','758412549');
INSERT INTO Clientes (Codigo,NIF,Nombre,Direccion,Ciudad,Telefono) VALUES ('3','58471254','Manuel','C/ america 56','Cadiz','695823567');
INSERT INTO Clientes (Codigo,NIF,Nombre,Direccion,Ciudad,Telefono) VALUES ('4','58471254F','Sara','C/ america 56','Cadiz','495823567');

INSERT INTO Operaciones (Codigo,Descripcion,HorasMO) VALUES (1,'Cambio de aceite',4);
INSERT INTO Operaciones (Codigo,Descripcion,HorasMO) VALUES (2,'Alineacion de direccion',7);
INSERT INTO Operaciones (Codigo,Descripcion,HorasMO) VALUES (3,'Cambio de neumatico',2);

INSERT INTO Materiales (Codigo,Nombre,Precio) VALUES (1,'Aceite','50');
INSERT INTO Materiales (Codigo,Nombre,Precio) VALUES (2,'Rueda','75');

INSERT INTO Coches (Matricula,Modelo,Color,PVP,CodigoCliente) VALUES ('3425FFX','Ibiza','Amarillo','12000',1);
INSERT INTO Coches (Matricula,Modelo,Color,PVP,CodigoCliente) VALUES ('G-6384-GF','C200','Rojo','25000',2);
INSERT INTO Coches (Matricula,Modelo,Color,PVP,CodigoCliente) VALUES ('3425-FFX','Astra','Rojo','11000',1);
INSERT INTO Coches (Matricula,Modelo,Color,PVP,CodigoCliente) VALUES ('7652LFT','Octavia','Plata','15000',2);
INSERT INTO Coches (Matricula,Modelo,Color,PVP,CodigoCliente) VALUES ('AF-2345-KF','320','Verde','7200',1);

INSERT INTO Revisiones(Codigo,FechaRevision,MatriculaCoches) VALUES('1',TO_DATE('14/07/2018 15' , 'DD/MM/YYYY HH24'),'3425FFX');
INSERT INTO Revisiones(Codigo,FechaRevision,MatriculaCoches) VALUES ('2',TO_DATE('16/08/2018 19' , 'DD/MM/YYYY HH24:MI') ,'G-6384-GF');
INSERT INTO Revisiones (Codigo,FechaRevision,MatriculaCoches)VALUES ('3',TO_DATE('26/10/2019 06' , 'DD/MM/YYYY HH24:MI') ,'3425FFX');

INSERT INTO PiezasPorOperacion(CodigoMaterial,CodigoOperacion,Cantidad) VALUES (1,1,1);
INSERT INTO PiezasPorOperacion(CodigoMaterial,CodigoOperacion,Cantidad) VALUES (2,3,4);


