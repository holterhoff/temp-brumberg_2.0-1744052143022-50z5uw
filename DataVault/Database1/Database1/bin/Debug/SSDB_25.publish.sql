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
Der Typ von Spalte "Leistung" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " DECIMAL (18, 5) NOT NULL", wird aber in " DECIMAL (5, 2) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " DECIMAL (5, 2) NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [hub].[Spot_Leuchte])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Das erneute Erstellen der Tabelle "[hub].[Spot_Leuchte]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [hub].[tmp_ms_xx_Spot_Leuchte] (
    [Leuchte_SK]      INT            IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]     NVARCHAR (50)  NOT NULL,
    [Farbkanal]       NVARCHAR (50)  NOT NULL,
    [Lichtfarbe]      NVARCHAR (50)  NOT NULL,
    [Leistung]        DECIMAL (5, 2) NOT NULL,
    [Abstrahlwinkel]  INT            NOT NULL,
    [Lichtstrom]      INT            NOT NULL,
    [Effizienzklasse] NVARCHAR (50)  NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_hub_Spot_Leuchte1] PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [hub].[Spot_Leuchte])
    BEGIN
        SET IDENTITY_INSERT [hub].[tmp_ms_xx_Spot_Leuchte] ON;
        INSERT INTO [hub].[tmp_ms_xx_Spot_Leuchte] ([Leuchte_SK], [Leuchtentyp], [Farbkanal], [Lichtfarbe], [Leistung], [Abstrahlwinkel], [Lichtstrom], [Effizienzklasse])
        SELECT   [Leuchte_SK],
                 [Leuchtentyp],
                 [Farbkanal],
                 [Lichtfarbe],
                 CAST ([Leistung] AS DECIMAL (5, 2)),
                 [Abstrahlwinkel],
                 [Lichtstrom],
                 [Effizienzklasse]
        FROM     [hub].[Spot_Leuchte]
        ORDER BY [Leuchte_SK] ASC;
        SET IDENTITY_INSERT [hub].[tmp_ms_xx_Spot_Leuchte] OFF;
    END

DROP TABLE [hub].[Spot_Leuchte];

EXECUTE sp_rename N'[hub].[tmp_ms_xx_Spot_Leuchte]', N'Spot_Leuchte';

EXECUTE sp_rename N'[hub].[tmp_ms_xx_constraint_PK_hub_Spot_Leuchte1]', N'PK_hub_Spot_Leuchte', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Prozedur "[dbo].[load_hub_Spot_Leuchte]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_hub_Spot_Leuchte]';


GO
PRINT N'Update abgeschlossen.';


GO
