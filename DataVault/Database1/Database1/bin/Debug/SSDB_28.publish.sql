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
PRINT N'Tabelle "[hub].[Spot_Gehaeuse]" wird erstellt...';


GO
CREATE TABLE [hub].[Spot_Gehaeuse] (
    [Gehaeuse_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp] NVARCHAR (50) NOT NULL,
    [Typ]         NVARCHAR (50) NOT NULL,
    [Farbe]       NVARCHAR (50) NOT NULL,
    [Form]        NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Spot_Gehaeusee] PRIMARY KEY CLUSTERED ([Gehaeuse_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Spot_Gehaeuse_Stammdaten]" wird erstellt...';


GO
CREATE TABLE [sat].[Spot_Gehaeuse_Stammdaten] (
    [Gehaeuse_SK]         INT           NOT NULL,
    [Schutzart]           NVARCHAR (50) NOT NULL,
    [Einbaudurchmesser]   INT           NOT NULL,
    [Einbautiefe]         INT           NOT NULL,
    [Schwenkwinkel]       INT           NOT NULL,
    [Leistung]            INT           NOT NULL,
    [Ausführung]          NVARCHAR (50) NOT NULL,
    [Image]               NVARCHAR (50) NOT NULL,
    [Produktbeschreibung] TEXT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Gehaeuse_SK] ASC)
);


GO
PRINT N'Prozedur "[dbo].[load_hub_Spot_Gehaeuse]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Spot_Gehaeuse] as

TRUNCATE TABLE hub.Spot_Gehaeuse

INSERT INTO hub.Spot_Gehaeuse (Leuchtentyp, Farbe, Form)

SELECT * FROM (VALUES

 ('MR16'	,'1963'			, 'chrom'	                    ,'Rund')
,('MR16'	,'1963'			, 'chrom matt'	                ,'Rund')
,('MR16'	,'1963'			, 'gold'	                    ,'Rund')
,('MR16'	,'1963'			, 'schwarz'	                    ,'Rund')
,('MR16'	,'1963'			, 'strukturweiss'               ,'Rund')
,('MR16'	,'1963'			, 'weiss'	                    ,'Rund')
,('MR16'	,'1963'			, 'nickel matt'	                ,'Rund')
,('MR16'	,'1964'			, 'chrom'	                    ,'Quadratisch')
,('MR16'	,'1964'			, 'chrom matt'	                ,'Quadratisch')
,('MR16'	,'1964'			, 'gold'	                    ,'Quadratisch')
,('MR16'	,'1964'			, 'schwarz'	                    ,'Quadratisch')
,('MR16'	,'1964'			, 'strukturweiss'               ,'Quadratisch')
,('MR16'	,'1964'			, 'weiss'	                    ,'Quadratisch')
,('MR16'	,'1964'			, 'nickel matt'	                ,'Quadratisch')
,('MR16'	,'2034'			, 'chrom'	                    ,'Rund')
,('MR16'	,'2034'			, 'chrom matt'	                ,'Rund')
,('MR16'	,'2034'			, 'gold'                        ,'Rund')
,('MR16'	,'2034'			, 'weiss'                       ,'Rund')
,('MR16'	,'2034'			, 'schwarz'                     ,'Rund')
,('MR16'	,'0282'			, 'chrom'                       ,'Rund')
,('MR16'	,'37005'		, 'weiss'                       ,'Rund')
,('MR16'	,'37005'		, 'edelstahl'                   ,'Rund')
,('MR16'	,'2169'			, 'chrom'                       ,'Rund')
,('MR16'	,'2169'			, 'chrom matt'	                ,'Rund')
,('MR16'	,'2169'			, 'weiss'	                    ,'Rund')
,('MR16'	,'2295'			, 'chrom'	                    ,'Rund')
,('MR16'	,'2295'			, 'weiss'	                    ,'Rund')
,('MR16'	,'2295'			, 'nickel matt'	                ,'Rund')
,('MR16'	,'2296'			, 'chrom'	                    ,'Quadratisch')
,('MR16'	,'2296'			, 'weiss'	                    ,'Quadratisch')
,('MR16'	,'2296'			, 'nickel matt'	                ,'Quadratisch')
,('MR16'	,'2062'			, 'chrom'	                    ,'Rund')
,('MR16'	,'2062'			, 'weiss'	                    ,'Rund')
,('MR16'	,'2062'			, 'nickel matt'	                ,'Rund')
,('MR16'	,'2339'			, 'edelstahl'	                ,'Rund')
,('MR16'	,'1180'			, 'edelstahl'	                ,'Rund')
,('MR16'	,'1181'			, 'edelstahl'	                ,'Quadratisch')
,('MR16'	,'2191'			, 'weiss'	                    ,'Rund')
,('MR16'	,'2191'			, 'edelstahl'	                ,'Rund')
,('MR16'	,'2191'			, 'edelstahl klar gepulvert'    ,'Rund')
,('MR16'	,'0066'			, 'schwarz/alu'	                ,'Rund')
,('MR16'	,'0064'			, 'schwarz/alu'	                ,'Rund')
,('MR16'	,'0069'			, 'alu matt'                    ,'Rund')
,('MR16'	,'0070'			, 'alu matt'	                ,'Quadratisch')
,('MR16'	,'512811'		, 'alu matt'	                ,'Quadratisch')
,('MR16'	,'0063_tief'	, 'weiss'	                    ,'Rund')
,('MR16'	,'0063_tief'	, 'alu matt'                    ,'Rund')
,('MR16'	,'0063_tief'	, 'schwarz'	                    ,'Rund')
,('MR16'	,'0283'			, 'chrom'	                    ,'Quadratisch')
,('MR16'	,'20353'		, 'weiss'	                    ,'Rund')
,('MR16'	,'20353'		, 'nickel matt'                 ,'Rund')
,('MR16'	,'20353'		, 'silber'	                    ,'Rund')
,('MR16'	,'20355'		, 'weiss'	                    ,'Quadratisch')
,('MR16'	,'20355'		, 'nickel matt'	                ,'Quadratisch')
,('MR16'	,'20355'		, 'silber'	                    ,'Quadratisch')
,('MR16'	,'2110'			, 'chrom'	                    ,'Rund')
,('MR16'	,'2110'			, 'weiss'	                    ,'Rund')
,('MR16'	,'2110'			, 'nickel matt'	                ,'Rund')
,('MR16'	,'2111'			, 'chrom'	                    ,'Quadratisch')
,('MR16'	,'2111'			, 'weiss'	                    ,'Quadratisch')
,('MR16'	,'2111'			, 'nickel matt'	                ,'Quadratisch')
,('MR16'	,'20001'		, 'weiss'	                    ,'Quadratisch')
,('MR16'	,'20001'		, 'alu matt'                    ,'Quadratisch')
,('MR16'	,'0063'			, 'chrom'	                    ,'Rund')
,('MR16'	,'0063'			, 'weiss'	                    ,'Rund')
,('MR16'	,'0063'			, 'schwarz'	                    ,'Rund')
,('MR16'	,'0063'			, 'strukturweiss'	            ,'Rund')
,('MR16'	,'0063'			, 'alu matt'	                ,'Rund')
,('MR16'	,'0063'			, 'Champagner matt'	            ,'Rund')
,('MR16'	,'0063'			, 'Titan matt'	                ,'Rund')
,('MR16'	,'0065'			, 'chrom'	                    ,'Quadratisch')
,('MR16'	,'0065'			, 'weiss'	                    ,'Quadratisch')
,('MR16'	,'0065'			, 'schwarz'	                    ,'Quadratisch')
,('MR16'	,'0065'			, 'strukturweiss'	            ,'Quadratisch')
,('MR16'	,'0065'			, 'alu matt'	                ,'Quadratisch')
,('MR16'	,'0065'			, 'Champagner matt'	            ,'Quadratisch')
,('MR16'	,'0065'			, 'Titan matt'	                ,'Quadratisch')
,('MR16'	,'37006'		, 'weiss'	                    ,'Rund')
,('MR16'	,'37006'		, 'edelstahl'                   ,'Rund')
,('MR16'	,'45320'		, 'weiss mit Dekoklar klar'	    ,'Rund')
,('MR16'	,'45320'		, 'schwarz mit Dekoglas klar'	,'Rund')
,('MR16'	,'45321'		, 'weiss mit Dekoklar klar'	    ,'Quadratisch')
,('MR16'	,'45321'		, 'schwarz mit Dekoglas klar'	,'Quadratisch')
,('MR16'	,'20368'		, 'weiss'	                    ,'Rund')
,('MR16'	,'20368'		, 'nickel matt'	                ,'Rund')
,('MR16'	,'20368'		, 'silber'	                    ,'Rund')
,('MR16'	,'26004'		, 'weiss'	                    ,'Rund')
,('MR16'	,'26004'		, 'nickel matt'	                ,'Rund')
,('MR16'	,'26004'		, 'silber'	                    ,'Rund')
,('MR16'	,'26005'		, 'weiss'	                    ,'Quadratisch')
,('MR16'	,'26005'		, 'nickel matt'	                ,'Quadratisch')
,('MR16'	,'26005'		, 'silber'	                    ,'Quadratisch')






)t (Leuchtentyp, Farbe, Form)
GO
PRINT N'Update abgeschlossen.';


GO
