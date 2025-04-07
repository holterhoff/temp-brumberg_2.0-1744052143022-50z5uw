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
PRINT N'Tabelle "[link].[Spot_Leuchte__Treiber]" wird erstellt...';


GO
CREATE TABLE [link].[Spot_Leuchte__Treiber] (
    [Leuchte_SK] INT NOT NULL,
    [Treiber_SK] INT NOT NULL
);


GO
PRINT N'Prozedur "[dbo].[load_link_Spot_Leuchte__Treiber]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Spot_Leuchte__Treiber] as

TRUNCATE TABLE link.Spot_Leuchte__Treiber

INSERT INTO link.Spot_Leuchte__Treiber (Leuchte_SK, Treiber_SK)

select distinct

	h1.Leuchte_SK
,	h2.Treiber_SK


 from hub.Spot_Leuchte h1
 JOIN hub.Spot_Treiber h2 ON h1.Leistung BETWEEN h2.Leistung_Min AND h2.Leistung_Max
GO
PRINT N'Update abgeschlossen.';


GO
