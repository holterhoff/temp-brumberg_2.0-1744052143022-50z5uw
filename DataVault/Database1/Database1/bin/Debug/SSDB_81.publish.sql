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
Die Spalte "[hub].[Spot_Leuchte].[Image]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Der Typ von Spalte "Farbkanal" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (100) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (100) NOT NULL" kompatibel sind.

Der Typ von Spalte "Leuchtentyp" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (100) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (100) NOT NULL" kompatibel sind.

Der Typ von Spalte "Lichtfarbe" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (100) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (100) NOT NULL" kompatibel sind.

Der Typ von Spalte "Lichtstrom" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " INT NOT NULL", wird aber in " DECIMAL (18) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " DECIMAL (18) NOT NULL" kompatibel sind.

Der Typ von Spalte "Versorgung" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (100) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (100) NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [hub].[Spot_Leuchte])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "[sat].[Spot_Leuchte_Stammdaten].[Artikelnummer]" in der Tabelle "[sat].[Spot_Leuchte_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Die Spalte "[sat].[Spot_Leuchte_Stammdaten].[Maße]" in der Tabelle "[sat].[Spot_Leuchte_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Die Spalte "[sat].[Spot_Leuchte_Stammdaten].[Moegliche_Konverter]" in der Tabelle "[sat].[Spot_Leuchte_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Die Spalte "[sat].[Spot_Leuchte_Stammdaten].[Nettogewicht]" in der Tabelle "[sat].[Spot_Leuchte_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Die Spalte "[sat].[Spot_Leuchte_Stammdaten].[Offline]" in der Tabelle "[sat].[Spot_Leuchte_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Die Spalte "[sat].[Spot_Leuchte_Stammdaten].[Preis]" in der Tabelle "[sat].[Spot_Leuchte_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Der Typ von Spalte "Image" in Tabelle "[sat].[Spot_Leuchte_Stammdaten]" lautet aktuell " NVARCHAR (50) NOT NULL", wird aber in " VARCHAR (100) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " VARCHAR (100) NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [sat].[Spot_Leuchte_Stammdaten])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Der folgende Vorgang wird aus der Umgestaltungsprotokolldatei "36a06fc7-518b-41bd-bb61-1710ac4f7afd, 6655a62c-7315-44eb-ba70-ff32f2e91436" erstellt.';

PRINT N'"[hub].[Spot_Leuchte].[Effizienzklasse]" in "Image" umbenennen';


GO
EXECUTE sp_rename @objname = N'[hub].[Spot_Leuchte].[Effizienzklasse]', @newname = N'Image', @objtype = N'COLUMN';


GO
PRINT N'Der folgende Vorgang wird aus der Umgestaltungsprotokolldatei "f900d9c8-c05e-4c71-92f0-b54b44fca364" erstellt.';

PRINT N'"[sat].[Spot_Leuchte_Stammdaten].[Website]" in "SEO_Url" umbenennen';


GO
EXECUTE sp_rename @objname = N'[sat].[Spot_Leuchte_Stammdaten].[Website]', @newname = N'SEO_Url', @objtype = N'COLUMN';


GO
PRINT N'Primärschlüssel "[hub].[PK_hub_Spot_Leuchte]" wird gelöscht...';


GO
ALTER TABLE [hub].[Spot_Leuchte] DROP CONSTRAINT [PK_hub_Spot_Leuchte];


GO
PRINT N'Tabelle "[hub].[Spot_Leuchte]" wird geändert...';


GO
ALTER TABLE [hub].[Spot_Leuchte] DROP COLUMN [Image];


GO
ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Farbkanal] VARCHAR (100) NOT NULL;

ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Leuchtentyp] VARCHAR (100) NOT NULL;

ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Lichtfarbe] VARCHAR (100) NOT NULL;

ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Lichtstrom] DECIMAL (18) NOT NULL;

ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Versorgung] VARCHAR (100) NOT NULL;


GO
PRINT N'Tabelle "[sat].[Spot_Leuchte_Stammdaten]" wird geändert...';


GO
ALTER TABLE [sat].[Spot_Leuchte_Stammdaten] ALTER COLUMN [Image] VARCHAR (100) NOT NULL;


GO
ALTER TABLE [sat].[Spot_Leuchte_Stammdaten]
    ADD [Artikelnummer]       VARCHAR (50)    NOT NULL,
        [Preis]               DECIMAL (18, 2) NOT NULL,
        [Nettogewicht]        VARCHAR (50)    NOT NULL,
        [Maße]                VARBINARY (50)  NOT NULL,
        [Moegliche_Konverter] VARCHAR (MAX)   NOT NULL,
        [Offline]             VARBINARY (50)  NOT NULL;


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
	,	s33.Artikelnummer as Artikelnummer_Treiber
	,	s33.Preis as Preis_Treiber
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
 inner JOIN sat.Spot_Treiber_Artikel s33 ON h3.Treiber_SK = s33.Treiber_SK

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
PRINT N'Prozedur "[dbo].[load_hub_Spot_Leuchte]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_Spot_Leuchte] as

TRUNCATE TABLE hub.Spot_Leuchte

INSERT INTO hub.Spot_Leuchte (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom )

SELECT * FROM (VALUES


  ('MR16', 'STATISCH', '2700 K', '350', '3', '38', '290.0'),
	('MR16', 'STATISCH', '3000 K', '350', '3', '38', '310.0'),
	('MR16', 'STATISCH', '4000 K', '350', '3', '38', '340.0'),
	('MR16', 'STATISCH', '2700 K', '350', '6', '38', '600.0'),
	('MR16', 'STATISCH', '2700 K', '350', '6', '60', '570.0'),
	('MR16', 'STATISCH', '3000 K', '350', '6', '38', '680.0'),
	('MR16', 'STATISCH', '3000 K', '350', '6', '60', '660.0'),
	('MR16', 'STATISCH', '3500 K', '350', '6', '38', '680.0'),
	('MR16', 'STATISCH', '3500 K', '350', '6', '60', '660.0'),
	('MR16', 'STATISCH', '4000 K', '350', '6', '38', '720.0'),
	('MR16', 'STATISCH', '4000 K', '350', '6', '60', '700.0'),
	('MR16', 'D2W', '3000 K - 1800 K', '350', '6', '38', '460.0'),
	('MR16', 'D2W', '3000 K - 1800 K', '350', '6', '60', '430.0'),
	('MR16', 'DISC', '3000 K', '350', '6', '18', '640.0'),
	('MR16', 'DISC', '3000 K', '350', '6', '24', '690.0'),
	('MR16', 'DISC', '3000 K', '350', '6', '38', '670.0'),
	('MR16', 'DISC', '3000 K', '350', '6', '60', '620.0'),
	('MR16', 'DISC', '4000 K', '350', '6', '18', '685.0'),
	('MR16', 'DISC', '4000 K', '350', '6', '24', '740.0'),
	('MR16', 'DISC', '4000 K', '350', '6', '38', '720.0'),
	('MR16', 'DISC', '4000 K', '350', '6', '60', '660.0'),
	('MR16', 'STATISCH', '2700 K', '350', '12', '38', '1.1'),
	('MR16', 'STATISCH', '3000 K', '350', '12', '38', '1.2'),
	('MR16', 'STATISCH', '3500 K', '350', '12', '38', '1.2'),
	('MR16', 'STATISCH', '4000 K', '350', '12', '38', '1.3'),
	('MR16', 'D2W', '3000 K - 1800 K', '350', '12', '38', '930.0'),
	('MR16', 'SUNLIKE', '3000 K', '350', '12,5', '38', '920.0'),
	('MR16', 'RGB', 'RGB', '12', '13,8', '45', '0.0'),
	('MR16', 'STATISCH', '2850 K', '24', '8', '60', '900.0'),
	('MR16', 'TUNABLEWHITE', '2000 K - 6500 K', '24', '8', '60', '640.0'),
	('MR16', 'RGB+WW', 'RGB+WW', '24', '8', '60', '400.0')




)t (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom)
GO
PRINT N'Prozedur "[dbo].[load_sat_Spot_Leuchte_Stammdaten]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_sat_Spot_Leuchte_Stammdaten] as

TRUNCATE TABLE sat.Spot_Leuchte_Stammdaten

INSERT INTO sat.Spot_Leuchte_Stammdaten (Leuchte_SK, [Image], Produktbeschreibung, SEO_Url, Artikelnummer, Preis, Nettogewicht, Maße, Moegliche_Konverter, [Offline])
SELECT * FROM (VALUES

  ('1', '12923003_12924003_12924004_01_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 3 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 3W, Lichtstrom: 290lm, Farbtemperatur: 2.700 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-3-w-350-ma-12925003', '12925003', '44.5', '0,079', '50 x 40', '17666000|17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('2', '12923003_12924003_12924004_01_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 3 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 3W, Lichtstrom: 310lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-3-w-350-ma-12926003', '12926003', '44.5', '0,079', '50 x 40', '17666000|17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('3', '12923003_12924003_12924004_01_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 3 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 3W, Lichtstrom: 340lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-3-w-350-ma-12925004', '12925004', '44.5', '0,079', '50 x 40', '17666000|17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('4', '12963603_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 600lm, Farbtemperatur: 2.700 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923383', '12923383', '63.5', '0,078', '50 x 32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('5', '12963603_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 570lm, Farbtemperatur: 2.700 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923603', '12923603', '63.5', '0,078', '50 x 32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('6', '12963603_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 680 lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924383', '12924383', '63.5', '0,078', '50 x 32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('7', '12963603_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 660lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924603', '12924603', '63.5', '0,078', '50 x 32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('8', '12963603_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 680 lm, Farbtemperatur: 3.500 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924384', '12924384', '63.5', '0,078', '50 x 32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('9', '12963603_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 660lm, Farbtemperatur: 3.500 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924604', '12924604', '63.5', '0,078', '50 x 32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('10', '12963603_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 720 lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923384', '12923384', '63.5', '0,078', '50 x 32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('11', '12963603_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 700lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923604', '12923604', '63.5', '0,078', '50 x 32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('12', '12963603_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 6 W, dim2warm, 350 mA, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 460lm, Farbtemperatur: von 1.800 K bis 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-dim2warm-350-ma-12963383', '12963383', '79.9', '0,078', '50 x 32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('13', '12963603_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 6 W, dim2warm, 350 mA, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 430lm, Farbtemperatur: von 1.800 K bis 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-dim2warm-350-ma-12963603', '12963603', '79.9', '0,078', '50 x 32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('14', '12920003#12920004_BMEcat.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 640lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 18°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920183', '12920183', '39.5', '0,061', '50 x 31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('15', '12920003#12920004_BMEcat.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 690lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 24°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920243', '12920243', '39.5', '0,061', '50 x 31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('16', '12920003#12920004_BMEcat.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 670lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920003', '12920003', '39.5', '0,061', '50 x 31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('17', '12920003#12920004_BMEcat.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 620lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920603', '12920603', '39.5', '0,061', '50 x 31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('18', '12920003#12920004_BMEcat.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 685lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 18°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920184', '12920184', '39.5', '0,061', '50 x 31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('19', '12920003#12920004_BMEcat.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 740lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 24°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920244', '12920244', '39.5', '0,061', '50 x 31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('20', '12920003#12920004_BMEcat.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 720lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920004', '12920004', '39.5', '0,061', '50 x 31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('21', '12920003#12920004_BMEcat.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 660lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920604', '12920604', '39.5', '0,061', '50 x 31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('22', '12953003#12954003#12953004#12954003_01_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.120lm, Farbtemperatur: 2.700 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12953003', '12953003', '99.9', '0,143', '50 x 70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('23', '12953003#12954003#12953004#12954003_01_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.210lm, Farbtemperatur: 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12954003', '12954003', '99.9', '0,143', '50 x 70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('24', '12953003#12954003#12953004#12954003_01_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.240lm, Farbtemperatur: 3.500 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12954004', '12954004', '99.9', '0,143', '50 x 70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('25', '12953003#12954003#12953004#12954003_01_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.250lm, Farbtemperatur: 4.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12953004', '12953004', '99.9', '0,143', '50 x 70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('26', '12953003#12954003#12953004#12954003_01_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 12 W, dim2warm, 350 mA, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 930lm, Farbtemperatur: von 1.800 K bis 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-dim2warm-350-ma-12965003', '12965003', '119.9', '0,138', '50 x 70', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('27', '12983003_01_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 12,5 W, SunLike, CRI > 97, 350 mA. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12.5W, Lichtstrom: 920lm, Farbtemperatur: 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-5-w-sunlike-cri->-97-350-ma-12983003', '12983003', '119.9', '0,125', '50 x 95', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('28', '18101001_print_BMEcat.jpg', 'LED-Einsatz mit Linsenoptik MR16, RGB, 12 V DC, rund. RGB-Modul, Anschlussleitung: 5-adrig, Ansteuerung: negativ, gemeinsame Anode (C.A.), Lichtstrom: rot: 65 lm | grün: 135 lm | blau: 30 lm. Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 13.8W, Anzahl der Leuchtmittel / Fassungen: 3.0 Stk, Abstrahlwinkel: 45°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-einsatz-mit-linsenoptik-mr16-rgb-12-v-dc-18101001', '18101001', '171.5', '0,114', '51 x 52', '', 'Online'),
	('29', '12823003_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 8 W, 24 V DC, rund. Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 24V, Leistung: 8W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 900lm, Farbtemperatur: 2.850 K, Lichtfarbe: weiß, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-8-w-24-v-dc-12823003', '12823003', '109.9', '0,072', '50 x 50', '17206000|17207000|17223000', 'Online'),
	('30', '12843004_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 8 W, TunableWhite, 24 V DC, rund. Anschlussleitung: 3-adrig, Ansteuerung: negativ, gemeinsame Anode (C.A.). Lichtstrom: 318 lm bei 2000 K, 374 lm bei 4000 K, 415 lm bei 6500 K. Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 24V, Leistung: 8W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 700lm, Farbtemperatur: von 2.000 K bis 6.500 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-8-w-tunablewhite-24-v-dc-12843004', '12843004', '169.9', '0,067', '50 x 50', '17206000|17207000|17223000', 'Online'),
	('31', '18438002_BMEcat.jpg', 'LED-Reflektoreinsatz MR16, 8 W, dim4colour (RGB+WW), 24 V DC, rund. RGB+WW-Modul, Anschlussleitung: 5-adrig, Ansteuerung: negativ, gemeinsame Anode (C.A.), Lichtstrom: RGB (kombiniert): 165 lm und WW (2850 K): 235 lm, Farbwiedergabe (WW): CRI > 90. Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 24V, Leistung: 8W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 400lm, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-8-w-dim4colour-rgb+ww-24-v-dc-18438002', '18438002', '169.9', '0,068', '50 x 50', '', 'Online')

     

)t (Leuchte_SK, [Image], Produktbeschreibung, SEO_Url, Artikelnummer, Preis, Nettogewicht, Maße, Moegliche_Konverter, [Offline]  )
GO
PRINT N'Prozedur "[dbo].[load_link_Spot_Gehaeuse__Leuchte]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_link_Spot_Gehaeuse__Leuchte]';


GO
PRINT N'Prozedur "[dbo].[load_link_Spot_Leuchte__Treiber]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_link_Spot_Leuchte__Treiber]';


GO
-- Umgestaltungsschritt zum Aktualisieren des Zielservers mit bereitgestellten Transaktionsprotokollen
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '36a06fc7-518b-41bd-bb61-1710ac4f7afd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('36a06fc7-518b-41bd-bb61-1710ac4f7afd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6655a62c-7315-44eb-ba70-ff32f2e91436')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6655a62c-7315-44eb-ba70-ff32f2e91436')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f900d9c8-c05e-4c71-92f0-b54b44fca364')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f900d9c8-c05e-4c71-92f0-b54b44fca364')

GO

GO
PRINT N'Update abgeschlossen.';


GO
