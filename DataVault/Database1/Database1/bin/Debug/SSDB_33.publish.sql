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
PRINT N'Tabelle "[hub].[Spot_Leuchte]" wird erstellt...';


GO
CREATE TABLE [hub].[Spot_Leuchte] (
    [Leuchte_SK]      INT            IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]     NVARCHAR (50)  NOT NULL,
    [Farbkanal]       NVARCHAR (50)  NOT NULL,
    [Lichtfarbe]      NVARCHAR (50)  NOT NULL,
    [Versorgung]      NVARCHAR (50)  NOT NULL,
    [Leistung]        DECIMAL (5, 2) NOT NULL,
    [Abstrahlwinkel]  INT            NOT NULL,
    [Lichtstrom]      INT            NOT NULL,
    [Effizienzklasse] NVARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_hub_Spot_Leuchte] PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Prozedur "[dbo].[load_hub_Spot_Leuchte]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Spot_Leuchte] as

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
,('MR16',	'Statisch'	, '4000 K'          ,'350mA'  ,12	    ,38	,1250	,'A+')
,('MR16',	'D2W'	    , '3000 K…1800K'	,'350mA'  ,6	    ,38	,460	,'A+')
,('MR16',	'D2W'	    , '3000 K…1800K'	,'350mA'  ,6	    ,60	,460	,'A+')
,('MR16',	'D2W'	    , '3000 K…1800K'	,'350mA'  ,12	    ,38	,930	,'A+')
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
PRINT N'Prozedur "[dbo].[load_link_Spot_Leuchte__Treiber]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Spot_Leuchte__Treiber] as

TRUNCATE TABLE link.Spot_Leuchte__Treiber

INSERT INTO link.Spot_Leuchte__Treiber (Leuchte_SK, Treiber_SK)

select distinct

	h1.Leuchte_SK
,	h2.Treiber_SK


 from hub.Spot_Leuchte h1
 JOIN hub.Spot_Treiber h2 ON h1.Versorgung = h2.Versorgung AND h1.Leistung < h2.Leistung_Max
GO
PRINT N'Update abgeschlossen.';


GO
