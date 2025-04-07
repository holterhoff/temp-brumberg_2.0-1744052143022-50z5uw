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
PRINT N'Tabelle "[hub].[Spot_Leuchte]" wird geändert...';


GO
ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Abstrahlwinkel] VARCHAR (50) NOT NULL;

ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Lichtstrom] VARCHAR (50) NOT NULL;


GO
PRINT N'Sicht "[fakt].[Spot]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[fakt].[Spot]';


GO
PRINT N'Prozedur "[dbo].[load_hub_Spot_Leuchte]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_Spot_Leuchte] as

TRUNCATE TABLE hub.Spot_Leuchte

INSERT INTO hub.Spot_Leuchte (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom )

SELECT * FROM (VALUES


  ('MR16', 'STATISCH', '2700 K',          '350', '3', '38',            '290.00'),
	('MR16', 'STATISCH', '3000 K',          '350', '3', '38',            '310.00'),
	('MR16', 'STATISCH', '4000 K',          '350', '3', '38',            '340.00'),
	('MR16', 'STATISCH', '2700 K',          '350', '6', '38',            '600.00'),
	('MR16', 'STATISCH', '2700 K',          '350', '6', '60',            '570.00'),
	('MR16', 'STATISCH', '3000 K',          '350', '6', '38',            '680.00'),
	('MR16', 'STATISCH', '3000 K',          '350', '6', '60',            '660.00'),
	('MR16', 'STATISCH', '3500 K',          '350', '6', '38',            '680.00'),
	('MR16', 'STATISCH', '3500 K',          '350', '6', '60',            '660.00'),
	('MR16', 'STATISCH', '4000 K',          '350', '6', '38',            '720.00'),
	('MR16', 'STATISCH', '4000 K',          '350', '6', '60',            '700.00'),
	('MR16', 'D2W',      '3000 K - 1800 K', '350', '6', '38',            '460.00'),
	('MR16', 'D2W',      '3000 K - 1800 K', '350', '6', '60',            '430.00'),
	('MR16', 'DISC',     '3000 K',          '350', '6', '18',            '640.00'),
	('MR16', 'DISC',     '3000 K',          '350', '6', '24',            '690.00'),
	('MR16', 'DISC',     '3000 K',          '350', '6', '38',            '670.00'),
	('MR16', 'DISC',     '3000 K',          '350', '6', '60',            '620.00'),
	('MR16', 'DISC',     '4000 K',          '350', '6', '18',            '685.00'),
	('MR16', 'DISC',     '4000 K',          '350', '6', '24',            '740.00'),
	('MR16', 'DISC',     '4000 K',          '350', '6', '38',            '720.00'),
	('MR16', 'DISC',     '4000 K',          '350', '6', '60',            '660.00'),
	('MR16', 'STATISCH', '2700 K',          '350', '12', '38', '1.10'),
	('MR16', 'STATISCH', '3000 K',          '350', '12', '38', '1.20'),
	('MR16', 'STATISCH', '3500 K',          '350', '12', '38', '1.20'),
	('MR16', 'STATISCH', '4000 K',          '350', '12', '38', '1.30'),
	('MR16', 'D2W',      '3000 K - 1800 K', '350', '12', '38', '930.00'),
	('MR16', 'SUNLIKE',  '3000 K',          '350', '12,5', '38', '920.00'),
	('MR16', 'RGB',         'RGB',           '12', '13,8', '45', '0.00'),
	('MR16', 'STATISCH', '2850 K',           '24', '8', '60', '900.00'),
	('MR16', 'TUNABLEWHITE', '2000 K - 6500 K', '24', '8', '60', '640.00'),
	('MR16', 'RGB+WW', 'RGB+WW', '24', '8', '60', '400.00')




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
