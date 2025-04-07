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
PRINT N'Tabelle "[sat].[Melody_Stehleuchte_Stammdaten]" wird geändert...';


GO
ALTER TABLE [sat].[Melody_Stehleuchte_Stammdaten] ALTER COLUMN [Produktbeschreibung] NVARCHAR (MAX) NULL;

ALTER TABLE [sat].[Melody_Stehleuchte_Stammdaten] ALTER COLUMN [Website] NVARCHAR (250) NULL;


GO
PRINT N'Prozedur "[dbo].[load_sat_Melody_Stehleuchte_Artikel]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_sat_Melody_Stehleuchte_Artikel] as

TRUNCATE TABLE sat.Melody_Stehleuchte_Artikel

INSERT INTO sat.Melody_Stehleuchte_Artikel (Melody_SK, Artikelnummer, Preis)
SELECT * FROM (VALUES
  ('1', '77411174MS',  '1829.0'),
	('2', '77412174MS',  '2999.0'),
	('3', '77422174MS',  '2999.0'),
	('4', '77432174MS',  '2999.0'),
	('5', '77442174MS',  '2999.0'),
	('6', '77413174MS',  '4099.0'),
	('7', '77423174MS',  '4099.0'),
	('8', '77414174MS',  '5199.0'),
	('9', '77411184MS',  '1829.0'),
	('10', '77412184MS', '2999.0'),
	('11', '77422184MS', '2999.0'),
	('12', '77432184MS', '2999.0'),
	('13', '77442184MS', '2999.0'),
	('14', '77413184MS', '4099.0'),
	('15', '77423184MS', '4099.0'),
	('16', '77414184MS', '5199.0'),
	('17', '77411694MS', '1829.0'),
	('18', '77412694MS', '2999.0'),
	('19', '77422694MS', '2999.0'),
	('20', '77432694MS', '2999.0'),
	('21', '77442694MS', '2999.0'),
	('22', '77413694MS', '4099.0'),
	('23', '77423694MS', '4099.0'),
	('24', '77414694MS', '5199.0'),
	('25', '77411174ST', '1949.0'),
	('26', '77412174ST', '3249.0'),
	('27', '77422174ST', '3249.0'),
	('28', '77432174ST', '3249.0'),
	('29', '77442174ST', '3249.0'),
	('30', '77413174ST', '4479.0'),
	('31', '77423174ST', '4479.0'),
	('32', '77414174ST', '5699.0'),
	('33', '77411184ST', '1949.0'),
	('34', '77412184ST', '3249.0'),
	('35', '77422184ST', '3249.0'),
	('36', '77432184ST', '3249.0'),
	('37', '77442184ST', '3249.0'),
	('38', '77413184ST', '4479.0'),
	('39', '77423184ST', '4479.0'),
	('40', '77414184ST', '5699.0'),
	('41', '77411694ST', '1949.0'),
	('42', '77412694ST', '3249.0'),
	('43', '77422694ST', '3249.0'),
	('44', '77432694ST', '3249.0'),
	('45', '77442694ST', '3249.0'),
	('46', '77413694ST', '4479.0'),
	('47', '77423694ST', '4479.0'),
	('48', '77414694ST', '5699.0'),
	('49', '77411174AI', '2049.0'),
	('50', '77412174AI', '3439.0'),
	('51', '77422174AI', '3439.0'),
	('52', '77432174AI', '3439.0'),
	('53', '77442174AI', '3439.0'),
	('54', '77413174AI', '4769.0'),
	('55', '77423174AI', '4769.0'),
	('56', '77414174AI', '6099.0'),
	('57', '77411184AI', '2049.0'),
	('58', '77412184AI', '3439.0'),
	('59', '77422184AI', '3439.0'),
	('60', '77432184AI', '3439.0'),
	('61', '77442184AI', '3439.0'),
	('62', '77413184AI', '4769.0'),
	('63', '77423184AI', '4769.0'),
	('64', '77414184AI', '6099.0'),
	('65', '77411694AI', '2049.0'),
	('66', '77412694AI', '3439.0'),
	('67', '77422694AI', '3439.0'),
	('68', '77432694AI', '3439.0'),
	('69', '77442694AI', '3439.0'),
	('70', '77413694AI', '4769.0'),
	('71', '77423694AI', '4769.0'),
	('72', '77414694AI', '6099.0')


)t (Melody_SK, Artikelnummer, Preis)
GO
PRINT N'Prozedur "[dbo].[load_sat_Melody_Stehleuchte_Stammdaten]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_sat_Melody_Stehleuchte_Stammdaten]';


GO
PRINT N'Update abgeschlossen.';


GO
