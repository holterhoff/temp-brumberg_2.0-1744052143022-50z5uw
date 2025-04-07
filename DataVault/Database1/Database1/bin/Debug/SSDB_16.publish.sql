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
PRINT N'Tabelle "[hub].[Biro40_Optik]" wird erstellt...';


GO
CREATE TABLE [hub].[Biro40_Optik] (
    [Optik_SK]        INT           IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]     NVARCHAR (50) NOT NULL,
    [Lichtrichtung]   NVARCHAR (50) NOT NULL,
    [Optik]           NVARCHAR (50) NOT NULL,
    [Max_Schnittmass] NVARCHAR (50) NOT NULL,
    [Position]        NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Biro40_Optik] PRIMARY KEY CLUSTERED ([Optik_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Biro40_Profil]" wird erstellt...';


GO
CREATE TABLE [hub].[Biro40_Profil] (
    [Profil_SK]       INT           IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]     NVARCHAR (50) NOT NULL,
    [Lichtrichtung]   NVARCHAR (50) NOT NULL,
    [Montageart]      NVARCHAR (50) NOT NULL,
    [Profiltyp]       NVARCHAR (50) NOT NULL,
    [Profilfarbe]     NVARCHAR (50) NOT NULL,
    [Max_Schnittmass] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Biro40_Profil] PRIMARY KEY CLUSTERED ([Profil_SK] ASC)
);


GO
PRINT N'Tabelle "[link].[Biro40_Figur__Montage]" wird erstellt...';


GO
CREATE TABLE [link].[Biro40_Figur__Montage] (
    [Figur_SK]   INT NOT NULL,
    [Montage_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Biro40_Leuchte__Optik]" wird erstellt...';


GO
CREATE TABLE [link].[Biro40_Leuchte__Optik] (
    [Leuchte_SK] INT NOT NULL,
    [Optik_SK]   INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Biro40_Montage__Leuchte]" wird erstellt...';


GO
CREATE TABLE [link].[Biro40_Montage__Leuchte] (
    [Montage_SK] INT NOT NULL,
    [Leuchte_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[sat].[Biro40_Leuchte_Artikel_MA]" wird erstellt...';


GO
CREATE TABLE [sat].[Biro40_Leuchte_Artikel_MA] (
    [Leuchte_SK]    INT           NOT NULL,
    [Mass]          INT           NOT NULL,
    [Artikelnummer] NVARCHAR (50) NOT NULL
);


GO
PRINT N'Tabelle "[sat].[Biro40_Leuchte_Laengen]" wird erstellt...';


GO
CREATE TABLE [sat].[Biro40_Leuchte_Laengen] (
    [Leuchte_SK] INT NOT NULL,
    [Min]        INT NOT NULL,
    [Max]        INT NOT NULL,
    [Step]       INT NOT NULL,
    [Ecke]       INT NOT NULL,
    [Toleranz]   INT NOT NULL,
    [Abzug]      INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Prozedur "[dbo].[load_hub_Biro40_Optik]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_Biro40_Optik] as

TRUNCATE TABLE hub.Biro40_Optik

INSERT INTO hub.Biro40_Optik (Leuchtentyp, Lichtrichtung, Optik, Max_Schnittmass, Position)

SELECT * FROM (VALUES

  ('Biro40'   , 'direkt'            , 'Microprismatisch'    , '1500'  , 'unten')
 ,('Biro40'   , 'direkt/indirekt'   , 'Microprismatisch'    , '1500'  , 'unten')
 ,('Biro40'   , 'direkt'            , 'Opal'                , '3000'  , 'unten')
 ,('Biro40'   , 'direkt/indirekt'   , 'Opal'                , '3000'  , 'unten')
 



)t (Leuchtentyp, Lichtrichtung, Optik, Max_Schnittmass, Position)
GO
PRINT N'Prozedur "[dbo].[load_hub_Biro40_Figur]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Biro40_Figur] as

TRUNCATE TABLE hub.Biro40_Figur

INSERT INTO hub.Biro40_Figur ([Figur])

SELECT * FROM (VALUES

 ('I')
,('L')
,('U')
,('Z')
,('O')


)t ([Figur])
GO
PRINT N'Prozedur "[dbo].[load_hub_Biro40_Leuchte]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Biro40_Leuchte] as

TRUNCATE TABLE hub.Biro40_Leuchte

INSERT INTO hub.Biro40_Leuchte (Leuchtentyp, Farbkanal,Kanal, Versorgung, Schutzart, Lichtfarbe, Lichtrichtung)

SELECT * FROM (VALUES

 ('Biro40'	, 'statisch'	, 'ON/OFF'	    , '230 V'	, 'IP 20'	, '3000K'	                  ,'direkt')
,('Biro40'	, 'statisch'	, 'ON/OFF'	    , '230 V'	, 'IP 20'	, '4000K'	                  ,'direkt')
,('Biro40'	, 'statisch'	, 'Dali'	    , '230 V'	, 'IP 20'	, '3000 K'                    ,'direkt')
,('Biro40'	, 'statisch'	, 'Dali'  	    , '230 V'	, 'IP 20'	, '4000 K'	                  ,'direkt')
,('Biro40'	, 'TW	Dali'   , 'Dali DT8'	, '230 V'	, 'IP 20'	, '2700-6500 K'	              ,'direkt')
,('Biro40'	, 'RGBW'	    , 'Dali DT8'  	, '230 V'	, 'IP 20'	, 'RGBW'	                  ,'direkt')
,('Biro40'	, 'statisch'	, 'ON/OFF'  	, '230 V'	, 'IP 20'	, '3000K'	                  ,'direkt/indirekt')
,('Biro40'	, 'statisch'	, 'ON/OFF'	    , '230 V'	, 'IP 20'	, '4000K'	                  ,'direkt/indirekt')
,('Biro40'	, 'statisch'	, 'Dali'  	    , '230 V'	, 'IP 20'	, '3000 K' 	                  ,'direkt/indirekt')
,('Biro40'	, 'statisch'	, 'Dali'  	    , '230 V'	, 'IP 20'	, '4000 K'	                  ,'direkt/indirekt')
,('Biro40'	, 'TW/ RGBW'	, 'Dali DT8'  	, '230 V'	, 'IP 20'	, '2700-6500 K / RGBW'	      ,'direkt/indirekt')
,('Biro40'	, 'TW (1050)'	, 'Dali DT8'  	, '230 V'	, 'IP 20'	, '2700-6500 K'	              ,'direkt/indirekt')
,('Biro40'	, 'TW (1120)'	, 'Dali DT8'  	, '230 V'	, 'IP 20'	, '2700-6500 K'	              ,'direkt/indirekt')
,('Biro40'	, 'TW (1190)'	, 'Dali DT8'  	, '230 V'	, 'IP 20'	, '2700-6500 K'	              ,'direkt/indirekt')
,('Biro40'	, 'TW (1260)'	, 'Dali DT8'  	, '230 V'	, 'IP 20'	, '2700-6500 K'	              ,'direkt/indirekt')
,('Biro40'	, 'TW (1330)'	, 'Dali DT8'  	, '230 V'	, 'IP 20'	, '2700-6500 K'	              ,'direkt/indirekt')


)t (Leuchtentyp, Farbkanal,Kanal, Versorgung, Schutzart, Lichtfarbe, Lichtrichtung)
GO
PRINT N'Prozedur "[dbo].[load_link_Biro40_Figur__Montage]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Biro40_Figur__Montage] as

TRUNCATE TABLE link.Biro40_Figur__Montage

INSERT INTO link.Biro40_Figur__Montage(Figur_SK, Montage_SK)

SELECT

	  h1.Figur_SK
	, h2.Montage_SK

FROM hub.Biro40_Figur h1
CROSS JOIN hub.Biro40_Montage h2
GO
PRINT N'Prozedur "[dbo].[load_link_Biro40_Leuchte__Optik]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Biro40_Leuchte__Optik] as

TRUNCATE TABLE link.Biro40_Leuchte__Optik

INSERT INTO link.Biro40_Leuchte__Optik(Leuchte_SK, Optik_SK)

SELECT 
		h1.Leuchte_SK
	,	h2.Optik_SK
FROM hub.Biro40_Leuchte h1
INNER JOIN hub.Biro40_Optik h2 ON h1.Lichtrichtung = h2.Lichtrichtung AND h1.Leuchtentyp = h2.Leuchtentyp
GO
PRINT N'Prozedur "[dbo].[load_link_Biro40_Montage__Leuchte]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Biro40_Montage__Leuchte] as

TRUNCATE TABLE link.Biro40_Montage__Leuchte

INSERT INTO link.Biro40_Montage__Leuchte(Montage_SK, Leuchte_SK)

SELECT 
		h1.Montage_SK
	,	h2.Leuchte_SK
FROM hub.Biro40_Montage h1
INNER JOIN hub.Biro40_Leuchte h2 ON h1.Lichtrichtung = h2.Lichtrichtung AND h1.Leuchtentyp = h2.Leuchtentyp
GO
PRINT N'Prozedur "[dbo].[sat_hub_Biro40_Leuchte_Artikel_MA]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_hub_Biro40_Leuchte_Artikel_MA] as

TRUNCATE TABLE sat.Biro40_Leuchte_Artikel_MA;

WITH cte as
(
	SELECT Leuchte_SK, [min] , [step], [max], [min] as newval  FROM sat.Biro40_Leuchte_Laengen

	UNION ALL

	SELECT Leuchte_SK, [min] , [step], [max],  newval + [step] from cte
	WHERE newval < [max]

)
INSERT INTO sat.Biro40_Leuchte_Artikel_MA (Leuchte_SK, Mass, Artikelnummer)
SELECT Leuchte_SK, newval as Mass, 0 AS Artikelnummer  FROM cte

order by Leuchte_SK, Mass
GO
PRINT N'Prozedur "[dbo].[sat_hub_Biro40_Leuchte_Laengen]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_hub_Biro40_Leuchte_Laengen] as

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
PRINT N'Update abgeschlossen.';


GO
