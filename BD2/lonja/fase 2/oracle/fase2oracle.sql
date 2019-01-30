CREATE TABLE CALADEROS
(
Referencia VARCHAR2(2),
Nombre VARCHAR2(25) UNIQUE,
Ubicacion VARCHAR2(16),
Extension NUMBER(6),
CONSTRAINT pk_Caladeros PRIMARY KEY (Referencia),
CONSTRAINT ck_Ubicacion CHECK (Ubicacion IN ('Atlantico Norte', 'Mediterraneo', 'Atlantico Sur', 'Costas de Africa'))
);

CREATE TABLE ARMADORES
(
DNI VARCHAR2(9),
Nombre VARCHAR2(15),
Apellidos VARCHAR2(15),
Ciudad VARCHAR2(35),
Direccion VARCHAR2(20),
Telefono VARCHAR2(9) UNIQUE,
NumeroCuenta VARCHAR2(29) UNIQUE,
CONSTRAINT pk_Armadores PRIMARY KEY (DNI),
CONSTRAINT ck_NumeroCuenta CHECK (REGEXP_LIKE(NumeroCuenta,'[A-Z]{2}[0-9]{2}\ [0-9]{4}\ [0-9]{4}\ [0-9]{4}\ [0-9]{4}\ [0-9]{4}$')),
CONSTRAINT ckCiudad CHECK (Ciudad LIKE '%(España)' OR Ciudad LIKE '%(Portugal)')
);

CREATE TABLE BARCOS
(
Matricula VARCHAR2(15),
DNIArmador VARCHAR2(9) UNIQUE,
Nombre VARCHAR2(20),
Clase VARCHAR2(20),
Eslora NUMBER(6,3),
Manga NUMBER(6,4),
CONSTRAINT pk_Barcos PRIMARY KEY(Matricula),
CONSTRAINT ck_Matricula CHECK (REGEXP_LIKE(Matricula,'6ª\-[A-Z]{2}\-[0-9]{1}\-[0-9]{1,3}\-[0-9]{2}$') OR REGEXP_LIKE(Matricula,'7ª\-[A-Z]{2}\-[0-9]{1}\-[0-9]{1,3}\-[0-9]{2}$'))
);

CREATE TABLE PUNTOS_DE_ATRAQUES
(
Cod VARCHAR2(2),
DistanciaALonja NUMBER(6,4),
Manga NUMBER(6,4),
Eslora NUMBER(6,4),
CintaTransportadora NUMBER(1),
Precio NUMBER(6,3),
CONSTRAINT pk_PuntosDeAtraque PRIMARY KEY (Cod),
CONSTRAINT ck_Precio CHECK (Precio BETWEEN 200 AND 420)
);

CREATE TABLE ESPECIES_DE_PESCADOS
(
Codigo VARCHAR2(4),
NombreCientifico VARCHAR2(25) UNIQUE,
NombreComercial VARCHAR2(12) UNIQUE,
Tipo VARCHAR2(15),
TamañoMinimo NUMBER(6,3) DEFAULT 80.00,
CONSTRAINT pk_EspeciesDePescados PRIMARY KEY (Codigo),
CONSTRAINT ck_NombreCientifico CHECK (NombreCientifico = INITCAP(NombreCientifico))
);

CREATE TABLE CAPTURA_CALADEROS
(
Año VARCHAR2(4),
CodigoEspecie VARCHAR2(4),
ReferenciaCaladero VARCHAR2(2),
MaximoKilos NUMBER(3),
CONSTRAINT pk_CapturasCaladeros PRIMARY KEY (CodigoEspecie,ReferenciaCaladero,Año),
CONSTRAINT fk_CodigoEspecieCC FOREIGN KEY (CodigoEspecie) REFERENCES ESPECIES_DE_PESCADOS(Codigo),
CONSTRAINT fk_ReferenciaCaladerosCC FOREIGN KEY (ReferenciaCaladero) REFERENCES CALADEROS(Referencia)
);

CREATE TABLE FAENAS_BARCOS
(
MatriculaBarco VARCHAR2(15),
ReferenciaCaladero VARCHAR2(2),
FechaInicio DATE,
FechaFin DATE,
CONSTRAINT fk_ReferenciaCaladerosFB FOREIGN KEY (ReferenciaCaladero) REFERENCES CALADEROS(Referencia),
CONSTRAINT fk_MatriculaBarcoFB FOREIGN KEY (MatriculaBarco) REFERENCES BARCOS(Matricula),
CONSTRAINT pk_FaenasBarcos PRIMARY KEY (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin),
CONSTRAINT ck_FechaPescaInicio CHECK (TO_CHAR(FechaInicio, 'MM-DD') NOT BETWEEN '04-15' AND '06-15'),
CONSTRAINT ck_FechaPescaFin CHECK (TO_CHAR(FechaFin, 'MM-DD') NOT BETWEEN '04-15' AND '06-15')
);

CREATE TABLE CAPTURAS_DIARIAS
(
Codigo VARCHAR2(6),
CodigoEspecie VARCHAR2(4),
ReferenciaCaladero VARCHAR2(2),
MatriculaBarco VARCHAR2(15),
Kilos NUMBER(6,4),
Tamaño NUMBER(6,3),
FechaPescaInicio DATE,
FechaPescaFin DATE,
CONSTRAINT fk_CodigoEspecieCD FOREIGN KEY (CodigoEspecie) REFERENCES ESPECIES_DE_PESCADOS(Codigo),
CONSTRAINT fk_ReferenciaCaladeroCD FOREIGN KEY (ReferenciaCaladero) REFERENCES CALADEROS(Referencia),
CONSTRAINT fk_MatriculaBarcosCD FOREIGN KEY (MatriculaBarco) REFERENCES BARCOS(Matricula),
CONSTRAINT pk_CapturasDiarias PRIMARY KEY (Codigo),
CONSTRAINT ck_FechaInicio CHECK (TO_CHAR(FechaPescaInicio, 'HH24:MI') > '05:30')
);

CREATE TABLE PAGOS_ATRAQUES
(
MatriculaBarco VARCHAR2(15),
CodigoPuntoDeAtraque VARCHAR2(2),
Tipo VARCHAR2(15),
ProximoPago DATE,
CONSTRAINT fk_MatriculaBarcoPA FOREIGN KEY (MatriculaBarco) REFERENCES BARCOS(Matricula),
CONSTRAINT fk_CodigoPuntoDeAtraquePA FOREIGN KEY (CodigoPuntoDeAtraque) REFERENCES PUNTOS_DE_ATRAQUES(Cod),
CONSTRAINT pk_PagosAtraques PRIMARY KEY (MatriculaBarco,ProximoPago)
);
