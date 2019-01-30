INSERT INTO Equipos(Codigo,Nombre,Ciudad,AñoFundacion) VALUES (1,'Betis','Sevilla','1907');
INSERT INTO Equipos(Codigo,Nombre,Ciudad,AñoFundacion) VALUES (2,'Sevilla','Sevilla','1890');

INSERT INTO Presidentes(DNI,Nombre,Apellidos,FechaEleccion,CodigoEquipo) VALUES ('58412369F','Angel','Haro','2015-05-25',1);
INSERT INTO Presidentes(DNI,Nombre,Apellidos,FechaEleccion,CodigoEquipo) VALUES ('58471254Y','Jose','Castro','2010-06-13',2);

INSERT INTO Partidos(Codigo,Fecha,CodigoEquipoVisitante,CodigoEquipoLocal) VALUES (1,'2018-08-25 23:00:00',1,2);
INSERT INTO Partidos(Codigo,Fecha,CodigoEquipoVisitante,CodigoEquipoLocal) VALUES (2,'2017-03-25 09:00:00',2,1);
INSERT INTO Partidos(Codigo,Fecha,CodigoEquipoVisitante,CodigoEquipoLocal) VALUES (3,'2016-12-25 12:30:00',2,1);
INSERT INTO Partidos(Codigo,Fecha,CodigoEquipoVisitante,CodigoEquipoLocal) VALUES (4,'2015-01-01 00:30:00',1,2);
INSERT INTO Partidos(Codigo,Fecha,CodigoEquipoVisitante,CodigoEquipoLocal) VALUES (5,NULL,2,1);

INSERT INTO Jugadores(Codigo,Nombre,FechaNacimiento,Posicion,CodigoEquipo) VALUES (1,'Marc','1991-01-15','Defensa',1);
INSERT INTO Jugadores(Codigo,Nombre,FechaNacimiento,Posicion,CodigoEquipo) VALUES (2,'Joaquin','1981-07-21','Centrocampista',1);
INSERT INTO Jugadores(Codigo,Nombre,FechaNacimiento,Posicion,CodigoEquipo) VALUES (3,'Sergio','1993-01-09','Portero',2);
INSERT INTO Jugadores(Codigo,Nombre,FechaNacimiento,Posicion,CodigoEquipo) VALUES (4,'Nolito','1986-10-15','Delantero',2);
INSERT INTO Jugadores(Codigo,Nombre,FechaNacimiento,Posicion,CodigoEquipo) VALUES (5,'Quique','1958-09-27','Entrenador',1);
INSERT INTO Jugadores(Codigo,Nombre,FechaNacimiento,Posicion,CodigoEquipo) VALUES (6,'Andres','2000-01-02','Defensa',2);


INSERT INTO Goles(CodigoPartido,CodigoJugador,Minuto) VALUES (2,1,90);
INSERT INTO Goles(CodigoPartido,CodigoJugador,Minuto) VALUES (2,3,101);


