CREATE TABLE Clientes
(
Codigo  	 VARCHAR(15),
Direccion     	 VARCHAR(20),
Telefono      	 VARCHAR(9),
CONSTRAINT pk_Clientes PRIMARY KEY(Codigo)
);

CREATE TABLE Proyectos
(
Codigo          VARCHAR(9),
Descripcion     VARCHAR(30),
Cuantia         NUMERIC(7),
FechaInicio     DATE,
FechaFin        DATE,
CodigoCliente   VARCHAR(15),
CONSTRAINT pk_Proyectos PRIMARY KEY (Codigo),
CONSTRAINT fk_CodigoCliente FOREIGN KEY (CodigoCliente) REFERENCES Clientes(Codigo),
CONSTRAINT ck_CodigoProyectos CHECK (SUBSTR(Codigo,1,1) IN ('D','S')) 
);

CREATE TABLE Bancos
(
Nombre			VARCHAR(20),
CuentaCorriente		NUMERIC(20),
CONSTRAINT pk_Bancos PRIMARY KEY (CuentaCorriente),
CONSTRAINT ck_NombreBanco CHECK (Nombre = INITCAP(Nombre))
);

CREATE TABLE Colaboradores
(
NIF			VARCHAR(9),
Nombre			VARCHAR(18),
Apellidos		VARCHAR(20),
Domicilio		VARCHAR(20),
Telefono		VARCHAR(9),
CuentaCorrienteBanco	NUMERIC(20),
CONSTRAINT pk_Colaboradores PRIMARY KEY (NIF),
CONSTRAINT fk_CuentaCorrienteBancos FOREIGN KEY (CuentaCorrienteBanco) REFERENCES Bancos(CuentaCorriente),
CONSTRAINT ck_NombreColaborador CHECK (Nombre = INITCAP(Nombre))
);

CREATE TABLE Colaboraciones
(
CodigoProyecto   VARCHAR(9),
NIFColaborador VARCHAR(9),
CONSTRAINT fk_CodigoProyecto FOREIGN KEY (CodigoProyecto) REFERENCES Proyectos(Codigo),
CONSTRAINT fk_NIFColaborador FOREIGN KEY (NIFColaborador) REFERENCES Colaboradores(NIF),
CONSTRAINT pk_Colaboraciones PRIMARY KEY (CodigoProyecto,NIFColaborador)
);

CREATE TABLE TiposDePagos
(
Codigo		INT,
Descripcion	VARCHAR(13),
CONSTRAINT pk_TiposDePagos PRIMARY KEY (Codigo),
CONSTRAINT ck_TipoDePagos CHECK (Descripcion IN ('Efectivo', 'Transferencia', 'Plazos'))
);

CREATE TABLE Pagos
(
Numero				INT,
Concepto			VARCHAR(20),
Importe				NUMERIC(8,2),
Fecha				DATE,
CodigoTipoDePago		INT,
CodigoProyecto			VARCHAR(6),
NIFColaborador			VARCHAR(9),
CONSTRAINT pk_Pagos PRIMARY KEY (Numero),
CONSTRAINT fk_CodigoTipoDePago FOREIGN KEY (CodigoTipoDePago) REFERENCES TiposDePagos(Codigo),
CONSTRAINT fk_CodigoProyecto FOREIGN KEY (CodigoProyecto) REFERENCES Proyectos(Codigo),
CONSTRAINT fk_NIFColaborador FOREIGN KEY (NIFColaborador) REFERENCES Colaboradores(NIF),
CONSTRAINT ck_Importe CHECK (Importe < 35000)
);



ALTER TABLE CLIENTES ADD CONSTRAINT CK_clientes_codigo CHECK (SUBSTR(Codigo,1,2) = 'C-' AND SUBSTRING(Codigo from '.$') SIMILAR TO '[aeiou]');
ALTER TABLE Proyectos ADD CONSTRAINT ck_horario CHECK (TO_CHAR(FechaInicio, 'YYYY-MM') > '2009-05');
ALTER TABLE Proyectos ADD COLUMN Nombre VARCHAR(20);
ALTER TABLE Colaboradores ADD CONSTRAINT ck_Telefono CHECK (substr(Telefono,1,1)  IN ('6','7'));
DROP TABLE Colaboraciones;
ALTER TABLE Pagos ADD CONSTRAINT ck_ImporteObligatorio CHECK (Importe IS NOT NULL);
ALTER TABLE Pagos DROP CONSTRAINT ck_Importe;
ALTER TABLE Pagos DROP COLUMN Concepto;

