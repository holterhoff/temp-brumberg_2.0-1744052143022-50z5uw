CREATE PROCEDURE [dbo].[load_link_Spot_LED__Treiber] as

TRUNCATE TABLE link.Spot_LED__Treiber

INSERT INTO link.Spot_LED__Treiber (Leuchte_SK, Treiber_SK)

select distinct

	h1.Leuchte_SK
,	h2.Treiber_SK


 from hub.LED h1
 JOIN hub.Treiber h2 ON h1.Versorgung = h2.Versorgung AND h1.Leistung < h2.Leistung_Max

