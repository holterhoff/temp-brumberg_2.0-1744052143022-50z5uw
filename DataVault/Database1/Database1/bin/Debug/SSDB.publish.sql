/*
Bereitstellungsskript für Siteco

Dieser Code wurde von einem Tool generiert.
Änderungen an dieser Datei führen möglicherweise zu falschem Verhalten und gehen verloren, falls
der Code neu generiert wird.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Siteco"
:setvar DefaultFilePrefix "Siteco"
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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Datenbank "$(DatabaseName)" wird erstellt...'
GO
CREATE DATABASE [$(DatabaseName)] COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
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
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Die Datenbankeinstellungen können nicht geändert werden. Diese Einstellungen können nur von Systemadministratoren übernommen werden.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Die Datenbankeinstellungen können nicht geändert werden. Diese Einstellungen können nur von Systemadministratoren übernommen werden.';
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
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


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
PRINT N'Tabelle "[hub].[Profil_Zubehoer_Klasse]" wird erstellt...';


GO
CREATE TABLE [hub].[Profil_Zubehoer_Klasse] (
    [Profil_Zubehoer_Klasse_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Bezeichnung]               NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Profil_Zubehoer_Klasse] PRIMARY KEY CLUSTERED ([Profil_Zubehoer_Klasse_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Profil_Laenge]" wird erstellt...';


GO
CREATE TABLE [hub].[Profil_Laenge] (
    [Profil_Laenge_SK] INT IDENTITY (1, 1) NOT NULL,
    [Bezeichnung]      INT NOT NULL,
    CONSTRAINT [PK_hub_Profil_Laenge] PRIMARY KEY CLUSTERED ([Profil_Laenge_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Profil_Farbe]" wird erstellt...';


GO
CREATE TABLE [hub].[Profil_Farbe] (
    [Profil_Farbe_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Bezeichnung]     NVARCHAR (50) NOT NULL,
    [Beschichtung]    NVARCHAR (50) NULL,
    CONSTRAINT [PK_hub_Profilfarbe] PRIMARY KEY CLUSTERED ([Profil_Farbe_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Geraet]" wird erstellt...';


GO
CREATE TABLE [hub].[Geraet] (
    [Geraet_SK]       INT           IDENTITY (1, 1) NOT NULL,
    [Profil_Klasse]   NVARCHAR (50) NULL,
    [Lichtrichtung]   NVARCHAR (50) NULL,
    [Lichtfarbe_Code] NVARCHAR (50) NOT NULL,
    [Schaltung]       NVARCHAR (50) NOT NULL,
    [Lumenpaket]      NVARCHAR (50) NOT NULL,
    [Step]            INT           NOT NULL,
    [Min]             INT           NOT NULL,
    [Max]             INT           NOT NULL,
    CONSTRAINT [PK_hub_Geraet] PRIMARY KEY CLUSTERED ([Geraet_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Geraet_Basis]" wird erstellt...';


GO
CREATE TABLE [hub].[Geraet_Basis] (
    [Geraet_Basis_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Profil_Klasse]   NVARCHAR (50) NULL,
    [Lichtrichtung]   NVARCHAR (50) NULL,
    [Lichtfarbe_Code] NVARCHAR (50) NOT NULL,
    [Schaltung]       NVARCHAR (50) NOT NULL,
    [Lumenpaket]      NVARCHAR (50) NOT NULL,
    [Step]            INT           NOT NULL,
    [Min]             INT           NOT NULL,
    [Max]             INT           NOT NULL,
    CONSTRAINT [PK_hub_Geraet_Basis] PRIMARY KEY CLUSTERED ([Geraet_Basis_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Geraet_Lichtfarbe]" wird erstellt...';


GO
CREATE TABLE [hub].[Geraet_Lichtfarbe] (
    [Geraet_Lichtfarbe_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Lichtfarbe_Code]      NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Lichtfarbe] PRIMARY KEY CLUSTERED ([Geraet_Lichtfarbe_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Lichtrichtung]" wird erstellt...';


GO
CREATE TABLE [hub].[Lichtrichtung] (
    [Lichtrichtung_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Lichtrichtung]    NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Lichtrichtung] PRIMARY KEY CLUSTERED ([Lichtrichtung_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Geraet_Klasse]" wird erstellt...';


GO
CREATE TABLE [hub].[Geraet_Klasse] (
    [Geraet_Klasse_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Bezeichnung]      NVARCHAR (50) NOT NULL,
    [Lichtrichtung]    NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Geraet_Klasse] PRIMARY KEY CLUSTERED ([Geraet_Klasse_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Geraet_Schaltung]" wird erstellt...';


GO
CREATE TABLE [hub].[Geraet_Schaltung] (
    [Geraet_Schaltung_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Schaltung]           NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Schaltung] PRIMARY KEY CLUSTERED ([Geraet_Schaltung_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Schenkel]" wird erstellt...';


GO
CREATE TABLE [hub].[Schenkel] (
    [Schenkel_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Schenkel]    NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Schenkel] PRIMARY KEY CLUSTERED ([Schenkel_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Montage]" wird erstellt...';


GO
CREATE TABLE [hub].[Montage] (
    [Montage_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Montageart] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Montage] PRIMARY KEY CLUSTERED ([Montage_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Optik_Klasse]" wird erstellt...';


GO
CREATE TABLE [hub].[Optik_Klasse] (
    [Optik_Klasse_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Bezeichnung]     NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Optik_Klasse] PRIMARY KEY CLUSTERED ([Optik_Klasse_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Figur]" wird erstellt...';


GO
CREATE TABLE [hub].[Figur] (
    [Figur_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Figur]    NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Figur] PRIMARY KEY CLUSTERED ([Figur_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Geraet_Laenge]" wird erstellt...';


GO
CREATE TABLE [hub].[Geraet_Laenge] (
    [Geraet_Laenge_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Lichtfarbe_Code]  NVARCHAR (50) NOT NULL,
    [Schaltung]        NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Geraet_Laenge] PRIMARY KEY CLUSTERED ([Geraet_Laenge_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Geraet_Lumenpaket]" wird erstellt...';


GO
CREATE TABLE [hub].[Geraet_Lumenpaket] (
    [Geraet_Lumenpaket_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Lumenpaket]           NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Geraet_Lumenpaket] PRIMARY KEY CLUSTERED ([Geraet_Lumenpaket_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Profil_Zubehoer]" wird erstellt...';


GO
CREATE TABLE [hub].[Profil_Zubehoer] (
    [Profil_Zubehoer_SK]     INT           IDENTITY (1, 1) NOT NULL,
    [Produkt_Klasse]         NVARCHAR (50) NOT NULL,
    [Profil_Zubehoer_Klasse] NVARCHAR (50) NOT NULL,
    [Montageart]             NVARCHAR (50) NOT NULL,
    [Profil_Farbe]           NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Profil_Zubehoer] PRIMARY KEY CLUSTERED ([Profil_Zubehoer_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Profil]" wird erstellt...';


GO
CREATE TABLE [hub].[Profil] (
    [Profil_SK]       INT           IDENTITY (1, 1) NOT NULL,
    [Produkt_Klasse]  NVARCHAR (50) NOT NULL,
    [Profil_Richtung] NVARCHAR (50) NOT NULL,
    [Profil_Farbe]    NVARCHAR (50) NOT NULL,
    [Profil_Laenge]   NVARCHAR (50) NOT NULL,
    [Montage_Kurz]    NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Profil] PRIMARY KEY CLUSTERED ([Profil_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Profil_Richtung]" wird erstellt...';


GO
CREATE TABLE [hub].[Profil_Richtung] (
    [Profil_Richtung_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Bezeichnung]        NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Profil_Richtung] PRIMARY KEY CLUSTERED ([Profil_Richtung_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Produkt_Klasse]" wird erstellt...';


GO
CREATE TABLE [hub].[Produkt_Klasse] (
    [Produkt_Klasse_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Bezeichnung]       NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Produkt_Klasse] PRIMARY KEY CLUSTERED ([Produkt_Klasse_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Optik]" wird erstellt...';


GO
CREATE TABLE [hub].[Optik] (
    [Produkt_Klasse] NVARCHAR (50) NOT NULL,
    [Optik_Klasse]   NVARCHAR (50) NOT NULL,
    [Lichtrichtung]  NVARCHAR (50) NOT NULL,
    [Laenge]         INT           NOT NULL
);


GO
PRINT N'Tabelle "[link].[Montage_Lichtrichtung]" wird erstellt...';


GO
CREATE TABLE [link].[Montage_Lichtrichtung] (
    [Montage_SK]       INT NOT NULL,
    [Lichtrichtung_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Profil_Farbe_Profil_Zubehoer_Klasse]" wird erstellt...';


GO
CREATE TABLE [link].[Profil_Farbe_Profil_Zubehoer_Klasse] (
    [Profil_Farbe_SK]           INT NOT NULL,
    [Profil_Zubehoer_Klasse_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Montage_Profil_Zubehoer_Klasse]" wird erstellt...';


GO
CREATE TABLE [link].[Montage_Profil_Zubehoer_Klasse] (
    [Montage_SK]                INT NOT NULL,
    [Profil_Zubehoer_Klasse_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Geraet_Schaltung_Geraet_Laenge]" wird erstellt...';


GO
CREATE TABLE [link].[Geraet_Schaltung_Geraet_Laenge] (
    [Geraet_Schaltung_SK] INT NOT NULL,
    [Geraet_Laenge_SK]    INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Montage_Geraet_Klasse]" wird erstellt...';


GO
CREATE TABLE [link].[Montage_Geraet_Klasse] (
    [Montage_SK]       INT NOT NULL,
    [Geraet_Klasse_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Geraet_Klasse_Geraet_Lichtfarbe]" wird erstellt...';


GO
CREATE TABLE [link].[Geraet_Klasse_Geraet_Lichtfarbe] (
    [Geraet_Klasse_SK]     INT NOT NULL,
    [Geraet_Lichtfarbe_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Figur_Montage]" wird erstellt...';


GO
CREATE TABLE [link].[Figur_Montage] (
    [Figur_SK]   INT NOT NULL,
    [Montage_SK] INT NOT NULL
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Tabelle "[link].[Figur_Schenkel]" wird erstellt...';


GO
CREATE TABLE [link].[Figur_Schenkel] (
    [Figur_SK]    INT NOT NULL,
    [Schenkel_SK] INT NOT NULL
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Tabelle "[link].[Optik_Klasse_Profil_Klasse]" wird erstellt...';


GO
CREATE TABLE [link].[Optik_Klasse_Profil_Klasse] (
    [Optik_KLasse_SK]  INT NOT NULL,
    [Profil_Klasse_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Lichtrichtung_Optik_Klasse]" wird erstellt...';


GO
CREATE TABLE [link].[Lichtrichtung_Optik_Klasse] (
    [Lichtrichtung_SK] INT NOT NULL,
    [Optik_Klasse_SK]  INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Optik_Klasse_Profil_Laenge]" wird erstellt...';


GO
CREATE TABLE [link].[Optik_Klasse_Profil_Laenge] (
    [Optik_Klasse_SK]  INT NOT NULL,
    [Profil_laenge_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Geraet_Lichtfarbe_Geraet_Schaltung]" wird erstellt...';


GO
CREATE TABLE [link].[Geraet_Lichtfarbe_Geraet_Schaltung] (
    [Geraet_Lichtfarbe_SK] INT NOT NULL,
    [Geraet_Schaltung_SK]  INT NOT NULL
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Tabelle "[link].[Geraet_Laenge_Geraet_Lumenpaket]" wird erstellt...';


GO
CREATE TABLE [link].[Geraet_Laenge_Geraet_Lumenpaket] (
    [Geraet_Laenge_SK]     INT NOT NULL,
    [Geraet_Lumenpaket_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Produkt_Klasse_Profil_Richtung]" wird erstellt...';


GO
CREATE TABLE [link].[Produkt_Klasse_Profil_Richtung] (
    [Produkt_Klasse_SK]  INT NOT NULL,
    [Profil_Richtung_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Produkt_Klasse_Profil_Laenge]" wird erstellt...';


GO
CREATE TABLE [link].[Produkt_Klasse_Profil_Laenge] (
    [Produkt_Klasse_SK] INT NOT NULL,
    [Profil_Laenge_SK]  INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Produkt_Klasse_Profil_Farbe]" wird erstellt...';


GO
CREATE TABLE [link].[Produkt_Klasse_Profil_Farbe] (
    [Produkt_Klasse_SK] INT NOT NULL,
    [Profil_Farbe_SK]   INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Optik_Klasse_Produkt_Klasse]" wird erstellt...';


GO
CREATE TABLE [link].[Optik_Klasse_Produkt_Klasse] (
    [Optik_KLasse_SK]   INT NOT NULL,
    [Produkt_Klasse_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Montage_Produkt_Klasse]" wird erstellt...';


GO
CREATE TABLE [link].[Montage_Produkt_Klasse] (
    [Montage_SK]        INT NOT NULL,
    [Produkt_Klasse_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[sat].[Profil_Zubehoer]" wird erstellt...';


GO
CREATE TABLE [sat].[Profil_Zubehoer] (
    [Profil_Zubehoer_SK] INT           NOT NULL,
    [Verkauf_Nummer]     NVARCHAR (50) NULL,
    [Artikel_Nummer]     NVARCHAR (50) NULL,
    [Bezeichnung]        NVARCHAR (50) NULL,
    [KG_M]               NVARCHAR (50) NULL,
    [KG_STK]             NVARCHAR (50) NULL,
    [Anmerkung]          NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Profil_Zubehoer_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Profil]" wird erstellt...';


GO
CREATE TABLE [sat].[Profil] (
    [Profil_SK]      INT           NOT NULL,
    [Verkauf_Nummer] NVARCHAR (50) NULL,
    [Artikel_Nummer] NVARCHAR (50) NULL,
    [Bezeichnung]    NVARCHAR (50) NULL,
    [Laenge]         NVARCHAR (50) NULL,
    [KG_M]           NVARCHAR (50) NULL,
    [KG_STK]         NVARCHAR (50) NULL,
    [Anmerkung]      NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Profil_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Montage]" wird erstellt...';


GO
CREATE TABLE [sat].[Montage] (
    [Montage_SK]   INT           NOT NULL,
    [Montage_Kurz] NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Montage_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Geraet_Laenge]" wird erstellt...';


GO
CREATE TABLE [sat].[Geraet_Laenge] (
    [Geraet_Laenge_SK] INT NOT NULL,
    [Step]             INT NOT NULL,
    [Min]              INT NOT NULL,
    [Max]              INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Geraet_Laenge_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Geraet_Lichtfarbe]" wird erstellt...';


GO
CREATE TABLE [sat].[Geraet_Lichtfarbe] (
    [Geraet_Lichtfarbe_SK] INT           NOT NULL,
    [Lichtfarbe]           NVARCHAR (50) NOT NULL,
    [Farbwiedergabe_Index] NVARCHAR (50) NULL,
    [MAC_ADAM_STEP]        NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Geraet_Lichtfarbe_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Profil_Farbe]" wird erstellt...';


GO
CREATE TABLE [sat].[Profil_Farbe] (
    [Profil_Farbe_SK] INT           NOT NULL,
    [Beschreibung]    NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Profil_Farbe_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Figur]" wird erstellt...';


GO
CREATE TABLE [sat].[Figur] (
    [Figur_SK]     INT           NOT NULL,
    [Beschreibung] NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Figur_SK] ASC)
);


GO
PRINT N'Tabelle "[dbo].[Loblicht_Profile]" wird erstellt...';


GO
CREATE TABLE [dbo].[Loblicht_Profile] (
    [Typ]             VARCHAR (50) NULL,
    [Verkauf_artikel] VARCHAR (50) NULL,
    [Artikel_Nummer]  VARCHAR (50) NULL,
    [Bezeichnung]     VARCHAR (50) NULL,
    [Länge]           VARCHAR (50) NULL,
    [kg_m]            VARCHAR (50) NULL,
    [kg_Stk ]         VARCHAR (50) NULL,
    [Profil]          VARCHAR (50) NULL,
    [Farbe]           VARCHAR (50) NULL,
    [Anmerkung]       VARCHAR (50) NULL
);


GO
PRINT N'Sicht "[dim].[Profil_Farbe]" wird erstellt...';


GO

CREATE VIEW dim.Profil_Farbe as 


SELECT 

		h.Profil_Farbe_SK
	,	Bezeichnung
	,	Beschreibung
	,	Beschichtung

FROM hub.Profil_Farbe h
INNER JOIN sat.Profil_Farbe s ON h.Profil_Farbe_SK = s.Profil_Farbe_SK
GO
PRINT N'Sicht "[dim].[Montage]" wird erstellt...';


GO

CREATE VIEW dim.Montage as 

SELECT * FROM hub.montage
GO
PRINT N'Sicht "[dim].[Geraet_Lichtfarbe_Schaltung]" wird erstellt...';


GO

CREATE VIEW dim.Geraet_Lichtfarbe_Schaltung as 


SELECT 

			h.Geraet_Lichtfarbe_SK
		,	h2.Geraet_Schaltung_SK
		,	Lichtfarbe
		--,	Lichtfarbe_Code
		,	Schaltung

FROM hub.Geraet_Lichtfarbe h
INNER JOIN sat.Geraet_Lichtfarbe s ON h.Geraet_Lichtfarbe_SK = s.Geraet_Lichtfarbe_SK
INNER JOIN link.Geraet_Lichtfarbe_Geraet_Schaltung l1 ON h.Geraet_Lichtfarbe_SK = l1.Geraet_Lichtfarbe_SK
INNER JOIN hub.Geraet_Schaltung h2 ON h2.Geraet_Schaltung_SK = l1.Geraet_Schaltung_SK
GO
PRINT N'Sicht "[dim].[Figur]" wird erstellt...';


GO

CREATE VIEW dim.Figur as 

SELECT 
		h.Figur_SK
	,	Figur
	,	Beschreibung
 
FROM hub.Figur h
INNER JOIN sat.Figur s ON h.Figur_SK = s.Figur_SK
GO
PRINT N'Prozedur "[dbo].[calc]" wird erstellt...';


GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[calc]
	-- Add the parameters for the stored procedure here
	@p0_berechnung nvarchar(20),
	@p1_wunschmass float,
	@p2_stepmass float,
	@p3_minmass float,
	@p4_maxmass float,
	@p5_@zusatz_var INT,
	@p6_@zusatz_fix INT,
	@p7_ecke float

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
    -- Insert statements for procedure here

IF OBJECT_ID('tempdb..#temp') IS NOT NULL
    DROP TABLE #temp
IF OBJECT_ID('tempdb..#temp2') IS NOT NULL
    DROP TABLE #temp2
IF OBJECT_ID('tempdb..#temp3') IS NOT NULL
    DROP TABLE #temp3


DECLARE @startnum INT=0
DECLARE @endnum INT=40

DECLARE @berechnung nvarchar(20) = @p0_berechnung


DECLARE @wunschmass FLOAT = @p1_wunschmass
DECLARE @stepmass FLOAT = @p2_stepmass
DECLARE @minmass FLOAT = @p3_minmass
DECLARE @maxmass FLOAT = @p4_maxmass

DECLARE @zusatz_var INT = @p5_@zusatz_var
DECLARE @zusatz_fix INT = @p6_@zusatz_fix
DECLARE @ecke INT = @p7_ecke



declare @step int = @wunschmass / @stepmass
declare @negativestep int= @step - 30
declare @positivestep int= 9

declare @searchrn int = 0

;


WITH gen AS (
    SELECT @startnum AS rn
    UNION ALL
    SELECT rn+1 FROM gen WHERE rn+1<=@endnum
),


gen2 as
(
	SELECT 
		@negativestep AS wert
    UNION all
    SELECT wert+1 FROM gen2 WHERE wert+1<=@step

),
gen3 as 
(
	SELECT 
		 @step+1 AS wert
    UNION all
    SELECT wert+1 FROM gen3 WHERE wert+1<=@positivestep+ @step

),
genunion as
(

	SELECT * FROM gen2
	UNION ALL
	SELECT * FROM gen3
),
genfinal as
(

	SELECT 
		ROW_NUMBER() OVER (ORDER BY wert) as rn
		,* 
	FROM genunion


)

,

--------------------------

result1
as
(
	SELECT 
			ISNULL(genfinal.rn,0) as rn --A
		,	ISNULL(genfinal.wert,0) as wert --B
		,	ISNULL(genfinal.wert*@stepmass,0) as rn3 --C
		--
		,	@maxmass / @stepmass as rn4 
		,	CASE WHEN gen.rn = 0 THEN 0 ELSE @minmass / @stepmass END as rn5 
		,	CASE WHEN gen.rn= 0 THEN 0 ELSE @minmass / @minmass END as rn6
		,	CASE WHEN gen.rn= 0 THEN 0 ELSE @wunschmass / @stepmass END as rn7
		,	CASE WHEN gen.rn= 0 THEN 0 ELSE CAST((@wunschmass / @stepmass) as INT) END as r8
		,	CASE WHEN gen.rn= 0 THEN 0 ELSE (@minmass / @stepmass) / (@maxmass / @stepmass) END as rn9
		
		-----------------------------
		-- WIRD NICHT BENÖTIGT E bis G dazu muss spalte E fest gepflegt werden
		--
		--,	ISNULL(genfinal.wert,0) as r10 --E
		--,	ISNULL(genfinal.wert * @maxmass,0) as r11 --F
		--,	ISNULL((genfinal.wert * @stepmass)  - (genfinal.wert * @maxmass),0) as r12 --G
		-----------------------------
		
		,	ISNULL(genfinal.wert / (@maxmass / @stepmass),0) as r13 --H
		,	ISNULL(CAST(genfinal.wert / (@maxmass / @stepmass) as INT ),0) as r14 --I

	FROM gen
	left JOIN genfinal ON gen.rn = genfinal.rn


),
result2 as
(
	SELECT 
			* 
		,	CASE WHEN r14+rn9 <= r13 THEN r14 ELSE 0 END as r15 --J
	FROM result1
),
result3 as
(
	SELECT 
			*
		,	CASE WHEN r13=cast(r14 as float) THEN r13 ELSE r15 END AS r16
	FROM result2
),
result4 as
(
	SELECT
			* 
		,	CASE WHEN rn= 0 THEN 0 ELSE	
				CASE WHEN r16=0 THEN r14-1 ELSE r16 END
			END as r17
	FROM result3
),
result5 as
(
	SELECT 
			* 
		,	CASE WHEN r17 <=0 THEN rn3 ELSE @maxmass END as r18
	FROM result4
),
result6 as
(
	SELECT 
			*
		,	r17*r18 as r19
	FROM result5
),
result7 as
(
	SELECT 
			*
		,	CASE WHEN r19<0 THEN r19*-1 ELSE r19 END as r20
		,	CASE WHEN r17<0 THEN r17*-1 ELSE r17 END as ME_KOMM
	FROM result6
),
result8 as
(
	SELECT 
			*
		,	CASE WHEN ME_KOMM=0 THEN 0 ELSE r20/ME_KOMM END as BASIS_KOMM
	FROM result7
),
result9 as
(
	SELECT 
			*
		,	rn3-(ME_KOMM*BASIS_KOMM) as REST_0
	FROM result8
),
result10 as
(
	SELECT 
			*
		,	CASE WHEN REST_0=0 THEN 0 ELSE (REST_0 / @stepmass ) END as REST_STEPS
	FROM result9
),
result11 as
(
	SELECT 
			*
		,	CASE WHEN REST_STEPS > rn4 THEN ROUND((REST_STEPS / 2 ),0) ELSE REST_STEPS END as ME_REST_1
	FROM result10
),
result12 as
(
	SELECT 
			*
		,	ME_REST_1 * @stepmass as REST_2
		,	REST_STEPS - ME_REST_1 as ME_REST_2
	FROM result11
)
	SELECT 
			*
		,	ME_REST_2 * @stepmass as REST_2_2
	into #temp
	FROM result12

------------------------------------------------------
------------------------------------------------------
------------------------------------------------------
------------------------------------------------------
------------------------------------------------------



SELECT 
		*
	,	ME_KOMM as ME_BASIS
	,	BASIS_KOMM as BASIS
	,	CASE WHEN ME_REST_1 = 0 THEN 0 ELSE 1 END as ME_REST_1_1
	,	REST_2 as REST_1
	,	CASE WHEN ME_REST_2 = 0 THEN 0 ELSE 1 END as ME_REST_2_1
	,	REST_2_2 as REST_2_1
into #temp2
FROM #temp

;
------------------------------------------------------
------------------------------------------------------
------------------------------------------------------
WITH result as
(
	SELECT
			 * 
		,	ME_BASIS * BASIS + ME_REST_1_1 * REST_1 + ME_REST_2_1 * REST_2_2 as BASIS_WUNSCH
		,	( ME_BASIS + ME_REST_1_1 + ME_REST_2_1 ) * @zusatz_var as ZUSATZ_VAR
		,	 @zusatz_fix as ZUSATZ_FIX
		,	 @ecke as ECKE
	FROM #temp2
),
result2 as
(

	SELECT
			* 
		,	BASIS_WUNSCH+ZUSATZ_VAR+ZUSATZ_FIX+ECKE as EFF_WUNSCH
		,	@wunschmass	 as EINGABE
	FROM result
),
result3 as
(
	SELECT 
			*
		,	CASE WHEN rn = 0 THEN 0 ELSE 
				EINGABE-EFF_WUNSCH 
			END as AQ
	FROM result2
),
result4 as
(
	SELECT 
			* 
		,	CASE WHEN rn= 0 THEN 0 ELSE 
				CASE WHEN AQ < 0 THEN AQ *-1 ELSE AQ END 
			END as AR
	FROM result3
),
result5 as
(
	
	SELECT 
			* 
		,	CASE WHEN rn = 0 THEN 1 ELSE 
				CASE WHEN AQ = 0 AND AR=0 THEN 0 ELSE (AQ/AR) END 
			END as [AS]
	FROM result4
),
result6 as
(
	SELECT 
			* 
		,	CASE WHEN rn = 0 THEN 2 ELSE 
				CASE WHEN [AS]=0 THEN 0 ELSE ([AS] + LAG([AS]) OVER (ORDER BY rn))  END
			END as AT
	FROM result5
),
result7 as
(
	SELECT 
			*
			,CASE WHEN rn = 0 THEN 0 ELSE
					CASE WHEN AT=0 THEN 1 ELSE 0 END 
				END as AU
	FROM result6
),
result8 as
(
	SELECT 
			*
		,	CASE WHEN rn = 0 THEN 0 ELSE
				CASE WHEN AU=1 AND AQ >= 0 THEN EFF_WUNSCH ELSE LAG(EFF_WUNSCH) OVER (ORDER BY rn) END
			END as AV
	FROM result7
),
result9 as
(
	---- LEAD FUNKTION PRÜFEN!!!!!
	SELECT 
			*

		--,	CASE WHEN rn = 0 THEN 0 ELSE
		--		CASE WHEN AU=1 AND AQ >= 0 THEN EFF_WUNSCH ELSE LEAD(EFF_WUNSCH) OVER (ORDER BY rn ) END 
		--	END as AW
		
		,	CASE WHEN rn = 0 THEN 0 ELSE
				CASE WHEN AU=1 AND AQ >= 0 THEN EFF_WUNSCH ELSE EFF_WUNSCH END 
			END as AW
			
	FROM result8
),
result10 as
(

	SELECT 
			* 
		,	AU * AV AS AX
		,	AU * EINGABE AS AY
		,	AU * AW AS AZ
		,	0 AS BA
	FROM result9
)

-------------------------------
--select * FROM result10


------------------------------


,SRC as
(
	SELECT	
			AX
		,	AZ


	FROM result10
	WHERE AU = 1
),

final as 
(




SELECT 
	
		@berechnung as TYP
	,	org.AW AS LAENGE
	,	org.ME_BASIS
	,	org.BASIS
	,	org.ME_REST_1_1
	,	org.REST_1
	,	org.ME_REST_2_1
	,	org.REST_2_2
	

FROM result10 ORG
INNER JOIN SRC ON ORG.AW = SRC.AX


UNION ALL 


SELECT 

		@berechnung as TYP
	,	@wunschmass AS LAENGE
	,	org.ME_BASIS
	,	org.BASIS
	,	org.ME_REST_1_1
	,	org.REST_1
	,	org.ME_REST_2_1
	,	org.REST_2_2


FROM result10 ORG
INNER JOIN SRC ON ORG.AW = SRC.AX



UNION ALL 


SELECT 

		@berechnung as TYP
	,	org.AW AS LAENGE
	,	org.ME_BASIS
	,	org.BASIS
	,	org.ME_REST_1_1
	,	org.REST_1
	,	org.ME_REST_2_1
	,	org.REST_2_2


FROM result10 ORG
INNER JOIN SRC ON ORG.AW = SRC.AZ


)

	SELECT 
			* 
		,	(ME_BASIS * (BASIS + @zusatz_var )) + (ME_REST_1_1 * (REST_1 + @zusatz_var )) + (ME_REST_2_1 * (REST_2_2 + @zusatz_var )) as profil_laenge
		,	(ME_BASIS * (BASIS + 4 )) + (ME_REST_1_1 * (REST_1 +4 )) + (ME_REST_2_1 * (REST_2_2 + 4 )) as geraetrtraeger_laenge
		,	(ME_BASIS * (BASIS + 4 )) + (ME_REST_1_1 * (REST_1 +4 )) + (ME_REST_2_1 * (REST_2_2 + 4 )) as optik_laenge
	FROM final 


------------------ PROFIL --------------------


--UNION ALL



--SELECT 
	
--		'Profil' as TYP
--	,	org.AW AS LAENGE
--	,	org.ME_BASIS
--	,	org.BASIS
--	,	org.ME_REST_1_1
--	,	org.REST_1
--	,	org.ME_REST_2_1
--	,	org.REST_2_2
	



--FROM result10 ORG
--INNER JOIN SRC ON ORG.AW = SRC.AX


--UNION ALL

--SELECT 

--		'Profil' as TYP
--	,	@wunschmass AS LAENGE
--	,	org.ME_BASIS
--	,	org.BASIS
--	,	org.ME_REST_1_1
--	,	org.REST_1
--	,	org.ME_REST_2_1
--	,	org.REST_2_2


--FROM result10 ORG
--INNER JOIN SRC ON ORG.AW = SRC.AZ



--UNION ALL

--SELECT 

--		'Profil' as TYP
--	,	org.AW
--	,	org.ME_BASIS
--	,	org.BASIS
--	,	org.ME_REST_1_1
--	,	org.REST_1
--	,	org.ME_REST_2_1
--	,	org.REST_2_2


--FROM result10 ORG
--INNER JOIN SRC ON ORG.AW = SRC.AZ






END
GO
PRINT N'Prozedur "[dbo].[load_hub_Figur]" wird erstellt...';


GO
CREATE PROCEDURE [load_hub_Figur] as

truncate table hub.figur

insert into hub.figur (Figur)
SELECT Figur FROM (VALUES

		(1,'I'),
		(2,'L'),
		(3,'U'),
		(4,'Z'),
		(5,'O')
) t1 (id,Figur)
GO
PRINT N'Prozedur "[dbo].[load_hub_Geraet]" wird erstellt...';


GO


CREATE PROCEDURE [dbo].[load_hub_Geraet] as


TRUNCATE TABLE hub.geraet;


WITH gen AS (
    SELECT 
			Geraet_Basis_SK
		,	Profil_Klasse
		,	Lichtrichtung
		,	[Lichtfarbe_Code]
		,	[Schaltung]
		,	[Lumenpaket]
		,	[Step]
		,	[Min]
		,	[Max]
		
	FROM hub.geraet_basis
    UNION ALL
    
	
	SELECT 
			Geraet_Basis_SK
		,	Profil_Klasse
		,	Lichtrichtung
		,	[Lichtfarbe_Code]
		,	[Schaltung]
		,	[Lumenpaket]
		,	[Step]
		,	[Min]+[step]
		,	[Max]
	FROM gen WHERE [min]+[Step]<= [max]
)




INSERT INTO hub.geraet 
select  

			Profil_Klasse
		,	Lichtrichtung
		,	[Lichtfarbe_Code]
		,	[Schaltung]
		,	[Lumenpaket]
		,	[Step]
		,	[Min]
		,	[Max]

FROM gen

order by 1,2,3,6



--select * FROM hub.geraet_basis
GO
PRINT N'Prozedur "[dbo].[load_hub_Geraet_Basis]" wird erstellt...';


GO


CREATE PROCEDURE [dbo].[load_hub_Geraet_Basis] as

truncate table hub.Geraet_Basis

INSERT INTO hub.Geraet_Basis (

			Profil_Klasse
	  ,		Lichtrichtung
      ,		[Lichtfarbe_Code]
      ,		[Schaltung]
	  ,		Lumenpaket
	  ,		[Step]
	  ,		[Min]
	  ,		[Max]
 )


SELECT distinct

			h1.Bezeichnung as Profil_Klasse
	 ,		Lichtrichtung
     , 		h2.[Lichtfarbe_Code]
     ,		h3.[Schaltung]
	 ,		Lumenpaket
	 ,		[Step]
	 ,		[Min]
	 ,		[Max]
	 

  
  FROM hub.Geraet_Klasse h1
  INNER JOIN link.Geraet_Klasse_Geraet_Lichtfarbe l1 ON h1.Geraet_Klasse_SK = l1.Geraet_Klasse_SK
  INNER JOIN hub.Geraet_Lichtfarbe h2 ON h2.Geraet_Lichtfarbe_SK = l1.Geraet_Lichtfarbe_SK
  INNER JOIN link.Geraet_Lichtfarbe_Geraet_Schaltung l2 ON h2.Geraet_Lichtfarbe_SK = l2.Geraet_Lichtfarbe_SK
  INNER JOIN hub.Geraet_Schaltung h3 on l2.Geraet_Schaltung_SK = h3.Geraet_Schaltung_SK
  INNER JOIN [link].[Geraet_Schaltung_Geraet_Laenge] l3 ON l3.Geraet_Schaltung_SK = h3.Geraet_Schaltung_SK
  INNER JOIN hub.Geraet_Laenge h4 ON l3.Geraet_Laenge_SK = h4.Geraet_Laenge_SK
  INNER JOIN sat.Geraet_Laenge s1 ON h4.Geraet_Laenge_SK = s1.Geraet_Laenge_SK
  INNER JOIN link.Geraet_Laenge_Geraet_Lumenpaket l4 ON l4.Geraet_Laenge_SK = h4.Geraet_Laenge_SK
  INNER JOIN hub.Geraet_Lumenpaket h5 ON h5.Geraet_Lumenpaket_SK = l4.Geraet_Lumenpaket_SK
GO
PRINT N'Prozedur "[dbo].[load_hub_Geraet_Klasse]" wird erstellt...';


GO

CREATE PROCEDURE load_hub_Geraet_Klasse as


TRUNCATE TABLE hub.Geraet_Klasse
INSERT INTO hub.Geraet_Klasse (Bezeichnung, Lichtrichtung)
SELECT 
	Bezeichnung
	,Lichtrichtung


FROM (VALUES
('Lichteinsatz')
)t (Bezeichnung)
CROSS JOIN hub.Lichtrichtung
GO
PRINT N'Prozedur "[dbo].[load_hub_Geraet_Laenge]" wird erstellt...';


GO


CREATE PROCEDURE [dbo].[load_hub_Geraet_Laenge] as

TRUNCATE TABLE hub.Geraet_Laenge

INSERT INTO hub.Geraet_Laenge ([Lichtfarbe_Code],[Schaltung])
SELECT
	 Lichtfarbe_Code
	,Schaltung

FROM hub.Geraet_Lichtfarbe h
INNER JOIN [link].[Geraet_Lichtfarbe_Geraet_Schaltung] lls ON lls.Geraet_Lichtfarbe_SK = h.Geraet_Lichtfarbe_SK
--
INNER JOIN hub.Geraet_schaltung hs ON hs.Geraet_Schaltung_SK = lls.Geraet_Schaltung_SK
GO
PRINT N'Prozedur "[dbo].[load_hub_Geraet_Lichtfarbe]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Geraet_Lichtfarbe] as

truncate table hub.Geraet_Lichtfarbe

insert into hub.Geraet_Lichtfarbe (Lichtfarbe_Code)
SELECT Lichtfarbe FROM (VALUES

		('830'),
		('840')
		


) t1 (Lichtfarbe)
GO
PRINT N'Prozedur "[dbo].[load_hub_Geraet_Schaltung]" wird erstellt...';


GO

CREATE PROCEDURE [dbo].[load_hub_Geraet_Schaltung] as

truncate table hub.Geraet_Schaltung

insert into hub.Geraet_Schaltung (schaltung)
SELECT schaltung FROM (VALUES

		('Schaltbar'),
		('DALI')
		
) t1 (schaltung)
GO
PRINT N'Prozedur "[dbo].[load_hub_Lichtrichtung]" wird erstellt...';


GO

CREATE PROCEDURE [dbo].[load_hub_Lichtrichtung] as

truncate table hub.Lichtrichtung

insert into hub.Lichtrichtung (Lichtrichtung)
SELECT Lichtrichtung FROM (VALUES

		('direkt'),
		('indirekt')



) t1 (Lichtrichtung)
GO
PRINT N'Prozedur "[dbo].[load_hub_Montage]" wird erstellt...';


GO

CREATE PROCEDURE [dbo].[load_hub_Montage] as

truncate table hub.montage

insert into hub.montage (Montageart)
SELECT Montageart FROM (VALUES

		('Einbau'),
		('Einbau RL'),
		('Anbau'),
		('Pendel di'),
		('Pendel di/in')


) t1 (Montageart)
GO
PRINT N'Prozedur "[dbo].[load_hub_Optik]" wird erstellt...';


GO


CREATE PROCEDURE [dbo].[load_hub_Optik] as

TRUNCATE TABLE hub.Optik

INSERT INTO hub.Optik (Produkt_Klasse, Optik_Klasse, Lichtrichtung, Laenge)
Select distinct

		h1.Bezeichnung as Produkt_Klasse
	,	h2.Bezeichnung as Optik_Klasse
	,	h3.Lichtrichtung 
	,	h4.Bezeichnung as Laenge

FROM hub.Produkt_Klasse h1
INNER JOIN link.Optik_Klasse_Produkt_Klasse l1 ON h1.Produkt_Klasse_SK = h1.Produkt_Klasse_SK

INNER JOIN hub.Optik_Klasse h2 ON h2.Optik_Klasse_SK = l1.Optik_Klasse_SK

INNER JOIN link.Lichtrichtung_Optik_Klasse l2 ON l2.Optik_Klasse_SK = h2.Optik_Klasse_SK

INNER JOIN hub.Lichtrichtung h3 ON h3.Lichtrichtung_SK = l2.Lichtrichtung_SK

INNER JOIN link.Optik_Klasse_Profil_Laenge l3 ON l3.Optik_Klasse_SK = h2.Optik_Klasse_SK

INNER JOIN hub.Profil_Laenge h4 ON l3.Profil_Laenge_SK = h4.Profil_Laenge_SK

order by 1
GO
PRINT N'Prozedur "[dbo].[load_hub_Optik_Klasse]" wird erstellt...';


GO


CREATE PROCEDURE [dbo].[load_hub_Optik_Klasse] as

TRUNCATE TABLE [hub].[Optik_Klasse]
INSERT INTO [hub].[Optik_Klasse] ([Bezeichnung])

SELECT 
	*
FROM (VALUES 

('opal'),
('mikro klar'),
('mikro grau')

) t (Bezeichnung)
GO
PRINT N'Prozedur "[dbo].[load_hub_Produkt_Klasse]" wird erstellt...';


GO



CREATE PROCEDURE [dbo].[load_hub_Produkt_Klasse] as

truncate table hub.Produkt_Klasse

insert into hub.Produkt_Klasse (Bezeichnung)
SELECT * FROM (VALUES

		('Profil 45'),
		('Profil 67')


) t1 (Bezeichnung)
GO
PRINT N'Prozedur "[dbo].[load_hub_Profil]" wird erstellt...';


GO

CREATE PROCEDURE [dbo].[load_hub_Profil] as


TRUNCATE TABLE hub.profil

INSERT INTO hub.profil (Produkt_Klasse,Profil_Richtung,[Profil_Farbe], [Profil_Laenge],[Montage_Kurz])

SELECT DISTINCT
	
	
			h1.Bezeichnung	as Produkt_Klasse
		,	h2.Bezeichnung	as Profil_Richtung
		,	h4.Bezeichnung	as Profil_Farbe
		,	h3.Bezeichnung  as Profil_Laenge
		,	s1.Montage_Kurz



FROM hub.Produkt_Klasse h1
INNER JOIN link.Produkt_Klasse_Profil_Richtung l1 ON h1.Produkt_Klasse_SK = l1.Produkt_Klasse_SK
INNER JOIN hub.Profil_Richtung h2 ON h2.Profil_Richtung_SK = l1.Profil_Richtung_SK

INNER JOIN link.Produkt_Klasse_Profil_Laenge l2 ON h1.Produkt_Klasse_SK = l2.Produkt_Klasse_SK
INNER JOIN  hub.Profil_Laenge h3 ON h3.Profil_Laenge_SK = l2.Profil_Laenge_SK

INNER JOIN link.Produkt_Klasse_Profil_Farbe l3 ON h1.Produkt_Klasse_SK = l3.Produkt_Klasse_SK

INNER JOIN hub.Profil_Farbe h4 on h4.Profil_Farbe_SK = l3.Profil_Farbe_SK

INNER JOIN link.Montage_Produkt_Klasse l4 ON h1.Produkt_Klasse_SK = l4.Produkt_Klasse_SK
INNER JOIN hub.Montage h5 ON h5.Montage_SK = l4.Montage_SK
INNER JOIN sat.Montage s1 ON s1.Montage_SK = h5.Montage_SK






ORDER BY 1,2,3,5
GO
PRINT N'Prozedur "[dbo].[load_hub_Profil_Farbe]" wird erstellt...';


GO


CREATE PROCEDURE [dbo].[load_hub_Profil_Farbe] as

truncate table hub.Profil_Farbe

insert into hub.Profil_Farbe (Bezeichnung,Beschichtung)
SELECT Bezeichnung,Beschichtung FROM (VALUES

		('roh','roh'),
		('RAL 9005','gepulvert'),
		('RAL 9006','gepulvert'),
		('RAL 9016','gepulvert'),
		('RAL ___','gepulvert')

		


) t1 (Bezeichnung,Beschichtung)
GO
PRINT N'Prozedur "[dbo].[load_hub_Profil_Laenge]" wird erstellt...';


GO


CREATE PROCEDURE [dbo].[load_hub_Profil_Laenge] as

truncate table hub.Profil_Laenge

insert into hub.Profil_Laenge (Bezeichnung)
SELECT * FROM (VALUES
    
        (90),
        (1120),
        (1260),
        (1400),
        (1540),
        (1680),
        (1820),
        (1960),
        (2100),
        (2240)



) t1 (Bezeichnung)
GO
PRINT N'Prozedur "[dbo].[load_hub_Profil_Richtung]" wird erstellt...';


GO

CREATE PROCEDURE load_hub_Profil_Richtung as

TRUNCATE TABLE hub.Profil_Richtung
INSERT INTO hub.Profil_Richtung (Bezeichnung)

SELECT * FROM (VALUES

('Primär'),
('Sekundär')

) t (Bezeichnung)
GO
PRINT N'Prozedur "[dbo].[load_hub_Profil_Zubehoer]" wird erstellt...';


GO


CREATE PROCEDURE [dbo].[load_hub_Profil_Zubehoer] as

TRUNCATE TABLE [hub].[Profil_Zubehoer]

INSERT into [hub].[Profil_Zubehoer] ([Produkt_Klasse],[Profil_Zubehoer_Klasse],[Montageart],[Profil_Farbe])
SELECT DISTINCT


	h4.Bezeichnung as Produkt_Klasse
,	h1.Bezeichnung	as Profil_Zubehoer_Klasse
,	Montageart
,	h3.Bezeichnung	as Profil_Farbe






FROM hub.Profil_Zubehoer_Klasse h1
-- Link
INNER JOIN [link].[Montage_Profil_Zubehoer_Klasse] l1 ON h1.Profil_Zubehoer_Klasse_SK = l1.Profil_Zubehoer_Klasse_SK
--- Hub Montage
INNER JOIN [hub].[Montage] h2 ON h2.Montage_SK = l1.Montage_SK
-- 
INNER JOIN [link].[Profil_Farbe_Profil_Zubehoer_Klasse] l2 ON l2.Profil_Zubehoer_Klasse_SK = l1.Profil_Zubehoer_Klasse_SK

-- 
INNER JOIN [hub].[Profil_Farbe] h3 ON h3.Profil_Farbe_SK = l2.Profil_Farbe_SK
---

INNER JOIN [link].[Produkt_Klasse_Profil_Farbe] l3 ON l3.Profil_Farbe_SK = h3.Profil_Farbe_SK


INNER JOIN [hub].[Produkt_Klasse] h4 ON h4.Produkt_Klasse_SK = l3.Produkt_Klasse_SK



ORDER BY 1,2,3,4
GO
PRINT N'Prozedur "[dbo].[load_hub_Schenkel]" wird erstellt...';


GO
CREATE PROCEDURE load_hub_Schenkel as

truncate table hub.Schenkel

insert into hub.Schenkel (Schenkel)
SELECT Schenkel FROM (VALUES

		('A'),
		('B'),
		('C'),
		('D')


) t1 (Schenkel)
GO
PRINT N'Prozedur "[dbo].[load_link_Figur_Montage]" wird erstellt...';


GO
CREATE PROCEDURE load_link_Figur_Montage as

truncate table link.Figur_Montage

insert into link.Figur_Montage (Figur_SK,Montage_SK)

SELECT 

	Figur_SK,
	Montage_SK

FROM hub.figur
CROSS JOIN hub.Montage
GO
PRINT N'Prozedur "[dbo].[load_link_Figur_Profil]" wird erstellt...';


GO
CREATE PROCEDURE load_link_Figur_Profil as

SELECT 

		Figur_SK
		,Profil_SK

FROM hub.Figur
CROSS JOIN hub.Profil
GO
PRINT N'Prozedur "[dbo].[load_link_Figur_Schenkel]" wird erstellt...';


GO
CREATE PROCEDURE load_link_Figur_Schenkel as

truncate table link.Figur_Schenkel

insert into link.Figur_Schenkel (Figur_SK,Schenkel_SK)

SELECT 

	Figur_SK,
	Schenkel_SK

FROM hub.figur
CROSS JOIN hub.Schenkel
GO
PRINT N'Prozedur "[dbo].[load_link_Geraet_Klasse_Geraet_Lichtfarbe]" wird erstellt...';


GO


CREATE PROCEDURE load_link_Geraet_Klasse_Geraet_Lichtfarbe as

TRUNCATE TABLE  link.Geraet_Klasse_Geraet_Lichtfarbe

INSERT INTO link.Geraet_Klasse_Geraet_Lichtfarbe (Geraet_Klasse_SK,Geraet_Lichtfarbe_SK)

SELECT 

	Geraet_Klasse_SK
	,Geraet_Lichtfarbe_SK


FROM hub.Geraet_Klasse
CROSS JOIN hub.Geraet_Lichtfarbe
GO
PRINT N'Prozedur "[dbo].[load_link_Geraet_Laenge_Geraet_Lumenpaket]" wird erstellt...';


GO

  CREATE PROCEDURE [dbo].[load_link_Geraet_Laenge_Geraet_Lumenpaket] as

  TRUNCATE TABLE link.Geraet_Laenge_Geraet_Lumenpaket
  INSERT INTO link.Geraet_Laenge_Geraet_Lumenpaket (Geraet_Laenge_SK,Geraet_Lumenpaket_SK)

  SELECT * FROM (VALUES

		(1,1),
		(2,1),
		(3,1),
		(4,1),
		(1,2),
		(2,2),
		(3,2),
		(4,2),
		(1,3),
		(2,3),
		(3,3),
		(4,3),
		(5,3)
	)t (Geraet_Laenge_SK,Geraet_Lumenpaket_SK)
GO
PRINT N'Prozedur "[dbo].[load_link_Geraet_Lichtfarbe_Geraet_Schaltung]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Geraet_Lichtfarbe_Geraet_Schaltung] as

truncate table link.Geraet_Lichtfarbe_Geraet_Schaltung

insert into link.Geraet_Lichtfarbe_Geraet_Schaltung (Geraet_Lichtfarbe_SK,Geraet_Schaltung_SK)

SELECT 

	Geraet_Lichtfarbe_SK,
	Geraet_Schaltung_SK

FROM (VALUES

(1,1), --830 Schaltbar
(2,1), --840 Schaltbar
(1,2), -- 830 Dali
(2,2) -- 840 Dali


)t (Geraet_Lichtfarbe_SK , Geraet_Schaltung_SK)
GO
PRINT N'Prozedur "[dbo].[load_link_Geraet_Schaltung_Geraet_Laenge]" wird erstellt...';


GO


CREATE PROCEDURE load_link_Geraet_Schaltung_Geraet_Laenge as

TRUNCATE TABLE link.Geraet_Schaltung_Geraet_Laenge
INSERT INTO link.Geraet_Schaltung_Geraet_Laenge (Geraet_Schaltung_SK,Geraet_Laenge_SK)
SELECT 

		Geraet_Schaltung_SK
	,	Geraet_Laenge_SK


FROM hub.Geraet_Schaltung h1
INNER JOIN hub.Geraet_Laenge  h2 ON h1.Schaltung = h2.Schaltung
GO
PRINT N'Prozedur "[dbo].[load_link_Lichtrichtung_Optik_Klasse]" wird erstellt...';


GO

CREATE PROCEDURE load_link_Lichtrichtung_Optik_Klasse as


TRUNCATE TABLE link.Lichtrichtung_Optik_Klasse
INSERT INTO link.Lichtrichtung_Optik_Klasse (Lichtrichtung_SK,Optik_Klasse_SK)
SELECT 

		Lichtrichtung_SK
	,	Optik_Klasse_SK

FROM hub.Lichtrichtung
CROSS JOIN hub.Optik_Klasse
GO
PRINT N'Prozedur "[dbo].[load_link_Montage_Geraet_Klasse]" wird erstellt...';


GO



CREATE PROCEDURE load_link_Montage_Geraet_Klasse as 

TRUNCATE TABLE link.Montage_Geraet_Klasse
INSERT INTO link.Montage_Geraet_Klasse (Montage_SK,Geraet_Klasse_SK)
SELECT 
		Montage_SK
	,	Geraet_Klasse_SK


FROM hub.Montage
CROSS JOIN hub.Geraet_Klasse
GO
PRINT N'Prozedur "[dbo].[load_link_Montage_Lichtrichtung]" wird erstellt...';


GO


CREATE PROCEDURE load_link_Montage_Lichtrichtung as 

TRUNCATE TABLE link.Montage_Lichtrichtung
INSERT INTO link.Montage_Lichtrichtung (montage_SK,Lichtrichtung_SK)
SELECT * FROM (VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(5,2)

)t (montage_SK, Lichtrichtung_SK)
GO
PRINT N'Prozedur "[dbo].[load_link_Montage_Produkt_Klasse]" wird erstellt...';


GO

CREATE PROCEDURE [dbo].[load_link_Montage_Produkt_Klasse] as

truncate table link.Montage_Produkt_Klasse

insert into link.Montage_Produkt_Klasse (Montage_SK,Produkt_Klasse_SK)

SELECT 

	Montage_SK,
	Produkt_Klasse_SK

FROM hub.Montage
CROSS JOIN hub.Produkt_Klasse
GO
PRINT N'Prozedur "[dbo].[load_link_Montage_Profil_Zubehoer_Klasse]" wird erstellt...';


GO

CREATE PROCEDURE [dbo].[load_link_Montage_Profil_Zubehoer_Klasse] as

TRUNCATE TABLE [link].[Montage_Profil_Zubehoer_Klasse]

INSERT INTO [link].[Montage_Profil_Zubehoer_Klasse] (Montage_SK, Profil_Zubehoer_Klasse_SK)



SELECT  * FROM (VALUES


(1,1),
(1,2),
(1,3),
(1,4),
(2,1),
(2,2),
(2,3),
(2,5),
(3,1),
(3,2),
(3,3),
(4,1),
(4,2),
(4,3),
(4,7),
(4,8),
(4,9),
(4,10),
(4,11),
(4,12),
(5,1),
(5,2),
(5,3),
(5,7),
(5,8),
(5,9),
(5,10),
(5,11),
(5,12)

) t (Montage_SK,Profil_Zubehoer_Klasse_SK)
GO
PRINT N'Prozedur "[dbo].[load_link_Optik_Klasse_Produkt_Klasse]" wird erstellt...';


GO

CREATE PROCEDURE [dbo].[load_link_Optik_Klasse_Produkt_Klasse] as

TRUNCATE TABLE link.Optik_Klasse_Produkt_Klasse
INSERT INTO  link.Optik_Klasse_Produkt_Klasse (Optik_KLasse_SK, Produkt_Klasse_SK) 
SELECT 
		Optik_KLasse_SK
	,	Produkt_Klasse_SK

FROM hub.Optik_KLasse 
CROSS JOIN hub.Produkt_Klasse
GO
PRINT N'Prozedur "[dbo].[load_link_Optik_Klasse_Profil_Laenge]" wird erstellt...';


GO

CREATE PROCEDURE load_link_Optik_Klasse_Profil_Laenge as

TRUNCATE TABLE link.Optik_Klasse_Profil_Laenge

INSERT INTO link.Optik_Klasse_Profil_Laenge
SELECT
	
			Optik_Klasse_SK
		,	Profil_laenge_SK


FROM hub.Optik_Klasse
CROSS JOIN hub.Profil_laenge
GO
PRINT N'Prozedur "[dbo].[load_link_Produkt_Klasse_Profil_Farbe]" wird erstellt...';


GO


CREATE PROCEDURE [dbo].[load_link_Produkt_Klasse_Profil_Farbe] as

truncate table link.Produkt_Klasse_Profil_Farbe

insert into link.Produkt_Klasse_Profil_Farbe (Produkt_Klasse_SK,Profil_Farbe_SK)

SELECT 

		Produkt_Klasse_SK
	,	Profil_Farbe_SK

FROM hub.Produkt_Klasse
CROSS JOIN hub.Profil_Farbe
GO
PRINT N'Prozedur "[dbo].[load_link_Produkt_Klasse_Profil_Laenge]" wird erstellt...';


GO

CREATE PROCEDURE [dbo].[load_link_Produkt_Klasse_Profil_Laenge] as

truncate table link.Produkt_Klasse_Profil_Laenge

insert into link.Produkt_Klasse_Profil_Laenge (Produkt_Klasse_SK,Profil_Laenge_SK)

SELECT 

	 Produkt_Klasse_SK
	,Profil_Laenge_SK

FROM hub.Produkt_Klasse
CROSS JOIN hub.Profil_Laenge
GO
PRINT N'Prozedur "[dbo].[load_link_Produkt_Klasse_Profil_Richtung]" wird erstellt...';


GO

CREATE PROCEDURE load_link_Produkt_Klasse_Profil_Richtung as

TRUNCATE TABLE link.Produkt_Klasse_Profil_Richtung
INSERT INTO link.Produkt_Klasse_Profil_Richtung (Produkt_Klasse_SK,Profil_Richtung_SK)
SELECT 
		Produkt_Klasse_SK
	,	Profil_Richtung_SK

FROM hub.Produkt_Klasse
CROSS JOIN hub.Profil_Richtung
GO
PRINT N'Prozedur "[dbo].[load_link_Profil_Farbe_Profil_Zubehoer_Klasse]" wird erstellt...';


GO

CREATE PROCEDURE load_link_Profil_Farbe_Profil_Zubehoer_Klasse as

TRUNCATE TABLE [link].[Profil_Farbe_Profil_Zubehoer_Klasse]

INSERT INTO [link].[Profil_Farbe_Profil_Zubehoer_Klasse] (Profil_Farbe_SK, Profil_Zubehoer_Klasse_SK)
SELECT  

	Profil_Farbe_SK
	,Profil_Zubehoer_Klasse_SK




FROM hub.Profil_Farbe
CROSS JOIN hub.Profil_Zubehoer_Klasse
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update abgeschlossen.';


GO
