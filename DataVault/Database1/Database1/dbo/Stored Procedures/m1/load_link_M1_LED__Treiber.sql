﻿CREATE PROCEDURE [dbo].[load_link_M1_LED__Treiber] as
TRUNCATE TABLE link.M1_LED__Treiber;

WITH src as
(

SELECT 

		h.Gehaeuse_SK
	,	h.Form_DE
	,	h.Farbe_DE
	,	h.Leuchtentyp
	,	h.Typ_DE
	,	h.Verstellbarkeit_DE
	,	s.Moegliche_Konverter
	,	s.Moegliche_Leuchtmittel
	,	s.Artikelnummer

FROM hub.M1_Gehaeuse h
INNER JOIN sat.M1_Gehaeuse_Stammdaten s ON h.Gehaeuse_SK = s.Gehaeuse_SK
),

src2 as(

SELECT 
	
		h1.Leuchte_SK
	,	h1.Farbkanal
	,	h1.Lichtfarbe
	,	h1.Leistung
	,	s1.Artikelnummer
	,	s1.Moegliche_Konverter



FROM hub.LED h1 
INNER JOIN sat.LED_Stammdaten s1 ON h1.Leuchte_SK = s1.Leuchte_SK

),
src3 as
(
SELECT
		h.Ansteuerung_DE
	,	h.Ausführung_DE
	,	h.Leistung_Min
	,	h.Leistung_Max
	,	s.* 

FROM hub.Treiber h
INNER JOIN sat.Treiber_Stammdaten s ON h.Treiber_SK = s.Treiber_SK

)

INSERT INTO link.M1_LED__Treiber (Gehaeuse_SK, Leuchte_SK, Treiber_SK)
SELECT DISTINCT



		src.Gehaeuse_SK
	,	src2.Leuchte_SK
	,	src3.Treiber_SK


FROM src
INNER JOIN src2 ON src.Moegliche_Leuchtmittel LIKE '%'+ src2.Artikelnummer + '%' 
INNER JOIN src3 ON src.Moegliche_Konverter LIKE '%'+ src3.Artikelnummer + '%'



WHERE 1=1
AND src2.Moegliche_Konverter LIKE '%' + src3.Artikelnummer + '%'

