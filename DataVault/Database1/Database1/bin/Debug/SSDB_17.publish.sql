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
PRINT N'Tabelle "[link].[Biro40_Leuchte__Profil]" wird erstellt...';


GO
CREATE TABLE [link].[Biro40_Leuchte__Profil] (
    [Leuchte_SK] INT NOT NULL,
    [Profil_SK]  INT NOT NULL
);


GO
PRINT N'Tabelle "[sat].[Biro40_Optik_Laengen]" wird erstellt...';


GO
CREATE TABLE [sat].[Biro40_Optik_Laengen] (
    [Leuchte_SK] INT NOT NULL,
    [Min]        INT NOT NULL,
    [Max]        INT NOT NULL,
    [Step]       INT NOT NULL,
    [Ecke]       INT NOT NULL,
    [Toleranz]   INT NOT NULL,
    [Abzug]      INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Biro40_Profil_Laengen]" wird erstellt...';


GO
CREATE TABLE [sat].[Biro40_Profil_Laengen] (
    [Leuchte_SK] INT NOT NULL,
    [Min]        INT NOT NULL,
    [Max]        INT NOT NULL,
    [Step]       INT NOT NULL,
    [Ecke]       INT NOT NULL,
    [Toleranz]   INT NOT NULL,
    [Abzug]      INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Prozedur "[dbo].[load_link_Biro40_Leuchte__Profil]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Biro40_Leuchte__Profil] as

TRUNCATE TABLE link.Biro40_Leuchte__Profil

INSERT INTO link.Biro40_Leuchte__Profil(Leuchte_SK, Profil_SK)

select 

		h1.Leuchte_SK
	,	h2.Profil_SK

from hub.Biro40_Leuchte h1
INNER JOIN hub.Biro40_Profil h2 ON h1.Leuchtentyp = h2.Leuchtentyp AND h1.Lichtrichtung = h2.Lichtrichtung
GO
PRINT N'Update abgeschlossen.';


GO
