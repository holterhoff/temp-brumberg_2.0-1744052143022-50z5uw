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
PRINT N'Prozedur "[dbo].[load_hub_Spot_Treiber]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_hub_Spot_Treiber] as

TRUNCATE TABLE hub.Spot_Treiber

INSERT INTO hub.Spot_Treiber (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)

SELECT * FROM (VALUES



  ('MR16', 'LED-Konverter', 'Plug&Play', 'schaltbar',                         '350mA', 1.0,   5.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'schaltbar',                         '350mA', 1.0,   7.2),
	('MR16', 'LED-Konverter', 'ohne', 'schaltbar',                              '350mA', 1.0,   7.2),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'schaltbar',          '350mA', 1.0,   7.2),
	('MR16', 'LED-Konverter', 'Plug&Play', 'schaltbar',                         '350mA', 1.0,   15.0),
	('MR16', 'LED-Konverter', 'ohne', 'schaltbar',                              '350mA', 1.0,   15.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'schaltbar',          '350mA', 1.0,   15.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'schaltbar',                         '350mA', 1.0,   21.0),
	('MR16', 'LED-Konverter', 'ohne', 'schaltbar',                              '350mA', 1.0,   21.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'schaltbar',          '350mA', 1.0,   21.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt',                   '350mA', 2.8,   7.0),
	('MR16', 'LED-Konverter', 'ohne', 'Phasenabschnitt',                        '350mA', 2.8,   7.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt',    '350mA', 2.8,   7.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt',                   '350mA', 4.9,   7.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt',    '350mA', 4.9,   7.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt',                   '350mA', 4.2,   10.0),
	('MR16', 'LED-Konverter', 'ohne', 'Phasenabschnitt',                        '350mA', 4.2,   10.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt',    '350mA', 4.2,   10.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt',                   '350mA', 10.2 , 14.0),
	('MR16', 'LED-Konverter', 'ohne', 'Phasenabschnitt',                        '350mA', 10.2 , 14.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt',    '350mA', 10.2 , 14.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt',                   '350mA', 8.8 ,  18.0),
	('MR16', 'LED-Konverter', 'ohne', 'Phasenabschnitt',                        '350mA', 8.8 ,  18.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt',    '350mA', 8.8 ,  18.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Phasenabschnitt',                   '350mA', 0.7 ,  17.0),
	('MR16', 'LED-Konverter', 'ohne', 'Phasenabschnitt',                        '350mA', 0.7 ,  17.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Phasenabschnitt',    '350mA', 0.7 ,  17.0),
	('MR16', 'LED-Konverter', 'Plug&Play', '1-10 V',                            '350mA', 5.2 ,  18.0),
	('MR16', 'LED-Konverter', 'ohne', '1-10 V',                                 '350mA', 5.2 ,  18.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'DALI-2',                            '350mA', 3.5 ,  17.0),
	('MR16', 'LED-Konverter', 'ohne', 'DALI-2',                                 '350mA', 3.5 ,  17.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'DALI-2',             '350mA', 3.5 ,  17.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'DALI-2',                            '350mA', 2.8 ,  7.0),
	('MR16', 'LED-Konverter', 'ohne', 'DALI-2',                                 '350mA', 2.8 ,  7.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'DALI-2',             '350mA', 2.8 ,  7.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'DALI, PUSH-Dimm',                   '350mA', 2.1 ,  9.0),
	('MR16', 'LED-Konverter', 'ohne', 'DALI, PUSH-Dimm',                        '350mA', 2.1 ,  9.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'DALI, PUSH-Dimm',    '350mA', 2.1 ,  9.0),
	('MR16', 'LED-Konverter', 'Plug&Play', 'ZigBee',                            '350mA', 3.5 ,  18.5),
	('MR16', 'LED-Konverter', 'ohne', 'ZigBee',                                 '350mA', 3.5 ,  18.5),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'ZigBee',             '350mA', 3.5 ,  18.5),
	('MR16', 'LED-Konverter', 'Plug&Play', 'Casambi-Push',                      '350mA', 3.5 ,  18.0),
	('MR16', 'LED-Konverter', 'ohne', 'Casambi-Push',                           '350mA', 3.5 ,  18.0),
	('MR16', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Casambi-Push',       '350mA', 3.5 ,  18.0)




)t (Leuchtentyp, Beschreibung, Ausführung, Ansteuerung, Versorgung, Leistung_Min, Leistung_Max)
GO
PRINT N'Update abgeschlossen.';


GO
