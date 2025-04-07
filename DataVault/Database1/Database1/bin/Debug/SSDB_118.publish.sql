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
PRINT N'Tabelle "[sat].[LED_Stammdaten]" wird geändert...';


GO
ALTER TABLE [sat].[LED_Stammdaten] ALTER COLUMN [Datenblatt] VARCHAR (MAX) NULL;


GO
PRINT N'Tabelle "[sat].[Treiber_Stammdaten]" wird geändert...';


GO
ALTER TABLE [sat].[Treiber_Stammdaten] ALTER COLUMN [Datenblatt] VARCHAR (MAX) NULL;


GO
PRINT N'Sicht "[fakt].[M1]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[fakt].[M1]';


GO
PRINT N'Sicht "[fakt].[Spot]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[fakt].[Spot]';


GO
PRINT N'Prozedur "[dbo].[load_sat_LED_Stammdaten]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_sat_LED_Stammdaten]';


GO
PRINT N'Prozedur "[dbo].[load_sat_Treiber_Stammdaten]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_sat_Treiber_Stammdaten]';


GO
PRINT N'Update abgeschlossen.';


GO
