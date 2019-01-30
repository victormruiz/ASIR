CREATE TABLE Clientes
(
Codigo NUMBER(6),
NIF VARCHAR2(9),
Nombre VARCHAR2(10),
Direccion VARCHAR2(20),
Ciudad VARCHAR2(10),
Telefono VARCHAR2(9),
CONSTRAINT pk_Clientes PRIMARY KEY (Codigo),
CONSTRAINT ck_NIF CHECK (REGEXP_LIKE(NIF,'[0-9]{8}[A-Z]$')),
CONSTRAINT ck_telef CHECK (REGEXP_LIKE(Telefono,'[6-9]{1}[0-9]{8}$')),
CONSTRAINT un_NIF UNIQUE (NIF)
);

CREATE TABLE Operaciones
(
Codigo NUMBER(10),
Descripcion VARCHAR2(30),
HorasMO NUMBER(1),
CONSTRAINT pk_Codigo PRIMARY KEY (Codigo),
CONSTRAINT ck_HorasMO CHECK (HorasMO <= 4)
);

CREATE TABLE Materiales
(
Codigo NUMBER(6),
Nombre VARCHAR2(10),
Precio VARCHAR2(3),
CONSTRAINT pk_Materiales PRIMARY KEY (Codigo)
);

CREATE TABLE Coches
(
Matricula VARCHAR2(10),
Modelo VARCHAR2(10),
Color VARCHAR2(8),
PVP VARCHAR2(5),
CodigoCliente NUMBER(6),
CONSTRAINT pk_Matricula PRIMARY KEY(Matricula),
CONSTRAINT ck_color CHECK (Color IN('Amarillo','Blanco','Verde','Rojo')),
CONSTRAINT ck_Matricula CHECK((REGEXP_LIKE(Matricula,'^[1-9]{4}[A-Z]{3}$') OR (REGEXP_LIKE(Matricula,'^[A-Z]{1,2}\-[0-9]{4}\-[A-Z]{1,2}$')))),
CONSTRAINT fk_CodigoCliente FOREIGN KEY (CodigoCliente) REFERENCES Clientes(Codigo),
CONSTRAINT ck_modelo CHECK (Modelo IS NOT NULL),
CONSTRAINT ck_precio CHECK (PVP BETWEEN 10000 AND 60000)
);


CREATE TABLE Revisiones
(
Codigo VARCHAR2(10),
FechaRevision DATE,
MatriculaCoches VARCHAR2(10),
CONSTRAINT pk_Revisiones PRIMARY KEY(Codigo),
CONSTRAINT fk_Matricula FOREIGN KEY (MatriculaCoches) REFERENCES Coches(Matricula),
CONSTRAINT ck_horario CHECK (TO_CHAR(FechaRevision, 'HH24') > '08' AND (TO_CHAR(FechaRevision, 'HH24') < '17'))
);

CREATE TABLE PiezasPorOperacion
(
CodigoMaterial NUMBER(6),
CodigoOperacion NUMBER(10),
Cantidad VARCHAR2(4) DEFAULT 1,
CONSTRAINT fk_CodigoOperacion FOREIGN KEY (CodigoOperacion) REFERENCES Operaciones(Codigo),
CONSTRAINT fk_CodigoMaterial FOREIGN KEY (CodigoMaterial) REFERENCES Materiales(Codigo)
);
