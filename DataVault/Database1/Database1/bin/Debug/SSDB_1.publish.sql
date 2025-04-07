/*
Bereitstellungsskript für Plameco

Dieser Code wurde von einem Tool generiert.
Änderungen an dieser Datei führen möglicherweise zu falschem Verhalten und gehen verloren, falls
der Code neu generiert wird.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Plameco"
:setvar DefaultFilePrefix "Plameco"
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
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Tabelle "[hub].[Leuchten]" wird erstellt...';


GO
CREATE TABLE [hub].[Leuchten] (
    [Leuchte_SK]  INT           IDENTITY (1, 1) NOT NULL,
    [Leuchte]     NVARCHAR (50) NOT NULL,
    [Leuchtentyp] NVARCHAR (50) NOT NULL,
    [Schutzart]   NVARCHAR (50) NOT NULL,
    [Kanal]       NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Leuchten] PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Steuerung]" wird erstellt...';


GO
CREATE TABLE [hub].[Steuerung] (
    [Steuerung_SK]       INT           IDENTITY (1, 1) NOT NULL,
    [Steuerungsvariante] NVARCHAR (50) NOT NULL,
    [Steuerungstyp]      NVARCHAR (50) NOT NULL,
    [Maximal_Leistung]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Steuerung] PRIMARY KEY CLUSTERED ([Steuerung_SK] ASC)
);


GO
PRINT N'Tabelle "[hub].[Treiber]" wird erstellt...';


GO
CREATE TABLE [hub].[Treiber] (
    [Treiber_SK]         INT           IDENTITY (1, 1) NOT NULL,
    [Treiber_Hersteller] NVARCHAR (50) NOT NULL,
    [Treiber_Leistung]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_Treiber] PRIMARY KEY CLUSTERED ([Treiber_SK] ASC)
);


GO
PRINT N'Tabelle "[link].[Leuchten__Steuerung]" wird erstellt...';


GO
CREATE TABLE [link].[Leuchten__Steuerung] (
    [Leuchte_SK]   INT NOT NULL,
    [Steuerung_SK] INT NOT NULL
);


GO
PRINT N'Tabelle "[link].[Steuerung__Treiber]" wird erstellt...';


GO
CREATE TABLE [link].[Steuerung__Treiber] (
    [Steuerung_SK] INT NOT NULL,
    [Treiber_SK]   INT NOT NULL
);


GO
PRINT N'Tabelle "[sat].[LED_Flex_Rolle_MA]" wird erstellt...';


GO
CREATE TABLE [sat].[LED_Flex_Rolle_MA] (
    [Leuchte_SK]       INT           NOT NULL,
    [Lichtfarbe]       NVARCHAR (50) NOT NULL,
    [Leistung]         NVARCHAR (50) NOT NULL,
    [Leistung_Einheit] NVARCHAR (50) NOT NULL,
    [Lumen]            NVARCHAR (50) NOT NULL,
    [Lumen_Einheit]    NVARCHAR (50) NOT NULL,
    [Artikelnummer]    NVARCHAR (50) NOT NULL
);


GO
PRINT N'Tabelle "[sat].[LED_Flex_Schnitt_MA]" wird erstellt...';


GO
CREATE TABLE [sat].[LED_Flex_Schnitt_MA] (
    [Leuchte_SK]       INT           NOT NULL,
    [Lichtfarbe]       NVARCHAR (50) NOT NULL,
    [Leistung]         NVARCHAR (50) NOT NULL,
    [Leistung_Einheit] NVARCHAR (50) NOT NULL,
    [Lumen]            NVARCHAR (50) NOT NULL,
    [Lumen_Einheit]    NVARCHAR (50) NOT NULL,
    [Artikelnummer]    NVARCHAR (50) NOT NULL
);


GO
PRINT N'Tabelle "[sat].[Steuerung_MA]" wird erstellt...';


GO
CREATE TABLE [sat].[Steuerung_MA] (
    [Steuerung_SK]  INT           NOT NULL,
    [Typ]           NVARCHAR (50) NOT NULL,
    [Master_Slave]  NCHAR (10)    NOT NULL,
    [Artikelnummer] NVARCHAR (50) NOT NULL
);


GO
PRINT N'Tabelle "[sat].[Treiber_MA]" wird erstellt...';


GO
CREATE TABLE [sat].[Treiber_MA] (
    [Treiber_SK] INT           NOT NULL,
    [Leistung]   NVARCHAR (50) NULL
);


GO
PRINT N'Prozedur "[dbo].[load_hub_Leuchten]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Leuchten] as

TRUNCATE TABLE hub.Leuchten

INSERT INTO hub.Leuchten (Leuchte, Leuchtentyp, Schutzart, Kanal)

SELECT * FROM (VALUES



('Flex', 'COB RGBW',	'IP 00',	'4-Kanal'),
('Flex', 'COB RGBW',	'IP 65',	'4-Kanal'),
('Flex', 'COB STATIC',	'IP 00',	'1-Kanal'),
('Flex', 'COB STATIC',	'IP 67',	'1-Kanal'),
('Flex', 'COB TW',		'IP 00',	'2-Kanal'),
('Flex', 'COB TW',		'IP 65',	'2-Kanal'),
('Flex', 'D2W',			'IP 00',	'1-Kanal'),
('Flex', 'D2W',			'IP 65',	'1-Kanal'),
('Flex', 'Performance',	'IP 00',	'1-Kanal'),
('Flex', 'RGB-TW',		'IP 00',	'4-Kanal'),
('Flex', 'RGBW',		'IP 00',	'4-Kanal'),
('Flex', 'Select',		'IP 00',	'1-Kanal'),
('Flex', 'Select',		'IP 60',	'1-Kanal'),
('Flex', 'TW',			'IP 00',	'2-Kanal'),
('Flex', 'TW',			'IP 60',	'2-Kanal')





)t (Leuchte, Leuchtentyp, Schutzart, Kanal)
GO
PRINT N'Prozedur "[dbo].[load_hub_Steuerung]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Steuerung] as

TRUNCATE TABLE hub.Steuerung

INSERT INTO hub.Steuerung (Steuerungsvariante, Steuerungstyp, Maximal_Leistung)

SELECT * FROM (VALUES

('BASIC',		'ON/OFF',		'0'),
('CASAMBI',		'PWM 4',		'144'),
('CASAMBI',		'PWM 5',		'168'),
('CASAMBI',		'PWM 5',		'198'),
('CASAMBI',		'1-10V Dim',	'20'),
('Brumberg',	'Controller 1-4 Kanal',	'240')



)t (Steuerungsvariante, Steuerungstyp, Maximal_Leistung)
GO
PRINT N'Prozedur "[dbo].[load_hub_Treiber]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_Treiber] as

TRUNCATE TABLE hub.Treiber

INSERT INTO hub.Treiber (Treiber_Hersteller, Treiber_Leistung)

SELECT * FROM (VALUES

('MEANWELL',	'16'),
('MEANWELL',	'25'),
('MEANWELL',	'40'),
('MEANWELL',	'60'),
('MEANWELL',	'90'),
('MEANWELL',	'120'),
('MEANWELL',	'150'),
('MEANWELL',	'200'),
('MEANWELL',	'240'),
('Philipps',	'20'),
('Philipps',	'40'),
('Philipps',	'60'),
('Philipps',	'120'),
('Philipps',	'150')

)t (Treiber_Hersteller,Treiber_Leistung)
GO
PRINT N'Prozedur "[dbo].[load_link_Leuchten__Steuerung]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Leuchten__Steuerung] as

TRUNCATE TABLE link.Leuchten__Steuerung

INSERT INTO link.Leuchten__Steuerung (Leuchte_SK, Steuerung_SK)

SELECT * FROM (VALUES 


(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),

(6,2),
(6,3),
(6,4),
(6,6),
(6,7)


)t (Leuchte_SK, Steuerung_SK)
GO
PRINT N'Prozedur "[dbo].[load_link_Steuerung__Treiber]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Steuerung__Treiber] as

TRUNCATE TABLE link.Steuerung__Treiber

INSERT INTO link.Steuerung__Treiber (Steuerung_SK, Treiber_SK)

SELECT * FROM (VALUES 


(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,12),
(1,13),
(1,14),
(2,1),
(2,2),
(2,3),
(2,4),
(2,5),
(2,6),
(2,7),
(2,8),
(2,9),
(2,10),
(2,11),
(2,12),
(2,13),
(2,14),
(3,1),
(3,2),
(3,3),
(3,4),
(3,5),
(3,6),
(3,7),
(3,8),
(3,9),
(3,10),
(3,11),
(3,12),
(3,13),
(3,14),
(4,1),
(4,2),
(4,3),
(4,4),
(4,5),
(4,6),
(4,7),
(4,8),
(4,9),
(4,10),
(4,11),
(4,12),
(4,13),
(4,14),
(5,1),
(5,2),
(5,3),
(5,4),
(5,5),
(5,6),
(5,7),
(5,8),
(5,9),
(5,10),
(5,11),
(5,12),
(5,13),
(5,14),
(6,1),
(6,2),
(6,3),
(6,4),
(6,5),
(6,6),
(6,7),
(6,8),
(6,9),
(6,10),
(6,11),
(6,12),
(6,13),
(6,14),
(7,7),
(7,14)


)t (Steuerung_SK, Treiber_SK)
GO
PRINT N'Prozedur "[dbo].[load_sat_LED_Flex_Rolle_MA]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_LED_Flex_Rolle_MA] as

TRUNCATE TABLE sat.LED_Flex_Rolle_MA

INSERT INTO sat.LED_Flex_Rolle_MA (Leuchte_SK, Lichtfarbe, Leistung, Leistung_Einheit, Lumen, Lumen_Einheit, Artikelnummer)

SELECT * FROM (VALUES

(1,	'2700K',	'4,8'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'2700K',	'9,6'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'2700K',	'14,4'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'2700K',	'19,2'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'3000K',	'4,8'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'3000K',	'9,6'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'3000K',	'14,4'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'3000K',	'19,2'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'4000K',	'4,8'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'4000K',	'9,6'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'4000K',	'14,4'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'4000K',	'19,2'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'6000K',	'4,8'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'6000K',	'9,6'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'6000K',	'14,4'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'6000K',	'19,2'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(6, '2000K-6500K', '19,2', 'Watt / m' , '', 'Lumen / m'	,''),
(6, '2000K-6500K', '22,0', 'Watt / m' , '', 'Lumen / m'	,''),
(6, '2000K-6500K', '36,0', 'Watt / m' , '', 'Lumen / m'	,''),
(7, '2000K-6500K', '19,2', 'Watt / m' , '', 'Lumen / m'	,'')



)t (Leuchte_SK, Lichtfarbe, Leistung, Leistung_Einheit, Lumen, Lumen_Einheit, Artikelnummer)
GO
PRINT N'Prozedur "[dbo].[load_sat_LED_Flex_Schnitt_MA]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_LED_Flex_Schnitt_MA] as

TRUNCATE TABLE sat.LED_Flex_Schnitt_MA

INSERT INTO sat.LED_Flex_Schnitt_MA (Leuchte_SK, Lichtfarbe, Leistung, Leistung_Einheit, Lumen, Lumen_Einheit, Artikelnummer)

SELECT * FROM (VALUES

(1,	'2700K',	'4,8'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'2700K',	'9,6'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'2700K',	'14,4'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'2700K',	'19,2'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'3000K',	'4,8'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'3000K',	'9,6'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'3000K',	'14,4'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'3000K',	'19,2'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'4000K',	'4,8'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'4000K',	'9,6'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'4000K',	'14,4'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'4000K',	'19,2'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'6000K',	'4,8'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'6000K',	'9,6'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'6000K',	'14,4'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(1,	'6000K',	'19,2'	, 'Watt / m' ,	'', 'Lumen / m'	,''),
(6, '2000K-6500K', '19,2', 'Watt / m' , '', 'Lumen / m'	,''),
(6, '2000K-6500K', '22,0', 'Watt / m' , '', 'Lumen / m'	,''),
(6, '2000K-6500K', '36,0', 'Watt / m' , '', 'Lumen / m'	,''),
(7, '2000K-6500K', '19,2', 'Watt / m' , '', 'Lumen / m'	,'')



)t (Leuchte_SK, Lichtfarbe, Leistung, Leistung_Einheit, Lumen, Lumen_Einheit, Artikelnummer)
GO
PRINT N'Prozedur "[dbo].[load_sat_Steuerung_MA]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Steuerung_MA] as

TRUNCATE TABLE sat.Steuerung_MA

INSERT INTO sat.Steuerung_MA (Steuerung_SK, Typ, Master_Slave, Artikelnummer)

SELECT * FROM (VALUES

(1, 'N.N',	'Master',	'100100'),	
(2, 'PWM 4','Master',   '200101'),
(3, 'PWM 5','Master',	'200201'),
(5, 'CBU ASD','Master',	'300201'),
(5, 'CBU ASD','Slave',	'300201-Slave')



)t (Steuerung_SK, Master_Slave, Typ, Artikel)
GO
PRINT N'Prozedur "[dbo].[load_sat_Treiber_MA]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Treiber_MA] as

TRUNCATE TABLE sat.Treiber_MA

INSERT INTO sat.Treiber_MA (Treiber_SK, Leistung)

SELECT * FROM (VALUES

(1,	'16'),
(1,	'25'),
(1,	'40'),
(1,	'60'),
(1,	'90'),
(1,	'120'),
(1,	'150'),
(1,	'200'),
(1,	'240'),
(2,	'20'),
(2,	'40'),
(2,	'60'),
(2,	'120'),
(2,	'150')


)t (Treiber_SK, Leistung)
GO
PRINT N'Prozedur "[dbo].[load_all]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_all] as

--
---- HUBS
TRUNCATE TABLE hub.Leuchten;
TRUNCATE TABLE hub.Steuerung;
TRUNCATE TABLE hub.Treiber;
--TRUNCATE TABLE hub.Optik_Klasse;
--TRUNCATE TABLE hub.Lichtverteilung_Klasse;
--TRUNCATE TABLE hub.Lichtstrom_Klasse;
--TRUNCATE TABLE hub.Lichtfarbe_Klasse;
--TRUNCATE TABLE hub.Schaltungsart_Klasse;a
--
--
exec load_hub_Leuchten;
exec load_hub_Steuerung;
exec load_hub_Treiber;
--exec load_hub_Optik_Klasse;
--exec load_hub_Lichtverteilung_Klasse;
--exec load_hub_Lichtstrom_Klasse;
--exec load_hub_Lichtfarbe_Klasse;
--exec load_hub_Schaltungsart_Klasse
--
--
--
--
----LINKS
--
--
TRUNCATE TABLE link.Leuchten__Steuerung;
TRUNCATE TABLE link.Steuerung__Treiber;
--TRUNCATE TABLE link.Produkt_Typ_Klasse__Leuchten_Laenge_Klasse__Optik_Klasse__Lichtverteilung_Klasse;
--TRUNCATE TABLE link.Lichtverteilung_Klasse__Produkt_Typ_Klasse__Leuchten_Laenge_Klasse__Optik_Klasse__Lichtstrom_Klasse;
--TRUNCATE TABLE link.Lichtstrom_Klasse__Produkt_Typ_Klasse__Leuchten_Laenge_Klasse__Optik_Klasse__Lichtfarbe_Klasse;
--TRUNCATE TABLE link.Lichtfarbe_Klasse__Schaltungsart_Klasse;
--
exec load_link_Leuchten__Steuerung;
exec load_link_Steuerung__Treiber;
--exec load_link_Leuchten_Laenge_Klasse__Optik_Klasse;
--exec load_link_Produkt_Typ_Klasse__Leuchten_Laenge_Klasse__Optik_Klasse__Lichtverteilung_Klasse;
--exec load_link_Lichtverteilung_Klasse__Produkt_Typ_Klasse__Leuchten_Laenge_Klasse__Optik_Klasse__Lichtstrom_Klasse;
--exec load_link_Lichtstrom_Klasse__Produkt_Typ_Klasse__Leuchten_Laenge_Klasse__Optik_Klasse__Lichtfarbe_Klasse;
--exec load_link_Lichtfarbe_Klasse__Schaltungsart_Klasse;

---SATS

TRUNCATE TABLE sat.Steuerung_MA;
TRUNCATE TABLE sat.Treiber_MA;
TRUNCATE TABLE sat.LED_Flex_Rolle_MA;
TRUNCATE TABLE sat.LED_Flex_Schnitt_MA;

exec load_sat_Steuerung_MA;
exec load_sat_Treiber_MA;
exec load_sat_LED_Flex_Rolle_MA;
exec load_sat_LED_Flex_Schnitt_MA;
GO
PRINT N'Update abgeschlossen.';


GO
