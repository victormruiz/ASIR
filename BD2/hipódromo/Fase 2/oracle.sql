-- Creación de tablas

create table jockeys
(
	DNI VARCHAR2(9),
	Nombre VARCHAR2(25),
	Peso NUMBER(3, 1),
	Altura VARCHAR2(3),
	Telefono VARCHAR2(9),
	constraint pk_jockeys PRIMARY KEY(DNI),
	constraint uu_tlfj UNIQUE(Telefono),
	constraint ck_dni CHECK((REGEXP_LIKE(DNI, '[0-9]{8}[A-Z]')) OR (REGEXP_LIKE(DNI, '[KLMX-Z][0-9]{7}[A-Z]')))
);

create table clientes
(
	NIFCliente VARCHAR2(9),
	Nombre VARCHAR2(25),
	Apellido1 VARCHAR2(25),
	Apellido2 VARCHAR2(25),
	Direccion VARCHAR2(30),
	Localidad VARCHAR2(20),
	Provincia VARCHAR2(20),
	Telefono VARCHAR2(9),
	constraint pk_clientes PRIMARY KEY(NIFCliente),
	constraint uu_tlfc UNIQUE(Telefono),
	constraint ck_localidad CHECK(Localidad = INITCAP(Localidad)),
	constraint ck_nifc CHECK((REGEXP_LIKE(NIFCliente, '[0-9]{8}[A-Z]')) OR (REGEXP_LIKE(NIFCliente, '[KLMX-Z][0-9]{7}[A-Z]')))
);

create table propietarios
(
	NIF VARCHAR2(9),
	CuotaMensual NUMBER(5, 2),
	constraint pk_propietarios PRIMARY KEY(NIF),
	constraint ck_nifp CHECK((REGEXP_LIKE(NIF, '[0-9]{8}[A-Z]')) OR (REGEXP_LIKE(NIF, '[KLMX-Z][0-9]{7}[A-Z]')))
);

create table instalacionescuadras
(
	CodCuadra VARCHAR2(4),
	Aforo NUMBER(3),
	Tamanyo NUMBER(4, 1),
	Tipo VARCHAR2(20),
	constraint pk_instalacionescuadras PRIMARY KEY(CodCuadra),
	constraint ck_tipo CHECK(Tipo IN ('Hierba', 'Arena batida', 'Tierra'))
);

create table pistasentrenamiento
(
	CodCuadra VARCHAR2(4),
	Longitud NUMBER(4),
	constraint pk_pistasentrenamiento PRIMARY KEY(CodCuadra),
	constraint fk_cuadraspe FOREIGN KEY(CodCuadra) REFERENCES instalacionescuadras
);

create table caballos
(
	CodigoCaballo VARCHAR2(4),
	Nombre VARCHAR2(25),
	FechaNac DATE,
	Raza VARCHAR2(25),
	NIFPropietario VARCHAR2(9),
	constraint pk_caballos PRIMARY KEY(CodigoCaballo),
	constraint fk_propietarios FOREIGN KEY(NIFPropietario) REFERENCES propietarios
);

create table cuadrante
(
	CodigoCaballo VARCHAR2(4),
	CodCuadra VARCHAR2(4),
	FechaHora DATE,
	constraint pk_cuadrante PRIMARY KEY(CodigoCaballo, CodCuadra, FechaHora),
	constraint fk_caballoscuad FOREIGN KEY(CodigoCaballo) REFERENCES caballos,
	constraint fk_cuadrascuad FOREIGN KEY(CodCuadra) REFERENCES instalacionescuadras,
	constraint ck_fechaok CHECK(TO_CHAR(FechaHora, 'D') != '1')
);

create table caballoscarreras
(
	CodigoCaballo VARCHAR2(4),
	Peso NUMBER(5, 2),
	Nacionalidad VARCHAR2(20),
	FechaNacMin DATE,
	FechaNacMax DATE,
	constraint pk_caballoscarreras PRIMARY KEY(CodigoCaballo),
	constraint fk_caballosccarr FOREIGN KEY(CodigoCaballo) REFERENCES caballos
);

create table carrerasprofesionales
(
	CodCarrera VARCHAR2(4),
	FechaHora DATE,
	ImportePremio NUMBER(5),
	LimiteApuesta NUMBER(5),
	FechaNacMin DATE,
	FechaNacMax DATE,
	constraint pk_carrerasprofesionales PRIMARY KEY(CodCarrera),
	constraint ck_limiteapuesta CHECK(LimiteApuesta <= 9000),
	constraint ck_FechaCarrera CHECK(FechaHora BETWEEN TO_DATE('20/10/0001', 'DD/MM/YYYY') AND TO_DATE('02/03/9999', 'DD/MM/YYYY')),
	constraint ck_HoraCarrera CHECK(TO_CHAR(FechaHora, 'HH24MI') BETWEEN '0900' AND '1400'),
	constraint ck_DiaCarrera CHECK(TO_CHAR(FechaHora, 'D') != '7')
);

create table participaciones
(
	CodCarrera VARCHAR2(4),
	CodigoCaballo VARCHAR2(4),
	DNIJockey VARCHAR2(9),
	Dorsal VARCHAR2(2),
	PosicionFinal NUMBER,
	constraint pk_participaciones PRIMARY KEY(CodCarrera, CodigoCaballo),
	constraint fk_carrerasprofesionales FOREIGN KEY(CodCarrera) REFERENCES carrerasprofesionales,
	constraint fk_caballos FOREIGN KEY(CodigoCaballo) REFERENCES caballos,
	constraint fk_jockeys FOREIGN KEY(DNIJockey) REFERENCES jockeys,
	constraint ck_posfinal CHECK(PosicionFinal <= 12)
);

create table apuestas
(
	NIFCliente VARCHAR2(9),
	CodCarrera VARCHAR2(4),
	CodigoCaballo VARCHAR2(4),
	ImporteApostado NUMBER(7, 2),
	TantoAUnoReal NUMBER(3),
	constraint pk_apuestas PRIMARY KEY(NIFCliente, CodCarrera, CodigoCaballo),
	constraint fk_clientes FOREIGN KEY(NIFCliente) REFERENCES clientes,
	constraint fk_carrerasprofesionalesap FOREIGN KEY(CodCarrera) REFERENCES carrerasprofesionales,
	constraint fk_caballosap FOREIGN KEY(CodigoCaballo) REFERENCES caballos,
	constraint nn_importe CHECK(ImporteApostado is not null),
	constraint nn_tantoxuno CHECK(TantoAUnoReal is not null),
	constraint ck_importeapostado CHECK(ImporteApostado <= 9000)
);


-- Inserción de datos

-- Jockeys
insert into jockeys(DNI, Nombre, Peso, Altura, Telefono)
values('12345678A', 'R. H. HUAYAS', 60, '176', '661837162');
insert into jockeys(DNI, Nombre, Peso, Altura, Telefono)
values('23162745J', 'J. A. RODRIGUEZ', 59.5, '177', '672194728');
insert into jockeys(DNI, Nombre, Peso, Altura, Telefono)
values('28361847I', 'J. C. MARTINEZ', 62.5, '175', '666128382');
insert into jockeys(DNI, Nombre, Peso, Altura, Telefono)
values('42817283K', 'B. RAMA', 61, '175', '627183642');
insert into jockeys(DNI, Nombre, Peso, Altura, Telefono)
values('28167492P', 'O. RODRIGUEZ', 60.4, '173', '698827153');
insert into jockeys(DNI, Nombre, Peso, Altura, Telefono)
values('12846382D', 'R. AON', 61.5, '176', '677222153');
insert into jockeys(DNI, Nombre, Peso, Altura, Telefono)
values('26917283W', 'A. R. ACOSTA', 59.8, '179', '654325465');
insert into jockeys(DNI, Nombre, Peso, Altura, Telefono)
values('26481732O', 'P. HALEY', 60, '178', '687762412');

-- Clientes
insert into clientes(NIFCliente, Nombre, Apellido1, Apellido2, Direccion, Localidad, Provincia, Telefono)
values('21151051K', 'JOSE', 'GARCIA', 'MARQUEZ', 'C/Luna nº 12', 'Utrera', 'Sevilla', '688452642');
insert into clientes(NIFCliente, Nombre, Apellido1, Apellido2, Direccion, Localidad, Provincia, Telefono)
values('03602069Q', 'FIONA', 'LEAL', 'ROSAS', 'C/Andalucía nº 8', 'Dos Hermanas', 'Sevilla', '725214148');
insert into clientes(NIFCliente, Nombre, Apellido1, Apellido2, Direccion, Localidad, Provincia, Telefono)
values('94896146D', 'HELEN', 'BAÑUELOS', 'MATIAS', 'C/Cañadilla nº 56', 'Sevilla', 'Sevilla', '625493291');
insert into clientes(NIFCliente, Nombre, Apellido1, Apellido2, Direccion, Localidad, Provincia, Telefono)
values('38172653J', 'ADOLFO', 'ALCARAZ', 'PICHARDO', 'C/Hornos nº 24', 'Dos Hermanas', 'Sevilla', '682201105');
insert into clientes(NIFCliente, Nombre, Apellido1, Apellido2, Direccion, Localidad, Provincia, Telefono)
values('93522209T', 'IRENE', 'TOVAR', 'JURADO', 'C/Paraguay nº 2', 'Sevilla', 'Sevilla', '784907000');
insert into clientes(NIFCliente, Nombre, Apellido1, Apellido2, Direccion, Localidad, Provincia, Telefono)
values('34372081F', 'NICOLAS', 'SANTOS', 'RIOS', 'C/Francisco Giráldez nº 22', 'Utrera', 'Sevilla', '649793980');
insert into clientes(NIFCliente, Nombre, Apellido1, Apellido2, Direccion, Localidad, Provincia, Telefono)
values('Z8419432B',  'ERUNESUTO', 'VAZQUEZ', 'GARCIA', 'C/Clarinete nº 13', 'Utrera', 'Sevilla', '627918231');

-- Propietarios
insert into propietarios(NIF, CuotaMensual)
values('Z8419432B', 550);
insert into propietarios(NIF, CuotaMensual)
values('25439654K', 600);
insert into propietarios(NIF, CuotaMensual)
values('06911410W', 535.50);
insert into propietarios(NIF, CuotaMensual)
values('X1563263E', 709);
insert into propietarios(NIF, CuotaMensual)
values('78146235D', 800.35);

-- Instalaciones Cuadras
insert into instalacionescuadras(CodCuadra, Aforo, Tamanyo, Tipo)
values('001', 200, 6.5, 'Hierba');
insert into instalacionescuadras(CodCuadra, Aforo, Tamanyo, Tipo)
values('002', 320, 5.8, 'Hierba');
insert into instalacionescuadras(CodCuadra, Aforo, Tamanyo, Tipo)
values('003', 400, 7, 'Tierra');
insert into instalacionescuadras(CodCuadra, Aforo, Tamanyo, Tipo)
values('004', 250, 7.2, 'Hierba');
insert into instalacionescuadras(CodCuadra, Aforo, Tamanyo, Tipo)
values('005', 300, 6.7, 'Arena batida');
insert into instalacionescuadras(CodCuadra, Aforo, Tamanyo, Tipo)
values('006', 420, 6, 'Arena batida');
insert into instalacionescuadras(CodCuadra, Aforo, Tamanyo, Tipo)
values('007', 120, 7, 'Tierra');
insert into instalacionescuadras(CodCuadra, Aforo, Tamanyo, Tipo)
values('008', 440, 6.5, 'Hierba');

-- Pistas entrenamiento
insert into pistasentrenamiento(CodCuadra, Longitud)
values('001', 1800);
insert into pistasentrenamiento(CodCuadra, Longitud)
values('003', 1850);
insert into pistasentrenamiento(CodCuadra, Longitud)
values('006', 1500);
insert into pistasentrenamiento(CodCuadra, Longitud)
values('008', 1750);

-- Caballos
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0001', 'ARISTODEMUS', TO_DATE('26/01/2013', 'DD/MM/YYYY'), 'Cuarto de milla', 'Z8419432B');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0002', 'CACHA', TO_DATE('07/12/2012', 'DD/MM/YYYY'), 'Cuarto de milla', '25439654K');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0003', 'BILLYCOCK HILL', TO_DATE('30/01/2013', 'DD/MM/YYYY'), 'Morgan', '25439654K');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0004', 'MY LADY', TO_DATE('25/02/2013', 'DD/MM/YYYY'), 'Purasangre', '06911410W');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0005', 'SABATERET', TO_DATE('29/03/2013', 'DD/MM/YYYY'), 'Caballo andaluz', 'X1563263E');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0006', 'BELOKI', TO_DATE('07/01/2013', 'DD/MM/YYYY'), 'Árabe', 'X1563263E');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0007', 'CECILIUS', TO_DATE('09/10/2013', 'DD/MM/YYYY'), 'Jaca', '78146235D');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0008', 'KASPAROVA', TO_DATE('08/07/2013', 'DD/MM/YYYY'), 'Apalusa', '78146235D');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0009', 'EK BALAM', TO_DATE('10/11/2012', 'DD/MM/YYYY'), 'Caballo andaluz', '78146235D');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0010', 'BARAKA', TO_DATE('28/02/2013', 'DD/MM/YYYY'), 'Apalusa', '78146235D');

-- Cuadrante
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0001', '005', TO_DATE('02/01/2018 09:30', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0001', '003', TO_DATE('02/01/2018 10:45', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0002', '001', TO_DATE('02/01/2018 10:00', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0002', '007', TO_DATE('03/01/2018 10:00', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0002', '007', TO_DATE('03/01/2018 12:00', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0003', '002', TO_DATE('04/01/2018 12:45', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0003', '004', TO_DATE('05/01/2018 10:00', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0004', '006', TO_DATE('05/01/2018 12:00', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0004', '002', TO_DATE('10/01/2018 09:00', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0005', '001', TO_DATE('12/01/2018 09:30', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0005', '001', TO_DATE('12/01/2018 17:30', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0006', '005', TO_DATE('17/01/2018 13:45', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0006', '008', TO_DATE('17/01/2018 19:45', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0007', '007', TO_DATE('18/01/2018 09:45', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0007', '002', TO_DATE('18/01/2018 11:00', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0008', '005', TO_DATE('18/01/2018 12:00', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0008', '005', TO_DATE('18/01/2018 17:00', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0009', '003', TO_DATE('19/01/2018 10:45', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0009', '004', TO_DATE('20/01/2018 09:00', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0010', '006', TO_DATE('24/01/2018 14:45', 'DD/MM/YYYY HH24:MI'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0010', '008', TO_DATE('24/01/2018 17:30', 'DD/MM/YYYY HH24:MI'));

-- Caballos de carrera
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0001', 470, 'Irlandés', TO_DATE('01/01/2013', 'DD/MM/YYYY'), TO_DATE('30/10/2013', 'DD/MM/YYYY'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0002', 482.70, 'Inglés', TO_DATE('01/10/2012', 'DD/MM/YYYY'), TO_DATE('10/12/2012', 'DD/MM/YYYY'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0003', 475, 'Inglés', TO_DATE('10/01/2013', 'DD/MM/YYYY'), TO_DATE('31/12/2013', 'DD/MM/YYYY'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0004', 466.50, 'Francés', TO_DATE('25/01/2013', 'DD/MM/YYYY'), TO_DATE('31/12/2013', 'DD/MM/YYYY'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0005', 478.40, 'Francés', TO_DATE('02/02/2013', 'DD/MM/YYYY'), TO_DATE('30/10/2013', 'DD/MM/YYYY'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0006', 480, 'Español', TO_DATE('01/01/2013', 'DD/MM/YYYY'), TO_DATE('15/08/2013', 'DD/MM/YYYY'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0007', 479.90, 'Español', TO_DATE('01/05/2013', 'DD/MM/YYYY'), TO_DATE('10/10/2013', 'DD/MM/YYYY'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0008', 477, 'Español', TO_DATE('05/01/2013', 'DD/MM/YYYY'), TO_DATE('05/09/2013', 'DD/MM/YYYY'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0009', 480, 'Español', TO_DATE('05/05/2012', 'DD/MM/YYYY'), TO_DATE('10/12/2012', 'DD/MM/YYYY'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0010', 490.90, 'Español', TO_DATE('09/01/2013', 'DD/MM/YYYY'), TO_DATE('09/10/2013', 'DD/MM/YYYY'));

-- Carreras profesionales
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0001', TO_DATE('21/01/2018 09:30', 'DD/MM/YYYY HH24:MI'), 7000, 3500, TO_DATE('01/01/2013', 'DD/MM/YYYY'), TO_DATE('01/08/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0002', TO_DATE('21/01/2018 10:00', 'DD/MM/YYYY HH24:MI'), 7875, 3500, TO_DATE('01/01/2012', 'DD/MM/YYYY'), TO_DATE('28/01/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0003', TO_DATE('21/01/2018 12:30', 'DD/MM/YYYY HH24:MI'), 14000, 9000, TO_DATE('01/02/2013', 'DD/MM/YYYY'), TO_DATE('31/12/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0004', TO_DATE('21/01/2018 13:30', 'DD/MM/YYYY HH24:MI'), 7000, 3500, TO_DATE('01/01/2013', 'DD/MM/YYYY'), TO_DATE('31/12/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0005', TO_DATE('28/01/2018 09:30', 'DD/MM/YYYY HH24:MI'), 7875, 3500, TO_DATE('01/01/2012', 'DD/MM/YYYY'), TO_DATE('31/10/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0006', TO_DATE('28/01/2018 10:00', 'DD/MM/YYYY HH24:MI'), 8750, 4500, TO_DATE('01/01/2013', 'DD/MM/YYYY'), TO_DATE('03/12/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0007', TO_DATE('28/01/2018 10:30', 'DD/MM/YYYY HH24:MI'), 7200, 3500, TO_DATE('10/01/2013', 'DD/MM/YYYY'), TO_DATE('03/12/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0008', TO_DATE('28/01/2018 12:00', 'DD/MM/YYYY HH24:MI'), 8000, 4500, TO_DATE('01/02/2013', 'DD/MM/YYYY'), TO_DATE('01/12/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0009', TO_DATE('04/02/2018 10:00', 'DD/MM/YYYY HH24:MI'), 8000, 4500, TO_DATE('01/05/2012', 'DD/MM/YYYY'), TO_DATE('05/05/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0010', TO_DATE('04/02/2018 11:30', 'DD/MM/YYYY HH24:MI'), 8750, 4500, TO_DATE('01/01/2013', 'DD/MM/YYYY'), TO_DATE('31/12/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0011', TO_DATE('04/02/2018 12:45', 'DD/MM/YYYY HH24:MI'), 7700, 3500, TO_DATE('01/02/2013', 'DD/MM/YYYY'), TO_DATE('20/12/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0012', TO_DATE('04/02/2018 13:30', 'DD/MM/YYYY HH24:MI'), 11350, 9000, TO_DATE('01/01/2012', 'DD/MM/YYYY'), TO_DATE('31/12/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0013', TO_DATE('04/02/2013 13:30', 'DD/MM/YYYY HH24:MI'), 11350, 9000, TO_DATE('01/01/2012', 'DD/MM/YYYY'), TO_DATE('31/12/2013', 'DD/MM/YYYY'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0014', TO_DATE('14/03/2013 13:30', 'DD/MM/YYYY HH24:MI'), 11350, 9000, TO_DATE('01/01/2012', 'DD/MM/YYYY'), TO_DATE('31/12/2013', 'DD/MM/YYYY'));


-- Participaciones
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0001', '12345678A', '33', 1);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0003', '23162745J', '14', 2);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0006', '28361847I', '90', 3);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0005', '42817283K', '28' ,4);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0008', '28167492P', '77', 5);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0010', '12846382D', '69', 6);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0002', '0002', '23162745J', '21', 1);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0002', '0001', '28361847I', '10', 2);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0002', '0006', '28167492P', '34', 3);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0002', '0009', '12345678A', '00', 4);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0003', '0004', '12345678A', '01', 1);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0003', '0005', '26481732O', '12', 2);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0003', '0007', '28361847I', '90', 3);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0003', '0008', '23162745J', '73', 4);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0004', '0003', '42817283K', '91', 1);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0004', '0001', '28167492P', '00', 2);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0004', '0006', '26481732O', '07', 3);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0005', '0002', '28361847I', '99', 1);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0005', '0006', '26481732O', '28', 2);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0005', '0010', '12846382D', '03', 3);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0006', '0010', '28167492P', '66', 1);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0006', '0004', '12345678A', '01', 2);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0006', '0008', '28361847I', '90', 3);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0006', '0005', '26917283W', '32', 4);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0006', '0003', '12846382D', '59', 5);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0007', '0005', '42817283K', '96', 1);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0007', '0010', '12345678A', '46', 2);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0007', '0007', '28361847I', '90', 3);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0007', '0003', '26481732O', '55', 4);
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0007', '0008', '23162745J', '13', 5);

-- Apuestas
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('21151051K', '0001', '0010', 20, 1);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('21151051K', '0004', '0003', 60, 10);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('21151051K', '0005', '0006', 35, 10);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('03602069Q', '0002', '0001', 27, 10);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('03602069Q', '0003', '0008', 10, 1);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('03602069Q', '0007', '0003', 1000, 1);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('03602069Q', '0005', '0002', 5, 10);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('94896146D', '0006', '0010', 25, 1);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('94896146D', '0004', '0006', 10, 10);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('94896146D', '0001', '0003', 30, 50);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('38172653J', '0003', '0004', 10, 10);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('38172653J', '0004', '0006', 5, 50);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('38172653J', '0007', '0003', 55, 50);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('93522209T', '0002', '0002', 3500, 1);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('93522209T', '0003', '0008', 5000, 5);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('93522209T', '0006', '0008', 50, 1);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('34372081F', '0001', '0006', 100, 10);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('34372081F', '0003', '0004', 65, 50);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('34372081F', '0006', '0008', 70, 10);
insert into apuestas(NIFCliente, CodCarrera, CodigoCaballo, ImporteApostado, TantoAUnoReal)
values('34372081F', '0004', '0001', 60, 10);