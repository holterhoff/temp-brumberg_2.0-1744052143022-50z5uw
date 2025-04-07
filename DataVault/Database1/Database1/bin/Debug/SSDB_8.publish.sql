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
PRINT N'Tabelle "[sat].[Biro40_Leuchten_Laengen]" wird erstellt...';


GO
CREATE TABLE [sat].[Biro40_Leuchten_Laengen] (
    [Leuchte_SK] INT           NOT NULL,
    [Min]        NVARCHAR (50) NULL,
    [Max]        NVARCHAR (50) NULL,
    [Step]       NVARCHAR (50) NULL,
    [Toleranz]   NVARCHAR (50) NULL,
    [Abzug]      NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Prozedur "[dbo].[load_hub_Biro40_Leuchte_Laengen]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Biro40_Leuchte_Laengen] as

TRUNCATE TABLE sat.Biro40_Leuchten_Laengen

INSERT INTO sat.Biro40_Leuchten_Laengen([Min], [Max], [Step], [Toleranz], [Abzug])
SELECT * FROM (VALUES

('560'	    , '2380'	, '140'	    , '2'	, '591')
,('560'	    , '2380'	, '140'	    , '2'	, '591')
,('840'	    , '2380'	, '140'	    , '2'	, '591')
,('840'	    , '2380'	, '140'	    , '2'	, '591')
,('980'	    , '2520'	, '70'	    , '2'	, '591')
,('2520'	, '5600'	, '280'	    , '2'	, '591')
,('560'	    , '2240'	, '140'	    , '2'	, '591')
,('560'	    , '2240'	, '140'	    , '2'	, '591')
,('560'	    , '2240'	, '140'	    , '2'	, '591')
,('560'	    , '2240'	, '140'	    , '2'	, '591')
,('2520'	, '2520'	, '2520'  	, '2'	, '591')
,('1050'	, '1050'	, '1050'  	, '2'	, '591')
,('1120'	, '1120'	, '1120'  	, '2'	, '591')
,('1190'	, '1190'	, '1190'  	, '2'	, '591')
,('1260'	, '1260'	, '1260'  	, '2'	, '591')
,('1330'	, '1330'	, '1330'  	, '2'	, '591')



)t ([Min], [Max], [Step], [Toleranz], [Abzug])
GO
PRINT N'Update abgeschlossen.';


GO
