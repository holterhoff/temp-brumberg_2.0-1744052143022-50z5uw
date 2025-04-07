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
Die Spalte "Abzug" der Tabelle "[sat].[Biro40_Leuchte_Laengen]" muss von NULL in NOT NULL geändert werden. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript u. U. nicht. Um dieses Problem zu vermeiden, müssen Sie dieser Spalte für alle Zeilen Werte hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Der Typ von Spalte "Abzug" in Tabelle "[sat].[Biro40_Leuchte_Laengen]" lautet aktuell " NVARCHAR (50) NULL", wird aber in " INT NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " INT NOT NULL" kompatibel sind.

Die Spalte "Max" der Tabelle "[sat].[Biro40_Leuchte_Laengen]" muss von NULL in NOT NULL geändert werden. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript u. U. nicht. Um dieses Problem zu vermeiden, müssen Sie dieser Spalte für alle Zeilen Werte hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Der Typ von Spalte "Max" in Tabelle "[sat].[Biro40_Leuchte_Laengen]" lautet aktuell " NVARCHAR (50) NULL", wird aber in " INT NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " INT NOT NULL" kompatibel sind.

Die Spalte "Min" der Tabelle "[sat].[Biro40_Leuchte_Laengen]" muss von NULL in NOT NULL geändert werden. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript u. U. nicht. Um dieses Problem zu vermeiden, müssen Sie dieser Spalte für alle Zeilen Werte hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Der Typ von Spalte "Min" in Tabelle "[sat].[Biro40_Leuchte_Laengen]" lautet aktuell " NVARCHAR (50) NULL", wird aber in " INT NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " INT NOT NULL" kompatibel sind.

Die Spalte "Step" der Tabelle "[sat].[Biro40_Leuchte_Laengen]" muss von NULL in NOT NULL geändert werden. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript u. U. nicht. Um dieses Problem zu vermeiden, müssen Sie dieser Spalte für alle Zeilen Werte hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Der Typ von Spalte "Step" in Tabelle "[sat].[Biro40_Leuchte_Laengen]" lautet aktuell " NVARCHAR (50) NULL", wird aber in " INT NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " INT NOT NULL" kompatibel sind.

Die Spalte "Toleranz" der Tabelle "[sat].[Biro40_Leuchte_Laengen]" muss von NULL in NOT NULL geändert werden. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript u. U. nicht. Um dieses Problem zu vermeiden, müssen Sie dieser Spalte für alle Zeilen Werte hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Der Typ von Spalte "Toleranz" in Tabelle "[sat].[Biro40_Leuchte_Laengen]" lautet aktuell " NVARCHAR (50) NULL", wird aber in " INT NOT NULL" geändert. Es kann zu einem Datenverlust kommen, und möglicherweise ist die Bereitstellung nicht erfolgreich, wenn die Spalte Daten enthält, die nicht mit dem Typ " INT NOT NULL" kompatibel sind.
*/

IF EXISTS (select top 1 1 from [sat].[Biro40_Leuchte_Laengen])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Tabelle "[sat].[Biro40_Leuchte_Laengen]" wird geändert...';


GO
ALTER TABLE [sat].[Biro40_Leuchte_Laengen] ALTER COLUMN [Abzug] INT NOT NULL;

ALTER TABLE [sat].[Biro40_Leuchte_Laengen] ALTER COLUMN [Max] INT NOT NULL;

ALTER TABLE [sat].[Biro40_Leuchte_Laengen] ALTER COLUMN [Min] INT NOT NULL;

ALTER TABLE [sat].[Biro40_Leuchte_Laengen] ALTER COLUMN [Step] INT NOT NULL;

ALTER TABLE [sat].[Biro40_Leuchte_Laengen] ALTER COLUMN [Toleranz] INT NOT NULL;


GO
PRINT N'Prozedur "[dbo].[sat_hub_Biro40_Leuchte_Laengen]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[sat_hub_Biro40_Leuchte_Laengen] as

TRUNCATE TABLE sat.Biro40_Leuchte_Laengen

INSERT INTO sat.Biro40_Leuchte_Laengen(Leuchte_SK, [Min], [Max], [Step], [Toleranz], [Abzug])
SELECT * FROM (VALUES


 (1,  560	    ,  2380 	, 140	    , 2	, 591)
,(2,  560	    ,  2380 	, 140	    , 2	, 591)
,(3,  840	    ,  2380 	, 140	    , 2	, 591)
,(4,  840	    ,  2380 	, 140	    , 2	, 591)
,(5,  980	    ,  2520 	, 70	    , 2	, 591)
,(6,  2520  	,  5600 	, 280	    , 2	, 591)
,(7,  560	    ,  2240 	, 140	    , 2	, 591)
,(8,  560	    ,  2240 	, 140	    , 2	, 591)
,(9,  560	    ,  2240 	, 140	    , 2	, 591)
,(10, 560	    ,  2240 	, 140	    , 2	, 591)
,(11, 2520  	,  2520 	, 2520  	, 2	, 591)
,(12, 1050  	,  1050 	, 1050  	, 2	, 591)
,(13, 1120  	,  1120 	, 1120  	, 2	, 591)
,(14, 1190  	,  1190 	, 1190  	, 2	, 591)
,(15, 1260  	,  1260 	, 1260  	, 2	, 591)
,(16, 1330  	,  1330 	, 1330  	, 2	, 591)



)t (Leuchte_SK ,[Min], [Max], [Step], [Toleranz], [Abzug])
GO
PRINT N'Update abgeschlossen.';


GO
