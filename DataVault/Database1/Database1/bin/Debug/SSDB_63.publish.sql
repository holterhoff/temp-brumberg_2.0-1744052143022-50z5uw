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
PRINT N'Prozedur "[dbo].[load_sat_Melody_Stehleuchte_Artikel]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Melody_Stehleuchte_Artikel] as

TRUNCATE TABLE sat.Melody_Stehleuchte_Artikel

INSERT INTO sat.Melody_Stehleuchte_Artikel (Melody_SK, Artikelnummer, Preis)
SELECT * FROM (VALUES
  ('1', '77411174MS', '1829'),
	('2', '77412174MS', '2999'),
	('3', '77422174MS', '2999'),
	('4', '77432174MS', '2999'),
	('5', '77442174MS', '2999'),
	('6', '77413174MS', '4099'),
	('7', '77423174MS', '4099'),
	('8', '77414174MS', '5199'),
	('9', '77411184MS', '1829'),
	('10', '77412184MS', '2999'),
	('11', '77422184MS', '2999'),
	('12', '77432184MS', '2999'),
	('13', '77442184MS', '2999'),
	('14', '77413184MS', '4099'),
	('15', '77423184MS', '4099'),
	('16', '77414184MS', '5199'),
	('17', '77411694MS', '1829'),
	('18', '77412694MS', '2999'),
	('19', '77422694MS', '2999'),
	('20', '77432694MS', '2999'),
	('21', '77442694MS', '2999'),
	('22', '77413694MS', '4099'),
	('23', '77423694MS', '4099'),
	('24', '77414694MS', '5199'),
	('25', '77411174ST', '1949'),
	('26', '77412174ST', '3249'),
	('27', '77422174ST', '3249'),
	('28', '77432174ST', '3249'),
	('29', '77442174ST', '3249'),
	('30', '77413174ST', '4479'),
	('31', '77423174ST', '4479'),
	('32', '77414174ST', '5699'),
	('33', '77411184ST', '1949'),
	('34', '77412184ST', '3249'),
	('35', '77422184ST', '3249'),
	('36', '77432184ST', '3249'),
	('37', '77442184ST', '3249'),
	('38', '77413184ST', '4479'),
	('39', '77423184ST', '4479'),
	('40', '77414184ST', '5699'),
	('41', '77411694ST', '1949'),
	('42', '77412694ST', '3249'),
	('43', '77422694ST', '3249'),
	('44', '77432694ST', '3249'),
	('45', '77442694ST', '3249'),
	('46', '77413694ST', '4479'),
	('47', '77423694ST', '4479'),
	('48', '77414694ST', '5699'),
	('49', '77411174AI', '2049'),
	('50', '77412174AI', '3439'),
	('51', '77422174AI', '3439'),
	('52', '77432174AI', '3439'),
	('53', '77442174AI', '3439'),
	('54', '77413174AI', '4769'),
	('55', '77423174AI', '4769'),
	('56', '77414174AI', '6099'),
	('57', '77411184AI', '2049'),
	('58', '77412184AI', '3439'),
	('59', '77422184AI', '3439'),
	('60', '77432184AI', '3439'),
	('61', '77442184AI', '3439'),
	('62', '77413184AI', '4769'),
	('63', '77423184AI', '4769'),
	('64', '77414184AI', '6099'),
	('65', '77411694AI', '2049'),
	('66', '77412694AI', '3439'),
	('67', '77422694AI', '3439'),
	('68', '77432694AI', '3439'),
	('69', '77442694AI', '3439'),
	('70', '77413694AI', '4769'),
	('71', '77423694AI', '4769'),
	('72', '77414694AI', '6099')


)t (Melody_SK, Artikelnummer, Preis)
GO
PRINT N'Update abgeschlossen.';


GO
