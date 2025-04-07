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
Die Spalte "[sat].[Spot_Treiber_Stammdaten].[Artikelnummer]" in der Tabelle "[sat].[Spot_Treiber_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Die Spalte "[sat].[Spot_Treiber_Stammdaten].[Preis]" in der Tabelle "[sat].[Spot_Treiber_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Der Typ von Spalte "Image" in Tabelle "[sat].[Spot_Treiber_Stammdaten]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (50) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (50) NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [sat].[Spot_Treiber_Stammdaten])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Der folgende Vorgang wird aus der Umgestaltungsprotokolldatei "4081b2fa-bd86-456d-84a9-1b6143178ba7" erstellt.';

PRINT N'"[sat].[Spot_Treiber_Stammdaten].[Website]" in "SEO_Url" umbenennen';


GO
EXECUTE sp_rename @objname = N'[sat].[Spot_Treiber_Stammdaten].[Website]', @newname = N'SEO_Url', @objtype = N'COLUMN';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "c131bf78-5e74-4fda-a864-86c016de97b0" wird übersprungen; das Element "[sat].[Spot_Treiber_Stammdaten].[Offlien]" (SqlSimpleColumn) wird nicht in "Offline" umbenannt.';


GO
PRINT N'Tabelle "[sat].[Spot_Treiber_Stammdaten]" wird geändert...';


GO
ALTER TABLE [sat].[Spot_Treiber_Stammdaten] ALTER COLUMN [Image] VARCHAR (50) NOT NULL;


GO
ALTER TABLE [sat].[Spot_Treiber_Stammdaten]
    ADD [Artikelnummer]     VARCHAR (50) NOT NULL,
        [Preis]             VARCHAR (50) NOT NULL,
        [Nettogewicht]      VARCHAR (50) NULL,
        [Laenge]            VARCHAR (50) NULL,
        [Breite]            VARCHAR (50) NULL,
        [Hoehe]             VARCHAR (50) NULL,
        [K_Prüfzeichen]     VARCHAR (50) NULL,
        [Offline]           VARCHAR (50) NULL,
        [Aussendurchmesser] VARCHAR (50) NULL,
        [Leistungsfaktor]   VARCHAR (50) NULL;


GO
PRINT N'Sicht "[fakt].[Spot]" wird geändert...';


GO






ALTER VIEW [fakt].[Spot] as 

select 

		h1.Leuchtentyp
	,	h1.Typ
	,	h1.Form
	,	h1.Farbe
	,	s1.Schutzart
	,	s1.Einbaudurchmesser	
	,	s1.Einbautiefe
	,	s1.Schwenkwinkel
	,	s1.Produktbeschreibung as Produktbeschreibung_Gehaeuse
	,	s1.Artikelnummer
	,	s1.Preis
	,	s1.Image as Gehaeuse_Image
	,	s1.SEO_Url
	,	h2.Lichtfarbe
	,	h2.Farbkanal
	,	h2.Lichtstrom
	,	h2.Leistung
	,	h2.Abstrahlwinkel
	,	S2.Artikelnummer as Artikelnummer_LED
	,	S2.Preis as Preis_LED
	,	s2.Image as Leuchten_Image
	,	s2.Produktbeschreibung as Produktbeschreibung_LED
	,	CONCAT(h3.Beschreibung,' ', h3.Versorgung) as Treiber
	,	h3.Beschreibung
	,	h3.Versorgung
	,	h3.Ansteuerung
	,	CONCAT(UPPER(h3.Ansteuerung), ' - ', (h3.Leistung_Min), 'W', ' ... ' , (h3.Leistung_Max), 'W') as Ansteuerung2
	,	h3.Ausführung
	,	s3.Image as Treiber_Image
	,	s3.Produktbeschreibung as Produktbeschreibung_Treiber
	,	h3.Leistung_Min
	,	h3.Leistung_Max
	,	s3.Artikelnummer as Artikelnummer_Treiber
	,	s3.Preis as Preis_Treiber
	,	CASE WHEN CEILING(h3.Leistung_Min / h2.Leistung) = 0 THEN 1  ELSE CEILING(h3.Leistung_Min / h2.Leistung) END as Min_Anzahl
	,	Max_Anzahl = FLOOR(h3.Leistung_Max / h2.Leistung)

	,	Lampenplatz = 1




 from hub.Spot_Gehaeuse h1
 INNER JOIN sat.Spot_Gehaeuse_Stammdaten s1 ON h1.Gehaeuse_SK = s1.Gehaeuse_SK
 INNER JOIN Link.Spot_Gehaeuse__Leuchte l1 ON h1.Gehaeuse_SK = l1.Gehaeuse_SK
 INNER JOIN hub.Spot_Leuchte h2 ON h2.Leuchte_SK = l1.Leuchte_SK
 INNER JOIN sat.Spot_Leuchte_Stammdaten s2 ON s2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN link.Spot_Leuchte__Treiber l2 ON l2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN hub.Spot_Treiber h3 ON l2.Treiber_SK = h3.Treiber_SK
 INNER JOIN sat.Spot_Treiber_Stammdaten s3 ON h3.Treiber_SK = s3.Treiber_SK

--where 1=1
----- Gehäuse
--and typ = '1964'
--and Farbe = 'chrom'
--
---- LED
--and Farbkanal = 'Statisch'
--and Lichtfarbe = '2700 K'
--And h2.Leistung = 3.00
--
---- Treiber
--and Ansteuerung ='DALI-2'
--and h3.Ausführung = 'Plug & Play'
GO
PRINT N'Prozedur "[dbo].[load_sat_Spot_Treiber_Stammdaten]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_sat_Spot_Treiber_Stammdaten] as

TRUNCATE TABLE sat.Spot_Treiber_Stammdaten

INSERT INTO sat.Spot_Treiber_Stammdaten (Treiber_SK, [Image], Produktbeschreibung, SEO_Url, Artikelnummer, Preis, Nettogewicht, Laenge, Breite, Hoehe, K_Prüfzeichen, [Offline], Aussendurchmesser, Leistungsfaktor)
SELECT * FROM (VALUES

  ('1', '17666000_pnp_print_BMEcat.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Maximale Leitungslänge sekundärseitig: 2.000 mm. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 5W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17666000', '17666000', '38.6', '0,045', '52', '30', '23', 'ENEC 15', 'Online', '', ''),
	('2', '17612000_17662000_17642000_01_BMEcat.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7.2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17662000', '17662000', '31.5', '0,038', '68', '35', '21', 'ENEC 15', 'Online', '', ''),
	('3', '17612010_17662010_17642010_01_BMEcat.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7.2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17662010', '17662010', '28', '0,033', '68', '35', '21', 'ENEC 15', 'Online', '', ''),
	('4', '17612020#17662020#17642020_01_BMEcat.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7.2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17662020', '17662020', '41.5', '0,078', '68', '35', '21', 'ENEC 15', 'Online', '', ''),
	('5', '17613000_pnp_print_BMEcat.jpg', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17613000', '17613000', '56.9', '0,067', '115', '34', '19', 'ENEC 05, MM', 'Online', '', ''),
	('6', '17613010_01_BMEcat.jpg', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17613010', '17613010', '47.9', '0,062', '115', '34', '19', 'ENEC 05, MM', 'Online', '', ''),
	('7', '17613020_BMEcat.jpg', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17613020', '17613020', '62.9', '0,107', '115', '34', '19', 'ENEC 05, MM', 'Online', '', ''),
	('8', '17621000_01_BMEcat.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17621000', '17621000', '59.9', '0,076', '128', '50', '13', 'ENEC 17, MM', 'Online', '', ''),
	('9', '17621010_01_BMEcat.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17621010', '17621010', '54.9', '0,072', '128', '50', '13', 'ENEC 17, MM', 'Online', '', ''),
	('10', '17621020_01_BMEcat.jpg', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-17621020', '17621020', '65.9', '0,117', '128', '50', '13', 'ENEC 17, MM', 'Online', '', ''),
	('11', '17663000#17664000_01_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17663000', '17663000', '36.6', '0,059', '110', '50', '19', 'ENEC 05', 'Online', '', ''),
	('12', '17663010#17664010_01_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17663010', '17663010', '34.3', '0,054', '110', '50', '19', 'ENEC 05', 'Online', '', ''),
	('13', '17663020_17664020_print_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17663020', '17663020', '45.5', '0,100', '110', '50', '19', 'ENEC 05', 'Online', '', ''),
	('14', '17652000_neu_BMEcat.jpg', 'LED-Rundkonverter 350 mA, Phasenabschnitt dimmbar. Ausführung: Plug&Play, Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-phasenabschnitt-dimmbar-17652000', '17652000', '52.9', '0,047', '', '', '24', '', 'Online', '51', ''),
	('15', '17652020_BMEcat.jpg', 'LED-Rundkonverter 350 mA, Phasenabschnitt dimmbar. Ausführung: Plug&Play, Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-phasenabschnitt-dimmbar-17652020', '17652020', '59.9', '0,087', '', '', '24', '', 'Online', '51', ''),
	('16', '17640000_02_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17640000', '17640000', '49.9', '0,073', '102', '38', '21', 'MM', 'Online', '', '0,95'),
	('17', '17640000_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17640010', '17640010', '46.9', '0,069', '102', '38', '21', 'MM', 'Online', '', '0,95'),
	('18', '17640020_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17640020', '17640020', '57.9', '0,112', '102', '38', '21', 'MM', 'Online', '', '0,95'),
	('19', '17663000#17664000_01_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17664000', '17664000', '52.4', '0,070', '125', '51', '20', 'ENEC 05', 'Online', '', ''),
	('20', '17663010#17664010_01_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17664010', '17664010', '49.9', '0,065', '125', '51', '20', 'ENEC 05', 'Online', '', ''),
	('21', '17663020#17664020_01_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17664020', '17664020', '62.3', '0,110', '125', '51', '20', 'ENEC 05', 'Online', '', ''),
	('22', '17643000_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17643000', '17643000', '51.9', '0,110', '110', '52', '22', 'ENEC 05, MM', 'Online', '', '0,95'),
	('23', '17643010_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17643010', '17643010', '48.9', '0,106', '110', '52', '22', 'ENEC 05, MM', 'Online', '', '0,95'),
	('24', '17643020_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-die-neue-konverter-generation-17643020', '17643020', '59.9', '0,151', '110', '52', '22', 'ENEC 05, MM', 'Online', '', '0,95'),
	('25', '17648000_print_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17648000', '17648000', '119.9', '0,183', '166', '46', '34', 'ENEC 05, MM', 'Online', '', '0,97'),
	('26', '17648010#17748010#17829010_print_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17648010', '17648010', '117.9', '0,179', '166', '46', '34', 'ENEC 05, MM', 'Online', '', '0,97'),
	('27', '17648020_print_BMEcat.jpg', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17648020', '17648020', '129.9', '0,223', '166', '46', '34', 'ENEC 05, MM', 'Online', '', '0,97'),
	('28', '17657000_BMEcat.jpg', 'LED-Konverter 350 mA, 1-10 V dimmbar (analog). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 18W, Art der Dimmung: 1-10 V.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-1-10-v-dimmbar-analog-die-neue-konverter-generation-17657000', '17657000', '78.9', '0,112', '110', '52', '22', 'ENEC 05, MM', 'Online', '', '0,95'),
	('29', '17657010#17767010_BMEcat.jpg', 'LED-Konverter 350 mA, 1-10 V dimmbar (analog). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 18W, Art der Dimmung: 1-10 V.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-1-10-v-dimmbar-analog-die-neue-konverter-generation-17657010', '17657010', '76.9', '0,108', '110', '52', '22', 'ENEC 05, MM', 'Online', '', '0,95'),
	('30', '17683000_BMEcat.jpg', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 17W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-die-neue-konverter-generation-17683000', '17683000', '93.3', '0,112', '110', '52', '22', 'ENEC 05, MM', 'Online', '', ''),
	('31', '17683010#17783010_BMEcat.jpg', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 17W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-die-neue-konverter-generation-17683010', '17683010', '88.3', '0,107', '110', '52', '22', 'ENEC 05, MM', 'Online', '', ''),
	('32', '17683020_BMEcat.jpg', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 17W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-die-neue-konverter-generation-17683020', '17683020', '97.7', '0,176', '110', '52', '22', 'ENEC 05, MM', 'Online', '', ''),
	('33', '17684000_BMEcat.jpg', 'LED-Konverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 7W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-17684000', '17684000', '81.2', '0,086', '130', '42', '22', 'ENEC 05', 'Online', '', ''),
	('34', '17684010_BMEcat.jpg', 'LED-Konverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 7W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-17684010', '17684010', '75.9', '0,082', '130', '42', '22', 'ENEC 05', 'Online', '', ''),
	('35', '17684020_BMEcat.jpg', 'LED-Konverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz , Leistung: 7W, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-17684020', '17684020', '86.3', '0,104', '130', '42', '22', 'ENEC 05', 'Online', '', ''),
	('36', '17658000_BMEcat.jpg', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658000', '17658000', '109.9', '0,070', '', '', '25', '', 'Online', '56', ''),
	('37', '17658010_BMEcat.jpg', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658010', '17658010', '108.9', '0,070', '', '', '25', '', 'Online', '56', ''),
	('38', '17658020_BMEcat.jpg', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658020', '17658020', '117.9', '0,085', '', '', '25', '', 'Online', '56', ''),
	('39', '17671000#17672000_print_BMEcat.jpg', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18.5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-17671000', '17671000', '197.5', '0,159', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95'),
	('40', '17671010#17672010#17771010#17772010_print_BMEcat.jpg', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18.5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-17671010', '17671010', '187.1', '0,155', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95'),
	('41', '17671020#17672020_print_BMEcat.jpg', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18.5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-17671020', '17671020', '207.9', '0,198', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95'),
	('42', '17671000#17672000_print_BMEcat.jpg', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-17672000', '17672000', '239.1', '0,159', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95'),
	('43', '17671010#17672010#17771010#17772010_print_BMEcat.jpg', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-17672010', '17672010', '233.9', '0,198', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95'),
	('44', '17671020#17672020_print_BMEcat.jpg', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-17672020', '17672020', '244.3', '0,170', '146', '44', '30', 'ENEC 05, MM', 'Online', '', '0,95')


)t (Treiber_SK, [Image], Produktbeschreibung, SEO_Url, Artikelnummer, Preis, Nettogewicht, Laenge, Breite, Hoehe, K_Prüfzeichen, [Offline], Aussendurchmesser, Leistungsfaktor)
GO
-- Umgestaltungsschritt zum Aktualisieren des Zielservers mit bereitgestellten Transaktionsprotokollen
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4081b2fa-bd86-456d-84a9-1b6143178ba7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4081b2fa-bd86-456d-84a9-1b6143178ba7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c131bf78-5e74-4fda-a864-86c016de97b0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c131bf78-5e74-4fda-a864-86c016de97b0')

GO

GO
PRINT N'Update abgeschlossen.';


GO
