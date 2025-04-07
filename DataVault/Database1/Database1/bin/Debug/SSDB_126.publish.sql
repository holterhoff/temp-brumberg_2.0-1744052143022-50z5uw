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
/*
Die Spalte "[link].[M1_LED__Treiber].[Gehaeuse_SK]" in der Tabelle "[link].[M1_LED__Treiber]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [link].[M1_LED__Treiber])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Das erneute Erstellen der Tabelle "[link].[M1_LED__Treiber]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [link].[tmp_ms_xx_M1_LED__Treiber] (
    [Gehaeuse_SK] INT NOT NULL,
    [Leuchte_SK]  INT NOT NULL,
    [Treiber_SK]  INT NOT NULL
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [link].[M1_LED__Treiber])
    BEGIN
        INSERT INTO [link].[tmp_ms_xx_M1_LED__Treiber] ([Leuchte_SK], [Treiber_SK])
        SELECT [Leuchte_SK],
               [Treiber_SK]
        FROM   [link].[M1_LED__Treiber];
    END

DROP TABLE [link].[M1_LED__Treiber];

EXECUTE sp_rename N'[link].[tmp_ms_xx_M1_LED__Treiber]', N'M1_LED__Treiber';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Sicht "[fakt].[M1]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[fakt].[M1]';


GO
PRINT N'Prozedur "[dbo].[load_link_M1_LED__Treiber]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_link_M1_LED__Treiber] as
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
		h.Ansteuerung
	,	h.Ausführung
	,	h.Leistung_Min
	,	h.Leistung_Max
	,	s.* 

FROM hub.Treiber h
INNER JOIN sat.Treiber_Stammdaten s ON h.Treiber_SK = s.Treiber_SK

)

INSERT INTO link.M1_LED__Treiber (Gehaeuse_SK, Leuchte_SK, Treiber_SK)
SELECT DISTINCT



		src.Gehaeuse_SK
	,	src2.Leuchte_SK
	,	src3.Treiber_SK


FROM src
INNER JOIN src2 ON src.Moegliche_Leuchtmittel LIKE '%'+ src2.Artikelnummer + '%' 
INNER JOIN src3 ON src.Moegliche_Konverter LIKE '%'+ src3.Artikelnummer + '%'



WHERE 1=1
AND src.Moegliche_Konverter LIKE '%' + src3.Artikelnummer + '%'
GO
PRINT N'Update abgeschlossen.';


GO
