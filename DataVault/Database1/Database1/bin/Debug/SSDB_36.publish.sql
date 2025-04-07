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
PRINT N'Tabelle "[sat].[Spot_Gehaeuse_Artikel]" wird erstellt...';


GO
CREATE TABLE [sat].[Spot_Gehaeuse_Artikel] (
    [Gehaeuse_SK]   INT            NOT NULL,
    [Artikelnummer] NVARCHAR (50)  NOT NULL,
    [Preis]         DECIMAL (5, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Gehaeuse_SK] ASC)
);


GO
PRINT N'Sicht "[fakt].[Spot]" wird erstellt...';


GO
CREATE VIEW [fakt].[Spot] as 

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
PRINT N'Prozedur "[dbo].[sat_Spot_Gehaeuse_Artikel]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_Spot_Gehaeuse_Artikel] as

TRUNCATE TABLE sat.Spot_Gehaeuse_Artikel

INSERT INTO sat.Spot_Gehaeuse_Artikel (Gehaeuse_SK, Artikelnummer, Preis)
SELECT * FROM (VALUES

 (1	    ,'1963.02'	          , 27.40)
,(2	    ,'1963.03'	          , 34.70)
,(3	    ,'1963.05'	          , 31.40)
,(4	    ,'1963.08'	          , 22.50)
,(5	    ,'1963.17'	          , 22.50)
,(6	    ,'1963.07'	          , 24.80)
,(7	    ,'1963.15'	          , 34.70)
,(8	    ,'1964.02'	          , 31.80)
,(9	    ,'1964.03'	          , 37.30)
,(10	  ,'1964.05'	          , 34.70)
,(11	  ,'1964.08'	          , 29.60)
,(12	  ,'1964.17'	          , 29.60)
,(13	  ,'1964.07'	          , 29.60)
,(14	  ,'1964.15'	          , 36.90)
,(15	  ,'2034.02'	          , 23.60)
,(16	  ,'2034.03'	          , 30.10)
,(17	  ,'2034.05'	          , 24.80)
,(18	  ,'2034.07'	          , 17.20)
,(19	  ,'2034.08'	          , 19.90)
,(20	  ,'0282.00'	          , 26.40)
,(21	  ,'37005070'	          , 84.40)
,(22	  ,'37005420'	          , 87.60)
,(23	  ,'2169.02'	          , 26.90)
,(24	  ,'2169.03'	          , 30.00)
,(25	  ,'2169.07'	          , 19.90)
,(26	  ,'2295.02'	          , 19.90)
,(27	  ,'2295.07'	          , 14.90)
,(28	  ,'2295.15'	          , 20.90)
,(29	  ,'2296.02'	          , 21.30)
,(30	  ,'2296.07'	          , 16.90)
,(31	  ,'2296.15'	          , 22.50)
,(32	  ,'2062.02'	          , 39.90)
,(33	  ,'2062.07'	          , 35.90)
,(34	  ,'2062.25'	          , 37.90)
,(35	  ,'2339.42'	          , 80.90)
,(36	  ,'1180.22'	          , 98.90)
,(37	  ,'1181.22'	          , 10.40)
,(38	  ,'2191.07'	          , 33.50)
,(39	  ,'2191.20'	          , 33.50)
,(40	  ,'2191.22'	          , 30.60)
,(41	  ,'0066.00'	          , 33.00)
,(42	  ,'0064.00'	          , 27.00)
,(43	  ,'0069.25'	          , 30.80)
,(44	  ,'0070.25'	          , 32.90)
,(45	  ,'512811' 	          , 53.80)
,(46	  ,'0063.60'	          , 38.50)
,(47	  ,'0063.62'	          , 38.50)
,(48	  ,'0063.80'	          , 38.50)
,(49	  ,'0283.00'	          , 33.60)
,(50	  ,'20353070' 	        , 28.90)
,(51	  ,'20353150' 	        , 31.90)
,(52	  ,'20353680' 	        , 26.80)
,(53	  ,'20355070' 	        , 29.90)
,(54	  ,'20355150' 	        , 33.90)
,(55	  ,'20355680' 	        , 27.90)
,(56	  ,'2110.02'	          , 36.50)
,(57	  ,'2110.07'	          , 34.40)
,(58	  ,'2110.15'	          , 45.90)
,(59	  ,'2111.02'	          , 36.90)
,(60	  ,'2111.07'	          , 34.90)
,(61	  ,'2111.15'	          , 46.90)
,(62	  ,'20001070' 	        , 56.90)
,(63	  ,'20001250' 	        , 56.90)
,(64	  ,'0063.02'	          , 25.90)
,(65	  ,'0063.07'	          , 24.80)
,(66	  ,'0063.08'	          , 24.80)
,(67	  ,'0063.17'	          , 24.80)
,(68	  ,'0063.25'	          , 24.80)
,(69	  ,'0063.63'	          , 30.80)
,(70	  ,'0063.64'	          , 30.80)
,(71	  ,'0065.02'	          , 28.60)
,(72	  ,'0065.07'	          , 27.00)
,(73	  ,'0065.08'	          , 27.00)
,(74	  ,'0065.17'	          , 27.00)
,(75	  ,'0065.25'	          , 27.00)
,(76	  ,'0065.63'	          , 33.00)
,(77	  ,'0065.64'	          , 33.00)
,(78	  ,'37006070' 	        , 90.10)
,(79	  ,'37006420' 	        , 94.90)
,(80	  ,'45320070' 	        , 58.20)
,(81	  ,'45320080' 	        , 58.20)
,(82	  ,'45321070' 	        , 60.50)
,(83	  ,'45321080' 	        , 60.50)
,(84	  ,'20368070' 	        , 42.90)
,(85	  ,'20368150' 	        , 47.90)
,(86	  ,'20368680' 	        , 40.30)
,(87	  ,'26004070' 	        , 71.30)
,(88	  ,'26004080' 	        , 71.30)
,(89	  ,'26004220' 	        , 71.30)
,(90	  ,'26005070' 	        , 74.30)
,(91	  ,'26005080' 	        , 74.30)
,(92	  ,'26005220' 	        , 74.30)



)t (Gehaeuse_SK, Artikelnummer, Preis)
GO
PRINT N'Update abgeschlossen.';


GO
