﻿/*
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
PRINT N'Tabelle "[sat].[Spot_Leuchte_Artikel]" wird erstellt...';


GO
CREATE TABLE [sat].[Spot_Leuchte_Artikel] (
    [Leuchte_SK]    INT            NOT NULL,
    [Artikelnummer] NVARCHAR (50)  NOT NULL,
    [Preis]         DECIMAL (5, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


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
	,	s1.Produktbeschreibung
	,	s1.Image as Gehaeuse_Image
	,	h2.Lichtfarbe
	,	h2.Farbkanal
	,	h2.Lichtstrom
	,	h2.Leistung
	,	h2.Effizienzklasse
	,	s2.Image as Leuchten_Image
	,	CONCAT(h3.Beschreibung,' ', h3.Versorgung) as Treiber
	,	h3.Beschreibung
	,	h3.Versorgung
	,	h3.Ansteuerung
	,	CONCAT(UPPER(h3.Ansteuerung), ' - ', (h3.Leistung_Min), 'W', ' ... ' , (h3.Leistung_Max), 'W') as Ansteuerung2
	,	h3.Ausführung
	,	s3.Image as Treiber_Image
	,	h3.Leistung_Min
	,	h3.Leistung_Max


	,	CASE WHEN CEILING(h3.Leistung_Min / h2.Leistung) = 0 THEN 1  ELSE CEILING(h3.Leistung_Min / h2.Leistung) END as Min_Anzahl
	,	Max_Anzahl = FLOOR(h3.Leistung_Max / h2.Leistung)

	,	Lampenplatz = 1




 from hub.Spot_Gehaeuse h1
 INNER JOIN sat.Spot_Gehaeuse_Stammdaten s1 ON h1.Gehaeuse_SK = s1.Gehaeuse_SK
 INNER JOIN Link.Spot_Gehaeuse__Leuchte l1 ON h1.Gehaeuse_SK = l1.Gehaeuse_SK
 INNER JOIN hub.Spot_Leuchte h2 ON h2.Leuchte_SK = l1.Leuchte_SK
 INNER JOIN sat.Spot_Leuchte_Stammdaten s2 ON s2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN link.Spot_Leuchte__Treiber l2 ON l2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN hub.Spot_Treiber h3 ON l2.Treiber_SK = h3.Treiber_SK
 INNER JOIN sat.Spot_Treiber_Stammdaten s3 ON h3.Treiber_SK = s3.Treiber_SK


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
PRINT N'Prozedur "[dbo].[load_sat_Spot_Leuchte_Artikel]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Spot_Leuchte_Artikel] as

TRUNCATE TABLE sat.Spot_Leuchte_Artikel

INSERT INTO sat.Spot_Leuchte_Artikel (Leuchte_SK, Artikelnummer, Preis)
SELECT * FROM (VALUES


 (1	    , '12925003'	    , 44.5)
,(2	    , '12923383'	    , 63.5)
,(3	    , '12923603'	    , 63.5)
,(4	    , '12953003'	    , 99.6)
,(5	    , '12926003'	    , 44.5)
,(6	    , '12924383'	    , 63.5)
,(7	    , '12924603'	    , 63.5)
,(8	    , '12954003'	    , 99.6)
,(9	    , '12924384'	    , 63.5)
,(10	  , '12924604'	    , 63.5)
,(11	  , '12954004'	    , 99.6)
,(12	  , '12925004'	    , 44.5)
,(13	  , '12923384'	    , 63.5)
,(14	  , '12923604'	    , 63.5)
,(15	  , '12953004'	    , 99.6)
,(16	  , '12963383'	    , 76.9)
,(17	  , '12963603'	    , 76.9)
,(18	  , '12965003'	    , 116.5)
,(19	  , '12983003'	    , 116.5)
,(20	  , '12920183'	    , 39.5)
,(21	  , '12920243'	    , 39.5)
,(22	  , '12920003'	    , 39.5)
,(23	  , '12920603'	    , 39.5)
,(24	  , '12920184'	    , 39.5)
,(25	  , '12920244'	    , 39.5)
,(26	  , '12920004'	    , 39.5)
,(27	  , '12920604'	    , 39.5)
,(28	  , '18101001'	    , 164.9)

     

)t (Leuchte_SK, Artikelnummer, Preis)
GO
PRINT N'Update abgeschlossen.';


GO
