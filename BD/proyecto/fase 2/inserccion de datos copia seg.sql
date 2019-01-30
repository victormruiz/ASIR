INSERT INTO CALADEROS (Referencia,Nombre,Ubicacion,Extension) VALUES ('GS','Gran Sol','Atlantico Norte',150000);
INSERT INTO CALADEROS (Referencia,Nombre,Ubicacion,Extension) VALUES ('TN','Terranova','Atlantico Norte',280000);
INSERT INTO CALADEROS (Referencia,Nombre,Ubicacion,Extension) VALUES ('MC','Marruecos','Costas de Africa',90000);
INSERT INTO CALADEROS (Referencia,Nombre,Ubicacion,Extension) VALUES ('MS','Mauritaunia y Senegal','Costas de Africa',300000);
INSERT INTO CALADEROS (Referencia,Nombre,Ubicacion,Extension) VALUES ('CV','Cabo Verde','Atlantico Sur',360000);
INSERT INTO CALADEROS (Referencia,Nombre,Ubicacion,Extension) VALUES ('GE','Groenlandia','Atlantico Norte',158000);

INSERT INTO ARMADORES (DNI,Nombre,Apellidos,Ciudad,Direccion,Telefono,NumeroCuenta) VALUES ('49094591X','Victor Manuel','Ruiz Mesa','Dos Hermanas(España)','C/ Alava 13',654958356,'ES56 0239 0806 7323 5206 7322');
INSERT INTO ARMADORES (DNI,Nombre,Apellidos,Ciudad,Direccion,Telefono,NumeroCuenta) VALUES ('52236294M','Sebastian','Ruiz Garcia','Sevilla(España)','C/ arroz 26',605020449,'ES50 8398 1625 7993 6314 5443');
INSERT INTO ARMADORES (DNI,Nombre,Apellidos,Ciudad,Direccion,Telefono,NumeroCuenta) VALUES ('49131363M','Raul','Corral Sanchez','Dos Hermanas(España)','C/ Vizcaya 62',664253327,'ES59 0914 2435 7131 1528 8767');
INSERT INTO ARMADORES (DNI,Nombre,Apellidos,Ciudad,Direccion,Telefono,NumeroCuenta) VALUES ('92857194F','Ezequiel','Adame Florindo','Caminha(Portugal)','R. Direita 20',656586417,'ES29 5769 6440 7155 8194 1531');


INSERT INTO BARCOS (Matricula,DNIArmador,Nombre,Clase,Eslora,Manga) VALUES ('7ª-IB-1-33-07','49094591X','Luhrs 31 open','Pesca/paseo','9.54','3.61');
INSERT INTO BARCOS (Matricula,DNIArmador,Nombre,Clase,Eslora,Manga) VALUES ('7ª-BA-4-90-99','52236294M','Astromar LS-707','Lancha','7.00','2.46');
INSERT INTO BARCOS (Matricula,DNIArmador,Nombre,Clase,Eslora,Manga) VALUES ('7ª-MA-4-17-02','49131363M','Maxum 3000 SCR','Lancha','9.82','3.98');
INSERT INTO BARCOS (Matricula,DNIArmador,Nombre,Clase,Eslora,Manga) VALUES ('7ª-BA-5-348-00','92857194F','Quer Divers','Embarcacion Abierta','9.00','2.48');
INSERT INTO BARCOS (Matricula,DNIArmador,Nombre,Clase,Eslora,Manga) VALUES ('7ª-BA-5-44-92','49094591X','Menorquin 45','Llaut a motor','7.48','3.05');
INSERT INTO BARCOS (Matricula,DNIArmador,Nombre,Clase,Eslora,Manga) VALUES ('7ª-BA-2-535-01','52236294M','Nimbus 31 Ultima','Llaut a motor','9.39','3.04');
INSERT INTO BARCOS (Matricula,DNIArmador,Nombre,Clase,Eslora,Manga) VALUES ('6ª-BA-2-70-15','49131363M','Myabca 32','Embarcacion cabinada','9.80','3.50');
INSERT INTO BARCOS (Matricula,DNIArmador,Nombre,Clase,Eslora,Manga) VALUES ('7ª-MA-3-35-12','92857194F','Astec 610','Pesca/Paseo','5.99','2.35');


INSERT INTO PUNTOS_DE_ATRAQUES (Cod,DistanciaAlonja,Manga,Eslora,CintaTransportadora,Precio) VALUES ('1',25.50,3.5,9.75,1,250.50);
INSERT INTO PUNTOS_DE_ATRAQUES (Cod,DistanciaAlonja,Manga,Eslora,CintaTransportadora,Precio) VALUES ('2',29.00,4.00,11.5,1,300.00);
INSERT INTO PUNTOS_DE_ATRAQUES (Cod,DistanciaAlonja,Manga,Eslora,CintaTransportadora,Precio) VALUES ('3',19.50,3.00,7.00,0,220.75);
INSERT INTO PUNTOS_DE_ATRAQUES (Cod,DistanciaAlonja,Manga,Eslora,CintaTransportadora,Precio) VALUES ('4',15.00,3.50,10.00,1,260.00);
INSERT INTO PUNTOS_DE_ATRAQUES (Cod,DistanciaAlonja,Manga,Eslora,CintaTransportadora,Precio) VALUES ('5',35.50,4.00,12.500,0,280.50);
INSERT INTO PUNTOS_DE_ATRAQUES (Cod,DistanciaAlonja,Manga,Eslora,CintaTransportadora,Precio) VALUES ('6',42.50,2.40,6.50,0,200.00);
INSERT INTO PUNTOS_DE_ATRAQUES (Cod,DistanciaAlonja,Manga,Eslora,CintaTransportadora,Precio) VALUES ('7',49.50,4.50,9.50,1,235.75);
INSERT INTO PUNTOS_DE_ATRAQUES (Cod,DistanciaAlonja,Manga,Eslora,CintaTransportadora,Precio) VALUES ('8',55.00,3.50,8.75,0,240.50);

INSERT INTO ESPECIES_DE_PESCADOS (Codigo,NombreCientifico,NombreComercial,Tipo,TamañoMinimo) VALUES ('1','Dicologlossa Cuneata','Acedia','Pescado Blanco',120.00);
INSERT INTO ESPECIES_DE_PESCADOS (Codigo,NombreCientifico,NombreComercial,Tipo,TamañoMinimo) VALUES ('2','Cuplea','Arenque','Pescado Azul',120.00);
INSERT INTO ESPECIES_DE_PESCADOS (Codigo,NombreCientifico,NombreComercial,Tipo,TamañoMinimo) VALUES ('3','Micromesistius Poutassou','Bacaladilla','Pescado Blanco',150.00);
INSERT INTO ESPECIES_DE_PESCADOS (Codigo,NombreCientifico,NombreComercial,Tipo,TamañoMinimo) VALUES ('4','Pagellus Bogaraveo','Besugo','Pescado Blanco',120.00);
INSERT INTO ESPECIES_DE_PESCADOS (Codigo,NombreCientifico,NombreComercial,Tipo,TamañoMinimo) VALUES ('5','Engraulis Encrasicolus','Boquerón','Pescado Azul',90.00);
INSERT INTO ESPECIES_DE_PESCADOS (Codigo,NombreCientifico,NombreComercial,Tipo,TamañoMinimo) VALUES ('6','Homarus Gammarus','Bogavante','Marisco',240.00);
INSERT INTO ESPECIES_DE_PESCADOS (Codigo,NombreCientifico,NombreComercial,Tipo,TamañoMinimo) VALUES ('7','Scomber Scombrus','Caballa','Pescado Azul',180.00);
INSERT INTO ESPECIES_DE_PESCADOS (Codigo,NombreCientifico,NombreComercial,Tipo,TamañoMinimo) VALUES ('8','Nephrops Norvegicus','Cigala','Marisco',70.00);

INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2018','1','GS',150);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2018','2','TN',175);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2018','3','MC',160);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2018','4','MS',95);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2018','5','CV',75);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2018','6','GE',185);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2017','1','GS',134);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2017','2','GE',135);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2017','1','MS',120);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2017','6','TN',185);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2017','2','MS',143);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2017','4','MS',95);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2017','4','GS',148);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2017','1','CV',163);
INSERT INTO CAPTURA_CALADEROS (año,CodigoEspecie,ReferenciaCaladero,MaximoKilos) VALUES ('2017','4','TN',110);



INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-IB-1-33-07','TN','2018-03-12','2018-03-15');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-4-90-99','MC','2018-03-13','2018-03-16');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-MA-4-17-02','CV','2018-03-11','2018-03-13');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-5-348-00','GE','2018-03-25','2018-03-28');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-5-44-92','MS','2018-04-03','2018-04-10');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-2-535-01','GS','2018-06-16','2018-06-18');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('6ª-BA-2-70-15','GS','2018-06-17','2018-06-20');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-MA-3-35-12','CV','2018-06-20','2018-06-22');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-5-44-92','MC','2018-06-25','2018-06-26');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-IB-1-33-07','GE','2018-07-02','2018-07-05');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-4-90-99','TN','2018-07-06','2018-07-10');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-5-348-00','MS','2018-07-12','2018-07-16');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-5-44-92','TN','2018-07-16','2018-07-18');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-2-535-01','CV','2018-07-22','2018-07-26');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-5-348-00','TN','2018-08-06','2018-08-12');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-5-44-92','GE','2018-08-16','2018-08-20');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('6ª-BA-2-70-15','MC','2018-08-22','2018-08-25');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-2-535-01','GE','2018-09-01','2018-09-05');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-MA-3-35-12','GS','2018-09-12','2018-09-16');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-IB-1-33-07','MS','2018-09-20','2018-09-26');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-2-535-01','CV','2018-09-27','2018-10-01');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-4-90-99','TN','2018-10-10','2018-10-13');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('7ª-BA-5-348-00','MS','2018-10-15','2018-10-20');
INSERT INTO FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin) VALUES ('6ª-BA-2-70-15','GE','2018-10-22','2018-10-29');

---------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPescaInicio,FechaPescaFin) VALUES (1,1,'MC','7ª-IB-1-33-07',15.50,128.50,'2018-03-12 07:00','2018-03-12 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (2,1,'TN','7ª-IB-1-33-07',13.00,126.50,'2018-03-13 07:00','2018-03-13 17:30'
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (3,1,'TN','7ª-IB-1-33-07',17.00,122.00,'2018-03-14 07:00','2018-03-14 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (4,1,'TN','7ª-IB-1-33-07',15.50,128.50,'2018-03-12 07:00','2018-03-12 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (5,2,'MC','77ª-BA-4-90-99',12.00,125.00,'2018-03-13 06:00','2018-03-13 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (6,2,'MC','77ª-BA-4-90-99',14.50,122.50,'2018-03-14 06:00','2018-03-14 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (7,2,'MC','77ª-BA-4-90-99',12.25,126.00,'2018-03-15 06:00','2018-03-15 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (8,3,'CV','7ª-MA-4-17-02',10.50,155.00,'2018-03-11 05:30','2018-03-11 16:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (9,3,'CV','7ª-MA-4-17-02',11.00,154.00,'2018-03-12 05:30','2018-03-12 16:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (10,3,'CV','7ª-MA-4-17-02',11.50,154.50,'2018-03-13 05:30','2018-03-13 16:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (11,4,'GE','7ª-BA-5-348-00',09.50,'121.50','2018-03-25 06:30','2018-03-25 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (12,4,'GE','7ª-BA-5-348-00',11.50,126.50,'2018-03-26 06:30','2018-03-26 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (13,4,'GE','7ª-BA-5-348-00',10.50,122.00,'2018-03-27 06:30','2018-03-27 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (14,4,'GE','7ª-BA-5-348-00',10.00,120.80,'2018-03-28 06:30','2018-03-28 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (15,5,'MS','7ª-BA-5-44-92',15.50,92.00,'2018-04-03 05:30','2018-04-03 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (16,5,'MS','7ª-BA-5-44-92',17.50,91.00,'2018-04-04 05:30','2018-04-04 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (17,6,'GS','7ª-BA-2-535-01',05.00,245.50,'2018-06-16 06:30','2018-06-16 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (18,6,'GS','7ª-BA-2-535-01',04.50,242.00,'2018-06-17 06:30','2018-06-17 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (19,6,'GS','7ª-BA-2-535-01',05.50,244.00,'2018-06-18 06:30','2018-06-18 17:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (20,7,'GS','6ª-BA-2-70-15',10.50,181.00,'2018-06-17 06:30','2018-06-17 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (21,7,'GS','6ª-BA-2-70-15',12.50,182.00,'2018-06-18 06:30','2018-06-18 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (22,7,'GS','6ª-BA-2-70-15',11.50,181.50,'2018-06-19 06:30','2018-06-19 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (23,7,'GS','6ª-BA-2-70-15',09.00,185.00,'2018-06-20 06:30','2018-06-20 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (24,7,'GS','6ª-BA-2-70-15',10.00,184.00,'2018-06-21 06:30','2018-06-21 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (25,8,'CV','7ª-MA-3-35-12',06.50,71.50,'2018-06-20 05:30','2018-06-20 15:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (26,8,'CV','7ª-MA-3-35-12',07.00,72.50,'2018-06-21 05:30','2018-06-21 15:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (27,8,'CV','7ª-MA-3-35-12',09.00,70.50,'2018-06-22 05:30','2018-06-22 15:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (28,5,'MC','7ª-BA-5-44-92',12.50,92.00,'2018-06-25 06:00','2018-06-25 16:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (29,5,'MC','7ª-BA-5-44-92',14.00,93.50,'2018-06-26 06:00','2018-06-26 16:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (30,4,'GE','7ª-IB-1-33-07',17.00,121.00,'2018-07-02 05:30','2018-07-02 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (31,4,'GE','7ª-IB-1-33-07',15.00,125.00,'2018-07-03 05:30','2018-07-03 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (32,4,'GE','7ª-IB-1-33-07',15.50,125.00,'2018-07-04 05:30','2018-07-04 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (33,4,'GE','7ª-IB-1-33-07',13.50,120.50,'2018-07-05 05:30','2018-07-05 17:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (34,1,'TN','7ª-BA-4-90-99',16.50,125.00,'2018-07-06 06:30','2018-07-06 14:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (35,1,'TN','7ª-BA-4-90-99',20.00,122.50,'2018-07-07 06:30','2018-07-07 14:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (36,1,'TN','7ª-BA-4-90-99',12.00,121.50,'2018-07-08 06:30','2018-08-06 14:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (37,1,'TN','7ª-BA-4-90-99',15.00,128.00,'2018-07-09 06:30','2018-07-09 14:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (38,1,'TN','7ª-BA-4-90-99',11.50,129.50,'2018-07-10 06:30','2018-07-10 14:30');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (39,4,'GE','7ª-BA-2-535-01',15.00,121.50,'2018-09-01 07:30','2018-09-01 18:00');
INSERT INTO CAPTURAS_DIARIAS (Codigo,CodigoEspecie,ReferenciaCaladero,MatriculaBarco,Kilos,Tamaño,FechaPesca) VALUES (40,4,'GE','7ª-BA-2-535-01',18.50,125.00,'2018-09-02 07:30','2018-09-02 18:00');



INSERT INTO PAGOS_ATRAQUES(MatriculaBarco,CodigoPuntoDeAtraque,Tipo,ProximoPago) VALUES ('7ª-BA-2-535-01',1,'Transferencia','2017-03-12');

