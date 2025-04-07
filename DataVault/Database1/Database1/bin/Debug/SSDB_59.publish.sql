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
PRINT N'Prozedur "[dbo].[load_hub_Melody_Stehleuchte]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Melody_Stehleuchte] as

TRUNCATE TABLE hub.Melody_Stehleuchte

INSERT INTO hub.Melody_Stehleuchte (Hersteller, Leuchtenfamilie, Variante, Leuchtentyp, Gehaeusefarbe, Gehaeuseform, Montageart, Optik, Lichtrichtung, Lichtfarbe, Schaltungsart)
SELECT * FROM (VALUES


  ('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK und TASTER'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'WEISS', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SCHWARZ', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '1-KOPF STANDARD (7600 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF PARALLEL (15200 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF LINEAR (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '2-KOPF DIAGONAL RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF RECHTS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '3-KOPF LINKS (22800 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP'),
	('BRUMBERG', 'MELODY', 'MELODY STEHLEUCHTE', '4-KOPF STANDARD (30400 lm)', 'SILBER', 'KONSTRUKTION', 'BODEN', 'Nanoprismen (direkt) / Mikroprismen (indirekt)', 'Direkt / Indirekt', '4000 K', 'MIT SENSORIK, TASTER und APP')



)t (Hersteller, Leuchtenfamilie, Leuchtentyp, Gehaeusefarbe, Gehaeuseform, Montageart, Optik, Lichtrichtung, Lichtfarbe, Schaltungsart)
GO
PRINT N'Update abgeschlossen.';


GO
