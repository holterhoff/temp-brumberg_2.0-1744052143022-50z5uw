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
Der Typ von Spalte "Abstrahlwinkel" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " DECIMAL (5, 2) NOT NULL", wird aber in " INT NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " INT NOT NULL" kompatibel sind.

Der Typ von Spalte "Lichtstrom" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " INT NOT NULL", wird aber in " DECIMAL (5, 2) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " DECIMAL (5, 2) NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [hub].[Spot_Leuchte])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Tabelle "[hub].[Spot_Leuchte]" wird geändert...';


GO
ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Abstrahlwinkel] INT NOT NULL;

ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Lichtstrom] DECIMAL (5, 2) NOT NULL;


GO
PRINT N'Sicht "[fakt].[Spot]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[fakt].[Spot]';


GO
PRINT N'Prozedur "[dbo].[load_hub_Spot_Leuchte]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_hub_Spot_Leuchte]';


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
