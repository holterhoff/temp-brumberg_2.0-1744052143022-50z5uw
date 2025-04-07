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
PRINT N'Prozedur "[dbo].[load_sat_Melody_Stehleuchte_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Melody_Stehleuchte_Stammdaten] as

TRUNCATE TABLE sat.Melody_Stehleuchte_Stammdaten

INSERT INTO sat.Melody_Stehleuchte_Stammdaten (Melody_SK, Lichtstrom_Gesamt, Systemleistung_Watt , Systemeffizienz_lm_Watt, Farbwiedergabeindex, Laenge, Breite, Hoehe, Durchmesser, Website, Produktbeschreibung) 
SELECT * FROM (VALUES

('1', '7600', '60', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77411174ms/', ''),
	('2', '15200', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77412174ms/', ''),
	('3', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77422174ms/', ''),
	('4', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77432174ms/', ''),
	('5', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77442174ms/', ''),
	('6', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77413174ms/', ''),
	('7', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77423174ms/', ''),
	('8', '30400', '240', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77414174ms/', ''),
	('9', '7600', '60', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77411184ms/', ''),
	('10', '15200', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77412184ms/', ''),
	('11', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77422184ms/', ''),
	('12', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77432184ms/', ''),
	('13', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77442184ms/', ''),
	('14', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77413184ms/', ''),
	('15', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77423184ms/', ''),
	('16', '30400', '240', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77414184ms/', ''),
	('17', '7600', '60', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77411694ms/', ''),
	('18', '15200', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77412694ms/', ''),
	('19', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77422694ms/', ''),
	('20', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77432694ms/', ''),
	('21', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77442694ms/', ''),
	('22', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77413694ms/', ''),
	('23', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77423694ms/', ''),
	('24', '30400', '240', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77414694ms/', ''),
	('25', '7600', '60', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77411174st/', ''),
	('26', '15200', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77412174st/', ''),
	('27', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77422174st/', ''),
	('28', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77432174st/', ''),
	('29', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77442174st/', ''),
	('30', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77413174st/', ''),
	('31', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77423174st/', ''),
	('32', '30400', '240', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77414174st/', ''),
	('33', '7600', '60', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77411184st/', ''),
	('34', '15200', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77412184st/', ''),
	('35', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77422184st/', ''),
	('36', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77432184st/', ''),
	('37', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77442184st/', ''),
	('38', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77413184st/', ''),
	('39', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77423184st/', ''),
	('40', '30400', '240', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77414184st/', ''),
	('41', '7600', '60', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77411694st/', ''),
	('42', '15200', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77412694st/', ''),
	('43', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77422694st/', ''),
	('44', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77432694st/', ''),
	('45', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77442694st/', ''),
	('46', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77413694st/', ''),
	('47', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77423694st/', ''),
	('48', '30400', '240', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77414694st/', ''),
	('49', '7600', '60', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77411174ai/', ''),
	('50', '15200', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77412174ai/', ''),
	('51', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77422174ai/', ''),
	('52', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77432174ai/', ''),
	('53', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77442174ai/', ''),
	('54', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77413174ai/', ''),
	('55', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77423174ai/', ''),
	('56', '30400', '240', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77414174ai/', ''),
	('57', '7600', '60', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77411184ai/', ''),
	('58', '15200', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77412184ai/', ''),
	('59', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77422184ai/', ''),
	('60', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77432184ai/', ''),
	('61', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77442184ai/', ''),
	('62', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77413184ai/', ''),
	('63', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77423184ai/', ''),
	('64', '30400', '240', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77414184ai/', ''),
	('65', '7600', '60', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77411694ai/', ''),
	('66', '15200', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77412694ai/', ''),
	('67', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77422694ai/', ''),
	('68', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77432694ai/', ''),
	('69', '22800', '120', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77442694ai/', ''),
	('70', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77413694ai/', ''),
	('71', '22800', '180', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77423694ai/', ''),
	('72', '30400', '240', '126', 'CRI >90', '', '', '', '', 'https://www.brumberg.com/de/produkte/melody-led-stehleuchte-nano-prismatische-abdeckung-mit-indirektanteil-77414694ai/', '' )



)t (Melody_SK, Lichtstrom_Gesamt, Systemleistung_Watt , Systemeffizienz_lm_Watt, Farbwiedergabeindex, Laenge, Breite, Hoehe, Durchmesser, Website, Produktbeschreibung)
GO
PRINT N'Update abgeschlossen.';


GO
