CREATE TABLE CALADEROS
(
Referencia VARCHAR(2),
Nombre VARCHAR(25) UNIQUE,
Ubicacion VARCHAR(16),
Extension FLOAT(6),
CONSTRAINT pk_Caladeros PRIMARY KEY (Referencia),
CONSTRAINT ck_Ubicacion CHECK (Ubicacion IN ('Atlantico Norte', 'Mediterraneo', 'Atlantico Sur', 'Costas de Africa'))
);

CREATE TABLE ARMADORES
(
DNI VARCHAR(9),
Nombre VARCHAR(15),
Apellidos VARCHAR(15),
Ciudad VARCHAR(20),
Direccion VARCHAR(20),
Telefono VARCHAR(9) UNIQUE,
NumeroCuenta VARCHAR(29) UNIQUE,
CONSTRAINT pk_Armadores PRIMARY KEY (DNI),
CONSTRAINT ck_NumeroCuenta CHECK (NumeroCuenta ~ '[A-Z]{2}[0-9]{2}\ [0-9]{4}\ [0-9]{4}\ [0-9]{4}\ [0-9]{4}\ [0-9]{4}$'),
CONSTRAINT ckCiudad CHECK (Ciudad LIKE '%(España)' OR Ciudad LIKE '%(Portugal)')
);

CREATE TABLE BARCOS
(
Matricula VARCHAR(15),
DNIArmador VARCHAR(9),
Nombre VARCHAR(20),
Clase VARCHAR(20),
Eslora FLOAT(6),
Manga FLOAT(6),
CONSTRAINT pk_Barcos PRIMARY KEY(Matricula),
CONSTRAINT ck_Matricula CHECK ((Matricula ~ '6ª\-[A-Z]{2}\-[0-9]{1}\-[0-9]{1,3}\-[0-9]{2}$') OR (Matricula ~ '7ª\-[A-Z]{2}\-[0-9]{1}\-[0-9]{1,3}\-[0-9]{2}$'))
);

CREATE TABLE PUNTOS_DE_ATRAQUES
(
Cod VARCHAR(2),
DistanciaALonja FLOAT(6),
Manga FLOAT(6),
Eslora FLOAT(6),
CintaTransportadora DECIMAL(1),
Precio FLOAT(6),
CONSTRAINT pk_PuntosDeAtraque PRIMARY KEY (Cod),
CONSTRAINT ck_Precio CHECK (Precio BETWEEN 200 AND 420)
);

CREATE TABLE ESPECIES_DE_PESCADOS
(
Codigo VARCHAR(4),
NombreCientifico VARCHAR(25) UNIQUE,
NombreComercial VARCHAR(12) UNIQUE,
Tipo VARCHAR(15),
TamañoMinimo FLOAT(6) DEFAULT 80,
CONSTRAINT pk_EspeciesDePescados PRIMARY KEY (Codigo),
CONSTRAINT ck_NombreCientifico CHECK (NombreCientifico = INITCAP(NombreCientifico))
);

CREATE TABLE CAPTURA_CALADEROS
(
Año VARCHAR(4),
CodigoEspecie VARCHAR(4),
ReferenciaCaladero VARCHAR(2),
MaximoKilos DECIMAL(3),
CONSTRAINT pk_CapturasCaladeros PRIMARY KEY (CodigoEspecie,ReferenciaCaladero,Año),
CONSTRAINT fk_CodigoEspecieCC FOREIGN KEY (CodigoEspecie) REFERENCES ESPECIES_DE_PESCADOS(Codigo),
CONSTRAINT fk_ReferenciaCaladerosCC FOREIGN KEY (ReferenciaCaladero) REFERENCES CALADEROS(Referencia)
);

CREATE TABLE FAENAS_BARCOS
(
MatriculaBarco VARCHAR(15),
ReferenciaCaladero VARCHAR(2),
FechaInicio DATE,
FechaFin DATE,
Kilos FLOAT(6),
CONSTRAINT fk_ReferenciaCaladerosFB FOREIGN KEY (ReferenciaCaladero) REFERENCES CALADEROS(Referencia),
CONSTRAINT fk_MatriculaBarcoFB FOREIGN KEY (MatriculaBarco) REFERENCES BARCOS(Matricula),
CONSTRAINT pk_FaenasBarcos PRIMARY KEY (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin),
CONSTRAINT ck_FechaPescaInicio CHECK (TO_CHAR(FechaInicio, 'MM-DD') NOT BETWEEN '04-15' AND '06-15'),
CONSTRAINT ck_FechaPescaFin CHECK (TO_CHAR(FechaFin, 'MM-DD') NOT BETWEEN '04-15' AND '06-15')
);

CREATE TABLE CAPTURAS_DIARIAS
(
Codigo VARCHAR(6),
CodigoEspecie VARCHAR(4),
ReferenciaCaladero VARCHAR(2),
MatriculaBarco VARCHAR(15),
Kilos FLOAT(6),
Tamaño FLOAT(6),
FechaPescaInicio TIMESTAMP,
FechaPescaFin TIMESTAMP,
CONSTRAINT fk_CodigoEspecieCD FOREIGN KEY (CodigoEspecie) REFERENCES ESPECIES_DE_PESCADOS(Codigo),
CONSTRAINT fk_ReferenciaCaladeroCD FOREIGN KEY (ReferenciaCaladero) REFERENCES CALADEROS(Referencia),
CONSTRAINT fk_MatriculaBarcosCD FOREIGN KEY (MatriculaBarco) REFERENCES BARCOS(Matricula),
CONSTRAINT pk_CapturasDiarias PRIMARY KEY (Codigo),
CONSTRAINT ck_FechaPescaInicio CHECK (TO_CHAR(FechaPescaInicio, 'HH24:MI') > '05:30')
);

CREATE TABLE PAGOS_ATRAQUES
(
MatriculaBarco VARCHAR(15),
CodigoPuntoDeAtraque VARCHAR(2),
Tipo VARCHAR(15),
ProximoPago DATE,
CONSTRAINT fk_MatriculaBarcoPA FOREIGN KEY (MatriculaBarco) REFERENCES BARCOS(Matricula),
CONSTRAINT fk_CodigoPuntoDeAtraquePA FOREIGN KEY (CodigoPuntoDeAtraque) REFERENCES PUNTOS_DE_ATRAQUES(Cod),
CONSTRAINT pk_PagosAtraques PRIMARY KEY (MatriculaBarco,ProximoPago)
);
