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
PRINT N'Tabelle "[link].[M1_Gehaeuse__LED]" wird erstellt...';


GO
CREATE TABLE [link].[M1_Gehaeuse__LED] (
    [Gehaeuse_SK] INT NOT NULL,
    [Leuchte_SK]  INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[M1_LED__Treiber]" wird erstellt...';


GO
CREATE TABLE [link].[M1_LED__Treiber] (
    [Leuchte_SK] INT NOT NULL,
    [Treiber_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Spot_Gehaeuse__LED]" wird erstellt...';


GO
CREATE TABLE [link].[Spot_Gehaeuse__LED] (
    [Gehaeuse_SK] INT NOT NULL,
    [Leuchte_SK]  INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Spot_LED__Treiber]" wird erstellt...';


GO
CREATE TABLE [link].[Spot_LED__Treiber] (
    [Leuchte_SK] INT NOT NULL,
    [Treiber_SK] INT NOT NULL
);


GO
PRINT N'Sicht "[fakt].[M1]" wird geändert...';


GO

ALTER VIEW [fakt].[M1] as 

SELECT 

		h1.Leuchtentyp
	,	CONCAT(h1.Typ, ' - ', h1.Montageart_2) as Typ
	,	h1.Form
	,	h1.Farbe
	,	CONCAT(h1.Montageart_3, ' - ', h1.Verstellbarkeit) as Verstellbarkeit
	,	s1.Schutzart
	,	s1.Einbaudurchmesser	
	,	s1.Schwenkwinkel
	,	s1.Anzahl_Leuchtmittel 
	,	s1.Produktbeschreibung as Produktbeschreibung_Gehaeuse
	,	s1.Artikelnummer as Artikelnummer_Gehaeuse
	,	s1.Preis as Preis_Gehaeuse
	,	s1.Image as Gehaeuse_Image
	,	s1.SEO_Url as SEO_Url_Gehaeuse
	,	h2.Lichtfarbe
	,	h2.Farbkanal
	,	h2.Lichtstrom
	,	h2.Leistung
	,	h2.Abstrahlwinkel
	,	S2.Artikelnummer as Artikelnummer_LED
	,	S2.Preis as Preis_LED
	,	s2.Image as Leuchten_Image
	,	s2.Produktbeschreibung as Produktbeschreibung_LED
	,	s2.SEO_Url as SEO_Url_LED
	,	CONCAT(h3.Beschreibung,' ', h3.Versorgung) as Treiber
	,	h3.Beschreibung
	,	h3.Versorgung
	,	h3.Ansteuerung
	,	CONCAT(UPPER(h3.Ansteuerung), ' - ', (h3.Leistung_Min), ' - ' , (h3.Leistung_Max), 'W') as Ansteuerung2
	,	h3.Ausführung
	,	s3.Image as Treiber_Image
	,	s3.Produktbeschreibung as Produktbeschreibung_Treiber
	,	h3.Leistung_Min
	,	h3.Leistung_Max
	,	s3.Artikelnummer as Artikelnummer_Treiber
	,	s3.Preis as Preis_Treiber
	,	s3.SEO_Url as SEO_Url_Treiber
	,	CASE WHEN CEILING(h3.Leistung_Min / h2.Leistung) = 0 THEN 1  ELSE CEILING(h3.Leistung_Min / h2.Leistung) END as Min_Anzahl
	,	Max_Anzahl = FLOOR(h3.Leistung_Max / h2.Leistung)



 from hub.M1_Gehaeuse h1
 INNER JOIN sat.M1_Gehaeuse_Stammdaten s1 ON h1.Gehaeuse_SK = s1.Gehaeuse_SK
 INNER JOIN Link.M1_Gehaeuse__LED l1 ON h1.Gehaeuse_SK = l1.Gehaeuse_SK
 INNER JOIN hub.LED h2 ON h2.Leuchte_SK = l1.Leuchte_SK
 INNER JOIN sat.LED_Stammdaten s2 ON s2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN link.M1_LED__Treiber l2 ON l2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN hub.Treiber h3 ON l2.Treiber_SK = h3.Treiber_SK
 INNER JOIN sat.Treiber_Stammdaten s3 ON h3.Treiber_SK = s3.Treiber_SK

WHERE 1=1
AND s1.Offline = 'online'
AND s2.Offline = 'online'
AND s3.Offline = 'online'
GO
PRINT N'Sicht "[fakt].[Spot]" wird geändert...';


GO






ALTER VIEW [fakt].[Spot] as 

select 

		CONCAT(h1.Gehaeuse_SK, '-', h2.Leuchte_SK, '-', h3.Treiber_SK) as ID
	,	h1.Leuchtentyp
	,	h1.Typ
	,	h1.Form
	,	h1.Farbe
	,	s1.Schutzart
	,	s1.Einbaudurchmesser	
	,	s1.Einbautiefe
	,	s1.Schwenkwinkel
	,	s1.Produktbeschreibung as Produktbeschreibung_Gehaeuse
	,	s1.Artikelnummer as Artikelnummer_Gehaeuse
	,	s1.Preis as Preis_Gehaeuse
	,	s1.Image as Gehaeuse_Image
	,	s1.SEO_Url as SEO_Url_Gehaeuse
	,	CONCAT(h1.Leuchtentyp, ' ', h1.Form, ' ', h1.Farbe, ' ', h1.Typ) as Bezeichnung_Gehaeuse
	,	h2.Lichtfarbe
	,	h2.Farbkanal
	,	h2.Lichtstrom
	,	h2.Leistung
	,	h2.Abstrahlwinkel
	,	s2.Artikelnummer as Artikelnummer_LED
	,	s2.Preis as Preis_LED
	,	s2.Image as Leuchten_Image
	,	s2.SEO_Url as SEO_Url_LED
	,	s2.Produktbeschreibung as Produktbeschreibung_LED
	,	CONCAT(h2.Farbkanal, ' ', h2.Lichtfarbe, ' ', h2.Leistung, ' ', h2.Abstrahlwinkel) as Bezeichnung_LED
	,	CONCAT(h3.Beschreibung,' ', h3.Versorgung) as Treiber
	,	h3.Beschreibung
	,	h3.Versorgung
	,	h3.Ansteuerung
	,	CONCAT(UPPER(h3.Ansteuerung), ' - ', (h3.Leistung_Min), ' - ' , (h3.Leistung_Max), 'W') as Ansteuerung2
	,	h3.Ausführung
	,	s3.Image as Treiber_Image
	,	s3.SEO_Url as SEO_Url_Treiber
	,	s3.Produktbeschreibung as Produktbeschreibung_Treiber
	,	h3.Leistung_Min
	,	h3.Leistung_Max
	,	s3.Artikelnummer as Artikelnummer_Treiber
	,	s3.Preis as Preis_Treiber
	,	CONCAT(h3.Beschreibung, ' ', h3.Versorgung, ' ', h3.Ansteuerung ) as Bezeichnung_Treiber
	,	CASE WHEN CEILING(h3.Leistung_Min / h2.Leistung) = 0 THEN 1  ELSE CEILING(h3.Leistung_Min / h2.Leistung) END as Min_Anzahl
	,	Max_Anzahl = CASE WHEN FLOOR(h3.Leistung_Max / h2.Leistung) <1 THEN 0 ELSE FLOOR(h3.Leistung_Max / h2.Leistung) END
	,	Lampenplatz = 1



 from hub.Spot_Gehaeuse h1
 INNER JOIN sat.Spot_Gehaeuse_Stammdaten s1 ON h1.Gehaeuse_SK = s1.Gehaeuse_SK
 INNER JOIN Link.Spot_Gehaeuse__LED l1 ON h1.Gehaeuse_SK = l1.Gehaeuse_SK
 INNER JOIN hub.LED h2 ON h2.Leuchte_SK = l1.Leuchte_SK
 INNER JOIN sat.LED_Stammdaten s2 ON s2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN link.Spot_LED__Treiber l2 ON l2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN hub.Treiber h3 ON l2.Treiber_SK = h3.Treiber_SK
 INNER JOIN sat.Treiber_Stammdaten s3 ON h3.Treiber_SK = s3.Treiber_SK

where 1=1
AND s1.Offline ='Online'
AND s2.Offline ='Online'
AND s3.Offline ='Online'
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
PRINT N'Prozedur "[dbo].[load_link_M1_LED__Treiber]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_M1_LED__Treiber] as

TRUNCATE TABLE link.M1_LED__Treiber;



WITH src as
(

SELECT 

		h.Gehaeuse_SK
	,	h.Form
	,	h.Farbe
	,	h.Leuchtentyp
	,	h.Typ
	,	h.Verstellbarkeit
	,	s.Moegliche_Konverter
	,	s.Moegliche_Leuchtmittel
	,	s.Artikelnummer

FROM hub.M1_Gehaeuse h
INNER JOIN sat.M1_Gehaeuse_Stammdaten s ON h.Gehaeuse_SK = s.Gehaeuse_SK
),

src2 as(

SELECT 
	
		h1.Leuchte_SK
	,	h1.Farbkanal
	,	h1.Lichtfarbe
	,	h1.Leistung
	,	s1.Artikelnummer
	,	s1.Moegliche_Konverter



FROM hub.LED h1 
INNER JOIN sat.LED_Stammdaten s1 ON h1.Leuchte_SK = s1.Leuchte_SK

),
src3 as
(
SELECT


s.* 
FROM hub.Treiber h
INNER JOIN sat.Treiber_Stammdaten s ON h.Treiber_SK = s.Treiber_SK

)

INSERT INTO link.M1_Leuchte__Treiber (Leuchte_SK, Treiber_SK)
SELECT distinct
	
		
		src2.Leuchte_SK
  , src3.Treiber_SK

FROM src
INNER JOIN src2 ON src.Moegliche_Leuchtmittel LIKE '%'+ src2.Artikelnummer + '%'
INNER JOIN src3 ON src.Moegliche_Konverter LIKE '%'+ src3.Artikelnummer + '%'


where 1=1
GO
PRINT N'Prozedur "[dbo].[load_link_Spot_Gehaeuse__LED]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Spot_Gehaeuse__LED] as

TRUNCATE TABLE link.Spot_Gehaeuse__LED

INSERT INTO link.Spot_Gehaeuse__LED (Gehaeuse_SK, Leuchte_SK)

SELECT 

		h1.Gehaeuse_Sk
	,	h2.Leuchte_SK

FROM hub.Spot_Gehaeuse h1
CROSS JOIN hub.LED h2
GO
PRINT N'Update abgeschlossen.';


GO
