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
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "694561d9-b52d-45d3-8b40-74c51265195b" wird übersprungen; das Element "[hub].[LED].[Leuchte]" (SqlSimpleColumn) wird nicht in "Lichtfarbe" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "50ffa6c5-70a5-42c0-b2a2-59252e3df9f7" wird übersprungen; das Element "[hub].[LED].[Leuchtentyp]" (SqlSimpleColumn) wird nicht in "Leistung_pro_Meter" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "6240f374-123d-4416-9eb0-77a0da01e716" wird übersprungen; das Element "[hub].[LED].[Schutzart]" (SqlSimpleColumn) wird nicht in "Einheit_Leistung_pro_Meter" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "369f279f-19bd-4ea2-aa11-dc44b9dbdb75" wird übersprungen; das Element "[hub].[LED].[Kanal]" (SqlSimpleColumn) wird nicht in "Lumen_pro_Meter" umbenannt.';


GO
PRINT N'Tabelle "[hub].[LED]" wird erstellt...';


GO
CREATE TABLE [hub].[LED] (
    [LED_SK]                     INT           IDENTITY (1, 1) NOT NULL,
    [Lichtfarbe]                 NVARCHAR (50) NOT NULL,
    [Leistung_pro_Meter]         NVARCHAR (50) NOT NULL,
    [Einheit_Leistung_pro_Meter] NVARCHAR (50) NOT NULL,
    [Lumen_pro_Meter]            NVARCHAR (50) NOT NULL,
    [Einheit_Lumen_pro_Meter]    NVARCHAR (50) NOT NULL,
    [Rollmass]                   NVARCHAR (50) NOT NULL,
    [Schnittmass]                NVARCHAR (50) NOT NULL,
    [Segmente]                   NVARCHAR (50) NOT NULL,
    [Watt_pro_Segment]           NVARCHAR (50) NOT NULL,
    [Einheit_Watt_pro_Segment]   NVARCHAR (50) NOT NULL,
    [Watt_pro_Rolle]             NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_hub_LED] PRIMARY KEY CLUSTERED ([LED_SK] ASC)
);


GO
PRINT N'Tabelle "[link].[Leuchten__LED]" wird erstellt...';


GO
CREATE TABLE [link].[Leuchten__LED] (
    [Leuchte_SK] INT NOT NULL,
    [LED_SK]     INT NOT NULL
);


GO
PRINT N'Prozedur "[dbo].[load_all]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_all] as

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

exec load_sat_Steuerung_MA;
exec load_sat_Treiber_MA;
GO
PRINT N'Prozedur "[dbo].[load_hub_LED]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_LED] as

TRUNCATE TABLE hub.LED

INSERT INTO hub.LED ([Lichtfarbe], [Leistung_pro_Meter], [Einheit_Leistung_pro_Meter] ,[Lumen_pro_Meter], [Einheit_Lumen_pro_Meter] , [Rollmass] , [Schnittmass] , [Segmente] , [Watt_pro_Segment], [Einheit_Watt_pro_Segment] , [Watt_pro_Rolle])

SELECT * FROM (VALUES


('RGBW-4000 K','16','W/m','','lm/m','5000','50','100','0,8','W','80','W'),
('RGBW-4000 K','16','W/m','','lm/m','5000','50','100','0,8','W','80','W'),
('2700 K','10','W/m','950','lm/m','5000','50','100','0,5','W','50','W'),
('3000 K','10','W/m','1000','lm/m','5000','50','100','0,5','W','50','W'),
('4000 K','10','W/m','1105','lm/m','5000','50','100','0,5','W','50','W'),
('2700 K','10','W/m','950','lm/m','5000','50','100','0,5','W','50','W'),
('3000 K','10','W/m','1000','lm/m','5000','50','100','0,5','W','50','W'),
('4000 K','10','W/m','1105','lm/m','5000','50','100','0,5','W','50','W'),
('2000-6500 K','15','W/m','','lm/m','5040','28','180','0,42','W','75,6','W'),
('2000-6500 K','15','W/m','','lm/m','5040','28','180','0,42','W','75,6','W'),
('1800-3000 K','14,4','W/m','1380','lm/m','5000','100','50','1,44','W','72','W'),
('1800-3000 K','14,4','W/m','1160','lm/m','5000','100','50','1,44','W','72','W'),
('2700 K','1,5','W/m','131','lm/m','30000','100','300','0,15','W','45','W'),
('2700 K','3','W/m','258','lm/m','30000','100','300','0,3','W','90','W'),
('2700 K','5','W/m','410','lm/m','20000','100','200','0,5','W','100','W'),
('2700 K','10','W/m','820','lm/m','10000','50','200','0,5','W','100','W'),
('2700 K','15','W/m','1152','lm/m','10000','100','100','1,5','W','150','W'),
('2700 K','20','W/m','1660','lm/m','5000','50','100','1','W','100','W'),
('3000 K','3','W/m','135','lm/m','30000','100','300','0,3','W','90','W'),
('3000 K','5','W/m','270','lm/m','30000','100','300','0,5','W','150','W'),
('3000 K','1,5','W/m','430','lm/m','20000','100','200','0,15','W','30','W'),
('3000 K','10','W/m','870','lm/m','10000','50','200','0,5','W','100','W'),
('3000 K','15','W/m','1181','lm/m','10000','100','100','1,5','W','150','W'),
('3000 K','20','W/m','1720','lm/m','5000','50','100','1','W','100','W'),
('4000 K','3','W/m','150','lm/m','30000','100','300','0,3','W','90','W'),
('4000 K','5','W/m','282','lm/m','30000','100','300','0,5','W','150','W'),
('4000 K','1,5','W/m','455','lm/m','20000','100','200','0,15','W','30','W'),
('4000 K','10','W/m','900','lm/m','10000','50','200','0,5','W','100','W'),
('4000 K','15','W/m','1238','lm/m','10000','100','100','1,5','W','150','W'),
('4000 K','20','W/m','1800','lm/m','5000','50','100','1','W','100','W'),
('6000 K','3','W/m','155','lm/m','30000','100','300','0,3','W','90','W'),
('6000 K','5','W/m','291','lm/m','30000','100','300','0,5','W','150','W'),
('6000 K','1,5','W/m','465','lm/m','20000','100','200','0,15','W','30','W'),
('6000 K','10','W/m','920','lm/m','10000','50','200','0,5','W','100','W'),
('6000 K','15','W/m','1267','lm/m','10000','100','100','1,5','W','150','W'),
('6000 K','20','W/m','1840','lm/m','5000','50','100','1','W','100','W'),
('RGB-TW 2400-6500 K','24','W/m','','lm/m','5000','100','50','2,4','W','120','W'),
('RGBW ','24','W/m','','lm/m','5000','100','50','2,4','W','120','W'),
('2700 K','4,8','W/m','380','lm/m','5000','100','50','0,48','W','24','W'),
('2700 K','9,6','W/m','770','lm/m','5000','50','100','0,48','W','48','W'),
('2700 K','14,4','W/m','1260','lm/m','5000','100','50','1,44','W','72','W'),
('2700 K','19,2','W/m','1500','lm/m','5000','25','200','0,48','W','96','W'),
('3000 K','4,8','W/m','400','lm/m','5000','100','50','0,48','W','24','W'),
('3000 K','9,6','W/m','800','lm/m','5000','50','100','0,48','W','48','W'),
('3000 K','14,4','W/m','1280','lm/m','5000','100','50','1,44','W','72','W'),
('3000 K','19,2','W/m','1550','lm/m','5000','25','200','0,48','W','96','W'),
('4000 K','4,8','W/m','410','lm/m','5000','100','50','0,48','W','24','W'),
('4000 K','9,6','W/m','840','lm/m','5000','50','100','0,48','W','48','W'),
('4000 K','14,4','W/m','1300','lm/m','5000','100','50','1,44','W','72','W'),
('4000 K','19,2','W/m','1630','lm/m','5000','25','200','0,48','W','96','W'),
('6000 K','4,8','W/m','430','lm/m','5000','100','50','0,48','W','24','W'),
('6000 K','9,6','W/m','880','lm/m','5000','50','100','0,48','W','48','W'),
('6000 K','14,4','W/m','1320','lm/m','5000','100','50','1,44','W','72','W'),
('6000 K','19,2','W/m','1720','lm/m','5000','25','200','0,48','W','96','W'),
('2700 K','4,8','W/m','310','lm/m','5000','100','50','0,48','W','24','W'),
('2700 K','9,6','W/m','640','lm/m','5000','50','100','0,48','W','48','W'),
('2700 K','14,4','W/m','1071','lm/m','5000','100','50','1,44','W','72','W'),
('3000 K','4,8','W/m','330','lm/m','5000','100','50','0,48','W','24','W'),
('3000 K','9,6','W/m','660','lm/m','5000','50','100','0,48','W','48','W'),
('3000 K','14,4','W/m','1088','lm/m','5000','100','50','1,44','W','72','W'),
('4000 K','4,8','W/m','340','lm/m','5000','100','50','0,48','W','24','W'),
('4000 K','9,6','W/m','700','lm/m','5000','50','100','0,48','W','48','W'),
('4000 K','14,4','W/m','1105','lm/m','5000','100','50','1,44','W','72','W'),
('6000 K','4,8','W/m','350','lm/m','5000','100','50','0,48','W','24','W'),
('6000 K','9,6','W/m','730','lm/m','5000','50','100','0,48','W','48','W'),
('6000 K','14,4','W/m','1122','lm/m','5000','100','50','1,44','W','72','W'),
('2000-6500 K','19,2','W/m','','lm/m','5000','100','50','1,92','W','96','W'),
('2000-6500 K','22','W/m','','lm/m','5005','55','91','1,21','W','110,11','W'),
('2000-6500 K','36','W/m','','lm/m','3024','56','54','2,02','W','109,08','W'),
('2700-5700 K','19,2','W/m','873','lm/m','5000','50','100','0,96','W','96','W'),
('2000-6500 K','19,2','W/m','870','lm/m','5000','100','50','1,92','W','96','W')





)t ([Lichtfarbe], [Leistung_pro_Meter], [Einheit_Leistung_pro_Meter] ,[Lumen_pro_Meter], [Einheit_Lumen_pro_Meter] , [Rollmass] , [Schnittmass] , [Segmente] , [Watt_pro_Segment], [Einheit_Watt_pro_Segment] , [Watt_pro_Rolle])
GO
PRINT N'Prozedur "[dbo].[load_link_Leuchten__LED]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_link_Leuchten__LED] as

TRUNCATE TABLE link.Leuchten__LED

INSERT INTO link.Leuchten__LED (Leuchte_SK, LED_SK)

SELECT * FROM (VALUES 

(1,1),
(2,2),
(3,3),
(3,4),
(3,5),
(4,6),
(4,7),
(4,8),
(5,9),
(6,10),
(7,11),
(8,12),
(9,13),
(9,14),
(9,15),
(9,16),
(9,17),
(9,18),
(9,19),
(9,20),
(9,21),
(9,22),
(9,23),
(9,24),
(9,25),
(9,26),
(9,27),
(9,28),
(9,29),
(9,30),
(9,31),
(9,32),
(9,33),
(9,34),
(9,35),
(9,36),
(10,37),
(11,38),
(12,39),
(12,40),
(12,41),
(12,42),
(12,43),
(12,44),
(12,45),
(12,46),
(12,47),
(12,48),
(12,49),
(12,50),
(12,51),
(12,52),
(12,53),
(12,54),
(13,55),
(13,56),
(13,57),
(13,58),
(13,59),
(13,60),
(13,61),
(13,62),
(13,63),
(13,64),
(13,65),
(13,66),
(14,67),
(14,68),
(14,69),
(14,70),
(15,71)

)t (Leuchte_SK, LED_SK)
GO
-- Umgestaltungsschritt zum Aktualisieren des Zielservers mit bereitgestellten Transaktionsprotokollen
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '694561d9-b52d-45d3-8b40-74c51265195b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('694561d9-b52d-45d3-8b40-74c51265195b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '50ffa6c5-70a5-42c0-b2a2-59252e3df9f7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('50ffa6c5-70a5-42c0-b2a2-59252e3df9f7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6240f374-123d-4416-9eb0-77a0da01e716')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6240f374-123d-4416-9eb0-77a0da01e716')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '369f279f-19bd-4ea2-aa11-dc44b9dbdb75')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('369f279f-19bd-4ea2-aa11-dc44b9dbdb75')

GO

GO
PRINT N'Update abgeschlossen.';


GO
