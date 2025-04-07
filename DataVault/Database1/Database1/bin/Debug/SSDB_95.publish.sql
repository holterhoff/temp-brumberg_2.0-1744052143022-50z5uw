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
Der Typ von Spalte "Abstrahlwinkel" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " VARCHAR (50) NOT NULL", wird aber in " DECIMAL (5, 2) NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " DECIMAL (5, 2) NOT NULL" kompatibel sind.

Der Typ von Spalte "Lichtstrom" in Tabelle "[hub].[Spot_Leuchte]" lautet aktuell " VARCHAR (50) NOT NULL", wird aber in " INT NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " INT NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [hub].[Spot_Leuchte])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Tabelle "[hub].[Spot_Leuchte]" wird geändert...';


GO
ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Abstrahlwinkel] DECIMAL (5, 2) NOT NULL;

ALTER TABLE [hub].[Spot_Leuchte] ALTER COLUMN [Lichtstrom] INT NOT NULL;


GO
PRINT N'Sicht "[fakt].[Spot]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[fakt].[Spot]';


GO
PRINT N'Prozedur "[dbo].[load_hub_Spot_Leuchte]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_Spot_Leuchte] as

TRUNCATE TABLE hub.Spot_Leuchte

INSERT INTO hub.Spot_Leuchte (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom )

SELECT * FROM (VALUES


  
	
	
	
	
	('MR16', 'STATISCH', '2700 K', '350mA', '3', '38', '290', '12925003.jpg', 'LED-Reflektoreinsatz MR16, 3 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 3W, Lichtstrom: 290lm, Farbtemperatur: 2.700 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-3-w-350-ma-12925003', '12925003', '44.5', '0,079', '50', '40', '17666000|17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '3000 K', '350mA', '3', '38', '310', '12926003.jpg', 'LED-Reflektoreinsatz MR16, 3 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 3W, Lichtstrom: 310lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-3-w-350-ma-12926003', '12926003', '44.5', '0,079', '50', '40', '17666000|17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '4000 K', '350mA', '3', '38', '340', '12925004.jpg', 'LED-Reflektoreinsatz MR16, 3 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 3W, Lichtstrom: 340lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-3-w-350-ma-12925004', '12925004', '44.5', '0,079', '50', '40', '17666000|17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '2700 K', '350mA', '6', '38', '600', '12923383.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 600lm, Farbtemperatur: 2.700 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923383', '12923383', '63.5', '0,078', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '2700 K', '350mA', '6', '60', '570', '12923603.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 570lm, Farbtemperatur: 2.700 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923603', '12923603', '63.5', '0,078', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '3000 K', '350mA', '6', '38', '680', '12924383.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 680 lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924383', '12924383', '63.5', '0,078', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '3000 K', '350mA', '6', '60', '660', '12924603.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 660lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924603', '12924603', '63.5', '0,078', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '3500 K', '350mA', '6', '38', '680', '12924384.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 680 lm, Farbtemperatur: 3.500 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924384', '12924384', '63.5', '0,078', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '3500 K', '350mA', '6', '60', '660', '12924604.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 660lm, Farbtemperatur: 3.500 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924604', '12924604', '63.5', '0,078', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '4000 K', '350mA', '6', '38', '720', '12923384.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 720 lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923384', '12923384', '63.5', '0,078', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '4000 K', '350mA', '6', '60', '700', '12923604.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 700lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923604', '12923604', '63.5', '0,078', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'D2W', '3000 K - 1800 K', '350mA', '6', '38', '460', '12963383.jpg', 'LED-Reflektoreinsatz MR16, 6 W, dim2warm, 350 mA, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 460lm, Farbtemperatur: von 1.800 K bis 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-dim2warm-350-ma-12963383', '12963383', '79.9', '0,078', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'D2W', '3000 K - 1800 K', '350mA', '6', '60', '430', '12963603.jpg', 'LED-Reflektoreinsatz MR16, 6 W, dim2warm, 350 mA, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 430lm, Farbtemperatur: von 1.800 K bis 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-dim2warm-350-ma-12963603', '12963603', '79.9', '0,078', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'DISC', '3000 K', '350mA', '6', '18', '640', '12920183.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 640lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 18°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920183', '12920183', '39.5', '0,061', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'DISC', '3000 K', '350mA', '6', '24', '690', '12920243.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 690lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 24°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920243', '12920243', '39.5', '0,061', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'DISC', '3000 K', '350mA', '6', '38', '670', '12920003.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 670lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920003', '12920003', '39.5', '0,061', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'DISC', '3000 K', '350mA', '6', '60', '620', '12920603.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 620lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920603', '12920603', '39.5', '0,061', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'DISC', '4000 K', '350mA', '6', '18', '685', '12920184.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 685lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 18°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920184', '12920184', '39.5', '0,061', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'DISC', '4000 K', '350mA', '6', '24', '740', '12920244.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 740lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 24°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920244', '12920244', '39.5', '0,061', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'DISC', '4000 K', '350mA', '6', '38', '720', '12920004.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 720lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920004', '12920004', '39.5', '0,061', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'DISC', '4000 K', '350mA', '6', '60', '660', '12920604.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 660lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920604', '12920604', '39.5', '0,061', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '2700 K', '350mA', '12', '38', '1.12', '12953003.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.120lm, Farbtemperatur: 2.700 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12953003', '12953003', '99.9', '0,143', '50', '70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '3000 K', '350mA', '12', '38', '1.21', '12954003.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.210lm, Farbtemperatur: 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12954003', '12954003', '99.9', '0,143', '50', '70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '3500 K', '350mA', '12', '38', '1.24', '12954004.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.240lm, Farbtemperatur: 3.500 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12954004', '12954004', '99.9', '0,143', '50', '70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'STATISCH', '4000 K', '350mA', '12', '38', '1.25', '12953004.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.250lm, Farbtemperatur: 4.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12953004', '12953004', '99.9', '0,143', '50', '70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'D2W', '3000 K - 1800 K', '350mA', '12', '38', '930', '12965003.jpg', 'LED-Reflektoreinsatz MR16, 12 W, dim2warm, 350 mA, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 930lm, Farbtemperatur: von 1.800 K bis 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-dim2warm-350-ma-12965003', '12965003', '119.9', '0,138', '50', '70', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'SUNLIKE', '3000 K', '350mA', '12,5', '38', '920', '12983003.jpg', 'LED-Reflektoreinsatz MR16, 12,5 W, SunLike, CRI > 97, 350 mA. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12.5W, Lichtstrom: 920lm, Farbtemperatur: 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-5-w-sunlike-cri->-97-350-ma-12983003', '12983003', '119.9', '0,125', '50', '95', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'Online'),
	('MR16', 'RGB', 'RGB', '12V', '13,8', '45', '', '18101001.jpg', 'LED-Einsatz mit Linsenoptik MR16, RGB, 12 V DC, rund. RGB-Modul, Anschlussleitung: 5-adrig, Ansteuerung: negativ, gemeinsame Anode (C.A.), Lichtstrom: rot: 65 lm | grün: 135 lm | blau: 30 lm. Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 13.8W, Anzahl der Leuchtmittel / Fassungen: 3.0 Stk, Abstrahlwinkel: 45°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-einsatz-mit-linsenoptik-mr16-rgb-12-v-dc-18101001', '18101001', '171.5', '0,114', '51', '52', '', 'Online'),
	('MR16', 'STATISCH', '2850 K', '24V', '8', '60', '900', '12823003.jpg', 'LED-Reflektoreinsatz MR16, 8 W, 24 V DC, rund. Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 24V, Leistung: 8W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 900lm, Farbtemperatur: 2.850 K, Lichtfarbe: weiß, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-8-w-24-v-dc-12823003', '12823003', '109.9', '0,072', '50', '50', '17206000|17207000|17223000', 'Online'),
	('MR16', 'TUNABLEWHITE', '2000 K - 6500 K', '24V', '8', '60', '640', '12843004.jpg', 'LED-Reflektoreinsatz MR16, 8 W, TunableWhite, 24 V DC, rund. Anschlussleitung: 3-adrig, Ansteuerung: negativ, gemeinsame Anode (C.A.). Lichtstrom: 318 lm bei 2000 K, 374 lm bei 4000 K, 415 lm bei 6500 K. Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 24V, Leistung: 8W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 700lm, Farbtemperatur: von 2.000 K bis 6.500 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-8-w-tunablewhite-24-v-dc-12843004', '12843004', '169.9', '0,067', '50', '50', '17206000|17207000|17223000', 'Online'),
	('MR16', 'RGB+WW', 'RGB+WW', '24V', '8', '60', '400', '18438002.jpg', 'LED-Reflektoreinsatz MR16, 8 W, dim4colour (RGB+WW), 24 V DC, rund. RGB+WW-Modul, Anschlussleitung: 5-adrig, Ansteuerung: negativ, gemeinsame Anode (C.A.), Lichtstrom: RGB (kombiniert): 165 lm und WW (2850 K): 235 lm, Farbwiedergabe (WW): CRI > 90. Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 24V, Leistung: 8W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 400lm, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-8-w-dim4colour-rgb+ww-24-v-dc-18438002', '18438002', '169.9', '0,068', '50', '50', '', 'Online')
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	




)t (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom)
GO
PRINT N'Prozedur "[dbo].[load_link_Spot_Gehaeuse__Leuchte]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_link_Spot_Gehaeuse__Leuchte]';


GO
PRINT N'Prozedur "[dbo].[load_link_Spot_Leuchte__Treiber]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[load_link_Spot_Leuchte__Treiber]';


GO
PRINT N'Update abgeschlossen.';


GO
