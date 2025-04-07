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
PRINT N'Prozedur "[dbo].[load_hub_Spot_Treiber]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_Spot_Treiber] as

TRUNCATE TABLE hub.Spot_Treiber

INSERT INTO hub.Spot_Treiber (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)

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
PRINT N'Update abgeschlossen.';


GO
