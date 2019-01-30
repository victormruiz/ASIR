INSERT INTO Clientes(Codigo,Direccion,Telefono) VALUES ('C-123a', 'C/ meninas 13','658475215');
INSERT INTO Clientes(Codigo,Direccion,Telefono) VALUES ('C-123b', 'C/ Velazquez 99','698548512');
INSERT INTO Clientes(Codigo,Direccion,Telefono) VALUES ('123a', 'C/ Cristobal Colon 24', '658745841');
INSERT INTO Clientes(Codigo,Direccion,Telefono) VALUES ('C-123x', 'C/ Avila 13','684741254');
INSERT INTO Clientes(Codigo,Direccion,Telefono) VALUES ('C-123e', 'C/ Alava 18','654958356');

INSERT INTO Proyectos(Codigo,Descripcion,Cuantia,FechaInicio,FechaFin,CodigoCliente) VALUES ('D1','Proyecto 1','45000','2018-05-25','2020-05-25','C-123a');
INSERT INTO Proyectos(Codigo,Descripcion,Cuantia,FechaInicio,FechaFin,CodigoCliente) VALUES ('N1','Proyecto 2','25000','2018-06-20','2020-09-14','C-123e');
INSERT INTO Proyectos(Codigo,Descripcion,Cuantia,FechaInicio,FechaFin,CodigoCliente) VALUES ('S1','Proyecto 3','15000','2018-09-08','2021-01-19','C-123e');

INSERT INTO Bancos(Nombre,CuentaCorriente) VALUES ('Deutche Bank', '20254158479632541548');
INSERT INTO Bancos(Nombre,CuentaCorriente) VALUES ('Caja Sur', '20245847856325145985');
INSERT INTO Bancos(Nombre,CuentaCorriente) VALUES ('ing', '20275847569512548547');

INSERT INTO Colaboradores(NIF,Nombre,Apellidos,Domicilio,Telefono,CuentaCorrienteBanco) VALUES ('69584253F','Victor','Castro Romero','C/ avlia 13', '658475125','20245847856325145985');
INSERT INTO Colaboradores(NIF,Nombre,Apellidos,Domicilio,Telefono,CuentaCorrienteBanco) VALUES ('58745869D','Pepe','Jimenez Ortega','C/ lorca 58', '695824521','20254158479632541548');
INSERT INTO Colaboradores(NIF,Nombre,Apellidos,Domicilio,Telefono,CuentaCorrienteBanco) VALUES ('85471254R','andrea','Romero Escasi','C/ menorca 7', '658475123','20245847856325145985');
INSERT INTO Colaboradores(NIF,Nombre,Apellidos,Domicilio,Telefono,CuentaCorrienteBanco) VALUES ('95854125A','Jaime','Santander Ino','C/ mallorca 55', '956235847','20254158479632541548');

INSERT INTO Colaboraciones(CodigoProyecto,NIFColaborador) VALUES ('D1','69584253F');
INSERT INTO Colaboraciones(CodigoProyecto,NIFColaborador) VALUES ('S1','58745869D');

INSERT INTO TiposDePagos(Codigo,Descripcion) VALUES (1,'Transferencia');
INSERT INTO TiposDePagos(Codigo,Descripcion) VALUES (2,'Efectivo');
INSERT INTO TiposDePagos(Codigo,Descripcion) VALUES (3,'Cheque');

INSERT INTO Pagos(Numero,importe,Fecha,CodigoTipoDePago,CodigoProyecto,NIFColaborador) VALUES (1,36000,'2018-02-13',2,'D1','69584253F');
INSERT INTO Pagos(Numero,importe,Fecha,CodigoTipoDePago,CodigoProyecto,NIFColaborador) VALUES (2,25000,'2017-01-25',1,'S1','58745869D');
