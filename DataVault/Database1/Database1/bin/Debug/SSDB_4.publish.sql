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
/*
Die Spalte "[hub].[LED].[Einheit_Watt_pro_Rolle]" in der Tabelle "[hub].[LED]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [hub].[LED])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "694561d9-b52d-45d3-8b40-74c51265195b" wird übersprungen; das Element "[hub].[LED].[Leuchte]" (SqlSimpleColumn) wird nicht in "Lichtfarbe" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "50ffa6c5-70a5-42c0-b2a2-59252e3df9f7" wird übersprungen; das Element "[hub].[LED].[Leuchtentyp]" (SqlSimpleColumn) wird nicht in "Leistung_pro_Meter" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "6240f374-123d-4416-9eb0-77a0da01e716" wird übersprungen; das Element "[hub].[LED].[Schutzart]" (SqlSimpleColumn) wird nicht in "Einheit_Leistung_pro_Meter" umbenannt.';


GO
PRINT N'Der Umgestaltungsvorgang mit Umbenennung mit Schlüssel "369f279f-19bd-4ea2-aa11-dc44b9dbdb75" wird übersprungen; das Element "[hub].[LED].[Kanal]" (SqlSimpleColumn) wird nicht in "Lumen_pro_Meter" umbenannt.';


GO
PRINT N'Tabelle "[hub].[LED]" wird geändert...';


GO
ALTER TABLE [hub].[LED]
    ADD [Einheit_Watt_pro_Rolle] NVARCHAR (50) NOT NULL;


GO
PRINT N'Prozedur "[dbo].[load_hub_LED]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_hub_LED] as

TRUNCATE TABLE hub.LED

INSERT INTO hub.LED ([Lichtfarbe], [Leistung_pro_Meter], [Einheit_Leistung_pro_Meter] ,[Lumen_pro_Meter], [Einheit_Lumen_pro_Meter] , [Rollmass] , [Schnittmass] , [Segmente] , [Watt_pro_Segment], [Einheit_Watt_pro_Segment] , [Watt_pro_Rolle], [Einheit_Watt_pro_Rolle])

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





)t ([Lichtfarbe], [Leistung_pro_Meter], [Einheit_Leistung_pro_Meter] ,[Lumen_pro_Meter], [Einheit_Lumen_pro_Meter] , [Rollmass] , [Schnittmass] , [Segmente] , [Watt_pro_Segment], [Einheit_Watt_pro_Segment] , [Watt_pro_Rolle], [Einheit_Watt_pro_Rolle])
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
PRINT N'Prozedur "[dbo].[load_all]" wird geändert...';


GO
ALTER PROCEDURE [dbo].[load_all] as

--
---- HUBS
TRUNCATE TABLE hub.Leuchten;
TRUNCATE TABLE hub.Steuerung;
TRUNCATE TABLE hub.Treiber;
TRUNCATE TABLE hub.LED;
--TRUNCATE TABLE hub.Lichtverteilung_Klasse;
--TRUNCATE TABLE hub.Lichtstrom_Klasse;
--TRUNCATE TABLE hub.Lichtfarbe_Klasse;
--TRUNCATE TABLE hub.Schaltungsart_Klasse;a
--
--
exec load_hub_Leuchten;
exec load_hub_Steuerung;
exec load_hub_Treiber;
exec load_hub_LED;
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
TRUNCATE TABLE link.Leuchten__LED;
TRUNCATE TABLE link.Steuerung__Treiber;
--TRUNCATE TABLE link.Lichtverteilung_Klasse__Produkt_Typ_Klasse__Leuchten_Laenge_Klasse__Optik_Klasse__Lichtstrom_Klasse;
--TRUNCATE TABLE link.Lichtstrom_Klasse__Produkt_Typ_Klasse__Leuchten_Laenge_Klasse__Optik_Klasse__Lichtfarbe_Klasse;
--TRUNCATE TABLE link.Lichtfarbe_Klasse__Schaltungsart_Klasse;
--
exec load_link_Leuchten__Steuerung;
exec load_link_Leuchten__LED;
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
