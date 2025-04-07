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
Der Typ von Spalte "Artikelnummer" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " DECIMAL (18, 2) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " DECIMAL (18, 2) NOT NULL" kompatibel sind.

Der Typ von Spalte "Ausführung" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (50) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (50) NOT NULL" kompatibel sind.

Der Typ von Spalte "Image" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (50) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (50) NOT NULL" kompatibel sind.

Der Typ von Spalte "Konfigurator" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (50) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (50) NOT NULL" kompatibel sind.

Der Typ von Spalte "Leuchtmittel" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NVARCHAR (MAX) NOT NULL", wird aber in " VARCHAR (MAX) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (MAX) NOT NULL" kompatibel sind.

Der Typ von Spalte "Nettogewicht" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (50) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (50) NOT NULL" kompatibel sind.

Der Typ von Spalte "Offline" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NCHAR (10) NOT NULL", wird aber in " VARCHAR (10) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (10) NOT NULL" kompatibel sind.

Der Typ von Spalte "Produktbeschreibung" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NVARCHAR (MAX) NOT NULL", wird aber in " VARCHAR (MAX) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (MAX) NOT NULL" kompatibel sind.

Der Typ von Spalte "Schutzart" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (50) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (50) NOT NULL" kompatibel sind.

Der Typ von Spalte "SEO_Url" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NVARCHAR (MAX) NOT NULL", wird aber in " VARCHAR (MAX) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (MAX) NOT NULL" kompatibel sind.

Der Typ von Spalte "Serienname" in Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (50) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (50) NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [sat].[Spot_Gehaeuse_Stammdaten])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Das erneute Erstellen der Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [sat].[tmp_ms_xx_Spot_Gehaeuse_Stammdaten] (
    [Gehaeuse_SK]         INT             NOT NULL,
    [Schutzart]           VARCHAR (50)    NOT NULL,
    [Einbaudurchmesser]   INT             NOT NULL,
    [Einbautiefe]         INT             NOT NULL,
    [Schwenkwinkel]       INT             NOT NULL,
    [Leistung]            INT             NOT NULL,
    [Ausführung]          VARCHAR (50)    NOT NULL,
    [Image]               VARCHAR (50)    NOT NULL,
    [Produktbeschreibung] VARCHAR (MAX)   NOT NULL,
    [Artikelnummer]       DECIMAL (18, 2) NOT NULL,
    [Preis]               DECIMAL (18, 2) NOT NULL,
    [Anzahl_Leuchtmittel] VARCHAR (10)    NOT NULL,
    [Leuchtmittel]        VARCHAR (MAX)   NOT NULL,
    [Nettogewicht]        VARCHAR (50)    NOT NULL,
    [Max_Deckenstaerke]   INT             NOT NULL,
    [SEO_Url]             VARCHAR (MAX)   NOT NULL,
    [Serienname]          VARCHAR (50)    NOT NULL,
    [Maße]                VARCHAR (50)    NOT NULL,
    [Offline]             VARCHAR (10)    NOT NULL,
    [Konfigurator]        VARCHAR (50)    NOT NULL,
    PRIMARY KEY CLUSTERED ([Gehaeuse_SK] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [sat].[Spot_Gehaeuse_Stammdaten])
    BEGIN
        INSERT INTO [sat].[tmp_ms_xx_Spot_Gehaeuse_Stammdaten] ([Gehaeuse_SK], [Schutzart], [Einbaudurchmesser], [Einbautiefe], [Schwenkwinkel], [Leistung], [Ausführung], [Image], [Produktbeschreibung], [Artikelnummer], [Preis], [Anzahl_Leuchtmittel], [Leuchtmittel], [Nettogewicht], [Max_Deckenstaerke], [SEO_Url], [Serienname], [Maße], [Offline], [Konfigurator])
        SELECT   [Gehaeuse_SK],
                 [Schutzart],
                 [Einbaudurchmesser],
                 [Einbautiefe],
                 [Schwenkwinkel],
                 [Leistung],
                 [Ausführung],
                 [Image],
                 [Produktbeschreibung],
                 [Artikelnummer],
                 [Preis],
                 [Anzahl_Leuchtmittel],
                 [Leuchtmittel],
                 [Nettogewicht],
                 [Max_Deckenstaerke],
                 [SEO_Url],
                 [Serienname],
                 [Maße],
                 [Offline],
                 [Konfigurator]
        FROM     [sat].[Spot_Gehaeuse_Stammdaten]
        ORDER BY [Gehaeuse_SK] ASC;
    END

DROP TABLE [sat].[Spot_Gehaeuse_Stammdaten];

EXECUTE sp_rename N'[sat].[tmp_ms_xx_Spot_Gehaeuse_Stammdaten]', N'Spot_Gehaeuse_Stammdaten';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Sicht "[fakt].[Spot]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[fakt].[Spot]';


GO
PRINT N'Prozedur "[dbo].[load_sat_Spot_Gehaeuse_Stammdaten]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_sat_Spot_Gehaeuse_Stammdaten]';


GO
PRINT N'Update abgeschlossen.';


GO
