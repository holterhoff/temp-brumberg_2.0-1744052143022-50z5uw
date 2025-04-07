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
Die Spalte "[sat].[Biro40_Leuchte_Laengen].[Ecke]" in der Tabelle "[sat].[Biro40_Leuchte_Laengen]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [sat].[Biro40_Leuchte_Laengen])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Das erneute Erstellen der Tabelle "[sat].[Biro40_Leuchte_Laengen]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [sat].[tmp_ms_xx_Biro40_Leuchte_Laengen] (
    [Leuchte_SK] INT NOT NULL,
    [Min]        INT NOT NULL,
    [Max]        INT NOT NULL,
    [Step]       INT NOT NULL,
    [Ecke]       INT NOT NULL,
    [Toleranz]   INT NOT NULL,
    [Abzug]      INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [sat].[Biro40_Leuchte_Laengen])
    BEGIN
        INSERT INTO [sat].[tmp_ms_xx_Biro40_Leuchte_Laengen] ([Leuchte_SK], [Min], [Max], [Step], [Toleranz], [Abzug])
        SELECT   [Leuchte_SK],
                 [Min],
                 [Max],
                 [Step],
                 [Toleranz],
                 [Abzug]
        FROM     [sat].[Biro40_Leuchte_Laengen]
        ORDER BY [Leuchte_SK] ASC;
    END

DROP TABLE [sat].[Biro40_Leuchte_Laengen];

EXECUTE sp_rename N'[sat].[tmp_ms_xx_Biro40_Leuchte_Laengen]', N'Biro40_Leuchte_Laengen';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Prozedur "[dbo].[sat_hub_Biro40_Leuchte_Artikel_MA]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[sat_hub_Biro40_Leuchte_Artikel_MA] as

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
PRINT N'Prozedur "[dbo].[sat_hub_Biro40_Leuchte_Laengen]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[sat_hub_Biro40_Leuchte_Laengen] as

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
PRINT N'Update abgeschlossen.';


GO
