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
PRINT N'Tabelle "[sat].[Spot_Treiber_Artikel]" wird erstellt...';


GO
CREATE TABLE [sat].[Spot_Treiber_Artikel] (
    [Treiber_SK]    INT            NOT NULL,
    [Artikelnummer] NVARCHAR (50)  NOT NULL,
    [Preis]         DECIMAL (5, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Treiber_SK] ASC)
);


GO
PRINT N'Sicht "[fakt].[Spot]" wird geändert...';


GO
ALTER VIEW [fakt].[Spot] as 

select 

		h1.Leuchtentyp
	,	h1.Typ
	,	h1.Form
	,	h1.Farbe
	,	s1.Schutzart
	,	s1.Einbaudurchmesser	
	,	s1.Einbautiefe
	,	s1.Schwenkwinkel
	,	s1.Produktbeschreibung
	,	s1.Image as Gehaeuse_Image
	,	h2.Lichtfarbe
	,	h2.Farbkanal
	,	h2.Lichtstrom
	,	h2.Leistung
	,	h2.Effizienzklasse
	,	s2.Image as Leuchten_Image
	,	CONCAT(h3.Beschreibung,' ', h3.Versorgung) as Treiber
	,	h3.Beschreibung
	,	h3.Versorgung
	,	h3.Ansteuerung
	,	CONCAT(UPPER(h3.Ansteuerung), ' - ', (h3.Leistung_Min), 'W', ' ... ' , (h3.Leistung_Max), 'W') as Ansteuerung2
	,	h3.Ausführung
	,	s3.Image as Treiber_Image
	,	h3.Leistung_Min
	,	h3.Leistung_Max


	,	CASE WHEN CEILING(h3.Leistung_Min / h2.Leistung) = 0 THEN 1  ELSE CEILING(h3.Leistung_Min / h2.Leistung) END as Min_Anzahl
	,	Max_Anzahl = FLOOR(h3.Leistung_Max / h2.Leistung)

	,	Lampenplatz = 1




 from hub.Spot_Gehaeuse h1
 INNER JOIN sat.Spot_Gehaeuse_Stammdaten s1 ON h1.Gehaeuse_SK = s1.Gehaeuse_SK
 INNER JOIN Link.Spot_Gehaeuse__Leuchte l1 ON h1.Gehaeuse_SK = l1.Gehaeuse_SK
 INNER JOIN hub.Spot_Leuchte h2 ON h2.Leuchte_SK = l1.Leuchte_SK
 INNER JOIN sat.Spot_Leuchte_Stammdaten s2 ON s2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN link.Spot_Leuchte__Treiber l2 ON l2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN hub.Spot_Treiber h3 ON l2.Treiber_SK = h3.Treiber_SK
 INNER JOIN sat.Spot_Treiber_Stammdaten s3 ON h3.Treiber_SK = s3.Treiber_SK


--where 1=1
----- Gehäuse
--and typ = '1964'
--and Farbe = 'chrom'
--
---- LED
--and Farbkanal = 'Statisch'
--and Lichtfarbe = '2700 K'
--And h2.Leistung = 3.00
--
---- Treiber
--and Ansteuerung ='DALI-2'
--and h3.Ausführung = 'Plug & Play'
GO
PRINT N'Prozedur "[dbo].[load_sat_Spot_Treiber_Artikel]" wird erstellt...';


GO
CREATE PROCEDURE [dbo].[load_sat_Spot_Treiber_Artikel] as

TRUNCATE TABLE sat.Spot_Treiber_Artikel

INSERT INTO sat.Spot_Treiber_Artikel (Treiber_SK, Artikelnummer, Preis)
SELECT * FROM (VALUES


 (1	      ,'17666000'	      ,37.1)
,(2	      ,'17662000'	      ,30.2)
,(3	      ,'17662010'	      ,26.9)
,(4	      ,'17662020'	      ,39.9)
,(5	      ,'17613000'	      ,54.9)
,(6	      ,'17613010'	      ,45.9)
,(7	      ,'17613020'	      ,59.7)
,(8	      ,'17621000'	      ,59.9)
,(9	      ,'17621010'	      ,54.9)
,(10	    ,'17621020'	      ,65.9)
,(11	    ,'17663000'	      ,34.9)
,(12	    ,'17663010'	      ,32.9)
,(13	    ,'17663020'	      ,43.7)
,(14	    ,'17652000'	      ,50.4)
,(15	    ,'17652020'	      ,56.9)
,(16	    ,'17640000'	      ,47.3)
,(17	    ,'17640010'	      ,44.9)
,(18	    ,'17640020'	      ,54.9)
,(19	    ,'17648000'	      ,119.9)
,(20	    ,'17648010'	      ,117.9)
,(21	    ,'17648020'	      ,129.9)
,(22	    ,'17643000'	      ,49.9)
,(23	    ,'17643010'	      ,45.9)
,(24	    ,'17643020'	      ,57.6)
,(25	    ,'17664000'	      ,50.3)
,(26	    ,'17664010'	      ,47.9)
,(27	    ,'17664020'	      ,59.9)
,(28	    ,'17657000'	      ,75.5)
,(29	    ,'17657010'	      ,73.0)
,(30	    ,'17683000'	      ,89.7)
,(31	    ,'17683010'	      ,84.9)
,(32	    ,'17683020'	      ,93.9)
,(33	    ,'17658000'	      ,106.9)
,(34	    ,'17658010'	      ,103.9)
,(35	    ,'17658020'	      ,112.9)
,(36	    ,'17672000'	      ,229.9)
,(37	    ,'17672010'	      ,224.9)
,(38	    ,'17672020'	      ,234.9)
,(39	    ,'17671000'	      ,189.9)
,(40	    ,'17671010'	      ,179.9)
,(41	    ,'17671020'	      ,199.9)


     

)t (Treiber_SK, Artikelnummer, Preis)
GO
PRINT N'Update abgeschlossen.';


GO
