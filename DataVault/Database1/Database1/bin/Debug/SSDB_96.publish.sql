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
Der Typ von Spalte "Abstrahlwinkel" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " VARCHAR (50) NOT NULL", wird aber in " DECIMAL (5, 2) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " DECIMAL (5, 2) NOT NULL" kompatibel sind.

Der Typ von Spalte "Lichtstrom" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " VARCHAR (50) NOT NULL", wird aber in " INT NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " INT NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [hub].[Spot_Leuchte])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Tabelle "[hub].[Spot_Leuchte]" wird geändert...';


GO
ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Abstrahlwinkel] DECIMAL (5, 2) NOT NULL;

ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Lichtstrom] INT NOT NULL;


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


  ('MR16', 'STATISCH', '2700 K', '350mA', '3', '38', '290'),
	('MR16', 'STATISCH', '3000 K', '350mA', '3', '38', '310'),
	('MR16', 'STATISCH', '4000 K', '350mA', '3', '38', '340'),
	('MR16', 'STATISCH', '2700 K', '350mA', '6', '38', '600'),
	('MR16', 'STATISCH', '2700 K', '350mA', '6', '60', '570'),
	('MR16', 'STATISCH', '3000 K', '350mA', '6', '38', '680'),
	('MR16', 'STATISCH', '3000 K', '350mA', '6', '60', '660'),
	('MR16', 'STATISCH', '3500 K', '350mA', '6', '38', '680'),
	('MR16', 'STATISCH', '3500 K', '350mA', '6', '60', '660'),
	('MR16', 'STATISCH', '4000 K', '350mA', '6', '38', '720'),
	('MR16', 'STATISCH', '4000 K', '350mA', '6', '60', '700'),
	('MR16', 'D2W', '3000 K - 1800 K', '350mA', '6', '38', '460'),
	('MR16', 'D2W', '3000 K - 1800 K', '350mA', '6', '60', '430'),
	('MR16', 'DISC', '3000 K', '350mA', '6', '18', '640'),
	('MR16', 'DISC', '3000 K', '350mA', '6', '24', '690'),
	('MR16', 'DISC', '3000 K', '350mA', '6', '38', '670'),
	('MR16', 'DISC', '3000 K', '350mA', '6', '60', '620'),
	('MR16', 'DISC', '4000 K', '350mA', '6', '18', '685'),
	('MR16', 'DISC', '4000 K', '350mA', '6', '24', '740'),
	('MR16', 'DISC', '4000 K', '350mA', '6', '38', '720'),
	('MR16', 'DISC', '4000 K', '350mA', '6', '60', '660'),
	('MR16', 'STATISCH', '2700 K', '350mA', '12', '38', '1.12'),
	('MR16', 'STATISCH', '3000 K', '350mA', '12', '38', '1.21'),
	('MR16', 'STATISCH', '3500 K', '350mA', '12', '38', '1.24'),
	('MR16', 'STATISCH', '4000 K', '350mA', '12', '38', '1.25'),
	('MR16', 'D2W', '3000 K - 1800 K', '350mA', '12', '38', '930'),
	('MR16', 'SUNLIKE', '3000 K', '350mA', '12.5', '38', '920'),
	('MR16', 'RGB', 'RGB', '12V', '13.8', '45', ''),
	('MR16', 'STATISCH', '2850 K', '24V', '8', '60', '900'),
	('MR16', 'TUNABLEWHITE', '2000 K - 6500 K', '24V', '8', '60', '640'),
	('MR16', 'RGB+WW', 'RGB+WW', '24V', '8', '60', '400')
	
	
	
	
	
	
	
	
	
	
	
	
	
	




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
