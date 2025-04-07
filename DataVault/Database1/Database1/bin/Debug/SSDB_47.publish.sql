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
Die Spalte "[sat].[Spot_Leuchte_Stammdaten].[Produktbeschreibung]" in der Tabelle "[sat].[Spot_Leuchte_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [sat].[Spot_Leuchte_Stammdaten])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "[sat].[Spot_Treiber_Stammdaten].[Produktbeschreibung]" in der Tabelle "[sat].[Spot_Treiber_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Die Spalte "[sat].[Spot_Treiber_Stammdaten].[Website]" in der Tabelle "[sat].[Spot_Treiber_Stammdaten]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [sat].[Spot_Treiber_Stammdaten])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Tabelle "[sat].[Spot_Leuchte_Stammdaten]" wird geändert...';


GO
ALTER TABLE [sat].[Spot_Leuchte_Stammdaten]
    ADD [Produktbeschreibung] VARCHAR (MAX) NOT NULL;


GO
PRINT N'Tabelle "[sat].[Spot_Treiber_Stammdaten]" wird geändert...';


GO
ALTER TABLE [sat].[Spot_Treiber_Stammdaten]
    ADD [Produktbeschreibung] VARCHAR (MAX) NOT NULL,
        [Website]             VARCHAR (MAX) NOT NULL;


GO
PRINT N'Tabelle "[hub].[M1_Leuchte]" wird erstellt...';


GO
CREATE TABLE [hub].[M1_Leuchte] (
    [Leuchte_SK]      INT            IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]     NVARCHAR (50)  NOT NULL,
    [Farbkanal]       NVARCHAR (50)  NOT NULL,
    [Lichtfarbe]      NVARCHAR (50)  NOT NULL,
    [Versorgung]      NVARCHAR (50)  NOT NULL,
    [Leistung]        DECIMAL (5, 2) NOT NULL,
    [Abstrahlwinkel]  INT            NOT NULL,
    [Lichtstrom]      INT            NOT NULL,
    [Effizienzklasse] NVARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_hub_M1_Leuchte] PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[M1_Leuchte_Artikel]" wird erstellt...';


GO
CREATE TABLE [sat].[M1_Leuchte_Artikel] (
    [Leuchte_SK]    INT            NOT NULL,
    [Artikelnummer] NVARCHAR (50)  NOT NULL,
    [Preis]         DECIMAL (5, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[M1_Leuchte_Stammdaten]" wird erstellt...';


GO
CREATE TABLE [sat].[M1_Leuchte_Stammdaten] (
    [Leuchte_SK]          INT           NOT NULL,
    [Image]               NVARCHAR (50) NOT NULL,
    [Produktbeschreibung] VARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[M1_Treiber_Artikel]" wird erstellt...';


GO
CREATE TABLE [sat].[M1_Treiber_Artikel] (
    [Treiber_SK]    INT            NOT NULL,
    [Artikelnummer] NVARCHAR (50)  NOT NULL,
    [Preis]         DECIMAL (5, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Treiber_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[M1_Treiber_Stammdaten]" wird erstellt...';


GO
CREATE TABLE [sat].[M1_Treiber_Stammdaten] (
    [Treiber_SK]          INT           NOT NULL,
    [Image]               NVARCHAR (50) NOT NULL,
    [Produktbeschreibung] VARCHAR (MAX) NOT NULL,
    [Website]             VARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Treiber_SK] ASC)
);


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
	,	s1.Produktbeschreibung
	,	s1.Image as Gehaeuse_Image
	,	h2.Lichtfarbe
	,	h2.Farbkanal
	,	h2.Lichtstrom
	,	h2.Leistung
	,	h2.Effizienzklasse
	,	s2.Image as Leuchten_Image
	,	CONCAT(h3.Beschreibung,' ', h3.Versorgung) as Treiber
	,	h3.Beschreibung
	,	h3.Versorgung
	,	h3.Ansteuerung
	,	CONCAT(UPPER(h3.Ansteuerung), ' - ', (h3.Leistung_Min), 'W', ' ... ' , (h3.Leistung_Max), 'W') as Ansteuerung2
	,	h3.Ausführung
	,	s3.Image as Treiber_Image
	,	h3.Leistung_Min
	,	h3.Leistung_Max


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
PRINT N'Prozedur "[dbo].[load_sat_Spot_Leuchte_Stammdaten]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_sat_Spot_Leuchte_Stammdaten] as

TRUNCATE TABLE sat.Spot_Leuchte_Stammdaten

INSERT INTO sat.Spot_Leuchte_Stammdaten (Leuchte_SK, [Image], Produktbeschreibung)
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
    
     

)t (Leuchte_SK, [Image], Produktbeschreibung)
GO
PRINT N'Prozedur "[dbo].[load_sat_Spot_Treiber_Stammdaten]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_sat_Spot_Treiber_Stammdaten] as

TRUNCATE TABLE sat.Spot_Treiber_Stammdaten

INSERT INTO sat.Spot_Treiber_Stammdaten (Treiber_SK, [Image], Produktbeschreibung, Website)
SELECT * FROM (VALUES


	(1  , '1.1.1.1', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Maximale Leitungslänge sekundärseitig: 2.000 mm. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-5W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konv-350ma5w-3-15v-nicht-dimmbar/de?number=17666000'),
	(2  , '1.1.2.1', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-7,2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4499-de?number=17662000'),
	(3  , '1.1.2.2', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-7,2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4499-de?number=17662010'),
	(4  , '1.1.2.3', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-7,2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4499-de?number=17662020'),
	(5  , '1.1.3.1', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0-15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konv350ma-15w-max43vnicht-dimmb/de?number=17613000'),
	(6  , '1.1.3.2', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0-15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konv350ma-15w-max43vnicht-dimmb/de?number=17613010'),
	(7  , '1.1.3.3', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0-15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konv350ma-15w-max43vnicht-dimmb/de?number=17613020'),
	(8  , '1.1.4.1', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4498-de?number=17621000'),
	(9  , '1.1.4.2', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4498-de?number=17621010'),
	(10 , '1.1.4.3', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4498-de?number=17621020'),
	(11 , '1.2.1.1', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 2,8-7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4501-de?number=17663000'),
	(12 , '1.2.1.2', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 2,8-7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4501-de?number=17663010'),
	(13 , '1.2.1.3', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 2,8-7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4501-de?number=17663020'),
	(14 , '1.2.2.1', 'LED-Rundkonverter 350 mA, Phasenabschnitt dimmbar. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 4,9-7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-phasenabschnitt-dimmbar-4496-de?number=17652000'),
	(15 , '1.2.2.3', 'LED-Rundkonverter 350 mA, Phasenabschnitt dimmbar. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 4,9-7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-phasenabschnitt-dimmbar-4496-de?number=17652020'),
	(16 , '1.2.3.1', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 4,2-10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17640000/de?number=17640000'),
	(17 , '1.2.3.2', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 4,2-10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17640000/de?number=17640010'),
	(18 , '1.2.3.3', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 4,2-10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17640000/de?number=17640020'),
	(19 , '1.2.4.1', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0,7-17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4524-de?number=17648000'),
	(20 , '1.2.4.2', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0,7-17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4524-de?number=17648010'),
	(21 , '1.2.4.3', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0,7-17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4524-de?number=17648020'),
	(22 , '1.2.5.1', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 8,75-18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4504-de?number=17643000'),
	(23 , '1.2.5.2', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 8,75-18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4504-de?number=17643010'),
	(24 , '1.2.5.3', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 8,75-18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4504-de?number=17643020'),
	(25 , '1.2.6.1', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 10,15-14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4502-de?number=17664000'),
	(26 , '1.2.6.2', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 10,15-14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4502-de?number=17664010'),
	(27 , '1.2.6.3', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 10,15-14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4502-de?number=17664020'),
	(28 , '1.3.1.1', 'LED-Konverter 350 mA, 1-10 V dimmbar (analog). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 5,25-18W, Art der Dimmung: 1-10 V.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-1-10-v-dimmbar-analog-4505-de?number=17657000'),
	(29 , '1.3.1.2', 'LED-Konverter 350 mA, 1-10 V dimmbar (analog). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 5,25-18W, Art der Dimmung: 1-10 V.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-1-10-v-dimmbar-analog-4505-de?number=17657010'),
	(30 , '1.4.1.1', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 3,5-17W, Art der Dimmung: DALI-2, nicht abwärtskompatibel.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-4506-de?number=17683000'),
	(31 , '1.4.1.2', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 3,5-17W, Art der Dimmung: DALI-2, nicht abwärtskompatibel.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-4506-de?number=17683010'),
	(32 , '1.4.1.3', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 3,5-17W, Art der Dimmung: DALI-2, nicht abwärtskompatibel.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-4506-de?number=17683020'),
	(33 , '1.4.2.1', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658000'),
	(34 , '1.4.2.2', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658010'),
	(35 , '1.4.2.3', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658020'),
	(36 , '1.5.1.1', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-4529-de?number=17672000'),
	(37 , '1.5.1.2', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-4529-de?number=17672010'),
	(38 , '1.5.1.3', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-4529-de?number=17672020'),
	(39 , '1.6.1.1', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18,5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-4527-de?number=17671000'),
	(40 , '1.6.1.2', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18,5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-4527-de?number=17671010'),
	(41 , '1.6.1.3', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18,5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-4527-de?number=17671020')


)t (Treiber_SK, [Image], Produktbeschreibung, Website)
GO
PRINT N'Prozedur "[dbo].[load_hub_M1_Leuchte]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_M1_Leuchte] as

TRUNCATE TABLE hub.M1_Leuchte

INSERT INTO hub.M1_Leuchte (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom, Effizienzklasse)

SELECT * FROM (VALUES


 ('MR16',	'Statisch'	, '2700 K'       	,'350mA'    ,3	    ,38	,290	,'A++')
,('MR16',	'Statisch'	, '2700 K'       	,'350mA'    ,6	    ,38	,680	,'A+')
,('MR16',	'Statisch'	, '2700 K'       	,'350mA'    ,6	    ,60	,680	,'A+')
,('MR16',	'Statisch'	, '2700 K'       	,'350mA'    ,12	    ,38	,1120	,'A+')
,('MR16',	'Statisch'	, '3000 K'        ,'350mA'    ,3	    ,38	,310	,'A++')
,('MR16',	'Statisch'	, '3000 K'        ,'350mA'    ,6	    ,38	,680	,'A+')
,('MR16',	'Statisch'	, '3000 K'        ,'350mA'    ,6	    ,60	,680	,'A+')
,('MR16',	'Statisch'	, '3000 K'        ,'350mA'    ,12	    ,38	,1210	,'A+')
,('MR16',	'Statisch'	, '3500 K'       	,'350mA'    ,6	    ,38	,680	,'A++')
,('MR16',	'Statisch'	, '3500 K'       	,'350mA'    ,6	    ,60	,680	,'A++')
,('MR16',	'Statisch'	, '3500 K'       	,'350mA'    ,12	    ,38	,1240	,'A+')
,('MR16',	'Statisch'	, '4000 K'       	,'350mA'    ,3	    ,38	,340	,'A++')
,('MR16',	'Statisch'	, '4000 K'       	,'350mA'    ,6	    ,38	,720	,'A+')
,('MR16',	'Statisch'	, '4000 K'       	,'350mA'    ,6	    ,60	,720	,'A+')
,('MR16',	'Statisch'	, '4000 K'       	,'350mA'    ,12	    ,38	,1250	,'A+')
,('MR16',	'D2W'	      , '3000 K…1800K'  ,'350mA'    ,6	    ,38	,460	,'A+')
,('MR16',	'D2W'    	  , '3000 K…1800K'	,'350mA'    ,6	    ,60	,460	,'A+')
,('MR16',	'D2W'    	  , '3000 K…1800K'	,'350mA'    ,12	    ,38	,930	,'A+')
,('MR16',	'SUNLIKE'	  , '3000 K'	      ,'350mA'    ,12.5	  ,38	,920	,'A')
,('MR16',	'DISC'	    , '3000 K'	      ,'350mA'    ,6	    ,18	,640	,'A++')
,('MR16',	'DISC'	    , '3000 K'	      ,'350mA'    ,6	    ,24	,690	,'A++')
,('MR16',	'DISC'	    , '3000 K'	      ,'350mA'    ,6	    ,38	,670	,'A++')
,('MR16',	'DISC'	    , '3000 K'	      ,'350mA'    ,6	    ,60	,620	,'A++')
,('MR16',	'DISC'	    , '4000 K'	      ,'350mA'    ,6	    ,18	,685	,'A++')
,('MR16',	'DISC'	    , '4000 K'	      ,'350mA'    ,6	    ,24	,740	,'A++')
,('MR16',	'DISC'	    , '4000 K'	      ,'350mA'    ,6	    ,38	,720	,'A++')
,('MR16',	'DISC'	    , '4000 K'	      ,'350mA'    ,6	    ,60	,660	,'A++')
,('MR16',	'RGB'	      , 'RGB' 	        ,'350mA'   ,13.8	  ,45	,230	,'Sonder')
,('MR16',	'RGB'	      , 'RGB+WW' 	      ,'350mA'   ,8   	  ,60	,235	,'Sonder')




)t (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom, Effizienzklasse)
GO
PRINT N'Prozedur "[dbo].[load_sat_M1_Leuchte_Artikel]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_M1_Leuchte_Artikel] as

TRUNCATE TABLE sat.M1_Leuchte_Artikel

INSERT INTO sat.M1_Leuchte_Artikel (Leuchte_SK, Artikelnummer, Preis)
SELECT * FROM (VALUES



  (1,      '12925003',      44.5),
	(2,      '12923383',      63.5),
	(3,      '12923603',      63.5),
	(4,      '12953003',      99.6),
	(5,      '12926003',      44.5),
	(6,      '12924383',      63.5),
	(7,      '12924603',      63.5),
	(8,      '12954003',      99.6),
	(9,      '12924384',      63.5),
	(10,     '12924604',      63.5),
	(11,     '12954004',      99.6),
	(12,     '12925004',      44.5),
	(13,     '12923384',      63.5),
	(14,     '12923604',      63.5),
	(15,     '12953004',      99.6),
	(16,     '12963383',      76.9),
	(17,     '12963603',      76.9),
	(18,     '12965003',      116.5),
	(19,     '12983003',      116.5),
	(20,     '12920183',      39.5),
	(21,     '12920243',      39.5),
	(22,     '12920003',      39.5),
	(23,     '12920603',      39.5),
	(24,     '12920184',      39.5),
	(25,     '12920244',      39.5),
	(26,     '12920004',      39.5),
	(27,     '12920604',      39.5),
	(28,     '18101001',      164.9),
	(29,     '18438002',      164.9)
     

)t (Leuchte_SK, Artikelnummer, Preis)
GO
PRINT N'Prozedur "[dbo].[load_sat_M1_Leuchte_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_M1_Leuchte_Stammdaten] as

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
,(29, '1.6.1.1.1', '"LED-Reflektoreinsatz MR16, 8 W, dim4colour (RGB+WW), 24 V DC, rund. RGB+WW-Modul, Anschlussleitung: 5-adrig,Ansteuerung: negativ, gemeinsame Anode (C.A.),Lichtstrom: RGB (kombiniert): 165 lm und ''WW (2850 K): 235 lm, Farbwiedergabe (WW): CRI > 90. Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 24V, Leistung: 8W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 400lm, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät."')
     

)t (Leuchte_SK, [Image])
GO
PRINT N'Prozedur "[dbo].[load_sat_M1_Treiber_Artikel]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_M1_Treiber_Artikel] as

TRUNCATE TABLE sat.M1_Treiber_Artikel

INSERT INTO sat.M1_Treiber_Artikel (Treiber_SK, Artikelnummer, Preis)
SELECT * FROM (VALUES


 (1	      ,'17666000'	      ,37.1)
,(2	      ,'17662000'	      ,30.2)
,(3	      ,'17662010'	      ,26.9)
,(4	      ,'17662020'	      ,39.9)
,(5	      ,'17613000'	      ,54.9)
,(6	      ,'17613010'	      ,45.9)
,(7	      ,'17613020'	      ,59.7)
,(8	      ,'17621000'	      ,59.9)
,(9	      ,'17621010'	      ,54.9)
,(10	    ,'17621020'	      ,65.9)
,(11	    ,'17663000'	      ,34.9)
,(12	    ,'17663010'	      ,32.9)
,(13	    ,'17663020'	      ,43.7)
,(14	    ,'17652000'	      ,50.4)
,(15	    ,'17652020'	      ,56.9)
,(16	    ,'17640000'	      ,47.3)
,(17	    ,'17640010'	      ,44.9)
,(18	    ,'17640020'	      ,54.9)
,(19	    ,'17648000'	      ,119.9)
,(20	    ,'17648010'	      ,117.9)
,(21	    ,'17648020'	      ,129.9)
,(22	    ,'17643000'	      ,49.9)
,(23	    ,'17643010'	      ,45.9)
,(24	    ,'17643020'	      ,57.6)
,(25	    ,'17664000'	      ,50.3)
,(26	    ,'17664010'	      ,47.9)
,(27	    ,'17664020'	      ,59.9)
,(28	    ,'17657000'	      ,75.5)
,(29	    ,'17657010'	      ,73.0)
,(30	    ,'17683000'	      ,89.7)
,(31	    ,'17683010'	      ,84.9)
,(32	    ,'17683020'	      ,93.9)
,(33	    ,'17658000'	      ,106.9)
,(34	    ,'17658010'	      ,103.9)
,(35	    ,'17658020'	      ,112.9)
,(36	    ,'17672000'	      ,229.9)
,(37	    ,'17672010'	      ,224.9)
,(38	    ,'17672020'	      ,234.9)
,(39	    ,'17671000'	      ,189.9)
,(40	    ,'17671010'	      ,179.9)
,(41	    ,'17671020'	      ,199.9)


     

)t (Treiber_SK, Artikelnummer, Preis)
GO
PRINT N'Prozedur "[dbo].[load_sat_M1_Treiber_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_M1_Treiber_Stammdaten] as

TRUNCATE TABLE sat.M1_Treiber_Stammdaten

INSERT INTO sat.M1_Treiber_Stammdaten (Treiber_SK, [Image], Produktbeschreibung, Website)
SELECT * FROM (VALUES


	(1  , '1.1.1.1', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Maximale Leitungslänge sekundärseitig: 2.000 mm. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-5W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konv-350ma5w-3-15v-nicht-dimmbar/de?number=17666000'),
	(2  , '1.1.2.1', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-7,2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4499-de?number=17662000'),
	(3  , '1.1.2.2', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-7,2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4499-de?number=17662010'),
	(4  , '1.1.2.3', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-7,2W, Dimmbar: Nein, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4499-de?number=17662020'),
	(5  , '1.1.3.1', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0-15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konv350ma-15w-max43vnicht-dimmb/de?number=17613000'),
	(6  , '1.1.3.2', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0-15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konv350ma-15w-max43vnicht-dimmb/de?number=17613010'),
	(7  , '1.1.3.3', 'LED-Konverter 350 mA, schaltbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0-15W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konv350ma-15w-max43vnicht-dimmb/de?number=17613020'),
	(8  , '1.1.4.1', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4498-de?number=17621000'),
	(9  , '1.1.4.2', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4498-de?number=17621010'),
	(10 , '1.1.4.3', 'LED-Konverter 350 mA, schaltbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 1-21W, Art der Dimmung: schaltbar.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-schaltbar-4498-de?number=17621020'),
	(11 , '1.2.1.1', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 2,8-7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4501-de?number=17663000'),
	(12 , '1.2.1.2', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 2,8-7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4501-de?number=17663010'),
	(13 , '1.2.1.3', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 2,8-7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4501-de?number=17663020'),
	(14 , '1.2.2.1', 'LED-Rundkonverter 350 mA, Phasenabschnitt dimmbar. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 4,9-7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-phasenabschnitt-dimmbar-4496-de?number=17652000'),
	(15 , '1.2.2.3', 'LED-Rundkonverter 350 mA, Phasenabschnitt dimmbar. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 4,9-7W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-phasenabschnitt-dimmbar-4496-de?number=17652020'),
	(16 , '1.2.3.1', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 4,2-10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17640000/de?number=17640000'),
	(17 , '1.2.3.2', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 4,2-10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17640000/de?number=17640010'),
	(18 , '1.2.3.3', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 2,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 4,2-10W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-17640000/de?number=17640020'),
	(19 , '1.2.4.1', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0,7-17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4524-de?number=17648000'),
	(20 , '1.2.4.2', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0,7-17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4524-de?number=17648010'),
	(21 , '1.2.4.3', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 0,7-17W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4524-de?number=17648020'),
	(22 , '1.2.5.1', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 8,75-18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4504-de?number=17643000'),
	(23 , '1.2.5.2', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 8,75-18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4504-de?number=17643010'),
	(24 , '1.2.5.3', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. . Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 8,75-18W, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4504-de?number=17643020'),
	(25 , '1.2.6.1', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 10,15-14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4502-de?number=17664000'),
	(26 , '1.2.6.2', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 10,15-14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4502-de?number=17664010'),
	(27 , '1.2.6.3', 'LED-Konverter 350 mA, Phasenabschnitt dimmbar. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 10,15-14W, Dimmbar: Ja, Art der Dimmung: Phasenabschnitt.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-phasenabschnitt-dimmbar-4502-de?number=17664020'),
	(28 , '1.3.1.1', 'LED-Konverter 350 mA, 1-10 V dimmbar (analog). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 5,25-18W, Art der Dimmung: 1-10 V.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-1-10-v-dimmbar-analog-4505-de?number=17657000'),
	(29 , '1.3.1.2', 'LED-Konverter 350 mA, 1-10 V dimmbar (analog). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 5,25-18W, Art der Dimmung: 1-10 V.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-1-10-v-dimmbar-analog-4505-de?number=17657010'),
	(30 , '1.4.1.1', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 3,5-17W, Art der Dimmung: DALI-2, nicht abwärtskompatibel.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-4506-de?number=17683000'),
	(31 , '1.4.1.2', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 3,5-17W, Art der Dimmung: DALI-2, nicht abwärtskompatibel.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-4506-de?number=17683010'),
	(32 , '1.4.1.3', 'LED-Konverter 350 mA, DALI dimmbar, (digital). Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von 0,75-1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz , Leistung: 3,5-17W, Art der Dimmung: DALI-2, nicht abwärtskompatibel.', 'https://www.brumberg.com/de/produkte/led-konverter-350-ma-dali-dimmbar-digital-4506-de?number=17683020'),
	(33 , '1.4.2.1', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658000'),
	(34 , '1.4.2.2', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658010'),
	(35 , '1.4.2.3', 'LED-Rundkonverter 350 mA, DALI dimmbar (digital). Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Spannung: 230V AC 50Hz, Leistung: 9W, Dimmbar: Ja, Art der Dimmung: DALI-2.', 'https://www.brumberg.com/de/produkte/led-rundkonverter-350-ma-dali-dimmbar-digital-17658020'),
	(36 , '1.5.1.1', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-4529-de?number=17672000'),
	(37 , '1.5.1.2', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-4529-de?number=17672010'),
	(38 , '1.5.1.3', 'LED-Konverter 350mA, Casambi dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18W, Dimmbar: Ja, Art der Dimmung: Casambi.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-casambi-dimmbar-4529-de?number=17672020'),
	(39 , '1.6.1.1', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18,5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-4527-de?number=17671000'),
	(40 , '1.6.1.2', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18,5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-4527-de?number=17671010'),
	(41 , '1.6.1.3', 'LED-Konverter 350mA, ZigBee dimmbar. Dieses Betriebsgerät erfüllt die Anforderungen für Sicherheitsbeleuchtungsanlagen nach DIN EN 50172 VDE 0108-100:2005-01. Dieser Konverter ist durch Sicherungseinrichtungen gegen Überspannung und Kurzschluss sowie thermische und elektrische Überlastung geschützt. Die Eingangs- und die Ausgangsklemme ist für Leitungen mit einem Querschnitt von bis zu 1,5 mm² geeignet. Material: Kunststoff, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) II, Strom: 350 mA, Spannung: 230V AC 50Hz, Leistung: 3,5-18,5W, Dimmbar: Ja, Art der Dimmung: ZigBee.', 'https://www.brumberg.com/de/produkte/led-konverter-350ma-zigbee-dimmbar-4527-de?number=17671020')


)t (Treiber_SK, [Image], Produktbeschreibung, Website)
GO
PRINT N'Update abgeschlossen.';


GO
