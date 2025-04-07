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
PRINT N'Prozedur "[dbo].[load_sat_M1_Leuchte_Stammdaten]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_sat_M1_Leuchte_Stammdaten] as

TRUNCATE TABLE sat.M1_Leuchte_Stammdaten

INSERT INTO sat.M1_Leuchte_Stammdaten (Leuchte_SK, [Image], Produktbeschreibung)
SELECT * FROM (VALUES

 (1, '1.1.1.1.1', 'LED-Reflektoreinsatz MR16, 3 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 3W, Lichtstrom: 290lm, Farbtemperatur: 2700K, Abstrahlwinkel: 38°.')
,(2, '1.1.1.2.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 680lm, : 2700 K Abstrahlwinkel: 38°. ')
,(3, '1.1.1.2.2', 'Brumberg 12923603. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12923603 , GTIN: 4251433936244')
,(4, '1.1.1.3.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.120lm, Farbtemperatur: 2700K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.')
,(5, '1.1.2.1.1', 'LED-Reflektoreinsatz MR16, 3 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 3W, Lichtstrom: 310lm, Farbtemperatur: 3000K, Abstrahlwinkel: 38°. ')
,(6, '1.1.2.2.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 680lm, : 3000 K Abstrahlwinkel: 38°. ')
,(7, '1.1.2.2.2', 'Brumberg 12924603. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12924603 , GTIN: 4251433930181')
,(8, '1.1.2.3.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.210lm, Farbtemperatur: 3000K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.')
,(9, '1.1.3.1.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 680lm, : 3500 K Abstrahlwinkel: 38°.')
,(10, '1.1.3.1.2', 'Brumberg 12924604. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12924604 , GTIN: 4251433936251')
,(11, '1.1.3.2.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.240lm, Farbtemperatur: 3500K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.')
,(12, '1.1.4.1.1', 'LED-Reflektoreinsatz MR16, 3 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 3W, Lichtstrom: 340lm, Farbtemperatur: 4000K, Abstrahlwinkel: 38°. ')
,(13, '1.1.4.2.1', 'LED-Reflektoreinsatz MR16, 6 W, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6,00W, Lichtstrom: 720lm, : 4000 K Abstrahlwinkel: 38°.')
,(14, '1.1.4.2.2', 'Brumberg 12923604. LED-Reflektoreinsatz MR16, 6 W, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Farbe:, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12923604 , GTIN: 4251433930174')
,(15, '1.1.4.3.1', 'LED-Reflektoreinsatz MR16, 12 W, rund. . Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 1.250lm, Farbtemperatur: 4000K, Lichtfarbe: weiß, Abstrahlwinkel: 38°.')
,(16, '1.2.1.1.1', 'LED-Reflektoreinsatz MR16, 6 W, dim2warm, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 460lm, Farbtemperatur: 3000 bis 1800K, Abstrahlwinkel: 38°.')
,(17, '1.2.1.1.2', 'Brumberg 12963603. LED-Reflektoreinsatz MR16, 6 W, dim2warm, 350 mA, Deckenausschnitt Einbautiefe mm, Außendurchmesser 50 mm, Gewicht 0,078 kg, mit rotationssymmetrisch tief-breit-strahlender Lichtstärkeverteilung. mit Fassung Plug&Play max: 6 W, Auslieferung ohne Leuchtmittel. Gehäusewerkstoff: Aluminium / Glas, Zulässige Umgebungstemperatur (ta): -20 °C - +25 °C, Schutzklasse (EN 61140): III, Schutzart (DIN EN 60529): IP20. Zum direkten Anschluss an Netzspannung, Abhängig vom Betriebsgerät dimmbar. Das Produkt erfüllt die grundlegenden Anforderungen der anwendbaren EU-Richtlinien und des Produktsicherheitsgesetzes und trägt die CE-Kennzeichnung. Brumberg-Artikelnummer: 12963603 , GTIN: 4251433930198')
,(18, '1.2.1.2.1', 'LED-Reflektoreinsatz MR16, 12 W, dim2warm, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Fassung: Plug&Play, Material: Aluminium / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 12W, Lichtstrom: 930lm, Abstrahlwinkel: 38°.')
,(19, '1.3.1.1.1', 'LED-Reflektoreinsatz MR16, 12,5 W, SunLike, CRI > 97. Weitere Informationen zu der SunLike-Technologie finden Sie im Kapitel „Smart Light Solutions“. Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 13W, Lichtstrom: 920lm, Farbtemperatur: 3000K, Lichtfarbe: weiß, Abstrahlwinkel: 38°. ')
,(20, '1.4.1.1.1', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 640lm, Farbtemperatur: 3000K, Abstrahlwinkel: 18°.')
,(21, '1.4.1.1.2', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 690lm, Farbtemperatur: 3000K, Abstrahlwinkel: 24°.')
,(22, '1.4.1.1.3', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 670lm, Farbtemperatur: 3000K, Abstrahlwinkel: 38°.')
,(23, '1.4.1.1.4', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 620lm, Farbtemperatur: 3000K, Abstrahlwinkel: 60°.')
,(24, '1.4.2.1.1', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 685lm, Farbtemperatur: 4000K, Abstrahlwinkel: 18°.')
,(25, '1.4.2.1.2', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 740lm, Farbtemperatur: 4000K, Abstrahlwinkel: 24°.')
,(26, '1.4.2.1.3', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 720lm, Farbtemperatur: 4000K, Abstrahlwinkel: 38°.')
,(27, '1.4.2.1.4', 'LED-Einsatz DISC, MR16, 6 W, mit Linsenoptik, rund. . Fassung: Plug&Play 350mA, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Strom: 350 mA, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 660lm, Farbtemperatur: 4000K, Abstrahlwinkel: 60°.')
,(28, '1.5.1.1.1', 'LED-Einsatz mit Linsenoptik MR16, RGB, rund. RGB-Modul, Anschlussleitung: 4-adrig, Ansteuerung: negativ, gemeinsame Anode (C.A.), Lichtstrom: rot: 65 lm | grün: 135 lm | blau: 30 lm. Fassung: ohne, Material: Aluminium / Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 13,8W, Anzahl der Leuchtmittel / Fassungen: 3.0 Stk, Abstrahlwinkel: 45°.')
,(29, '1.6.1.1.1', 'LED-Reflektoreinsatz MR16, 8 W, dim4colour (RGB+WW), 24 V DC, rund. RGB+WW-Modul, Anschlussleitung: 5-adrig,Ansteuerung: negativ, gemeinsame Anode (C.A.),Lichtstrom: RGB (kombiniert): 165 lm und ''WW (2850 K): 235 lm, Farbwiedergabe (WW): CRI > 90. Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 24V, Leistung: 8W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 400lm, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.')
     

)t (Leuchte_SK, [Image], Produktbeschreibung)
GO
PRINT N'Update abgeschlossen.';


GO
