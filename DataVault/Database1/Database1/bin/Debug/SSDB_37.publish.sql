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
PRINT N'Prozedur "[dbo].[load_sat_Biro40_Leuchte_Artikel_MA]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Biro40_Leuchte_Artikel_MA] as

TRUNCATE TABLE sat.Biro40_Leuchte_Artikel_MA;

WITH cte as
(
	SELECT Leuchte_SK, [Min] , [Step], [Max], [Min] as newval  FROM sat.Biro40_Leuchte_Laengen

	UNION ALL

	SELECT Leuchte_SK, [Min] , [Step], [Max],  newval + [step] from cte
	WHERE newval < [max]

)
INSERT INTO sat.Biro40_Leuchte_Artikel_MA (Leuchte_SK, Mass, Artikelnummer)
SELECT Leuchte_SK, newval as Mass, 0 AS Artikelnummer  FROM cte

order by Leuchte_SK, Mass
GO
PRINT N'Prozedur "[dbo].[load_sat_Biro40_Leuchte_Laengen]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Biro40_Leuchte_Laengen] as

TRUNCATE TABLE sat.Biro40_Leuchte_Laengen

INSERT INTO sat.Biro40_Leuchte_Laengen(Leuchte_SK, [Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
SELECT * FROM (VALUES


 (1,  560	    ,  2380 	, 140	,586   , 2	, 5)
,(2,  560	    ,  2380 	, 140	,586   , 2	, 5)
,(3,  840	    ,  2380 	, 140	,586   , 2	, 5)
,(4,  840	    ,  2380 	, 140	,586   , 2	, 5)
,(5,  980	    ,  2520 	, 70	,586   , 2	, 5)
,(6,  2520  	,  5600 	, 280	,586   , 2	, 5)
,(7,  560	    ,  2240 	, 140	,586   , 2	, 5)
,(8,  560	    ,  2240 	, 140	,586   , 2	, 5)
,(9,  560	    ,  2240 	, 140	,586   , 2	, 5)
,(10, 560	    ,  2240 	, 140	,586   , 2	, 5)
,(11, 2520  	,  2520 	, 2520  ,586   , 2	, 5)
,(12, 1050  	,  1050 	, 1050  ,586   , 2	, 5)
,(13, 1120  	,  1120 	, 1120  ,586   , 2	, 5)
,(14, 1190  	,  1190 	, 1190  ,586   , 2	, 5)
,(15, 1260  	,  1260 	, 1260  ,586   , 2	, 5)
,(16, 1330  	,  1330 	, 1330  ,586   , 2	, 5)



)t (Leuchte_SK ,[Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
GO
PRINT N'Prozedur "[dbo].[load_sat_Biro40_Optik_Laengen]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Biro40_Optik_Laengen] as

TRUNCATE TABLE sat.Biro40_Optik_Laengen

INSERT INTO sat.Biro40_Optik_Laengen(Leuchte_SK, [Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
SELECT * FROM (VALUES


 (1,  1500	    ,  1500 	, 1500	,586   , 0	, 0)
,(2,  3000	    ,  3000 	, 3000	,586   , 0	, 0)
,(3,  1500	    ,  1500 	, 1500	,586   , 0	, 0)
,(4,  3000	    ,  3000 	, 3000	,586   , 0	, 0)


)t (Leuchte_SK ,[Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
GO
PRINT N'Prozedur "[dbo].[load_sat_Biro40_Profil_Laengen]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Biro40_Profil_Laengen] as

TRUNCATE TABLE sat.Biro40_Profil_Laengen

INSERT INTO sat.Biro40_Profil_Laengen(Leuchte_SK, [Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
SELECT * FROM (VALUES


 (1,  1500	    ,  1500 	, 1500	,586   , 0	, 0)
,(2,  3000	    ,  3000 	, 3000	,586   , 0	, 0)
,(3,  1500	    ,  1500 	, 1500	,586   , 0	, 0)
,(4,  3000	    ,  3000 	, 3000	,586   , 0	, 0)


)t (Leuchte_SK ,[Min], [Max], [Step], [Ecke], [Toleranz], [Abzug])
GO
PRINT N'Prozedur "[dbo].[load_sat_Spot_Gehaeuse_Artikel]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Spot_Gehaeuse_Artikel] as

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
PRINT N'Prozedur "[dbo].[load_sat_Spot_Gehaeuse_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Spot_Gehaeuse_Stammdaten] as

TRUNCATE TABLE sat.Spot_Gehaeuse_Stammdaten

INSERT INTO sat.Spot_Gehaeuse_Stammdaten (Gehaeuse_SK, Schutzart, Einbaudurchmesser, Einbautiefe, Schwenkwinkel, Leistung, Ausführung, [Image], Produktbeschreibung)
SELECT * FROM (VALUES

 (1		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.1.jpg'		,'Einbaustrahler, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(2		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.2.jpg'		,'Einbaustrahler, GX5,3, chrom matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(3		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.3.jpg'		,'Einbaustrahler, GX5,3, gold, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(4		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.4.jpg'		,'Einbaustrahler, GX5,3,schwarz, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(5		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.5.jpg'		,'Einbaustrahler, GX5,3, strukturweiss, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(6		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.6.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(7		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.1.7.jpg'		,'Einbaustrahler, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(8		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.1.jpg'		,'Einbaustrahler, GX5,3, chrom, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(9		,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.2.jpg'		,'Einbaustrahler, GX5,3, chrom matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(10	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.3.jpg'		,'Einbaustrahler, GX5,3, gold, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(11	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.4.jpg'		,'Einbaustrahler, GX5,3, schwarz, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(12	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.5.jpg'		,'Einbaustrahler, GX5,3, strukturweiss, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(13	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.6.jpg'		,'Einbaustrahler, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(14	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.2.7.jpg'		,'Einbaustrahler, GX5,3, nickel matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(15	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.3.1.jpg'		,'Einbaustrahler, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl / Messing, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(16	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.3.2.jpg'		,'Einbaustrahler, GX5,3, chrom matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl / Messing, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(17	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.3.3.jpg'		,'Einbaustrahler, GX5,3, gold, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl / Messing, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(18	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.3.4.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl / Messing, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(19	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.3.5.jpg'		,'Einbaustrahler, GX5,3, schwarz, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl / Messing, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(20	,'IP20'		,68		,50		,0		,50		,'GX5,3'			,'1.4.1.jpg'		,'Einbaudownlight, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(21	,'IP65'		,68		,55		,0		,14		,'ohne Fassung'		,'1.5.1.jpg'		,'Einbaudownlight, V4A, IP65, strukturweiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit STEAM verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweilseingesetzten LED-Modul (hier: 2 mm, zzgl. Höhe des LED-Moduls).Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl / Aluminium / Kunststoff / Glas, Schutzart raumseitig: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(22	,'IP65'		,68		,55		,0		,14		,'ohne Fassung'		,'1.5.2.jpg'		,'Einbaudownlight, V4A, IP65, edelstahl, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit STEAM verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweilseingesetzten LED-Modul (hier: 2 mm, zzgl. Höhe des LED-Moduls).Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl / Aluminium / Kunststoff / Glas, Schutzart raumseitig: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(23	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.6.1.jpg'		,'Einbaustrahler, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(24	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.6.2.jpg'		,'Einbaustrahler, GX5,3, chrom matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(25	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.6.3.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(26	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.7.1.jpg'		,'Einbaustrahler, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(27	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.7.2.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(28	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.7.3.jpg'		,'Einbaustrahler, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(29	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.8.1.jpg'		,'Einbaustrahler, GX5,3, chrom, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(30	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.8.2.jpg'		,'Einbaustrahler, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(31	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.8.3.jpg'		,'Einbaustrahler, GX5,3, nickel matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Stahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(32	,'IP65'		,68		,80		,0		,50		,'GX5,3'			,'1.9.1.jpg'		,'Einbaudownlight, IP65, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss / Glas, Schutzart: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(33	,'IP65'		,68		,80		,0		,50		,'GX5,3'			,'1.9.2.jpg'		,'Einbaudownlight, IP65, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss / Glas, Schutzart: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(34	,'IP65'		,68		,80		,0		,50		,'GX5,3'			,'1.9.3.jpg'		,'Einbaudownlight, IP65, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Guss / Glas, Schutzart: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(35	,'IP65'		,68		,80		,0		,50		,'GX5,3'			,'1.10.1.jpg'		,'Einbaudownlight, V4A, IP65, GX5,3, edelstahl, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl / Glas, Schutzart: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(36	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.11.1.jpg'		,'Einbaustrahler, V4A, GX5,3, edelstahl, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(37	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.12.1.jpg'		,'Einbaustrahler, V4A, GX5,3, edelstahl, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(38	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.13.1.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(39	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.13.2.jpg'		,'Einbaustrahler, GX5,3, edelstahl klar gepulvert, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(40	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.13.3.jpg'		,'Einbaustrahler, GX5,3, edelstahl, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(41	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.14.1.jpg'		,'Einbaustrahler, GX5,3, schwarz / alu matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(42	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.15.1.jpg'		,'Einbaustrahler, GX5,3, schwarz / alu matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(43	,'IP20'		,75		,55		,30		,50		,'GX5,3'			,'1.16.1.jpg'		,'Einbaustrahler, GX5,3, alu matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(44	,'IP20'		,75		,55		,30		,50		,'GX5,3'			,'1.17.1.jpg'		,'Einbaustrahler, GX5,3, alu matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(45	,'IP20'		,80		,55		,30		,50		,'GX5,3'			,'1.18.1.jpg'		,'Einbaustrahler, GX5,3, alu matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(46	,'IP20'		,68		,70		,25		,50		,'GX5,3'			,'1.19.1.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(47	,'IP20'		,68		,70		,25		,50		,'GX5,3'			,'1.19.2.jpg'		,'Einbaustrahler, GX5,3, alu matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(48	,'IP20'		,68		,70		,25		,50		,'GX5,3'			,'1.19.3.jpg'		,'Einbaustrahler, GX5,3, schwarz, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(49	,'IP20'		,68		,50		,0		,50		,'GX5,3'			,'1.20.1.jpg'		,'Einbaudownlight, GX5,3, chrom, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss / Glas, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(50	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.21.1.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(51	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.21.2.jpg'		,'Einbaustrahler, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(52	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.21.3.jpg'		,'Einbaustrahler, GX5,3, silber, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(53	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.22.1.jpg'		,'Einbaustrahler, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(54	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.22.2.jpg'		,'Einbaustrahler, GX5,3, nickel matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(55	,'IP20'		,74		,55		,40		,50		,'GX5,3'			,'1.22.3.jpg'		,'Einbaustrahler, GX5,3, silber, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar.')
,(56	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.23.1.jpg'		,'Einbaustrahler, GX5,3, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(57	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.23.2.jpg'		,'Einbaustrahler, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(58	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.23.3.jpg'		,'Einbaustrahler, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(59	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.24.1.jpg'		,'Einbaustrahler, GX5,3, chrom, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(60	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.24.2.jpg'		,'Einbaustrahler, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(61	,'IP20'		,70		,55		,25		,50		,'ohne Fassung'		,'1.24.3.jpg'		,'Einbaustrahler, GX5,3, nickel matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: ohne Fassung, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminiumguss, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät.')
,(62	,'IP20'		,75		,55		,30		,50		,'GX5,3'			,'1.25.1.jpg'		,'Einbaustrahler, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Verstellbarkeit: drehbar und schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(63	,'IP20'		,75		,55		,30		,50		,'GX5,3'			,'1.25.2.jpg'		,'Einbaustrahler, GX5,3, alu matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauAusführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Verstellbarkeit: drehbar und schwenkbar, ohne Betriebsgerät, Art der Dimmung: abhängig vom Betriebsgerät .')
,(64	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.1.jpg'		,'Einbaustrahler, chrom, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(65	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.2.jpg'		,'Einbaustrahler, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(66	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.3.jpg'		,'Einbaustrahler, schwarz, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50WW, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(67	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.4.jpg'		,'Einbaustrahler, GX5,3, strukturweiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(68	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.5.jpg'		,'Einbaustrahler, alu matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige. ')
,(69	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.6.jpg'		,'Einbaustrahler, champagner matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(70	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.26.7.jpg'		,'Einbaustrahler, titan matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum DeckeneinbauNicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(71	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.1.jpg'		,'Einbaustrahler, chrom, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(72	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.2.jpg'		,'Einbaustrahler, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(73	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.3.jpg'		,'Einbaustrahler, schwarz, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(74	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.4.jpg'		,'Einbaustrahler, GX5,3, strukturweiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(75	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.5.jpg'		,'Einbaustrahler, alu matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige')
,(76	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.6.jpg'		,'Einbaustrahler, champagner matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(77	,'IP20'		,68		,55		,25		,50		,'GX5,3'			,'1.27.7.jpg'		,'Einbaustrahler, titan matt, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Nicht kompatibel zu den LED-Modulen 18498002, 12823003, 12843004 und 18438002. Fassung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium, Schutzart: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: max. 50W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: schwenkbar, ohne Betriebsgerät, Art der Dimmung: sonstige.')
,(78	,'IP20'		,68		,55		,0		,14		,'ohne Fassung'		,'1.28.1.jpg'		,'Einbaudownlight, V4A, IP54, strukturweiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit STEAM verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 2 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl / Aluminium / Kunststoff / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(79	,'IP20'		,68		,55		,0		,14		,'ohne Fassung'		,'1.28.2.jpg'		,'Einbaudownlight, V4A, IP54, edelstahl, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit STEAM verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 2 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl / Aluminium / Kunststoff / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(80	,'IP44'		,68		,55		,0		,14		,'ohne LED-Modul'	,'1.29.1.jpg'		,'Einbaudownlight, IP44, weiß mit Dekoglas klar, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit COVER-UP verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 11 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Stahl / Glas, Schutzart raumseitig: nach DIN EN 60529: IP44*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(81	,'IP44'		,68		,55		,0		,14		,'ohne LED-Modul'	,'1.29.2.jpg'		,'Einbaudownlight, IP44, schwarz mit Dekoglas klar, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit COVER-UP verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 11 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Stahl / Glas, Schutzart raumseitig: nach DIN EN 60529: IP44*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(82	,'IP44'		,68		,55		,0		,14		,'ohne LED-Modul'	,'1.30.1.jpg'		,'Einbaudownlight, IP44, weiß mit Dekoglas klar, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit COVER-UP verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 11 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Stahl / Glas, Schutzart raumseitig: nach DIN EN 60529: IP44*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(83	,'IP44'		,68		,55		,0		,14		,'ohne LED-Modul'	,'1.30.2.jpg'		,'Einbaudownlight, IP44, schwarz mit Dekoglas klar, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Alle Brumberg MR16-LED-Module sind für die Einbaueinheit COVER-UP verwendbar. Die Einbautiefe der Leuchte richtet sich nach dem jeweils verwendeten LED-Modul (hier: 11 mm, zzgl. Höhe des LED-Moduls). Das LED-Modul ist im Lieferumfang der Einbaueinheit nicht enthalten. Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Stahl / Glas, Schutzart raumseitig: nach DIN EN 60529: IP44*, Schutzklasse: (EN 61140) III, Leistung: 14W, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(84	,'IP65'		,75		,55		,0		,35		,'GX5,3'			,'1.31.1.jpg'		,'Einbaudownlight, IP65, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(85	,'IP65'		,75		,55		,0		,35		,'GX5,3'			,'1.31.2.jpg'		,'Einbaudownlight, IP65, GX5,3, nickel matt, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(86	,'IP65'		,75		,55		,0		,35		,'GX5,3'			,'1.31.3.jpg'		,'Einbaudownlight, IP65, GX5,3, silber, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP65*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(87	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.32.1.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, weiß, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(88	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.32.2.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, schwarz, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(89	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.32.3.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, edelstahl, rund. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(90	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.33.1.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, weiß, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(91	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.33.2.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, schwarz, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')
,(92	,'IP54'		,68		,55		,0		,35		,'GX5,3'			,'1.33.3.jpg'		,'Einbaudownlight, V4A, IP54, GX5,3, edelstahl, quadratisch. Ausgeführt in kompakter Bauform für werkzeuglose Schnellmontage zum Deckeneinbau. Ausführung: GX5,3, Montageart: Einbaumontage, Montageort: Deckenmontage, Material: Edelstahl V4A / Glas, Schutzart raumseitig: nach DIN EN 60529: IP54*, Schutzklasse: (EN 61140) III, Spannung: 12V, Leistung: 35W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Verstellbarkeit: nicht verstellbar, Mit Betriebsgerät: Nein, Dimmbar: Abhängig von Betriebsgerät, Art der Dimmung: Abhängig vom Betriebsgerät.')

)t (Gehaeuse_SK, Schutzart, Einbaudurchmesser, Einbautiefe, Schwenkwinkel, Leistung, Ausführung, [Image], Produktbeschreibung)
GO
PRINT N'Prozedur "[dbo].[load_sat_Spot_Leuchte_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Spot_Leuchte_Stammdaten] as

TRUNCATE TABLE sat.Spot_Leuchte_Stammdaten

INSERT INTO sat.Spot_Leuchte_Stammdaten (Leuchte_SK, [Image])
SELECT * FROM (VALUES

 (1	  , '1.1.1.1.1.jpg')
,(2	  , '1.1.1.2.1.jpg')
,(3	  , '1.1.1.2.2.jpg')
,(4	  , '1.1.1.3.1.jpg')
,(5	  , '1.1.2.1.1.jpg')
,(6	  , '1.1.2.2.1.jpg')
,(7	  , '1.1.2.2.2.jpg')
,(8	  , '1.1.2.3.1.jpg')
,(9	  , '1.1.3.1.1.jpg')
,(10  , '1.1.3.1.2.jpg')
,(11  , '1.1.3.2.1.jpg')
,(12  , '1.1.4.1.1.jpg')
,(13  , '1.1.4.2.1.jpg')
,(14  , '1.1.4.2.2.jpg')
,(15  , '1.1.4.3.1.jpg')
,(16  , '1.2.1.1.1.jpg')
,(17  , '1.2.1.1.2.jpg')
,(18  , '1.2.1.2.1.jpg')
,(19  , '1.3.1.1.1.jpg')
,(20  , '1.4.1.1.1.jpg')
,(21  , '1.4.1.1.2.jpg')
,(22  , '1.4.1.1.3.jpg')
,(23  , '1.4.1.1.4.jpg')
,(24  , '1.4.2.1.1.jpg')
,(25  , '1.4.2.1.2.jpg')
,(26  , '1.4.2.1.3.jpg')
,(27  , '1.4.2.1.4.jpg')
,(28  , '1.5.1.1.1.jpg')

     

)t (Leuchte_SK, [Image])
GO
PRINT N'Prozedur "[dbo].[load_sat_Spot_Treiber_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Spot_Treiber_Stammdaten] as

TRUNCATE TABLE sat.Spot_Treiber_Stammdaten

INSERT INTO sat.Spot_Treiber_Stammdaten (Treiber_SK, [Image])
SELECT * FROM (VALUES


 (1	 ,  '1.1.1.1.jpg')
,(2	 ,  '1.1.2.1.jpg')
,(3	 ,  '1.1.2.2.jpg')
,(4	 ,  '1.1.2.3.jpg')
,(5	 ,  '1.1.3.1.jpg')
,(6	 ,  '1.1.3.2.jpg')
,(7	 ,  '1.1.3.3.jpg')
,(8	 ,  '1.1.4.1.jpg')
,(9	 ,  '1.1.4.2.jpg')
,(10 ,  '1.1.4.3.jpg')
,(11 ,  '1.2.1.1.jpg')
,(12 ,  '1.2.1.2.jpg')
,(13 ,  '1.2.1.3.jpg')
,(14 ,  '1.2.2.1.jpg')
,(15 ,  '1.2.2.3.jpg')
,(16 ,  '1.2.3.1.jpg')
,(17 ,  '1.2.3.2.jpg')
,(18 ,  '1.2.3.3.jpg')
,(19 ,  '1.2.4.1.jpg')
,(20 ,  '1.2.4.2.jpg')
,(21 ,  '1.2.4.3.jpg')
,(22 ,  '1.2.5.1.jpg')
,(23 ,  '1.2.5.2.jpg')
,(24 ,  '1.2.5.3.jpg')
,(25 ,  '1.2.6.1.jpg')
,(26 ,  '1.2.6.2.jpg')
,(27 ,  '1.2.6.3.jpg')
,(28 ,  '1.3.1.1.jpg')
,(29 ,  '1.3.1.2.jpg')
,(30 ,  '1.4.1.1.jpg')
,(31 ,  '1.4.1.2.jpg')
,(32 ,  '1.4.1.3.jpg')
,(33 ,  '1.4.2.1.jpg')
,(34 ,  '1.4.2.2.jpg')
,(35 ,  '1.4.2.3.jpg')
,(36 ,  '1.5.1.1.jpg')
,(37 ,  '1.5.1.2.jpg')
,(38 ,  '1.5.1.3.jpg')
,(39 ,  '1.6.1.1.jpg')
,(40 ,  '1.6.1.2.jpg')
,(41 ,  '1.6.1.3.jpg')
     

)t (Treiber_SK, [Image])
GO
PRINT N'Update abgeschlossen.';


GO
