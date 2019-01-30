-- INITCAP Mysql (Wiki de la Moodle)
DELIMITER ||

CREATE FUNCTION `InicialesMayus`( str VARCHAR(255) ) RETURNS VARCHAR(255)
BEGIN  
  DECLARE c CHAR(1);  
  DECLARE s VARCHAR(255);  
  DECLARE i INT DEFAULT 1;  
  DECLARE bool INT DEFAULT 1;  
  DECLARE punct CHAR(17) DEFAULT ' ()[]{},.-_!@;:?/';  
  SET s = LCASE( str );  
  WHILE i < LENGTH( str ) DO  
     BEGIN  
       SET c = SUBSTRING( s, i, 1 );  
       IF LOCATE( c, punct ) > 0 THEN  
        SET bool = 1;  
      ELSEIF bool=1 THEN  
        BEGIN  
          IF c >= 'a' AND c <= 'z' THEN  
             BEGIN  
               SET s = CONCAT(LEFT(s,i-1),UCASE(c),SUBSTRING(s,i+1));  
               SET bool = 0;  
             END;  
           ELSEIF c >= '0' AND c <= '9' THEN  
            SET bool = 0;  
          END IF;  
        END;  
      END IF;  
      SET i = i+1;  
    END;  
  END WHILE;  
  RETURN s;
END ||  

DELIMITER ;


-- Creación de tablas

create table jockeys
(
	DNI VARCHAR(9),
	Nombre VARCHAR(25),
	Peso DECIMAL(3, 1),
	Altura VARCHAR(3),
	Telefono VARCHAR(9),
	constraint pk_jockeys PRIMARY KEY(DNI),
	constraint uu_tlfj UNIQUE(Telefono),
	constraint ck_dni CHECK((DNI RLIKE '[0-9]{8}[A-Z]') OR (DNI RLIKE '[KLMX-Z][0-9]{7}[A-Z]'))
);

create table clientes
(
	NIFCliente VARCHAR(9),
	Nombre VARCHAR(25),
	Apellido1 VARCHAR(25),
	Apellido2 VARCHAR(25),
	Direccion VARCHAR(30),
	Localidad VARCHAR(20),
	Provincia VARCHAR(20),
	Telefono VARCHAR(9),
	constraint pk_clientes PRIMARY KEY(NIFCliente),
	constraint uu_tlfc UNIQUE(Telefono),
	constraint ck_localidad CHECK(Localidad = InicialesMayus(Localidad)),
	constraint ck_nifc CHECK((NIFCliente RLIKE '[0-9]{8}[A-Z]') OR (NIFCliente RLIKE '[KLMX-Z][0-9]{7}[A-Z]'))
);

create table propietarios
(
	NIF VARCHAR(9),
	CuotaMensual DECIMAL(5, 2),
	constraint pk_propietarios PRIMARY KEY(NIF),
	constraint ck_nifp CHECK((NIF RLIKE '[0-9]{8}[A-Z]') OR (NIF RLIKE '[KLMX-Z][0-9]{7}[A-Z]'))
);

create table instalacionescuadras
(
	CodCuadra VARCHAR(4),
	Aforo INTEGER(3),
	Tamanyo DECIMAL(4, 1),
	Tipo VARCHAR(20),
	constraint pk_instalacionescuadras PRIMARY KEY(CodCuadra),
	constraint ck_tipo CHECK(Tipo IN ('Hierba', 'Arena batida', 'Tierra'))
);

create table pistasentrenamiento
(
	CodCuadra VARCHAR(4),
	Superficie DECIMAL(2, 1),
	Longitud INTEGER(4),
	constraint pk_pistasentrenamiento PRIMARY KEY(CodCuadra),
	constraint fk_cuadraspe FOREIGN KEY(CodCuadra) REFERENCES instalacionescuadras (CodCuadra)
);

create table caballos
(
	CodigoCaballo VARCHAR(4),
	Nombre VARCHAR(25),
	FechaNac DATE,
	Raza VARCHAR(25),
	NIFPropietario VARCHAR(9),
	constraint pk_caballos PRIMARY KEY(CodigoCaballo),
	constraint fk_propietarios FOREIGN KEY(NIFPropietario) REFERENCES propietarios (NIF)
);

create table cuadrante
(
	CodigoCaballo VARCHAR(4),
	CodCuadra VARCHAR(4),
	FechaHora DATETIME,
	constraint pk_cuadrante PRIMARY KEY(CodigoCaballo, CodCuadra, FechaHora),
	constraint fk_caballoscuad FOREIGN KEY(CodigoCaballo) REFERENCES caballos (CodigoCaballo),
	constraint fk_cuadrascuad FOREIGN KEY(CodCuadra) REFERENCES instalacionescuadras (CodCuadra),
	constraint ck_fechaok CHECK(DATE_FORMAT(FechaHora, '%w') != '1')
);

create table caballoscarreras
(
	CodigoCaballo VARCHAR(4),
	Peso DECIMAL(5, 2),
	Nacionalidad VARCHAR(20),
	FechaNacMin DATE,
	FechaNacMax DATE,
	constraint pk_caballoscarreras PRIMARY KEY(CodigoCaballo),
	constraint fk_caballosccarr FOREIGN KEY(CodigoCaballo) REFERENCES caballos (CodigoCaballo)
);

create table carrerasprofesionales
(
	CodCarrera VARCHAR(4),
	FechaHora DATETIME,
	ImportePremio INTEGER(5),
	LimiteApuesta INTEGER(5),
	FechaNacMin DATE,
	FechaNacMax DATE,
	constraint pk_carrerasprofesionales PRIMARY KEY(CodCarrera),
	constraint ck_limiteapuesta CHECK(LimiteApuesta <= 9000),
	constraint ck_FechaCarrera CHECK(FechaHora BETWEEN STR_TO_DATE('20/10', '%d/%m') AND STR_TO_DATE('02/03', '%d/%m')),
	constraint ck_HoraCarrera CHECK(DATE_FORMAT(FechaHora, '%H%i') BETWEEN '0900' AND '1400'),
	constraint ck_DiaCarrera CHECK(DATE_FORMAT(FechaHora, '%w') != '0')
);

create table participaciones
(
	CodCarrera VARCHAR(4),
	CodigoCaballo VARCHAR(4),
	DNIJockey VARCHAR(9),
	Dorsal VARCHAR(2),
	PosicionFinal VARCHAR(10),
	constraint pk_participaciones PRIMARY KEY(CodCarrera, CodigoCaballo),
	constraint fk_carrerasprofesionales FOREIGN KEY(CodCarrera) REFERENCES carrerasprofesionales (CodCarrera),
	constraint fk_caballos FOREIGN KEY(CodigoCaballo) REFERENCES caballos (CodigoCaballo),
	constraint fk_jockeys FOREIGN KEY(DNIJockey) REFERENCES jockeys (DNI),
	constraint ck_posfinal CHECK(PosicionFinal <= '12' or PosicionFinal IN ('Abandono', 'No sale'))
);

create table apuestas
(
	NIFCliente VARCHAR(9),
	CodCarrera VARCHAR(4),
	CodigoCaballo VARCHAR(4),
	ImporteApostado DECIMAL(7, 2) NOT NULL,
	TantoAUnoReal INTEGER(3) NOT NULL,
	constraint pk_apuestas PRIMARY KEY(NIFCliente, CodCarrera, CodigoCaballo),
	constraint fk_clientes FOREIGN KEY(NIFCliente) REFERENCES clientes (NIFCliente),
	constraint fk_carrerasprofesionalesap FOREIGN KEY(CodCarrera) REFERENCES carrerasprofesionales (CodCarrera),
	constraint fk_caballosap FOREIGN KEY(CodigoCaballo) REFERENCES caballos (CodigoCaballo),
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
values('0001', 'ARISTODEMUS', STR_TO_DATE('26/01/2013', '%d/%m/%Y'), 'Cuarto de milla', 'Z8419432B');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0002', 'CACHA', STR_TO_DATE('07/12/2012', '%d/%m/%Y'), 'Cuarto de milla', '25439654K');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0003', 'BILLYCOCK HILL', STR_TO_DATE('30/01/2013', '%d/%m/%Y'), 'Morgan', '25439654K');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0004', 'MY LADY', STR_TO_DATE('25/02/2013', '%d/%m/%Y'), 'Purasangre', '06911410W');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0005', 'SABATERET', STR_TO_DATE('29/03/2013', '%d/%m/%Y'), 'Caballo andaluz', 'X1563263E');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0006', 'BELOKI', STR_TO_DATE('07/01/2013', '%d/%m/%Y'), 'Árabe', 'X1563263E');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0007', 'CECILIUS', STR_TO_DATE('09/10/2013', '%d/%m/%Y'), 'Jaca', '78146235D');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0008', 'KASPAROVA', STR_TO_DATE('08/07/2013', '%d/%m/%Y'), 'Apalusa', '78146235D');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0009', 'EK BALAM', STR_TO_DATE('10/11/2012', '%d/%m/%Y'), 'Caballo andaluz', '78146235D');
insert into caballos(CodigoCaballo, Nombre, FechaNac, Raza, NIFPropietario)
values('0010', 'BARAKA', STR_TO_DATE('28/02/2013', '%d/%m/%Y'), 'Apalusa', '78146235D');

-- Cuadrante
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0001', '005', STR_TO_DATE('02/01/2018 09:30', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0001', '003', STR_TO_DATE('02/01/2018 10:45', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0002', '001', STR_TO_DATE('02/01/2018 10:00', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0002', '007', STR_TO_DATE('03/01/2018 10:00', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0003', '002', STR_TO_DATE('04/01/2018 12:45', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0003', '004', STR_TO_DATE('05/01/2018 10:00', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0004', '006', STR_TO_DATE('05/01/2018 12:00', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0004', '002', STR_TO_DATE('10/01/2018 09:00', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0005', '001', STR_TO_DATE('12/01/2018 09:30', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0005', '001', STR_TO_DATE('12/01/2018 17:30', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0006', '005', STR_TO_DATE('17/01/2018 13:45', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0006', '008', STR_TO_DATE('17/01/2018 19:45', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0007', '007', STR_TO_DATE('18/01/2018 09:45', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0007', '002', STR_TO_DATE('18/01/2018 11:00', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0008', '005', STR_TO_DATE('18/01/2018 12:00', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0008', '005', STR_TO_DATE('18/01/2018 17:00', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0009', '003', STR_TO_DATE('19/01/2018 10:45', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0009', '004', STR_TO_DATE('20/01/2018 09:00', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0010', '006', STR_TO_DATE('24/01/2018 14:45', '%d/%m/%Y %H:%i'));
insert into cuadrante(CodigoCaballo, CodCuadra, FechaHora)
values('0010', '008', STR_TO_DATE('24/01/2018 17:30', '%d/%m/%Y %H:%i'));

-- Caballos de carrera
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0001', 470, 'Irlandés', STR_TO_DATE('01/01/2013', '%d/%m/%Y'), STR_TO_DATE('30/10/2013', '%d/%m/%Y'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0002', 482.70, 'Inglés', STR_TO_DATE('01/10/2012', '%d/%m/%Y'), STR_TO_DATE('10/12/2012', '%d/%m/%Y'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0003', 475, 'Inglés', STR_TO_DATE('10/01/2013', '%d/%m/%Y'), STR_TO_DATE('31/12/2013', '%d/%m/%Y'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0004', 466.50, 'Francés', STR_TO_DATE('25/01/2013', '%d/%m/%Y'), STR_TO_DATE('31/12/2013', '%d/%m/%Y'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0005', 478.40, 'Francés', STR_TO_DATE('02/02/2013', '%d/%m/%Y'), STR_TO_DATE('30/10/2013', '%d/%m/%Y'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0006', 480, 'Español', STR_TO_DATE('01/01/2013', '%d/%m/%Y'), STR_TO_DATE('15/08/2013', '%d/%m/%Y'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0007', 479.90, 'Español', STR_TO_DATE('01/05/2013', '%d/%m/%Y'), STR_TO_DATE('10/10/2013', '%d/%m/%Y'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0008', 477, 'Español', STR_TO_DATE('05/01/2013', '%d/%m/%Y'), STR_TO_DATE('05/09/2013', '%d/%m/%Y'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0009', 480, 'Español', STR_TO_DATE('05/05/2012', '%d/%m/%Y'), STR_TO_DATE('10/12/2012', '%d/%m/%Y'));
insert into caballoscarreras(CodigoCaballo, Peso, Nacionalidad, FechaNacMin, FechaNacMax)
values('0010', 490.90, 'Español', STR_TO_DATE('09/01/2013', '%d/%m/%Y'), STR_TO_DATE('09/10/2013', '%d/%m/%Y'));

-- Carreras profesionales
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0001', STR_TO_DATE('21/01/2018 09:30', '%d/%m/%Y %H:%i'), 7000, 3500, STR_TO_DATE('01/01/2013', '%d/%m/%Y'), STR_TO_DATE('01/08/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0002', STR_TO_DATE('21/01/2018 10:00', '%d/%m/%Y %H:%i'), 7875, 3500, STR_TO_DATE('01/01/2012', '%d/%m/%Y'), STR_TO_DATE('28/01/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0003', STR_TO_DATE('21/01/2018 12:30', '%d/%m/%Y %H:%i'), 14000, 9000, STR_TO_DATE('01/02/2013', '%d/%m/%Y'), STR_TO_DATE('31/12/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0004', STR_TO_DATE('21/01/2018 13:30', '%d/%m/%Y %H:%i'), 7000, 3500, STR_TO_DATE('01/01/2013', '%d/%m/%Y'), STR_TO_DATE('31/12/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0005', STR_TO_DATE('28/01/2018 09:30', '%d/%m/%Y %H:%i'), 7875, 3500, STR_TO_DATE('01/01/2012', '%d/%m/%Y'), STR_TO_DATE('31/10/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0006', STR_TO_DATE('28/01/2018 10:00', '%d/%m/%Y %H:%i'), 8750, 4500, STR_TO_DATE('01/01/2013', '%d/%m/%Y'), STR_TO_DATE('03/12/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0007', STR_TO_DATE('28/01/2018 10:30', '%d/%m/%Y %H:%i'), 7200, 3500, STR_TO_DATE('10/01/2013', '%d/%m/%Y'), STR_TO_DATE('03/12/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0008', STR_TO_DATE('28/01/2018 12:00', '%d/%m/%Y %H:%i'), 8000, 4500, STR_TO_DATE('01/02/2013', '%d/%m/%Y'), STR_TO_DATE('01/12/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0009', STR_TO_DATE('04/02/2018 10:00', '%d/%m/%Y %H:%i'), 8000, 4500, STR_TO_DATE('01/05/2012', '%d/%m/%Y'), STR_TO_DATE('05/05/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0010', STR_TO_DATE('04/02/2018 11:30', '%d/%m/%Y %H:%i'), 8750, 4500, STR_TO_DATE('01/01/2013', '%d/%m/%Y'), STR_TO_DATE('31/12/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0011', STR_TO_DATE('04/02/2018 12:45', '%d/%m/%Y %H:%i'), 7700, 3500, STR_TO_DATE('01/02/2013', '%d/%m/%Y'), STR_TO_DATE('20/12/2013', '%d/%m/%Y'));
insert into carrerasprofesionales(CodCarrera, FechaHora, ImportePremio, LimiteApuesta, FechaNacMin, FechaNacMax)
values('0012', STR_TO_DATE('04/02/2018 13:30', '%d/%m/%Y %H:%i'), 11350, 9000, STR_TO_DATE('01/01/2012', '%d/%m/%Y'), STR_TO_DATE('31/12/2013', '%d/%m/%Y'));

-- Participaciones
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0001', '12345678A', '33', '1');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0003', '23162745J', '14', '2');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0006', '28361847I', '90', '3');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0005', '42817283K', '28', '4');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0008', '28167492P', '77', '5');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0001', '0010', '12846382D', '69', '6');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0002', '0002', '23162745J', '21', '1');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0002', '0001', '28361847I', '10', '2');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0002', '0006', '28167492P', '34', '3');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0002', '0009', '12345678A', '00', '4');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0003', '0004', '12345678A', '01', '1');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0003', '0005', '26481732O', '12', '2');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0003', '0007', '28361847I', '90', '3');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0003', '0008', '23162745J', '73', '4');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0004', '0003', '42817283K', '91', '1');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0004', '0001', '28167492P', '00', '2');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0004', '0006', '26481732O', '07', '3');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0005', '0002', '28361847I', '99', '1');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0005', '0006', '26481732O', '28', '2');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0005', '0010', '12846382D', '03', '3');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0006', '0010', '28167492P', '66', '1');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0006', '0004', '12345678A', '01', '2');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0006', '0008', '28361847I', '90', '3');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0006', '0005', '26917283W', '32', '4');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0006', '0003', '12846382D', '59', '5');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0007', '0005', '42817283K', '96', '1');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0007', '0010', '12345678A', '46', '2');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0007', '0007', '28361847I', '90', '3');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0007', '0003', '26481732O', '55', '4');
insert into participaciones(CodCarrera, CodigoCaballo, DNIJockey, Dorsal, PosicionFinal)
values('0007', '0008', '23162745J', '13', '5');

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