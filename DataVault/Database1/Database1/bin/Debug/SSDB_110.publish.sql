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
PRINT N'Sicht "[fakt].[M1]" wird geändert...';


GO

ALTER VIEW [fakt].[M1] as 

select 

		h1.Leuchtentyp
	,	h1.Typ
	,	h1.Form
	,	h1.Farbe
	,	h1.Verstellbarkeit
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
	,	CONCAT(UPPER(h3.Ansteuerung), ' - ', (h3.Leistung_Min), 'W', ' ... ' , (h3.Leistung_Max), 'W') as Ansteuerung2
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

	,	Lampenplatz = 1




 from hub.M1_Gehaeuse h1
 INNER JOIN sat.M1_Gehaeuse_Stammdaten s1 ON h1.Gehaeuse_SK = s1.Gehaeuse_SK
 INNER JOIN Link.M1_Gehaeuse__Leuchte l1 ON h1.Gehaeuse_SK = l1.Gehaeuse_SK
 INNER JOIN hub.M1_Leuchte h2 ON h2.Leuchte_SK = l1.Leuchte_SK
 INNER JOIN sat.M1_Leuchte_Stammdaten s2 ON s2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN link.M1_Leuchte__Treiber l2 ON l2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN hub.M1_Treiber h3 ON l2.Treiber_SK = h3.Treiber_SK
 INNER JOIN sat.M1_Treiber_Stammdaten s3 ON h3.Treiber_SK = s3.Treiber_SK

WHERE 1=1
AND s1.Offline = 'online'
AND s2.Offline = 'online'
AND s3.Offline = 'online'
GO
PRINT N'Prozedur "[dbo].[load_hub_M1_Gehaeuse]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_M1_Gehaeuse] as

TRUNCATE TABLE hub.M1_Gehaeuse

INSERT INTO hub.M1_Gehaeuse (Leuchtentyp, Typ, Farbe, Form, Montageart, Montageart_2, Montageart_3, Verstellbarkeit)

SELECT * FROM (VALUES

  ('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Einbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Einbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Anbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Anbaumontage', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'rund', 'Anbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß / strukturschwarz', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz / strukturweiß', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiß / strukturschwarz', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz / strukturweiß', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß / strukturschwarz', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz / strukturweiß', 'sonstige', 'Anbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'quadratisch', 'Anbaumontage', 'bündig', 'mit Modulhalterungen vertieft', 'schwenkbar')

)t (Leuchtentyp, Typ, Farbe, Form, Montageart, Montageart_2, Montageart_3, Verstellbarkeit)
GO
PRINT N'Prozedur "[dbo].[load_hub_M1_Treiber]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_M1_Treiber] as

TRUNCATE TABLE hub.M1_Treiber

INSERT INTO hub.M1_Treiber (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)

SELECT * FROM (VALUES



 ('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'schaltbar', 	    '350mA',	  1	        ,5 )
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'schaltbar',  	    '350mA',	  1	        ,7.2)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung'	 , 'schaltbar',    	  '350mA',	  1	        ,7.2)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'schaltbar', 	    '350mA',	  1	        ,7.2)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'schaltbar', 	    '350mA',	  0	        ,15)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung'	 , 'schaltbar', 	    '350mA',	  0	        ,15)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'schaltbar', 	    '350mA',	  0	        ,15)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'schaltbar', 	    '350mA',	  1	        ,21)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung'   , 'schaltbar', 	    '350mA',	  1	        ,21)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'schaltbar', 	    '350mA',	  1	        ,21)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'Phasenabschnit',	'350mA',	  2.8	      ,7)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung'	 , 'Phasenabschnit',	'350mA',	  2.8	      ,7)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'Phasenabschnit',	'350mA',	  2.8	      ,7)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'Phasenabschnit',	'350mA',	  4.9	      ,7)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'Phasenabschnit',	'350mA',	  4.9	      ,7)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung'	 , 'Phasenabschnit',	'350mA',	  4.2	      ,10)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'Phasenabschnit',	'350mA',	  4.2	      ,10)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'Phasenabschnit',	'350mA',	  4.2	      ,10)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung'   , 'Phasenabschnit',	'350mA',	  0.7	      ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'Phasenabschnit',	'350mA',	  0.7	      ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play'             , 'Phasenabschnit',	'350mA',	  0.7	      ,17)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung'	 , 'Phasenabschnit',	'350mA',	  8.75	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'Phasenabschnit',	'350mA',	  8.75	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'Phasenabschnit',	'350mA',	  8.75	    ,18)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung'   , 'Phasenabschnit',	'350mA',	  10.15	    ,14)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'Phasenabschnit',	'350mA',	  10.15	    ,14)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'Phasenabschnit',	'350mA',	  10.15	    ,14)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , '1-10V',	          '350mA',	  5.25	    ,18)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung' 	 , '1-10V',	          '350mA',	  5.25	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'DALI-2',	        '350mA',	  3.5	      ,17)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung' 	 , 'DALI-2',	        '350mA',	  3.5	      ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'DALI-2',	        '350mA',	  3.5	      ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'DALI-2',	        '350mA',	  2.1	      ,9)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung' 	 , 'DALI-2',	        '350mA',	  2.1	      ,9)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'DALI-2',	        '350mA',	  2.1	      ,9)
,('MR16',	'LED-Konverter'	,'Plug & Play'	           , 'CASAMBI',         '350mA',	  3.5	      ,18)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung' 	 , 'CASAMBI',         '350mA',	  3.5	      ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'CASAMBI',         '350mA',	  3.5	      ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play'   	         , 'ZigBee',	        '350mA',	  3.5	      ,18)
,('MR16',	'LED-Konverter'	,'ohne Anschlussleitung'	 , 'ZigBee',	        '350mA',	  3.5	      ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	       , 'ZigBee',	        '350mA',	  3.5	      ,18)





)t (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)
GO
PRINT N'Update abgeschlossen.';


GO
