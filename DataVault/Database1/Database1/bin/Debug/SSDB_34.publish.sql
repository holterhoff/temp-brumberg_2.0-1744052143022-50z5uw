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
PRINT N'Tabelle "[sat].[Spot_Leuchte_Stammdaten]" wird erstellt...';


GO
CREATE TABLE [sat].[Spot_Leuchte_Stammdaten] (
    [Leuchte_SK] INT           NOT NULL,
    [Image]      NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Tabelle "[sat].[Spot_Treiber_Stammdaten]" wird erstellt...';


GO
CREATE TABLE [sat].[Spot_Treiber_Stammdaten] (
    [Treiber_SK] INT           NOT NULL,
    [Image]      NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Treiber_SK] ASC)
);


GO
PRINT N'Prozedur "[dbo].[load_hub_Spot_Leuchte]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_Spot_Leuchte] as

TRUNCATE TABLE hub.Spot_Leuchte

INSERT INTO hub.Spot_Leuchte (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom, Effizienzklasse)

SELECT * FROM (VALUES


 ('MR16',	'Statisch'	, '2700 K'       	,'350mA'  ,3	    ,38	,290	,'A++')
,('MR16',	'Statisch'	, '2700 K'       	,'350mA'  ,6	    ,38	,680	,'A+')
,('MR16',	'Statisch'	, '2700 K'       	,'350mA'  ,6	    ,60	,680	,'A+')
,('MR16',	'Statisch'	, '2700 K'       	,'350mA'  ,12	    ,38	,1120	,'A+')
,('MR16',	'Statisch'	, '3000 K'        	,'350mA'  ,3	    ,38	,310	,'A++')
,('MR16',	'Statisch'	, '3000 K'        	,'350mA'  ,6	    ,38	,680	,'A+')
,('MR16',	'Statisch'	, '3000 K'        	,'350mA'  ,6	    ,60	,680	,'A+')
,('MR16',	'Statisch'	, '3000 K'        	,'350mA'  ,12	    ,38	,1210	,'A+')
,('MR16',	'Statisch'	, '3500 K'       	,'350mA'  ,6	    ,38	,680	,'A++')
,('MR16',	'Statisch'	, '3500 K'       	,'350mA'  ,6	    ,60	,680	,'A++')
,('MR16',	'Statisch'	, '3500 K'       	,'350mA'  ,12	    ,38	,1240	,'A+')
,('MR16',	'Statisch'	, '4000 K'       	,'350mA'  ,3	    ,38	,340	,'A++')
,('MR16',	'Statisch'	, '4000 K'       	,'350mA'  ,6	    ,38	,720	,'A+')
,('MR16',	'Statisch'	, '4000 K'       	,'350mA'  ,6	    ,60	,720	,'A+')
,('MR16',	'Statisch'	, '4000 K'       	,'350mA'  ,12	    ,38	,1250	,'A+')
,('MR16',	'D2W'	    , '3000 K…1800K'    ,'350mA'  ,6	    ,38	,460	,'A+')
,('MR16',	'D2W'    	, '3000 K…1800K'	,'350mA'  ,6	    ,60	,460	,'A+')
,('MR16',	'D2W'    	, '3000 K…1800K'	,'350mA'  ,12	    ,38	,930	,'A+')
,('MR16',	'SUNLIKE'	, '3000 K'	        ,'350mA'  ,12.5	    ,38	,920	,'A')
,('MR16',	'DISC'	    , '3000 K'	        ,'350mA'  ,6	    ,18	,640	,'A++')
,('MR16',	'DISC'	    , '3000 K'	        ,'350mA'  ,6	    ,24	,690	,'A++')
,('MR16',	'DISC'	    , '3000 K'	        ,'350mA'  ,6	    ,38	,670	,'A++')
,('MR16',	'DISC'	    , '3000 K'	        ,'350mA'  ,6	    ,60	,620	,'A++')
,('MR16',	'DISC'	    , '4000 K'	        ,'350mA'  ,6	    ,18	,685	,'A++')
,('MR16',	'DISC'	    , '4000 K'	        ,'350mA'  ,6	    ,24	,740	,'A++')
,('MR16',	'DISC'	    , '4000 K'	        ,'350mA'  ,6	    ,38	,720	,'A++')
,('MR16',	'DISC'	    , '4000 K'	        ,'350mA'  ,6	    ,60	,660	,'A++')
,('MR16',	'RGB'	    , 'RGB' 	        ,'350mA'  ,13.8	    ,45	,230	,'Sonder')



)t (Leuchtentyp, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom, Effizienzklasse)
GO
PRINT N'Prozedur "[dbo].[sat_hub_Spot_Leuchte_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_hub_Spot_Leuchte_Stammdaten] as

TRUNCATE TABLE sat.Spot_Leuchte_Stammdaten

INSERT INTO sat.Spot_Leuchte_Stammdaten (Leuchte_SK, [Image])
SELECT * FROM (VALUES

 (1	  , '1.1.1.1.1')
,(2	  , '1.1.1.2.1')
,(3	  , '1.1.1.2.2')
,(4	  , '1.1.1.3.1')
,(5	  , '1.1.2.1.1')
,(6	  , '1.1.2.2.1')
,(7	  , '1.1.2.2.2')
,(8	  , '1.1.2.3.1')
,(9	  , '1.1.3.1.1')
,(10  , '1.1.3.1.2')
,(11  , '1.1.3.2.1')
,(12  , '1.1.4.1.1')
,(13  , '1.1.4.2.1')
,(14  , '1.1.4.2.2')
,(15  , '1.1.4.3.1')
,(16  , '1.2.1.1.1')
,(17  , '1.2.1.1.2')
,(18  , '1.2.1.2.1')
,(19  , '1.3.1.1.1')
,(20  , '1.4.1.1.1')
,(21  , '1.4.1.1.2')
,(22  , '1.4.1.1.3')
,(23  , '1.4.1.1.4')
,(24  , '1.4.2.1.1')
,(25  , '1.4.2.1.2')
,(26  , '1.4.2.1.3')
,(27  , '1.4.2.1.4')
,(28  , '1.5.1.1.1')

     

)t (Leuchte_SK, [Image])
GO
PRINT N'Prozedur "[dbo].[sat_hub_Spot_Treiber_Stammdaten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_hub_Spot_Treiber_Stammdaten] as

TRUNCATE TABLE sat.Spot_Treiber_Stammdaten

INSERT INTO sat.Spot_Treiber_Stammdaten (Treiber_SK, [Image])
SELECT * FROM (VALUES


 (1	 ,  '1.1.1.1')
,(2	 ,  '1.1.2.1')
,(3	 ,  '1.1.2.2')
,(4	 ,  '1.1.2.3')
,(5	 ,  '1.1.3.1')
,(6	 ,  '1.1.3.2')
,(7	 ,  '1.1.3.3')
,(8	 ,  '1.1.4.1')
,(9	 ,  '1.1.4.2')
,(10 ,  '1.1.4.3')
,(11 ,  '1.2.1.1')
,(12 ,  '1.2.1.2')
,(13 ,  '1.2.1.3')
,(14 ,  '1.2.2.1')
,(15 ,  '1.2.2.3')
,(16 ,  '1.2.3.1')
,(17 ,  '1.2.3.2')
,(18 ,  '1.2.3.3')
,(19 ,  '1.2.4.1')
,(20 ,  '1.2.4.2')
,(21 ,  '1.2.4.3')
,(22 ,  '1.2.5.1')
,(23 ,  '1.2.5.2')
,(24 ,  '1.2.5.3')
,(25 ,  '1.2.6.1')
,(26 ,  '1.2.6.2')
,(27 ,  '1.2.6.3')
,(28 ,  '1.3.1.1')
,(29 ,  '1.3.1.2')
,(30 ,  '1.4.1.1')
,(31 ,  '1.4.1.2')
,(32 ,  '1.4.1.3')
,(33 ,  '1.4.2.1')
,(34 ,  '1.4.2.2')
,(35 ,  '1.4.2.3')
,(36 ,  '1.5.1.1')
,(37 ,  '1.5.1.2')
,(38 ,  '1.5.1.3')
,(39 ,  '1.6.1.1')
,(40 ,  '1.6.1.2')
,(41 ,  '1.6.1.3')
     

)t (Treiber_SK, [Image])
GO
PRINT N'Update abgeschlossen.';


GO
