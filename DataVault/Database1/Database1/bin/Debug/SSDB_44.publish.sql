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
PRINT N'Prozedur "[dbo].[load_hub_M1_Gehaeuse]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_M1_Gehaeuse] as

TRUNCATE TABLE hub.M1_Gehaeuse

INSERT INTO hub.M1_Gehaeuse (Leuchtentyp, Typ, Farbe, Form, Montageart, Montageart_2, Montageart_3, Verstellbarkeit)

SELECT * FROM (VALUES

	('M1', 'Einbaugehäuse', 'strukturweiss', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'sttrukturschwarz', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Rund', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukurschwarz', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Rund', 'Einbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiss', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiss', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiss', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Rund', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiss', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiss', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiss', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Rund', 'Anbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Oval', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Quadratisch', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Quadratisch', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiss', 'Quadratisch', 'Einbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiss / innen strukturschwarz', 'Quadratisch', 'Einbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Quadratisch', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Quadratisch', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Einbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiss', 'Quadratisch', 'Einbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Einbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiss', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung vertieft', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Anbau', 'vertieft', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturweiß', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Anbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Anbaugehäuse', 'strukturschwarz', 'Rechteckig', 'Anbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Rechteckig', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturweiß', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturweiß / innen strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung bündig', 'starr'),
	('M1', 'Einbaugehäuse', 'außen strukturschwarz / innen strukturweiß', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar'),
	('M1', 'Einbaugehäuse', 'strukturschwarz', 'Quadratisch', 'Einbau', 'bündig', 'mit Modulhalterung vertieft', 'schwenkbar')



)t (Leuchtentyp, Typ, Farbe, Form, Montageart, Montageart_2, Montageart_3, Verstellbarkeit)
GO
PRINT N'Update abgeschlossen.';


GO
