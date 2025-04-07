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
PRINT N'Tabelle "[sat].[Biro40_Leuchte_Laengen_MA]" wird erstellt...';


GO
CREATE TABLE [sat].[Biro40_Leuchte_Laengen_MA] (
    [Leuchte_SK] INT NOT NULL,
    [Min]        INT NOT NULL,
    [Max]        INT NOT NULL,
    [Step]       INT NOT NULL,
    [Toleranz]   INT NOT NULL,
    [Abzug]      INT NOT NULL
);


GO
PRINT N'Prozedur "[dbo].[sat_hub_Biro40_Leuchte_Artikel_MA]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_hub_Biro40_Leuchte_Artikel_MA] as

TRUNCATE TABLE sat.Biro40_Leuchte_Artikel_MA;

WITH cte as
(
	SELECT Leuchte_SK, [min] , [step], [max], [min] as newval  FROM sat.Biro40_Leuchte_Laengen

	UNION ALL

	SELECT Leuchte_SK, [min] , [step], [max],  newval + [step] from cte
	WHERE newval < [max]

)
INSERT INTO sat.Biro40_Leuchte_Artikel_MA (Leuchte_SK, Mass, Artikelnummer)
SELECT Leuchte_SK, newval as Mass, NULL AS Artikelnummer  FROM cte

order by Leuchte_SK, Mass
GO
PRINT N'Update abgeschlossen.';


GO
