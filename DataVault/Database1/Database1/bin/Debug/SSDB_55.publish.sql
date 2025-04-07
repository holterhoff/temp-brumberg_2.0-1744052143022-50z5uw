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
Die Spalte "Website" der Tabelle "[sat].[M1_Leuchte_Stammdaten]" muss von NULL in NOT NULL geändert werden. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript u. U. nicht. Um dieses Problem zu vermeiden, müssen Sie dieser Spalte für alle Zeilen Werte hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [sat].[M1_Leuchte_Stammdaten])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "Website" der Tabelle "[sat].[Spot_Leuchte_Stammdaten]" muss von NULL in NOT NULL geändert werden. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript u. U. nicht. Um dieses Problem zu vermeiden, müssen Sie dieser Spalte für alle Zeilen Werte hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [sat].[Spot_Leuchte_Stammdaten])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Tabelle "[sat].[M1_Leuchte_Stammdaten]" wird geändert...';


GO
ALTER TABLE [sat].[M1_Leuchte_Stammdaten] ALTER COLUMN [Website] VARCHAR (MAX) NOT NULL;


GO
PRINT N'Tabelle "[sat].[Spot_Leuchte_Stammdaten]" wird geändert...';


GO
ALTER TABLE [sat].[Spot_Leuchte_Stammdaten] ALTER COLUMN [Website] VARCHAR (MAX) NOT NULL;


GO
PRINT N'Sicht "[fakt].[Spot]" wird aktualisiert...';


GO
EXECUTE sp_refreshsqlmodule N'[fakt].[Spot]';


GO
PRINT N'Prozedur "[dbo].[load_sat_M1_Leuchte_Stammdaten]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_sat_M1_Leuchte_Stammdaten] as

TRUNCATE TABLE sat.M1_Leuchte_Stammdaten

INSERT INTO sat.M1_Leuchte_Stammdaten (Leuchte_SK, [Image], Produktbeschreibung, Website)
SELECT * FROM (VALUES

 (1, '1.1.1.1.1', 'LED-Reflektoreinsatz MR16, 3 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 3W, Lichtstrom: 290lm, Farbtemperatur: 2700K, Abstrahlwinkel: 38°.')
,(2, '1.1.1.2.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 680lm, : 2700 K Abstrahlwinkel: 38°. ')
,(3, '1.1.1.2.2', 'Brumberg 12923603. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12923603 , GTIN: 4251433936244','')
,(4, '1.1.1.3.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.120lm, Farbtemperatur: 2700K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.','')
,(5, '1.1.2.1.1', 'LED-Reflektoreinsatz MR16, 3 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 3W, Lichtstrom: 310lm, Farbtemperatur: 3000K, Abstrahlwinkel: 38°. ','')
,(6, '1.1.2.2.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 680lm, : 3000 K Abstrahlwinkel: 38°. ','')
,(7, '1.1.2.2.2', 'Brumberg 12924603. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12924603 , GTIN: 4251433930181','')
,(8, '1.1.2.3.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.210lm, Farbtemperatur: 3000K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.','')
,(9, '1.1.3.1.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 680lm, : 3500 K Abstrahlwinkel: 38°.','')
,(10, '1.1.3.1.2', 'Brumberg 12924604. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12924604 , GTIN: 4251433936251','')
,(11, '1.1.3.2.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.240lm, Farbtemperatur: 3500K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.','')
,(12, '1.1.4.1.1', 'LED-Reflektoreinsatz MR16, 3 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 3W, Lichtstrom: 340lm, Farbtemperatur: 4000K, Abstrahlwinkel: 38°. ','')
,(13, '1.1.4.2.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 720lm, : 4000 K Abstrahlwinkel: 38°.','')
,(14, '1.1.4.2.2', 'Brumberg 12923604. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12923604 , GTIN: 4251433930174','')
,(15, '1.1.4.3.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.250lm, Farbtemperatur: 4000K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.','')
,(16, '1.2.1.1.1', 'LED-Reflektoreinsatz MR16, 6 W, dim2warm, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 460lm, Farbtemperatur: 3000 bis 1800K, Abstrahlwinkel: 38°.','')
,(17, '1.2.1.1.2', 'Brumberg 12963603. LED-Reflektoreinsatz MR16, 6 W, dim2warm, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12963603 , GTIN: 4251433930198','')
,(18, '1.2.1.2.1', 'LED-Reflektoreinsatz MR16, 12 W, dim2warm, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 930lm, Abstrahlwinkel: 38°.','')
,(19, '1.3.1.1.1', 'LED-Reflektoreinsatz MR16, 12,5 W, SunLike, CRI > 97. Weitere Informationen zu der SunLike-Technologie finden Sie im Kapitel „Smart Light Solutions“. Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 13W, Lichtstrom: 920lm, Farbtemperatur: 3000K, Lichtfarbe: weiß, Abstrahlwinkel: 38°. ','')
,(20, '1.4.1.1.1', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 640lm, Farbtemperatur: 3000K, Abstrahlwinkel: 18°.','')
,(21, '1.4.1.1.2', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 690lm, Farbtemperatur: 3000K, Abstrahlwinkel: 24°.','')
,(22, '1.4.1.1.3', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 670lm, Farbtemperatur: 3000K, Abstrahlwinkel: 38°.','')
,(23, '1.4.1.1.4', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 620lm, Farbtemperatur: 3000K, Abstrahlwinkel: 60°.','')
,(24, '1.4.2.1.1', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 685lm, Farbtemperatur: 4000K, Abstrahlwinkel: 18°.','')
,(25, '1.4.2.1.2', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 740lm, Farbtemperatur: 4000K, Abstrahlwinkel: 24°.','')
,(26, '1.4.2.1.3', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 720lm, Farbtemperatur: 4000K, Abstrahlwinkel: 38°.','')
,(27, '1.4.2.1.4', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 660lm, Farbtemperatur: 4000K, Abstrahlwinkel: 60°.','')
,(28, '1.5.1.1.1', 'LED-Einsatz mit Linsenoptik MR16, RGB, rund. RGB-Modul, Anschlussleitung: 4-adrig, Ansteuerung: negativ, gemeinsame Anode (C.A.), Lichtstrom: rot: 65 lm | grün: 135 lm | blau: 30 lm. Fassung: ohne, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 13,8W, Anzahl der Leuchtmittel / Fassungen: 3.0 Stk, Abstrahlwinkel: 45°.','')
,(29, '1.6.1.1.1', 'LED-Reflektoreinsatz MR16, 8 W, dim4colour (RGB+WW), 24 V DC, rund. RGB+WW-Modul, Anschlussleitung: 5-adrig,Ansteuerung: negativ, gemeinsame Anode (C.A.),Lichtstrom: RGB (kombiniert): 165 lm und ''WW (2850 K): 235 lm, Farbwiedergabe (WW): CRI > 90. Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 24V, Leistung: 8W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 400lm, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.','')
     

)t (Leuchte_SK, [Image], Produktbeschreibung, Website)
GO
PRINT N'Prozedur "[dbo].[load_sat_Spot_Leuchte_Stammdaten]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_sat_Spot_Leuchte_Stammdaten] as

TRUNCATE TABLE sat.Spot_Leuchte_Stammdaten

INSERT INTO sat.Spot_Leuchte_Stammdaten (Leuchte_SK, [Image], Produktbeschreibung, Website)
SELECT * FROM (VALUES


 (1, '1.1.1.1.1', 'LED-Reflektoreinsatz MR16, 3 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 3W, Lichtstrom: 290lm, Farbtemperatur: 2700K, Abstrahlwinkel: 38°.','')
,(2, '1.1.1.2.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 680lm, : 2700 K Abstrahlwinkel: 38°. ','')
,(3, '1.1.1.2.2', 'Brumberg 12923603. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12923603 , GTIN: 4251433936244','')
,(4, '1.1.1.3.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.120lm, Farbtemperatur: 2700K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.','')
,(5, '1.1.2.1.1', 'LED-Reflektoreinsatz MR16, 3 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 3W, Lichtstrom: 310lm, Farbtemperatur: 3000K, Abstrahlwinkel: 38°. ','')
,(6, '1.1.2.2.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 680lm, : 3000 K Abstrahlwinkel: 38°. ','')
,(7, '1.1.2.2.2', 'Brumberg 12924603. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12924603 , GTIN: 4251433930181','')
,(8, '1.1.2.3.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.210lm, Farbtemperatur: 3000K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.','')
,(9, '1.1.3.1.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 680lm, : 3500 K Abstrahlwinkel: 38°.','')
,(10, '1.1.3.1.2', 'Brumberg 12924604. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12924604 , GTIN: 4251433936251','')
,(11, '1.1.3.2.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.240lm, Farbtemperatur: 3500K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.','')
,(12, '1.1.4.1.1', 'LED-Reflektoreinsatz MR16, 3 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 3W, Lichtstrom: 340lm, Farbtemperatur: 4000K, Abstrahlwinkel: 38°. ','')
,(13, '1.1.4.2.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 720lm, : 4000 K Abstrahlwinkel: 38°.','')
,(14, '1.1.4.2.2', 'Brumberg 12923604. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12923604 , GTIN: 4251433930174','')
,(15, '1.1.4.3.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.250lm, Farbtemperatur: 4000K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.','')
,(16, '1.2.1.1.1', 'LED-Reflektoreinsatz MR16, 6 W, dim2warm, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 460lm, Farbtemperatur: 3000 bis 1800K, Abstrahlwinkel: 38°.','')
,(17, '1.2.1.1.2', 'Brumberg 12963603. LED-Reflektoreinsatz MR16, 6 W, dim2warm, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12963603 , GTIN: 4251433930198','')
,(18, '1.2.1.2.1', 'LED-Reflektoreinsatz MR16, 12 W, dim2warm, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 930lm, Abstrahlwinkel: 38°.','')
,(19, '1.3.1.1.1', 'LED-Reflektoreinsatz MR16, 12,5 W, SunLike, CRI > 97. Weitere Informationen zu der SunLike-Technologie finden Sie im Kapitel „Smart Light Solutions“. Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 13W, Lichtstrom: 920lm, Farbtemperatur: 3000K, Lichtfarbe: weiß, Abstrahlwinkel: 38°. ','')
,(20, '1.4.1.1.1', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 640lm, Farbtemperatur: 3000K, Abstrahlwinkel: 18°.','')
,(21, '1.4.1.1.2', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 690lm, Farbtemperatur: 3000K, Abstrahlwinkel: 24°.','')
,(22, '1.4.1.1.3', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 670lm, Farbtemperatur: 3000K, Abstrahlwinkel: 38°.','')
,(23, '1.4.1.1.4', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 620lm, Farbtemperatur: 3000K, Abstrahlwinkel: 60°.','')
,(24, '1.4.2.1.1', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 685lm, Farbtemperatur: 4000K, Abstrahlwinkel: 18°.','')
,(25, '1.4.2.1.2', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 740lm, Farbtemperatur: 4000K, Abstrahlwinkel: 24°.','')
,(26, '1.4.2.1.3', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 720lm, Farbtemperatur: 4000K, Abstrahlwinkel: 38°.','')
,(27, '1.4.2.1.4', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 660lm, Farbtemperatur: 4000K, Abstrahlwinkel: 60°.','')
,(28, '1.5.1.1.1', 'LED-Einsatz mit Linsenoptik MR16, RGB, rund. RGB-Modul, Anschlussleitung: 4-adrig, Ansteuerung: negativ, gemeinsame Anode (C.A.), Lichtstrom: rot: 65 lm | grün: 135 lm | blau: 30 lm. Fassung: ohne, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 13,8W, Anzahl der Leuchtmittel / Fassungen: 3.0 Stk, Abstrahlwinkel: 45°.','')
    
     

)t (Leuchte_SK, [Image], Produktbeschreibung, Website)
GO
PRINT N'Prozedur "[dbo].[load_hub_M1_Treiber]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_M1_Treiber] as

TRUNCATE TABLE hub.M1_Treiber

INSERT INTO hub.M1_Treiber (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)

SELECT * FROM (VALUES



 ('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'schaltbar', 	    '350mA',	  1	        ,5 )
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'schaltbar',  	  '350mA',	  1	        ,7.2)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'schaltbar',    	'350mA',	  1	        ,7.2)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'schaltbar', 	    '350mA',	  1	        ,7.2)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'schaltbar', 	    '350mA',	  0	        ,15)
,('MR16',	'LED-Konverter'	,'ohne'	        ,     'schaltbar', 	    '350mA',	  0	        ,15)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'schaltbar', 	    '350mA',	  0	        ,15)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'schaltbar', 	    '350mA',	  1	        ,21)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'schaltbar', 	    '350mA',	  1	        ,21)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'schaltbar', 	    '350mA',	  1	        ,21)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'Phasenabschnit',	'350mA',	  2.8	      ,7)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'Phasenabschnit',	'350mA',	  2.8	      ,7)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  2.8	      ,7)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  4.9	      ,7)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'Phasenabschnit',	'350mA',	  4.9	      ,7)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'Phasenabschnit',	'350mA',	  4.2	      ,10)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  4.2	      ,10)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'Phasenabschnit',	'350mA',	  4.2	      ,10)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'Phasenabschnit',	'350mA',	  0.7	      ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  0.7	      ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play'      , 'Phasenabschnit',	'350mA',	  0.7	      ,17)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'Phasenabschnit',	'350mA',	  8.75	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  8.75	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'Phasenabschnit',	'350mA',	  8.75	    ,18)
,('MR16',	'LED-Konverter'	,'ohne'           	, 'Phasenabschnit',	'350mA',	  10.15	    ,14)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  10.15	    ,14)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'Phasenabschnit',	'350mA',	  10.15	    ,14)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , '1-10V',	        '350mA',	  5.25	    ,18)
,('MR16',	'LED-Konverter'	,'ohne' 	          , '1-10V',	        '350mA',	  5.25	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'DALI-2',	        '350mA',	  3.5	      ,17)
,('MR16',	'LED-Konverter'	,'ohne' 	          , 'DALI-2',	        '350mA',	  3.5	      ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'DALI-2',	        '350mA',	  3.5	      ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'DALI-2',	        '350mA',	  2.1	      ,9)
,('MR16',	'LED-Konverter'	,'ohne' 	          , 'DALI-2',	        '350mA',	  2.1	      ,9)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'DALI-2',	        '350mA',	  2.1	      ,9)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'CASAMBI',        '350mA',	  3.5	      ,18)
,('MR16',	'LED-Konverter'	,'ohne' 	          , 'CASAMBI',        '350mA',	  3.5	      ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'CASAMBI',        '350mA',	  3.5	      ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play'   	  , 'ZigBee',	        '350mA',	  3.5	      ,18)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'ZigBee',	        '350mA',	  3.5	      ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'ZigBee',	        '350mA',	  3.5	      ,18)





)t (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)
GO
PRINT N'Prozedur "[dbo].[load_link_M1_Gehaeuse__Leuchte]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_M1_Gehaeuse__Leuchte] as

TRUNCATE TABLE link.M1_Gehaeuse__Leuchte

INSERT INTO link.M1_Gehaeuse__Leuchte (Gehaeuse_SK, Leuchte_SK)

SELECT 

		h1.Gehaeuse_Sk
	,	h2.Leuchte_SK

FROM hub.M1_Gehaeuse h1
CROSS JOIN hub.M1_Leuchte h2




 -- Ausschluss LED
--MR 16 STATISCH 2700 K 12 W 38°
--MR 16 STATISCH 3000 K 12 W 38°
--MR 16 STATISCH 3500 K 12 W 38°
--MR 16 STATISCH 4000 K 12 W 38°
--MR 16 D2W 3000…1800 K 12 W 38°
--MR 16 SUNLIKE 3000 K 12,5 W 38°
--MR 16 RGB RGB 13,8 W 45°
--MR 16 DIM4COLOUR RGB+WW 8 W 60°


 WHERE Leuchte_SK NOT IN (4,8,12,15,18,28,29)
GO
PRINT N'Prozedur "[dbo].[load_link_M1_Leuchte__Treiber]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_M1_Leuchte__Treiber] as

TRUNCATE TABLE link.M1_Leuchte__Treiber

INSERT INTO link.M1_Leuchte__Treiber (Leuchte_SK, Treiber_SK)

select distinct

	h1.Leuchte_SK
,	h2.Treiber_SK


 from hub.M1_Leuchte h1
 JOIN hub.M1_Treiber h2 ON h1.Versorgung = h2.Versorgung AND h1.Leistung < h2.Leistung_Max
GO
PRINT N'Update abgeschlossen.';


GO
