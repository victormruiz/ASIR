1. El barco que tiene asignado actualmente el punto de atraque más alejado de la lonja
inicia hoy una faena en el caladero en el que dicho barco ha capturado más kilos de la
especie con mayor tamaño mínimo. La faena terminará dentro de 15 días. Añade
dicha información a la base de datos mediante una consulta de datos anexados.*/

create or replace view PuntoAlejado
as
select Cod
from PUNTOS_DE_ATRAQUES
where DistanciaAlonja = (select max(DistanciaAlonja)
                        from PUNTOS_DE_ATRAQUES);

create or replace view BarcoPunto
as
select distinct (MatriculaBarco)
from PAGOS_ATRAQUES
where CodigoPuntoDeAtraque=(select Cod
                            from PuntoAlejado);

-- Matricula del barco mas alejado ^ --

create or replace view EspecieMaxTamaño
as
select Codigo
from ESPECIES_DE_PESCADOS
where TamañoMinimo = (select max(TamañoMinimo)
                from ESPECIES_DE_PESCADOS);

-- Especie con mayor tamaño minimo ^ --

create or replace view CaladeroFinal
as
select ReferenciaCaladero
from CAPTURAS_DIARIAS CD
where MatriculaBarco = (select MatriculaBarco
                        from BarcoPunto)
AND CodigoEspecie = (select Codigo
                    from EspecieMaxTamaño)
AND Kilos = (select max(Kilos)
             from CAPTURAS_DIARIAS
             where MatriculaBarco = (select MatriculaBarco
                                     from BarcoPunto)
             AND CodigoEspecie = (select Codigo
                                 from EspecieMaxTamaño));

insert into FAENAS_BARCOS (MatriculaBarco,ReferenciaCaladero,FechaInicio,FechaFin)
select MatriculaBarco, ReferenciaCaladero,current_date,current_date + 15
from BarcoPunto, CaladeroFinal;

2. El barco que capturó menos kilos en un solo día de pesca de la especie de la que se
han capturado más kilos en total ha pescado hoy de esa misma especie el triple de la
cantidad que capturó el último día que pesco en ese mismo caladero.



3. Muestra por cada armador, el número de kilos de especies de crustaceos capturado
por el conjunto de sus barcos durante los seis últimos meses.

create or replace view TipoMariscoCodigo
as
select Codigo
from ESPECIES_DE_PESCADOS
where Tipo = 'Marisco';

-- Muestra los tipos de pescados que sean mariscos ^ --

create or replace view Final
as
select DNIArmador, sum(Kilos) as SumaKilos
from BARCOS b, CAPTURAS_DIARIAS cd
where cd.CodigoEspecie in (select Codigo
                          from TipoMariscoCodigo)
AND cd.MatriculaBarco = b.Matricula
AND cd.FechaPescaFin > date_add(current_date, interval -6 MONTH)
group by DNIArmador;

-- DNI de armador con la cantidad de kilos que han pescado sus barcos ^ --

select nombre, Apellidos, SumaKilos
from ARMADORES, Final f
where DNI = f.DniArmador;



4. Muestra por cada caladero, el número total de kilos capturados en el último año de
cada especie de pescado.

create or replace view FechaCorrecta
as
select ReferenciaCaladero,CodigoEspecie,sum(Kilos) as TotalKilos
from CAPTURAS_DIARIAS
where FechaPescaFin > date_add(current_date, interval -12 month)
group by ReferenciaCaladero,CodigoEspecie
order by ReferenciaCaladero;

select Nombre, NombreComercial, TotalKilos
from FechaCorrecta FC, ESPECIES_DE_PESCADOS EP, CALADEROS C
where FC.CodigoEspecie = EP.Codigo
AND FC.ReferenciaCaladero = C.Referencia;

5. Muestra los nombres de los armadores que cumplen que alguno de sus barcos ha
realizado capturas en Gran Sol tanto en 2013 como en 2014 como en 2015.

create or replace view CapturasEnAñosGranSol
as
select MatriculaBarco
from FAENAS_BARCOS
where DATE_FORMAT(FechaInicio, '%Y') = ('2013')
AND ReferenciaCaladero IN (select Referencia
                           from CALADEROS
                           where Nombre = 'Gran Sol')
INTERSECT
select MatriculaBarco
from FAENAS_BARCOS
where DATE_FORMAT(FechaInicio, '%Y') = ('2014')
AND ReferenciaCaladero IN (select Referencia
                           from CALADEROS
                           where Nombre = 'Gran Sol')
INTERSECT
select MatriculaBarco
from FAENAS_BARCOS
where DATE_FORMAT(FechaInicio, '%Y') = ('2015')
AND ReferenciaCaladero IN (select Referencia
                           from CALADEROS
                           where Nombre = 'Gran Sol');


create or replace view DNIArmadorGranSol
as
select distinct DNIArmador
from BARCOS
where Matricula IN (select MatriculaBarco
                         from CapturasEnAñosGranSol);

select Nombre
From ARMADORES
where DNI IN (select DNIArmador
              from DNIArmadorGranSol);

6. Muestra los kilos de gamba blanca capturados por cada barco en caladeros de más de
2000 kms cuadrados de extensión, incluyendo aquellos barcos que no han capturado
nunca esta especie.

create or replace view CaladerosDeMasDe2000
as
select Referencia
from CALADEROS
Where Extension > 2000;

create or replace view CodigoDeGambaBlanca
as
select Codigo
from ESPECIES_DE_PESCADOS
where NombreComercial = 'Gamba Blanca';

create or replace view BarcosQueSiHanPescado
as
select distinct MatriculaBarco, sum(Kilos) as TotalKilos
from CAPTURAS_DIARIAS
where ReferenciaCaladero IN (select Referencia
                             from CaladerosDeMasDe2000)
AND CodigoEspecie = (select Codigo
                     from CodigoDeGambaBlanca)
group by MatriculaBarco;


create or replace view BarcosQueNoHanPescado
as
select distinct Matricula, 0 as TotalKilos
from BARCOS
where Matricula NOT IN (Select MatriculaBarco
                           from BarcosQueSiHanPescado);


select MatriculaBarco, TotalKilos
from BarcosQueSiHanPescado
union
select Matricula, TotalKilos
from BarcosQueNoHanPescado
order by TotalKilos desc;


7. Muestra el importe pagado por cada armador por los puntos de atraque de sus barcos
en el último año y medio.

create or replace view NumeroDePagosPorMatricula
as
select MatriculaBarco,count(*) as VECESPAGOS ,CodigoPuntoDeAtraque
from PAGOS_ATRAQUES
where ProximoPago < current_date
AND ProximoPago > date_add(current_date, interval -19 month)
group by MatriculaBarco,CodigoPuntoDeAtraque;

create or replace view PagosQueHanRealizadoBarcos
as
select PM.MatriculaBarco,PA.Precio*PM.VECESPAGOS as TOTALITARIO
from PUNTOS_DE_ATRAQUES PA, NumeroDePagosPorMatricula PM
where PA.Cod=PM.CodigoPuntoDeAtraque;

select a.Nombre, sum(PB.TOTALITARIO) as PAGOTOTAL
from BARCOS b, PagosQueHanRealizadoBarcos PB,ARMADORES a
where b.Matricula = PB.MatriculaBarco
and a.Dni=b.DniArmador
group by a.Nombre;

8. Muestra para cada barco el caladero en el que ha permanecido durante más días
faenando en los últimos dos años.

create or replace view BarcosEnCaladerosEnDosAños
as
select MatriculaBarco, ReferenciaCaladero, FechaFin - FechaInicio as DiasDePesca
from FAENAS_BARCOS
where fechaInicio > date_add(current_date, interval -24 month)
group by MatriculaBarco, ReferenciaCaladero;


select distinct MatriculaBarco, ReferenciaCaladero, DiasDePesca
from BarcosEnCaladerosEnDosAños BA
where DiasDePesca =(select max(DiasDePesca)
                    from BarcosEnCaladerosEnDosAños
                    where MatriculaBarco = BA.MatriculaBarco);

9. Muestra los nombres de los barcos que no han superado el número máximo de kilos
de capturas de ninguna especie (que tenga cuota) en ningún caladero.

create or replace view TotalKilosPorBarco
as
select MatriculaBarco,CodigoEspecie,sum(Kilos) as TOTAL, ReferenciaCaladero
From CAPTURAS_DIARIAS
group by CodigoEspecie,MatriculaBarco,ReferenciaCaladero
order by MatriculaBarco;


create or replace view VistaCaladerosSimp
as
select distinct CodigoEspecie, ReferenciaCaladero, MaximoKilos
from CAPTURA_CALADEROS
where año = '2018';


create or replace view BarcosQuesiHanSuperado
as
select matriculabarco
from TotalKilosPorBarco KB, VistaCaladerosSimp CS
where KB.CodigoEspecie = CS.CodigoEspecie
and KB.ReferenciaCaladero = CS.ReferenciaCaladero
and KB.TOTAL > CS.MaximoKilos
group by MatriculaBarco;


select Nombre
from BARCOS
where Matricula NOT IN (select Matriculabarco
                   from BarcosQuesiHanSuperado);

10. Crea una vista con el nombre del barco, el nombre del armador y el total adeudado de
todos los barcos que tienen pendiente algún pago por un punto de atraque que
disponga de cinta transportadora.

--puntos de atraque con cinta

create or replace view PuntosConCinta
as
select Cod
from PUNTOS_DE_ATRAQUES
where CintaTransportadora = 1;


--total adeudado de los barcos
create or replace view BarcosConDeudas
as
select distinct MatriculaBarco, DATEDIFF(current_date, ProximoPago) as mesesporpagar, CodigoPuntoDeAtraque
from PAGOS_ATRAQUES
where ProximoPago < current_date
and CodigoPuntoDeAtraque IN (select Cod
                            from PuntosConCinta);

create or replace view BarcosConDeudasTotal
as
select matriculabarco, round(max(mesesporpagar)) as MaxMeses, codigopuntodeatraque
from BarcosConDeudas
group by matriculabarco,codigopuntodeatraque;

--- barcos con los meses que deben ^ ----
create or replace view TotalDeuda
as
select BD.matriculabarco, BD.MaxMeses*PT.precio as DeudaCompleta, BD.codigopuntodeatraque
from BarcosConDeudasTotal BD , PAGOS_ATRAQUES PA, PUNTOS_DE_ATRAQUES PT
where BD.Matriculabarco = PA.MatriculaBarco
AND BD.CodigoPuntoDeAtraque = PT.Cod
group by BD.matriculabarco,BD.codigopuntodeatraque,BD.MaxMeses*PT.precio;

----- barcos con la deuda y el punto de atraque ^ -----
create or replace view NombreBarco
as
select nombre, matricula, DniArmador
from BARCOS
where Matricula IN (select matriculabarco
                   from TotalDeuda);

-- Nombre de los barcos que corresponden a las matriculas ^ --

create or replace view ArmadorDeuda
as
select nombre, DNI
from ARMADORES
where DNI IN(select DNIArmador
              from NombreBarco);

create or replace view VistaFinal
as
select AD.nombre, NB.Nombre ,TD.DeudaCompleta
from TotalDeuda TD, NombreBarco NB, ArmadorDeuda AD
where TD.MatriculaBarco = NB.Matricula
AND NB.DniArmador = AD.DNI
group by AD.nombre,NB.Nombre,TD.DeudaCompleta
order by AD.nombre;
