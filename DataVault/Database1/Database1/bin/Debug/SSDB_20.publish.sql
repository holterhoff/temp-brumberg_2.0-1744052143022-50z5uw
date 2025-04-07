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
PRINT N'Prozedur "[dbo].[load_hub_Spot_Treiber]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Spot_Treiber] as

TRUNCATE TABLE hub.Spot_Treiber

INSERT INTO hub.Spot_Treiber (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)

SELECT * FROM (VALUES



 ('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'schaltbar', 	    '350mA',	  1	        ,5 )
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'schaltbar',  	'350mA',	  1	        ,7.2)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'schaltbar',   	'350mA',	  1	        ,7.2)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'schaltbar', 	    '350mA',	  1	        ,7.2)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'schaltbar', 	    '350mA',	  0	        ,15)
,('MR16',	'LED-Konverter'	,'ohne'	        ,     'schaltbar', 	    '350mA',	  0	        ,15)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'schaltbar', 	    '350mA',	  0	        ,15)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'schaltbar', 	    '350mA',	  1	        ,21)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'schaltbar', 	    '350mA',	  1	        ,21)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'schaltbar', 	    '350mA',	  1	        ,21)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'Phasenabschnit',	'350mA',	  2.8	    ,7)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'Phasenabschnit',	'350mA',	  2.8	    ,7)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  2.8	    ,7)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  4.9	    ,7)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'Phasenabschnit',	'350mA',	  4.9	    ,7)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  4.2	    ,10)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  4.2	    ,10)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'Phasenabschnit',	'350mA',	  4.2	    ,10)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  0.7	    ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  0.7	    ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play'      , 'Phasenabschnit',	'350mA',	  0.7	    ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  8.75	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  8.75	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'Phasenabschnit',	'350mA',	  8.75	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  10.15	    ,14)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'Phasenabschnit',	'350mA',	  10.15	    ,14)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'Phasenabschnit',	'350mA',	  10.15	    ,14)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , '1-10V',	        '350mA',	  5.25	    ,18)
,('MR16',	'LED-Konverter'	,'ohne' 	        , '1-10V',	        '350mA',	  5.25	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'DALI-2',	        '350mA',	  3.5	    ,17)
,('MR16',	'LED-Konverter'	,'ohne' 	        , 'DALI-2',	        '350mA',	  3.5	    ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'DALI-2',	        '350mA',	  3.5	    ,17)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'DALI-2',	        '350mA',	  2.1	    ,9)
,('MR16',	'LED-Konverter'	,'ohne' 	        , 'DALI-2',	        '350mA',	  2.1	    ,9)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'DALI-2',	        '350mA',	  2.1	    ,9)
,('MR16',	'LED-Konverter'	,'Plug & Play'	    , 'CASAMBI',        '350mA',	  3.5	    ,18)
,('MR16',	'LED-Konverter'	,'ohne' 	        , 'CASAMBI',        '350mA',	  3.5	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'CASAMBI',        '350mA',	  3.5	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play'   	, 'ZigBee',	        '350mA',	  3.5	    ,18)
,('MR16',	'LED-Konverter'	,'ohne'	            , 'ZigBee',	        '350mA',	  3.5	    ,18)
,('MR16',	'LED-Konverter'	,'Plug & Play Box'	, 'ZigBee',	        '350mA',	  3.5	    ,18)





)t (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)
GO
PRINT N'Update abgeschlossen.';


GO
