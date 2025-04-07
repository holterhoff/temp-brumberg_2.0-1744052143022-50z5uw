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
/*
Der Typ von Spalte "Nettogewicht" in Tabelle "[sat].[Spot_Treiber_Stammdaten]" lautet aktuell " VARCHAR (50) NULL", wird aber in " DECIMAL (5, 2) NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " DECIMAL (5, 2) NULL" kompatibel sind.

Der Typ von Spalte "Preis" in Tabelle "[sat].[Spot_Treiber_Stammdaten]" lautet aktuell " VARCHAR (50) NOT NULL", wird aber in " DECIMAL (5, 2) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " DECIMAL (5, 2) NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [sat].[Spot_Treiber_Stammdaten])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Tabelle "[sat].[Spot_Treiber_Stammdaten]" wird geändert...';


GO
ALTER TABLE [sat].[Spot_Treiber_Stammdaten] ALTER COLUMN [Nettogewicht] DECIMAL (5, 2) NULL;

ALTER TABLE [sat].[Spot_Treiber_Stammdaten] ALTER COLUMN [Preis] DECIMAL (5, 2) NOT NULL;


GO
PRINT N'Sicht "[fakt].[Spot]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[fakt].[Spot]';


GO
PRINT N'Prozedur "[dbo].[load_sat_Spot_Treiber_Stammdaten]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_sat_Spot_Treiber_Stammdaten] as

TRUNCATE TABLE sat.Spot_Treiber_Stammdaten

INSERT INTO sat.Spot_Treiber_Stammdaten (Treiber_SK, [Image], Produktbeschreibung, SEO_Url, Artikelnummer, Preis, Nettogewicht, Laenge, Breite, Hoehe, K_Prüfzeichen, [Offline], Aussendurchmesser, Leistungsfaktor)
SELECT * FROM (VALUES

  ('1', '17666000.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Maximale Leitungslänge sekundärseitig: 2.000 mm. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 5W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17666000', '17666000', '38.6', '0.045', '52', '30', '23', 'ENEC 15', 'Online', '', ''),
	('2', '17662000.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7.2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17662000', '17662000', '31.5', '0.038', '68', '35', '21', 'ENEC 15', 'Online', '', ''),
	('3', '17662010.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7.2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17662010', '17662010', '28', '0.033', '68', '35', '21', 'ENEC 15', 'Online', '', ''),
	('4', '17662020.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7.2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17662020', '17662020', '41.5', '0.078', '68', '35', '21', 'ENEC 15', 'Online', '', ''),
	('5', '17613000.jpg', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17613000', '17613000', '56.9', '0.067', '115', '34', '19', 'ENEC 05, MM', 'Online', '', ''),
	('6', '17613010.jpg', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17613010', '17613010', '47.9', '0.062', '115', '34', '19', 'ENEC 05, MM', 'Online', '', ''),
	('7', '17613020.jpg', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17613020', '17613020', '62.9', '0.107', '115', '34', '19', 'ENEC 05, MM', 'Online', '', ''),
	('8', '17621000.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17621000', '17621000', '59.9', '0.076', '128', '50', '13', 'ENEC 17, MM', 'Online', '', ''),
	('9', '17621010.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17621010', '17621010', '54.9', '0.072', '128', '50', '13', 'ENEC 17, MM', 'Online', '', ''),
	('10', '17621020.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17621020', '17621020', '65.9', '0.117', '128', '50', '13', 'ENEC 17, MM', 'Online', '', ''),
	('11', '17663000.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17663000', '17663000', '36.6', '0.059', '110', '50', '19', 'ENEC 05', 'Online', '', ''),
	('12', '17663010.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17663010', '17663010', '34.3', '0.054', '110', '50', '19', 'ENEC 05', 'Online', '', ''),
	('13', '17663020.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17663020', '17663020', '45.5', '0.1', '110', '50', '19', 'ENEC 05', 'Online', '', ''),
	('14', '17652000.jpg', 'LED-Rundkonverter 350 mA, Phasenabschnitt dimmbar. Ausführung: Plug&Play, Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-phasenabschnitt-dimmbar-17652000', '17652000', '52.9', '0.047', '', '', '24', '', 'Online', '51', ''),
	('15', '17652020.jpg', 'LED-Rundkonverter 350 mA, Phasenabschnitt dimmbar. Ausführung: Plug&Play, Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-phasenabschnitt-dimmbar-17652020', '17652020', '59.9', '0.087', '', '', '24', '', 'Online', '51', ''),
	('16', '17640000.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17640000', '17640000', '49.9', '0.073', '102', '38', '21', 'MM', 'Online', '', '0,95'),
	('17', '17640010.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17640010', '17640010', '46.9', '0.069', '102', '38', '21', 'MM', 'Online', '', '0,95'),
	('18', '17640020.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17640020', '17640020', '57.9', '0.112', '102', '38', '21', 'MM', 'Online', '', '0,95'),
	('19', '17664000.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17664000', '17664000', '52.4', '0.07', '125', '51', '20', 'ENEC 05', 'Online', '', ''),
	('20', '17664010.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17664010', '17664010', '49.9', '0.065', '125', '51', '20', 'ENEC 05', 'Online', '', ''),
	('21', '17664020.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17664020', '17664020', '62.3', '0.11', '125', '51', '20', 'ENEC 05', 'Online', '', ''),
	('22', '17643000.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17643000', '17643000', '51.9', '0.11', '110', '52', '22', 'ENEC 05, MM', 'Online', '', '0,95'),
	('23', '17643010.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17643010', '17643010', '48.9', '0.106', '110', '52', '22', 'ENEC 05, MM', 'Online', '', '0,95'),
	('24', '17643020.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17643020', '17643020', '59.9', '0.151', '110', '52', '22', 'ENEC 05, MM', 'Online', '', '0,95'),
	('25', '17648000.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17648000', '17648000', '119.9', '0.183', '166', '46', '34', 'ENEC 05, MM', 'Online', '', '0,97'),
	('26', '17648010.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17648010', '17648010', '117.9', '0.179', '166', '46', '34', 'ENEC 05, MM', 'Online', '', '0,97'),
	('27', '17648020.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17648020', '17648020', '129.9', '0.223', '166', '46', '34', 'ENEC 05, MM', 'Online', '', '0,97'),
	('28', '17657000.jpg', 'LED-Konverter 350 mA, 1-10 V dimmbar (analog). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 18W, Art der Dimmung: 1-10 V.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-1-10-v-dimmbar-analog-die-neue-konverter-generation-17657000', '17657000', '78.9', '0.112', '110', '52', '22', 'ENEC 05, MM', 'Online', '', '0,95'),
	('29', '17657010.jpg', 'LED-Konverter 350 mA, 1-10 V dimmbar (analog). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 18W, Art der Dimmung: 1-10 V.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-1-10-v-dimmbar-analog-die-neue-konverter-generation-17657010', '17657010', '76.9', '0.108', '110', '52', '22', 'ENEC 05, MM', 'Online', '', '0,95'),
	('30', '17683000.jpg', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 17W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-die-neue-konverter-generation-17683000', '17683000', '93.3', '0.112', '110', '52', '22', 'ENEC 05, MM', 'Online', '', ''),
	('31', '17683010.jpg', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 17W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-die-neue-konverter-generation-17683010', '17683010', '88.3', '0.107', '110', '52', '22', 'ENEC 05, MM', 'Online', '', ''),
	('32', '17683020.jpg', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 17W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-die-neue-konverter-generation-17683020', '17683020', '97.7', '0.176', '110', '52', '22', 'ENEC 05, MM', 'Online', '', ''),
	('33', '17684000.jpg', 'LED-Konverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 7W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-17684000', '17684000', '81.2', '0.086', '130', '42', '22', 'ENEC 05', 'Online', '', ''),
	('34', '17684010.jpg', 'LED-Konverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 7W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-17684010', '17684010', '75.9', '0.082', '130', '42', '22', 'ENEC 05', 'Online', '', ''),
	('35', '17684020.jpg', 'LED-Konverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 7W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-17684020', '17684020', '86.3', '0.104', '130', '42', '22', 'ENEC 05', 'Online', '', ''),
	('36', '17658000.jpg', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658000', '17658000', '109.9', '0.07', '', '', '25', '', 'Online', '56', ''),
	('37', '17658010.jpg', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658010', '17658010', '108.9', '0.07', '', '', '25', '', 'Online', '56', ''),
	('38', '17658020.jpg', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658020', '17658020', '117.9', '0.085', '', '', '25', '', 'Online', '56', ''),
	('39', '17671000.jpg', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18.5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-17671000', '17671000', '197.5', '0.159', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95'),
	('40', '17671010.jpg', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18.5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-17671010', '17671010', '187.1', '0.155', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95'),
	('41', '17671020.jpg', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18.5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-17671020', '17671020', '207.9', '0.198', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95'),
	('42', '17672000.jpg', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-17672000', '17672000', '239.1', '0.159', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95'),
	('43', '17672010.jpg', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-17672010', '17672010', '233.9', '0.198', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95'),
	('44', '17672020.jpg', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-17672020', '17672020', '244.3', '0.17', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95')

)t (Treiber_SK, [Image], Produktbeschreibung, SEO_Url, Artikelnummer, Preis, Nettogewicht, Laenge, Breite, Hoehe, K_Prüfzeichen, [Offline], Aussendurchmesser, Leistungsfaktor)
GO
PRINT N'Prozedur "[dbo].[load_hub_Spot_Treiber]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_Spot_Treiber] as

TRUNCATE TABLE hub.Spot_Treiber

INSERT INTO hub.Spot_Treiber (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)

SELECT * FROM (VALUES


('MR16', 'LED-Konverter', 'Plug&Play', 'schaltbar', '350mA', '1', '5'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'schaltbar', '350mA', '1', '7.2'),
	('MR16', 'LED-Konverter', 'ohne', 'schaltbar', '350mA', '1', '7.2'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'schaltbar', '350mA', '1', '7.2'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'schaltbar', '350mA', '1', '15'),
	('MR16', 'LED-Konverter', 'ohne', 'schaltbar', '350mA', '1', '15'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'schaltbar', '350mA', '1', '15'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'schaltbar', '350mA', '1', '21'),
	('MR16', 'LED-Konverter', 'ohne', 'schaltbar', '350mA', '1', '21'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'schaltbar', '350mA', '1', '21'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt', '350mA', '2.8', '7'),
	('MR16', 'LED-Konverter', 'ohne', 'Phasenabschnitt', '350mA', '2.8', '7'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt', '350mA', '2.8', '7'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt', '350mA', '4.9', '7'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt', '350mA', '4.9', '7'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt', '350mA', '4.2', '10'),
	('MR16', 'LED-Konverter', 'ohne', 'Phasenabschnitt', '350mA', '4.2', '10'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt', '350mA', '4.2', '10'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt', '350mA', '10.2', '14'),
	('MR16', 'LED-Konverter', 'ohne', 'Phasenabschnitt', '350mA', '10.2', '14'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt', '350mA', '10.2', '14'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt', '350mA', '8.8', '18'),
	('MR16', 'LED-Konverter', 'ohne', 'Phasenabschnitt', '350mA', '8.8', '18'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt', '350mA', '8.8', '18'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt', '350mA', '0.7', '17'),
	('MR16', 'LED-Konverter', 'ohne', 'Phasenabschnitt', '350mA', '0.7', '17'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt', '350mA', '0.7', '17'),
	('MR16', 'LED-Konverter', 'Plug&Play', '1-10 V', '350mA', '5.2', '18'),
	('MR16', 'LED-Konverter', 'ohne', '1-10 V', '350mA', '5.2', '18'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'DALI-2', '350mA', '3.5', '17'),
	('MR16', 'LED-Konverter', 'ohne', 'DALI-2', '350mA', '3.5', '17'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'DALI-2', '350mA', '3.5', '17'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'DALI-2', '350mA', '2.8', '7'),
	('MR16', 'LED-Konverter', 'ohne', 'DALI-2', '350mA', '2.8', '7'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'DALI-2', '350mA', '2.8', '7'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'DALI, PUSH-Dimm', '350mA', '2.1', '9'),
	('MR16', 'LED-Konverter', 'ohne', 'DALI, PUSH-Dimm', '350mA', '2.1', '9'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'DALI, PUSH-Dimm', '350mA', '2.1', '9'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'ZigBee', '350mA', '3.5', '18.5'),
	('MR16', 'LED-Konverter', 'ohne', 'ZigBee', '350mA', '3.5', '18.5'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'ZigBee', '350mA', '3.5', '18.5'),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Casambi-Push', '350mA', '3.5', '18'),
	('MR16', 'LED-Konverter', 'ohne', 'Casambi-Push', '350mA', '3.5', '18'),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Casambi-Push', '350mA', '3.5', '18')




)t (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)
GO
PRINT N'Update abgeschlossen.';


GO
