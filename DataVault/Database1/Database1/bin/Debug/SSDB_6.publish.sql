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
PRINT N'Update abgeschlossen.';


GO
