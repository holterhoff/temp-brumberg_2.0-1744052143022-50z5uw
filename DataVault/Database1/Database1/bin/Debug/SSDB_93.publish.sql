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
/*
Der Typ von Spalte "Leistung" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " VARCHAR (100) NOT NULL", wird aber in " DECIMAL (5, 2) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " DECIMAL (5, 2) NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [hub].[Spot_Leuchte])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Tabelle "[hub].[Spot_Leuchte]" wird geändert...';


GO
ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Leistung] DECIMAL (5, 2) NOT NULL;


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
	,	s1.Produktbeschreibung as Produktbeschreibung_Gehaeuse
	,	s1.Artikelnummer
	,	s1.Preis
	,	s1.Image as Gehaeuse_Image
	,	s1.SEO_Url
	,	h2.Lichtfarbe
	,	h2.Farbkanal
	,	h2.Lichtstrom
	,	h2.Leistung
	,	h2.Abstrahlwinkel
	,	S2.Artikelnummer as Artikelnummer_LED
	,	S2.Preis as Preis_LED
	,	s2.Image as Leuchten_Image
	,	s2.Produktbeschreibung as Produktbeschreibung_LED
	,	CONCAT(h3.Beschreibung,' ', h3.Versorgung) as Treiber
	,	h3.Beschreibung
	,	h3.Versorgung
	,	h3.Ansteuerung
	,	CONCAT(UPPER(h3.Ansteuerung), ' - ', (h3.Leistung_Min), 'W', ' ... ' , (h3.Leistung_Max), 'W') as Ansteuerung2
	,	h3.Ausführung
	,	s3.Image as Treiber_Image
	,	s3.Produktbeschreibung as Produktbeschreibung_Treiber
	,	h3.Leistung_Min
	,	h3.Leistung_Max
	,	s3.Artikelnummer as Artikelnummer_Treiber
	,	s3.Preis as Preis_Treiber
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
PRINT N'Prozedur "[dbo].[load_hub_Spot_Leuchte]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_Spot_Leuchte] as

TRUNCATE TABLE hub.Spot_Leuchte

INSERT INTO hub.Spot_Leuchte (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom )

SELECT * FROM (VALUES


  ('MR16', 'STATISCH', '2700 K',              '350',      3,      '38',            '290.00'),
	('MR16', 'STATISCH', '3000 K',              '350',      3,      '38',            '310.00'),
	('MR16', 'STATISCH', '4000 K',              '350',      3,      '38',            '340.00'),
	('MR16', 'STATISCH', '2700 K',              '350',      6,      '38',            '600.00'),
	('MR16', 'STATISCH', '2700 K',              '350',      6,      '60',            '570.00'),
	('MR16', 'STATISCH', '3000 K',              '350',      6,      '38',            '680.00'),
	('MR16', 'STATISCH', '3000 K',              '350',      6,      '60',            '660.00'),
	('MR16', 'STATISCH', '3500 K',              '350',      6,      '38',            '680.00'),
	('MR16', 'STATISCH', '3500 K',              '350',      6,      '60',            '660.00'),
	('MR16', 'STATISCH', '4000 K',              '350',      6,      '38',            '720.00'),
	('MR16', 'STATISCH', '4000 K',              '350',      6,      '60',            '700.00'),
	('MR16', 'D2W',      '3000 K - 1800 K',     '350',      6,      '38',            '460.00'),
	('MR16', 'D2W',      '3000 K - 1800 K',     '350',      6,      '60',            '430.00'),
	('MR16', 'DISC',     '3000 K',              '350',      6,      '18',            '640.00'),
	('MR16', 'DISC',     '3000 K',              '350',      6,      '24',            '690.00'),
	('MR16', 'DISC',     '3000 K',              '350',      6,      '38',            '670.00'),
	('MR16', 'DISC',     '3000 K',              '350',      6,      '60',            '620.00'),
	('MR16', 'DISC',     '4000 K',              '350',      6,      '18',            '685.00'),
	('MR16', 'DISC',     '4000 K',              '350',      6,      '24',            '740.00'),
	('MR16', 'DISC',     '4000 K',              '350',      6,      '38',            '720.00'),
	('MR16', 'DISC',     '4000 K',              '350',      6,      '60',            '660.00'),
	('MR16', 'STATISCH', '2700 K',              '350',      12,     '38',              '1.10'),
	('MR16', 'STATISCH', '3000 K',              '350',      12,     '38',              '1.20'),
	('MR16', 'STATISCH', '3500 K',              '350',      12,     '38',              '1.20'),
	('MR16', 'STATISCH', '4000 K',              '350',      12,     '38',              '1.30'),
	('MR16', 'D2W',      '3000 K - 1800 K',     '350',      12,     '38',            '930.00'),
	('MR16', 'SUNLIKE',  '3000 K',              '350',      12.5,   '38',            '920.00'),
	('MR16', 'RGB',         'RGB',               '12',      13.8,   '45',              '0.00'),
	('MR16', 'STATISCH', '2850 K',               '24',      8,      '60',            '900.00'),
	('MR16', 'TUNABLEWHITE', '2000 K - 6500 K',  '24',      8,      '60',            '640.00'),
	('MR16', 'RGB+WW', 'RGB+WW',                 '24',      8,      '60',            '400.00')




)t (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom)
GO
PRINT N'Prozedur "[dbo].[load_link_Spot_Gehaeuse__Leuchte]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_link_Spot_Gehaeuse__Leuchte]';


GO
PRINT N'Prozedur "[dbo].[load_link_Spot_Leuchte__Treiber]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_link_Spot_Leuchte__Treiber]';


GO
PRINT N'Update abgeschlossen.';


GO
