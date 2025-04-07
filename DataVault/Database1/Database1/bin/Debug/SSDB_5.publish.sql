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
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "18e2b90d-8893-47c9-92b4-5417e912e52a" wird übersprungen; das Element "[link].[Lichtverteilung_Klasse__Produkt_Typ_Klasse__Leuchten_Laenge_Klasse__Optik_Klasse__Lichtstrom_Klasse].[Lichtstrom_Klasse]" (SqlSimpleColumn) wird nicht in "Lichtstrom_Klasse_SK" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "24e964a7-d091-4455-bf51-d073821d0dcd" wird übersprungen; das Element "[hub].[Leuchte].[Lebensdauer_Klasse_SK]" (SqlSimpleColumn) wird nicht in "Leuchte_SK" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "6b49556c-11bf-4c32-b6ad-e62f23344f83" wird übersprungen; das Element "[hub].[Leuchte].[Lebensdauer]" (SqlSimpleColumn) wird nicht in "Leuchte" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "3d9f3e06-0c31-4c5f-9182-58c6d07dbfb0" wird übersprungen; das Element "[hub].[Schaltungsart_Klasse].[Schaltungsart_Klasse_SK]" (SqlSimpleColumn) wird nicht in "Steuerung_SK" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "805b9f71-c4e4-4830-8150-ead2c5663eae" wird übersprungen; das Element "[hub].[Schaltungsart_Klasse].[Schaltungsart]" (SqlSimpleColumn) wird nicht in "Steuerungsvariante" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "39f80036-7bcf-4335-9ab4-d75083319eb4" wird übersprungen; das Element "[hub].[Treiber].[S[Treiber_SK]" (SqlSimpleColumn) wird nicht in "Treiber_SK" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "57b6b24c-55aa-45e5-a19d-b656aaec7c32" wird übersprungen; das Element "[hub].[Treiber].[Steuerungsvariante]" (SqlSimpleColumn) wird nicht in "Hersteller" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "ee4f4205-2b5b-4c21-8b27-989246926ba4" wird übersprungen; das Element "[sat].[Steuerung].[Figur_SK]" (SqlSimpleColumn) wird nicht in "Steuerung_SK" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "1dd9b894-cf79-48a9-a2cd-4ba0c58c3a95" wird übersprungen; das Element "[sat].[Steuerung].[Beschreibung]" (SqlSimpleColumn) wird nicht in "Typ" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "e401513e-503b-424d-bce1-399d4b7c8cfe" wird übersprungen; das Element "[sat].[Steuerung].[Max_Leistung]" (SqlSimpleColumn) wird nicht in "Artikel" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "d95a0999-3c60-44f1-9c56-3658cb854473, 464c54e8-9f61-4cad-9784-cd6959c2bc72" wird übersprungen; das Element "[sat].[Treiber_MA].[Artikel]" (SqlSimpleColumn) wird nicht in "Hersteller" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "87e5beb5-5b80-4c90-8db1-8e7ef30125b0" wird übersprungen; das Element "[sat].[Treiber_MA].[T[Treiber_SK]" (SqlSimpleColumn) wird nicht in "Treiber_SK" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "c4fca279-7c41-4c8d-a649-62806ce04068" wird übersprungen; das Element "[sat].[Treiber_MA].[Leiserung]" (SqlSimpleColumn) wird nicht in "Leistung" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "6a252fe3-e2d0-43db-80ae-03675c166890" wird übersprungen; das Element "[link].[Leuchten__Steuerung].[Leuchten_SK]" (SqlSimpleColumn) wird nicht in "Leuchte_SK" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "fd81f1a6-e41a-4a5b-b301-eb96e3b01255" wird übersprungen; das Element "[link].[Leuchten__Treiber].[Leuchten_SK]" (SqlSimpleColumn) wird nicht in "Leuchte_SK" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "babad99a-017d-40f5-a53b-b3201f8ee4db" wird übersprungen; das Element "[hub].[Steuerung].[Leistung]" (SqlSimpleColumn) wird nicht in "Maximal_Leistung" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "367e2c92-6d62-4386-9c8e-0dd66645d037" wird übersprungen; das Element "[sat].[Steuerung_MA].[Artikel]" (SqlSimpleColumn) wird nicht in "Artikelnummer" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "694561d9-b52d-45d3-8b40-74c51265195b" wird übersprungen; das Element "[hub].[LED].[Leuchte]" (SqlSimpleColumn) wird nicht in "Lichtfarbe" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "50ffa6c5-70a5-42c0-b2a2-59252e3df9f7" wird übersprungen; das Element "[hub].[LED].[Leuchtentyp]" (SqlSimpleColumn) wird nicht in "Leistung_pro_Meter" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "6240f374-123d-4416-9eb0-77a0da01e716" wird übersprungen; das Element "[hub].[LED].[Schutzart]" (SqlSimpleColumn) wird nicht in "Einheit_Leistung_pro_Meter" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "369f279f-19bd-4ea2-aa11-dc44b9dbdb75" wird übersprungen; das Element "[hub].[LED].[Kanal]" (SqlSimpleColumn) wird nicht in "Lumen_pro_Meter" umbenannt.';


GO
PRINT N'Schema "[dim]" wird erstellt...';


GO
CREATE SCHEMA [dim]
    AUTHORIZATION [dbo];


GO
PRINT N'Schema "[fakt]" wird erstellt...';


GO
CREATE SCHEMA [fakt]
    AUTHORIZATION [dbo];


GO
PRINT N'Schema "[hub]" wird erstellt...';


GO
CREATE SCHEMA [hub]
    AUTHORIZATION [dbo];


GO
PRINT N'Schema "[link]" wird erstellt...';


GO
CREATE SCHEMA [link]
    AUTHORIZATION [dbo];


GO
PRINT N'Schema "[sat]" wird erstellt...';


GO
CREATE SCHEMA [sat]
    AUTHORIZATION [dbo];


GO
PRINT N'Tabelle "[hub].[Biro40_Profil]" wird erstellt...';


GO
CREATE TABLE [hub].[Biro40_Profil] (
    [Profil_SK]       INT           IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]     NVARCHAR (50) NOT NULL,
    [Lichtrichtung]   NVARCHAR (50) NOT NULL,
    [Montageart]      NVARCHAR (50) NOT NULL,
    [Profiltyp]       NVARCHAR (50) NOT NULL,
    [Profilfarbe]     NVARCHAR (50) NOT NULL,
    [Max_Schnittmass] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Biro40_Profil] PRIMARY KEY CLUSTERED ([Profil_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Biro40_Optik]" wird erstellt...';


GO
CREATE TABLE [hub].[Biro40_Optik] (
    [Optik_SK]        INT           IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]     NVARCHAR (50) NOT NULL,
    [Lichtrichtung]   NVARCHAR (50) NOT NULL,
    [Optik]           NVARCHAR (50) NOT NULL,
    [Max_Schnittmass] NVARCHAR (50) NOT NULL,
    [Position]        NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Biro40_Optik] PRIMARY KEY CLUSTERED ([Optik_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Biro40_Montage]" wird erstellt...';


GO
CREATE TABLE [hub].[Biro40_Montage] (
    [Montage_SK]    INT           IDENTITY (1, 1) NOT NULL,
    [Montageart]    NVARCHAR (50) NOT NULL,
    [Lichtrichtung] NVARCHAR (50) NOT NULL,
    [Leuchtentyp]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Biro40_Montage] PRIMARY KEY CLUSTERED ([Montage_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Biro40_Leuchte]" wird erstellt...';


GO
CREATE TABLE [hub].[Biro40_Leuchte] (
    [Leuchte_SK]    INT           IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]   NVARCHAR (50) NOT NULL,
    [Farbkanal]     NVARCHAR (50) NOT NULL,
    [Kanal]         NVARCHAR (50) NOT NULL,
    [Versorgung]    NVARCHAR (50) NOT NULL,
    [Schutzart]     NVARCHAR (50) NOT NULL,
    [Lichtfarbe]    NVARCHAR (50) NOT NULL,
    [Lichtrichtung] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Biro40_Leuchte] PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Biro40_Figur]" wird erstellt...';


GO
CREATE TABLE [hub].[Biro40_Figur] (
    [Figur_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Figur]    NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Biro40_Figur] PRIMARY KEY CLUSTERED ([Figur_SK] ASC)
);


GO
PRINT N'Prozedur "[dbo].[load_hub_Biro40_Figur]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Biro40_Figur] as

TRUNCATE TABLE hub.Biro40_Figur

INSERT INTO hub.Biro40_Figur ([Figur])

SELECT * FROM (VALUES

 ('I')
,('L')
,('U')
,('Z')
,('O')


)t ([Figur])
GO
PRINT N'Prozedur "[dbo].[load_hub_Biro40_Montage]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Biro40_Montage] as

TRUNCATE TABLE hub.Biro40_Montage

INSERT INTO hub.Biro40_Montage (Montageart, Lichtrichtung, Leuchtentyp)

SELECT * FROM (VALUES

 ('Einbau'                  , 'direkt'            , 'Biro40')
 ,('Anbau'                  ,  'direkt'           , 'Biro40')
 ,('Pendel'                 , 'direkt'            , 'Biro40')
 ,('Pendel direkt/indirekt' , 'direkt/indirekt'   , 'Biro40')



)t (Montageart, Lichtrichtung, Leuchtentyp)
GO
PRINT N'Prozedur "[dbo].[load_hub_Biro40_Optik]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Biro40_Optik] as

TRUNCATE TABLE hub.Biro40_Optik

INSERT INTO hub.Biro40_Optik (Leuchtentyp, Lichtrichtung, Optik, Max_Schnittmass, Position)

SELECT * FROM (VALUES

  ('Biro40'   , 'direkt'            , 'Microprismatisch'    , '1500'  , 'unten')
 ,('Biro40'   , 'direkt/indirekt'   , 'Microprismatisch'    , '1500'  , 'unten')
 ,('Biro40'   , 'direkt'            , 'Opal'                , '3000'  , 'unten')
 ,('Biro40'   , 'direkt/indirekt'   , 'Opal'                , '3000'  , 'unten')
 ,('Biro40'   , 'direkt/indirekt'   , 'klar'                , '1500'  , 'oben')



)t (Leuchtentyp, Lichtrichtung, Optik, Max_Schnittmass, Position)
GO
PRINT N'Prozedur "[dbo].[load_hub_Biro40_Profil]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Biro40_Profil] as

TRUNCATE TABLE hub.Biro40_Profil

INSERT INTO hub.Biro40_Profil (Leuchtentyp, Lichtrichtung, Montageart, Profiltyp, Profilfarbe, Max_Schnittmass)

SELECT * FROM (VALUES

 ('Biro40'  ,'direkt'           ,'Einbau'                   ,'Einbauprofil'	, 'weiss'	    , '3000')
,('Biro40'  ,'direkt'           ,'Einbau'                   ,'Einbauprofil'	, 'silber'	    , '3000')
,('Biro40'  ,'direkt'           ,'Einbau'                   ,'Einbauprofil'	, 'schwarz'     , '3000')
,('Biro40'  ,'direkt'           ,'Anbau	'                   ,'Anbauprofil'	, 'weiss'	    , '3000')
,('Biro40'  ,'direkt'           ,'Anbau	'                   ,'Anbauprofil'	, 'silber'	    , '3000')
,('Biro40'  ,'direkt'           ,'Anbau	'                   ,'Anbauprofil'	, 'schwarz'	    , '3000')
,('Biro40'  ,'direkt'           ,'Pendel'                   ,'Anbauprofil'	, 'weiss'	    , '3000')
,('Biro40'  ,'direkt'           ,'Pendel'                   ,'Anbauprofil'	, 'silber'	    , '3000')
,('Biro40'  ,'direkt'           ,'Pendel'                   ,'Anbauprofil'	, 'schwarz'	    , '3000')
,('Biro40'  ,'direkt/indirekt'  ,'Pendel direkt/indirekt'	,'Anbauprofil'  , 'weiss'	    , '3000')
,('Biro40'  ,'direkt/indirekt'  ,'Pendel direkt/indirekt'	,'Anbauprofil'  , 'silber'	    , '3000')
,('Biro40'  ,'direkt/indirekt'  ,'Pendel direkt/indirekt'	,'Anbauprofil'  , 'schwarz'	    , '3000')




)t (Leuchtentyp, Lichtrichtung, Montageart, Profiltyp, Profilfarbe, Max_Schnittmass)
GO
-- Umgestaltungsschritt zum Aktualisieren des Zielservers mit bereitgestellten Transaktionsprotokollen

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '18e2b90d-8893-47c9-92b4-5417e912e52a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('18e2b90d-8893-47c9-92b4-5417e912e52a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '24e964a7-d091-4455-bf51-d073821d0dcd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('24e964a7-d091-4455-bf51-d073821d0dcd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6b49556c-11bf-4c32-b6ad-e62f23344f83')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6b49556c-11bf-4c32-b6ad-e62f23344f83')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3d9f3e06-0c31-4c5f-9182-58c6d07dbfb0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3d9f3e06-0c31-4c5f-9182-58c6d07dbfb0')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '805b9f71-c4e4-4830-8150-ead2c5663eae')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('805b9f71-c4e4-4830-8150-ead2c5663eae')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '39f80036-7bcf-4335-9ab4-d75083319eb4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('39f80036-7bcf-4335-9ab4-d75083319eb4')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '57b6b24c-55aa-45e5-a19d-b656aaec7c32')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('57b6b24c-55aa-45e5-a19d-b656aaec7c32')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ee4f4205-2b5b-4c21-8b27-989246926ba4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ee4f4205-2b5b-4c21-8b27-989246926ba4')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1dd9b894-cf79-48a9-a2cd-4ba0c58c3a95')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1dd9b894-cf79-48a9-a2cd-4ba0c58c3a95')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e401513e-503b-424d-bce1-399d4b7c8cfe')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e401513e-503b-424d-bce1-399d4b7c8cfe')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd95a0999-3c60-44f1-9c56-3658cb854473')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d95a0999-3c60-44f1-9c56-3658cb854473')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '87e5beb5-5b80-4c90-8db1-8e7ef30125b0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('87e5beb5-5b80-4c90-8db1-8e7ef30125b0')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '464c54e8-9f61-4cad-9784-cd6959c2bc72')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('464c54e8-9f61-4cad-9784-cd6959c2bc72')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c4fca279-7c41-4c8d-a649-62806ce04068')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c4fca279-7c41-4c8d-a649-62806ce04068')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0d0794c8-6521-425d-a2a4-0b2234f861bd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0d0794c8-6521-425d-a2a4-0b2234f861bd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '55c05811-a1d1-4b30-a4fc-76cea049d193')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('55c05811-a1d1-4b30-a4fc-76cea049d193')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd9867dce-14b2-42c3-833f-bac93e9b2d66')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d9867dce-14b2-42c3-833f-bac93e9b2d66')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '39283126-85fc-4d3c-9401-b396eb7620e8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('39283126-85fc-4d3c-9401-b396eb7620e8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6a252fe3-e2d0-43db-80ae-03675c166890')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6a252fe3-e2d0-43db-80ae-03675c166890')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'fd81f1a6-e41a-4a5b-b301-eb96e3b01255')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('fd81f1a6-e41a-4a5b-b301-eb96e3b01255')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'babad99a-017d-40f5-a53b-b3201f8ee4db')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('babad99a-017d-40f5-a53b-b3201f8ee4db')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '367e2c92-6d62-4386-9c8e-0dd66645d037')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('367e2c92-6d62-4386-9c8e-0dd66645d037')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '694561d9-b52d-45d3-8b40-74c51265195b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('694561d9-b52d-45d3-8b40-74c51265195b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '50ffa6c5-70a5-42c0-b2a2-59252e3df9f7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('50ffa6c5-70a5-42c0-b2a2-59252e3df9f7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6240f374-123d-4416-9eb0-77a0da01e716')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6240f374-123d-4416-9eb0-77a0da01e716')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '369f279f-19bd-4ea2-aa11-dc44b9dbdb75')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('369f279f-19bd-4ea2-aa11-dc44b9dbdb75')

GO

GO
PRINT N'Update abgeschlossen.';


GO
