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
PRINT N'Tabelle "[link].[Biro40_Figur__Montage]" wird erstellt...';


GO
CREATE TABLE [link].[Biro40_Figur__Montage] (
    [Figur_SK]   INT NOT NULL,
    [Montage_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Biro40_Leuchte__Optik]" wird erstellt...';


GO
CREATE TABLE [link].[Biro40_Leuchte__Optik] (
    [Leuchte_SK] INT NOT NULL,
    [Optik_SK]   INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Biro40_Montage__Leuchte]" wird erstellt...';


GO
CREATE TABLE [link].[Biro40_Montage__Leuchte] (
    [Montage_SK] INT NOT NULL,
    [Leuchte_SK] INT NOT NULL
);


GO
PRINT N'Prozedur "[dbo].[load_link_Biro40_Figur__Montage]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Biro40_Figur__Montage] as

TRUNCATE TABLE link.Biro40_Figur__Montage

INSERT INTO link.Biro40_Figur__Montage(Figur_SK, Montage_SK)

SELECT

	  h1.Figur_SK
	, h2.Montage_SK

FROM hub.Biro40_Figur h1
CROSS JOIN hub.Biro40_Montage h2
GO
PRINT N'Prozedur "[dbo].[load_link_Biro40_Leuchte__Optik]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Biro40_Leuchte__Optik] as

TRUNCATE TABLE link.Biro40_Leuchte__Optik

INSERT INTO link.Biro40_Leuchte__Optik(Leuchte_SK, Optik_SK)

SELECT 
		h1.Leuchte_SK
	,	h2.Optik_SK
FROM hub.Biro40_Leuchte h1
INNER JOIN hub.Biro40_Optik h2 ON h1.Lichtrichtung = h2.Lichtrichtung AND h1.Leuchtentyp = h2.Leuchtentyp
GO
PRINT N'Prozedur "[dbo].[load_link_Biro40_Montage__Leuchte]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Biro40_Montage__Leuchte] as

TRUNCATE TABLE link.Biro40_Montage__Leuchte

INSERT INTO link.Biro40_Montage__Leuchte(Montage_SK, Leuchte_SK)

SELECT 
		h1.Montage_SK
	,	h2.Leuchte_SK
FROM hub.Biro40_Montage h1
INNER JOIN hub.Biro40_Leuchte h2 ON h1.Lichtrichtung = h2.Lichtrichtung AND h1.Leuchtentyp = h2.Leuchtentyp
GO
PRINT N'Update abgeschlossen.';


GO
