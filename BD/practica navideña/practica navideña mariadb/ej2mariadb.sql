CREATE TABLE Presidentes
(
DNI VARCHAR(9),
Nombre VARCHAR(15),
Apellidos VARCHAR(20),
FechaEleccion DATETIME,
FechaNacimiento DATETIME,
CodigoEquipo INT(6),
CONSTRAINT pk_Presidentes PRIMARY KEY(DNI)
);

CREATE TABLE Estadios
(
Codigo INT(6),
Nombre VARCHAR(15),
Aforo INT(6) DEFAULT 0,
CONSTRAINT pk_Estadios PRIMARY KEY (Codigo)
);

CREATE TABLE Equipos
(
Codigo INT(6),
Nombre VARCHAR(9),
Ciudad VARCHAR(10),
AñoFundacion VARCHAR(9),
CodigoEstadio INT(6),
CONSTRAINT pk_Equipos PRIMARY KEY (Codigo),
CONSTRAINT fk_CodigoEquipos FOREIGN KEY (CodigoEstadio) REFERENCES Estadios(Codigo)
);

CREATE TABLE Jugadores
(
Codigo INT(6),
Nombre VARCHAR(15),
FechaNacimiento DATETIME,
Posicion VARCHAR(20),
CodigoEquipo INT(6),
CONSTRAINT pk_Jugadores PRIMARY KEY (Codigo),
CONSTRAINT fk_CodigoEquipo FOREIGN KEY (CodigoEquipo) REFERENCES Equipos(Codigo),
CONSTRAINT ck_Posicion CHECK (Posicion IN('Portero','Delantero','Defensa','Centrocampista')),
CONSTRAINT ck_NacimientoJugadores CHECK (SUBSTR(CAST(FechaNacimiento AS CHAR),1,10) <= '1999-03-01')
);

CREATE TABLE Partidos
(
Codigo INT(6),
Fecha DATETIME,
CodigoEquipoVisitante INT(6),
CodigoEquipoLocal INT(6),
CONSTRAINT pk_Partidos PRIMARY KEY(Codigo),
CONSTRAINT fk_CodigoEquipoLocal FOREIGN KEY (CodigoEquipoLocal) REFERENCES Equipos(Codigo),
CONSTRAINT fk_CodigoEquipoVisitante FOREIGN KEY (CodigoEquipoVisitante) REFERENCES Equipos(Codigo),
CONSTRAINT ck_PartidosVerano CHECK ((SUBSTR(CAST(Fecha AS CHAR),6,5) NOT BETWEEN '06-21' AND '09-21') AND (SUBSTR(CAST(Fecha AS CHAR),6,5)!='12-25') AND (SUBSTR(CAST(Fecha AS CHAR),6,5)!='01-01')),
CONSTRAINT ck_FechaPartidos CHECK (Fecha IS NOT NULL)
);

CREATE TABLE Goles
(
CodigoPartido INT(6),
CodigoJugador INT(6),
Minuto INT(3),
CONSTRAINT pk_Goles PRIMARY KEY (Minuto),
CONSTRAINT fk_CodigoPartido FOREIGN KEY (CodigoPartido) REFERENCES Partidos(Codigo),
CONSTRAINT fk_CodigoJugador FOREIGN KEY (CodigoJugador) REFERENCES Jugadores(Codigo),
CONSTRAINT ck_MinutoGol CHECK (Minuto <= 100)
);








ALTER TABLE Equipos ADD NumTitulos INT(3);
ALTER TABLE Estadios DROP Aforo;
ALTER TABLE Equipos ADD CONSTRAINT ck_AñoFundacion CHECK (AñoFundacion > 1888);
ALTER TABLE Partidos ADD CONSTRAINT ck_HoraComienzo CHECK (SUBSTR(CAST(Fecha AS CHAR),12,5) BETWEEN '10:00' AND '23:30');


