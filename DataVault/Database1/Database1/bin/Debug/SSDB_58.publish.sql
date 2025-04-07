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
PRINT N'Tabelle "[hub].[Melody_Stehleuchte]" wird erstellt...';


GO
CREATE TABLE [hub].[Melody_Stehleuchte] (
    [Melody_SK]       INT           IDENTITY (1, 1) NOT NULL,
    [Hersteller]      NVARCHAR (50) NOT NULL,
    [Leuchtenfamilie] NVARCHAR (50) NOT NULL,
    [Variante]        NVARCHAR (50) NOT NULL,
    [Leuchtentyp]     NVARCHAR (50) NOT NULL,
    [Gehaeusefarbe]   NVARCHAR (50) NOT NULL,
    [Gehaeuseform]    NVARCHAR (50) NOT NULL,
    [Montageart]      NVARCHAR (50) NOT NULL,
    [Optik]           NVARCHAR (50) NOT NULL,
    [Lichtrichtung]   NVARCHAR (50) NOT NULL,
    [Lichtfarbe]      NVARCHAR (50) NOT NULL,
    [Schaltungsart]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Melody_Stehleuchte] PRIMARY KEY CLUSTERED ([Melody_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Melody_Stehleuchte_Artikel]" wird erstellt...';


GO
CREATE TABLE [sat].[Melody_Stehleuchte_Artikel] (
    [Melody_SK]     INT            NOT NULL,
    [Artikelnummer] NVARCHAR (50)  NOT NULL,
    [Preis]         DECIMAL (5, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Melody_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Melody_Stehleuchte_Stammdaten]" wird erstellt...';


GO
CREATE TABLE [sat].[Melody_Stehleuchte_Stammdaten] (
    [Melody_SK]               INT           NOT NULL,
    [Lichtstrom_Gesamt]       NVARCHAR (50) NULL,
    [Systemleistung_Watt]     NVARCHAR (50) NULL,
    [Systemeffizienz_lm_Watt] NVARCHAR (50) NULL,
    [Farbwiedergabeindex]     NVARCHAR (50) NULL,
    [Laenge]                  NVARCHAR (50) NULL,
    [Breite]                  NVARCHAR (50) NULL,
    [Hoehe]                   NVARCHAR (50) NULL,
    [Durchmesser]             NVARCHAR (50) NULL,
    [Website]                 NVARCHAR (50) NULL,
    [Produktbeschreibung]     NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Melody_SK] ASC)
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
	,	s11.Artikelnummer
	,	s11.Preis
	,	s1.Image as Gehaeuse_Image
	,	h2.Lichtfarbe
	,	h2.Farbkanal
	,	h2.Lichtstrom
	,	h2.Leistung
	,	h2.Effizienzklasse
	,	h2.Abstrahlwinkel
	,	S22.Artikelnummer as Artikelnummer_LED
	,	S22.Preis as Preis_LED
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
	,	s33.Artikelnummer as Artikelnummer_Treiber
	,	s33.Preis as Preis_Treiber
	,	CASE WHEN CEILING(h3.Leistung_Min / h2.Leistung) = 0 THEN 1  ELSE CEILING(h3.Leistung_Min / h2.Leistung) END as Min_Anzahl
	,	Max_Anzahl = FLOOR(h3.Leistung_Max / h2.Leistung)

	,	Lampenplatz = 1




 from hub.Spot_Gehaeuse h1
 INNER JOIN sat.Spot_Gehaeuse_Stammdaten s1 ON h1.Gehaeuse_SK = s1.Gehaeuse_SK
 INNER JOIN sat.Spot_Gehaeuse_Artikel s11 ON h1.Gehaeuse_SK = s11.Gehaeuse_SK
 INNER JOIN Link.Spot_Gehaeuse__Leuchte l1 ON h1.Gehaeuse_SK = l1.Gehaeuse_SK
 INNER JOIN hub.Spot_Leuchte h2 ON h2.Leuchte_SK = l1.Leuchte_SK
 INNER JOIN sat.Spot_Leuchte_Stammdaten s2 ON s2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN sat.Spot_Leuchte_Artikel s22 ON S22.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN link.Spot_Leuchte__Treiber l2 ON l2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN hub.Spot_Treiber h3 ON l2.Treiber_SK = h3.Treiber_SK
 INNER JOIN sat.Spot_Treiber_Stammdaten s3 ON h3.Treiber_SK = s3.Treiber_SK
 inner JOIN sat.Spot_Treiber_Artikel s33 ON h3.Treiber_SK = s33.Treiber_SK

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
PRINT N'Prozedur "[dbo].[load_hub_Melody_Stehleuchte]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Melody_Stehleuchte] as

TRUNCATE TABLE hub.Melody_Stehleuchte

INSERT INTO hub.Melody_Stehleuchte (Hersteller, Leuchtenfamilie, Variante, Gehaeusefarbe, Gehaeuseform, Montageart, Optik, Lichtrichtung, Lichtfarbe, Schaltungsart)
SELECT * FROM (VALUES


  ('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP')



)t (Hersteller, Leuchtenfamilie, Variante, Gehaeusefarbe, Gehaeuseform, Montageart, Optik, Lichtrichtung, Lichtfarbe, Schaltungsart)
GO
PRINT N'Update abgeschlossen.';


GO
