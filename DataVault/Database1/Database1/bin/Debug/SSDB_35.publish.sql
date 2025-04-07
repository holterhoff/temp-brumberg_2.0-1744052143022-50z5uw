/*
Bereitstellungsskript für Brumberg

Dieser Code wurde von einem Tool generiert.
Änderungen an dieser Datei führen möglicherweise zu falschem Verhalten und gehen verloren, falls
der Code neu generiert wird.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Brumberg"
:setvar DefaultFilePrefix "Brumberg"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Überprüfen Sie den SQLCMD-Modus, und deaktivieren Sie die Skriptausführung, wenn der SQLCMD-Modus nicht unterstützt wird.
Um das Skript nach dem Aktivieren des SQLCMD-Modus erneut zu aktivieren, führen Sie folgenden Befehl aus:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Der SQLCMD-Modus muss aktiviert sein, damit dieses Skript erfolgreich ausgeführt werden kann.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Sicht "[fakt].[Spot]" wird geändert...';


GO


ALTER VIEW [fakt].[Spot] as 

select 

		h1.Leuchtentyp
	,	h1.Typ
	,	h1.Form
	,	h1.Farbe
	,	s1.Schutzart
	,	s1.Einbaudurchmesser	
	,	s1.Einbautiefe
	,	s1.Schwenkwinkel
	,	s1.Image
	,	h2.Lichtfarbe
	,	h2.Farbkanal
	,	h2.Lichtstrom
	,	h2.Leistung
	,	h2.Effizienzklasse
	,	h3.Beschreibung
	,	h3.Versorgung
	,	h3.Ansteuerung
	,	h3.Ausführung
	,	h3.Leistung_Min
	,	h3.Leistung_Max


	,	CASE WHEN CEILING(h3.Leistung_Min / h2.Leistung) = 0 THEN 1  ELSE CEILING(h3.Leistung_Min / h2.Leistung) END as Min_Anzahl
	,	Max_Anzahl = FLOOR(h3.Leistung_Max / h2.Leistung)

	,	Lampenplatz = 1




 from hub.Spot_Gehaeuse h1
 INNER JOIN sat.Spot_Gehaeuse_Stammdaten s1 ON h1.Gehaeuse_SK = s1.Gehaeuse_SK
 INNER JOIN Link.Spot_Gehaeuse__Leuchte l1 ON h1.Gehaeuse_SK = l1.Gehaeuse_SK
 INNER JOIN hub.Spot_Leuchte h2 ON h2.Leuchte_SK = l1.Leuchte_SK
 INNER JOIN link.Spot_Leuchte__Treiber l2 ON l2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN hub.Spot_Treiber h3 ON l2.Treiber_SK = h3.Treiber_SK


--where 1=1
----- Gehäuse
--and typ = '1964'
--and Farbe = 'chrom'
--
---- LED
--and Farbkanal = 'Statisch'
--and Lichtfarbe = '2700 K'
--And h2.Leistung = 3.00
--
---- Treiber
--and Ansteuerung ='DALI-2'
--and h3.Ausführung = 'Plug & Play'
GO
PRINT N'Prozedur "[dbo].[sat_Biro40_Leuchte_Artikel_MA]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_Biro40_Leuchte_Artikel_MA] as

TRUNCATE TABLE sat.Biro40_Leuchte_Artikel_MA;

WITH cte as
(
	SELECT Leuchte_SK, [Min] , [Step], [Max], [Min] as newval  FROM sat.Biro40_Leuchte_Laengen

	UNION ALL

	SELECT Leuchte_SK, [min] , [step], [max],  newval + [step] from cte
	WHERE newval < [max]

)
INSERT INTO sat.Biro40_Leuchte_Artikel_MA (Leuchte_SK, Mass, Artikelnummer)
SELECT Leuchte_SK, newval as Mass, 0 AS Artikelnummer  FROM cte

order by Leuchte_SK, Mass
GO
PRINT N'Prozedur "[dbo].[sat_Biro40_Leuchte_Laengen]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_Biro40_Leuchte_Laengen] as

TRUNCATE TABLE sat.Biro40_Leuchte_Laengen

INSERT INTO sat.Biro40_Leuchte_Laengen(Leuchte_SK, [Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
SELECT * FROM (VALUES


 (1,  560	    ,  2380 	, 140	,586   , 2	, 5)
,(2,  560	    ,  2380 	, 140	,586   , 2	, 5)
,(3,  840	    ,  2380 	, 140	,586   , 2	, 5)
,(4,  840	    ,  2380 	, 140	,586   , 2	, 5)
,(5,  980	    ,  2520 	, 70	,586   , 2	, 5)
,(6,  2520  	,  5600 	, 280	,586   , 2	, 5)
,(7,  560	    ,  2240 	, 140	,586   , 2	, 5)
,(8,  560	    ,  2240 	, 140	,586   , 2	, 5)
,(9,  560	    ,  2240 	, 140	,586   , 2	, 5)
,(10, 560	    ,  2240 	, 140	,586   , 2	, 5)
,(11, 2520  	,  2520 	, 2520  ,586   , 2	, 5)
,(12, 1050  	,  1050 	, 1050  ,586   , 2	, 5)
,(13, 1120  	,  1120 	, 1120  ,586   , 2	, 5)
,(14, 1190  	,  1190 	, 1190  ,586   , 2	, 5)
,(15, 1260  	,  1260 	, 1260  ,586   , 2	, 5)
,(16, 1330  	,  1330 	, 1330  ,586   , 2	, 5)



)t (Leuchte_SK ,[Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
GO
PRINT N'Prozedur "[dbo].[sat_Biro40_Optik_Laengen]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_Biro40_Optik_Laengen] as

TRUNCATE TABLE sat.Biro40_Optik_Laengen

INSERT INTO sat.Biro40_Optik_Laengen(Leuchte_SK, [Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
SELECT * FROM (VALUES


 (1,  1500	    ,  1500 	, 1500	,586   , 0	, 0)
,(2,  3000	    ,  3000 	, 3000	,586   , 0	, 0)
,(3,  1500	    ,  1500 	, 1500	,586   , 0	, 0)
,(4,  3000	    ,  3000 	, 3000	,586   , 0	, 0)


)t (Leuchte_SK ,[Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
GO
PRINT N'Prozedur "[dbo].[sat_Biro40_Profil_Laengen]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_Biro40_Profil_Laengen] as

TRUNCATE TABLE sat.Biro40_Profil_Laengen

INSERT INTO sat.Biro40_Profil_Laengen(Leuchte_SK, [Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
SELECT * FROM (VALUES


 (1,  1500	    ,  1500 	, 1500	,586   , 0	, 0)
,(2,  3000	    ,  3000 	, 3000	,586   , 0	, 0)
,(3,  1500	    ,  1500 	, 1500	,586   , 0	, 0)
,(4,  3000	    ,  3000 	, 3000	,586   , 0	, 0)


)t (Leuchte_SK ,[Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
GO
PRINT N'Prozedur "[dbo].[sat_Spot_Gehaeuse_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_Spot_Gehaeuse_Stammdaten] as

TRUNCATE TABLE sat.Spot_Gehaeuse_Stammdaten

INSERT INTO sat.Spot_Gehaeuse_Stammdaten (Gehaeuse_SK, Schutzart, Einbaudurchmesser, Einbautiefe, Schwenkwinkel, Leistung, Ausführung, [Image], Produktbeschreibung)
SELECT * FROM (VALUES

 (1		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.1.jpg'		,'Einbaustrahler, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(2		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.2.jpg'		,'Einbaustrahler, GX5,3, chrom matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(3		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.3.jpg'		,'Einbaustrahler, GX5,3, gold, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(4		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.4.jpg'		,'Einbaustrahler, GX5,3,schwarz, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(5		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.5.jpg'		,'Einbaustrahler, GX5,3, strukturweiss, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(6		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.6.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(7		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.7.jpg'		,'Einbaustrahler, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(8		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.1.jpg'		,'Einbaustrahler, GX5,3, chrom, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(9		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.2.jpg'		,'Einbaustrahler, GX5,3, chrom matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(10	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.3.jpg'		,'Einbaustrahler, GX5,3, gold, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(11	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.4.jpg'		,'Einbaustrahler, GX5,3, schwarz, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(12	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.5.jpg'		,'Einbaustrahler, GX5,3, strukturweiss, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(13	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.6.jpg'		,'Einbaustrahler, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(14	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.7.jpg'		,'Einbaustrahler, GX5,3, nickel matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(15	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.3.1.jpg'		,'Einbaustrahler, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl / Messing, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(16	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.3.2.jpg'		,'Einbaustrahler, GX5,3, chrom matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl / Messing, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(17	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.3.3.jpg'		,'Einbaustrahler, GX5,3, gold, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl / Messing, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(18	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.3.4.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl / Messing, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(19	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.3.5.jpg'		,'Einbaustrahler, GX5,3, schwarz, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl / Messing, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(20	,'IP20'		,68		,50		,0		,50		,'GX5,3'			,'1.4.1.jpg'		,'Einbaudownlight, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(21	,'IP65'		,68		,55		,0		,14		,'ohne Fassung'		,'1.5.1.jpg'		,'Einbaudownlight, V4A, IP65, strukturweiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit STEAM verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweilseingesetzten LED-Modul (hier: 2 mm, zzgl. Höhe des LED-Moduls).Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl / Aluminium / Kunststoff / Glas, Schutzart raumseitig: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(22	,'IP65'		,68		,55		,0		,14		,'ohne Fassung'		,'1.5.2.jpg'		,'Einbaudownlight, V4A, IP65, edelstahl, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit STEAM verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweilseingesetzten LED-Modul (hier: 2 mm, zzgl. Höhe des LED-Moduls).Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl / Aluminium / Kunststoff / Glas, Schutzart raumseitig: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(23	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.6.1.jpg'		,'Einbaustrahler, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(24	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.6.2.jpg'		,'Einbaustrahler, GX5,3, chrom matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(25	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.6.3.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(26	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.7.1.jpg'		,'Einbaustrahler, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(27	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.7.2.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(28	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.7.3.jpg'		,'Einbaustrahler, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(29	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.8.1.jpg'		,'Einbaustrahler, GX5,3, chrom, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(30	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.8.2.jpg'		,'Einbaustrahler, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(31	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.8.3.jpg'		,'Einbaustrahler, GX5,3, nickel matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(32	,'IP65'		,68		,80		,0		,50		,'GX5,3'			,'1.9.1.jpg'		,'Einbaudownlight, IP65, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss / Glas, Schutzart: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(33	,'IP65'		,68		,80		,0		,50		,'GX5,3'			,'1.9.2.jpg'		,'Einbaudownlight, IP65, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss / Glas, Schutzart: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(34	,'IP65'		,68		,80		,0		,50		,'GX5,3'			,'1.9.3.jpg'		,'Einbaudownlight, IP65, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss / Glas, Schutzart: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(35	,'IP65'		,68		,80		,0		,50		,'GX5,3'			,'1.10.1.jpg'		,'Einbaudownlight, V4A, IP65, GX5,3, edelstahl, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl / Glas, Schutzart: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(36	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.11.1.jpg'		,'Einbaustrahler, V4A, GX5,3, edelstahl, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(37	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.12.1.jpg'		,'Einbaustrahler, V4A, GX5,3, edelstahl, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(38	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.13.1.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(39	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.13.2.jpg'		,'Einbaustrahler, GX5,3, edelstahl klar gepulvert, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(40	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.13.3.jpg'		,'Einbaustrahler, GX5,3, edelstahl, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(41	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.14.1.jpg'		,'Einbaustrahler, GX5,3, schwarz / alu matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(42	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.15.1.jpg'		,'Einbaustrahler, GX5,3, schwarz / alu matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(43	,'IP20'		,75		,55		,30		,50		,'GX5,3'			,'1.16.1.jpg'		,'Einbaustrahler, GX5,3, alu matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(44	,'IP20'		,75		,55		,30		,50		,'GX5,3'			,'1.17.1.jpg'		,'Einbaustrahler, GX5,3, alu matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(45	,'IP20'		,80		,55		,30		,50		,'GX5,3'			,'1.18.1.jpg'		,'Einbaustrahler, GX5,3, alu matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(46	,'IP20'		,68		,70		,25		,50		,'GX5,3'			,'1.19.1.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(47	,'IP20'		,68		,70		,25		,50		,'GX5,3'			,'1.19.2.jpg'		,'Einbaustrahler, GX5,3, alu matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(48	,'IP20'		,68		,70		,25		,50		,'GX5,3'			,'1.19.3.jpg'		,'Einbaustrahler, GX5,3, schwarz, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(49	,'IP20'		,68		,50		,0		,50		,'GX5,3'			,'1.20.1.jpg'		,'Einbaudownlight, GX5,3, chrom, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(50	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.21.1.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(51	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.21.2.jpg'		,'Einbaustrahler, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(52	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.21.3.jpg'		,'Einbaustrahler, GX5,3, silber, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(53	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.22.1.jpg'		,'Einbaustrahler, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(54	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.22.2.jpg'		,'Einbaustrahler, GX5,3, nickel matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(55	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.22.3.jpg'		,'Einbaustrahler, GX5,3, silber, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(56	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.23.1.jpg'		,'Einbaustrahler, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(57	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.23.2.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(58	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.23.3.jpg'		,'Einbaustrahler, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(59	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.24.1.jpg'		,'Einbaustrahler, GX5,3, chrom, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(60	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.24.2.jpg'		,'Einbaustrahler, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(61	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.24.3.jpg'		,'Einbaustrahler, GX5,3, nickel matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(62	,'IP20'		,75		,55		,30		,50		,'GX5,3'			,'1.25.1.jpg'		,'Einbaustrahler, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Verstellbarkeit: drehbar und schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(63	,'IP20'		,75		,55		,30		,50		,'GX5,3'			,'1.25.2.jpg'		,'Einbaustrahler, GX5,3, alu matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Verstellbarkeit: drehbar und schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(64	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.1.jpg'		,'Einbaustrahler, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(65	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.2.jpg'		,'Einbaustrahler, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(66	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.3.jpg'		,'Einbaustrahler, schwarz, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50WW, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(67	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.4.jpg'		,'Einbaustrahler, GX5,3, strukturweiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(68	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.5.jpg'		,'Einbaustrahler, alu matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige. ')
,(69	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.6.jpg'		,'Einbaustrahler, champagner matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(70	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.7.jpg'		,'Einbaustrahler, titan matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(71	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.1.jpg'		,'Einbaustrahler, chrom, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(72	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.2.jpg'		,'Einbaustrahler, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(73	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.3.jpg'		,'Einbaustrahler, schwarz, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(74	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.4.jpg'		,'Einbaustrahler, GX5,3, strukturweiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(75	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.5.jpg'		,'Einbaustrahler, alu matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige')
,(76	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.6.jpg'		,'Einbaustrahler, champagner matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(77	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.7.jpg'		,'Einbaustrahler, titan matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(78	,'IP20'		,68		,55		,0		,14		,'ohne Fassung'		,'1.28.1.jpg'		,'Einbaudownlight, V4A, IP54, strukturweiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit STEAM verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 2 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl / Aluminium / Kunststoff / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(79	,'IP20'		,68		,55		,0		,14		,'ohne Fassung'		,'1.28.2.jpg'		,'Einbaudownlight, V4A, IP54, edelstahl, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit STEAM verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 2 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl / Aluminium / Kunststoff / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(80	,'IP44'		,68		,55		,0		,14		,'ohne LED-Modul'	,'1.29.1.jpg'		,'Einbaudownlight, IP44, weiß mit Dekoglas klar, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit COVER-UP verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 11 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Stahl / Glas, Schutzart raumseitig: nach DIN EN 60529: IP44*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(81	,'IP44'		,68		,55		,0		,14		,'ohne LED-Modul'	,'1.29.2.jpg'		,'Einbaudownlight, IP44, schwarz mit Dekoglas klar, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit COVER-UP verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 11 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Stahl / Glas, Schutzart raumseitig: nach DIN EN 60529: IP44*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(82	,'IP44'		,68		,55		,0		,14		,'ohne LED-Modul'	,'1.30.1.jpg'		,'Einbaudownlight, IP44, weiß mit Dekoglas klar, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit COVER-UP verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 11 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Stahl / Glas, Schutzart raumseitig: nach DIN EN 60529: IP44*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(83	,'IP44'		,68		,55		,0		,14		,'ohne LED-Modul'	,'1.30.2.jpg'		,'Einbaudownlight, IP44, schwarz mit Dekoglas klar, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit COVER-UP verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 11 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Stahl / Glas, Schutzart raumseitig: nach DIN EN 60529: IP44*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(84	,'IP65'		,75		,55		,0		,35		,'GX5,3'			,'1.31.1.jpg'		,'Einbaudownlight, IP65, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(85	,'IP65'		,75		,55		,0		,35		,'GX5,3'			,'1.31.2.jpg'		,'Einbaudownlight, IP65, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(86	,'IP65'		,75		,55		,0		,35		,'GX5,3'			,'1.31.3.jpg'		,'Einbaudownlight, IP65, GX5,3, silber, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(87	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.32.1.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(88	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.32.2.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, schwarz, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(89	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.32.3.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, edelstahl, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(90	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.33.1.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(91	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.33.2.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, schwarz, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(92	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.33.3.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, edelstahl, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')

)t (Gehaeuse_SK, Schutzart, Einbaudurchmesser, Einbautiefe, Schwenkwinkel, Leistung, Ausführung, [Image], Produktbeschreibung)
GO
PRINT N'Prozedur "[dbo].[sat_Spot_Leuchte_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_Spot_Leuchte_Stammdaten] as

TRUNCATE TABLE sat.Spot_Leuchte_Stammdaten

INSERT INTO sat.Spot_Leuchte_Stammdaten (Leuchte_SK, [Image])
SELECT * FROM (VALUES

 (1	  , '1.1.1.1.1.jpg')
,(2	  , '1.1.1.2.1.jpg')
,(3	  , '1.1.1.2.2.jpg')
,(4	  , '1.1.1.3.1.jpg')
,(5	  , '1.1.2.1.1.jpg')
,(6	  , '1.1.2.2.1.jpg')
,(7	  , '1.1.2.2.2.jpg')
,(8	  , '1.1.2.3.1.jpg')
,(9	  , '1.1.3.1.1.jpg')
,(10  , '1.1.3.1.2.jpg')
,(11  , '1.1.3.2.1.jpg')
,(12  , '1.1.4.1.1.jpg')
,(13  , '1.1.4.2.1.jpg')
,(14  , '1.1.4.2.2.jpg')
,(15  , '1.1.4.3.1.jpg')
,(16  , '1.2.1.1.1.jpg')
,(17  , '1.2.1.1.2.jpg')
,(18  , '1.2.1.2.1.jpg')
,(19  , '1.3.1.1.1.jpg')
,(20  , '1.4.1.1.1.jpg')
,(21  , '1.4.1.1.2.jpg')
,(22  , '1.4.1.1.3.jpg')
,(23  , '1.4.1.1.4.jpg')
,(24  , '1.4.2.1.1.jpg')
,(25  , '1.4.2.1.2.jpg')
,(26  , '1.4.2.1.3.jpg')
,(27  , '1.4.2.1.4.jpg')
,(28  , '1.5.1.1.1.jpg')

     

)t (Leuchte_SK, [Image])
GO
PRINT N'Prozedur "[dbo].[sat_Spot_Treiber_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_Spot_Treiber_Stammdaten] as

TRUNCATE TABLE sat.Spot_Treiber_Stammdaten

INSERT INTO sat.Spot_Treiber_Stammdaten (Treiber_SK, [Image])
SELECT * FROM (VALUES


 (1	 ,  '1.1.1.1.jpg')
,(2	 ,  '1.1.2.1.jpg')
,(3	 ,  '1.1.2.2.jpg')
,(4	 ,  '1.1.2.3.jpg')
,(5	 ,  '1.1.3.1.jpg')
,(6	 ,  '1.1.3.2.jpg')
,(7	 ,  '1.1.3.3.jpg')
,(8	 ,  '1.1.4.1.jpg')
,(9	 ,  '1.1.4.2.jpg')
,(10 ,  '1.1.4.3.jpg')
,(11 ,  '1.2.1.1.jpg')
,(12 ,  '1.2.1.2.jpg')
,(13 ,  '1.2.1.3.jpg')
,(14 ,  '1.2.2.1.jpg')
,(15 ,  '1.2.2.3.jpg')
,(16 ,  '1.2.3.1.jpg')
,(17 ,  '1.2.3.2.jpg')
,(18 ,  '1.2.3.3.jpg')
,(19 ,  '1.2.4.1.jpg')
,(20 ,  '1.2.4.2.jpg')
,(21 ,  '1.2.4.3.jpg')
,(22 ,  '1.2.5.1.jpg')
,(23 ,  '1.2.5.2.jpg')
,(24 ,  '1.2.5.3.jpg')
,(25 ,  '1.2.6.1.jpg')
,(26 ,  '1.2.6.2.jpg')
,(27 ,  '1.2.6.3.jpg')
,(28 ,  '1.3.1.1.jpg')
,(29 ,  '1.3.1.2.jpg')
,(30 ,  '1.4.1.1.jpg')
,(31 ,  '1.4.1.2.jpg')
,(32 ,  '1.4.1.3.jpg')
,(33 ,  '1.4.2.1.jpg')
,(34 ,  '1.4.2.2.jpg')
,(35 ,  '1.4.2.3.jpg')
,(36 ,  '1.5.1.1.jpg')
,(37 ,  '1.5.1.2.jpg')
,(38 ,  '1.5.1.3.jpg')
,(39 ,  '1.6.1.1.jpg')
,(40 ,  '1.6.1.2.jpg')
,(41 ,  '1.6.1.3.jpg')
     

)t (Treiber_SK, [Image])
GO
PRINT N'Update abgeschlossen.';


GO
