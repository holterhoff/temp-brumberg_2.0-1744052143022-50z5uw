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
PRINT N'Prozedur "[dbo].[load_link_M1_Gehaeuse__Leuchte]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_link_M1_Gehaeuse__Leuchte] as

TRUNCATE TABLE link.M1_Gehaeuse__Leuchte;

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



FROM hub.M1_Leuchte h1 
INNER JOIN sat.M1_Leuchte_Stammdaten s1 ON h1.Leuchte_SK = s1.Leuchte_SK

),
src3 as
(
SELECT s.* 
FROM hub.M1_Treiber h
INNER JOIN sat.M1_Treiber_Stammdaten s ON h.Treiber_SK = s.Treiber_SK

)

INSERT INTO link.M1_Gehaeuse__Leuchte (Gehaeuse_SK, Leuchte_SK)
SELECT distinct
	
		src.Gehaeuse_SK
	,	src2.Leuchte_SK

FROM src
INNER JOIN src2 ON src.Moegliche_Leuchtmittel LIKE '%'+ src2.Artikelnummer + '%'
INNER JOIN src3 ON src2.Moegliche_Konverter LIKE '%'+ src3.Artikelnummer + '%'


where 1=1
GO
PRINT N'Update abgeschlossen.';


GO
