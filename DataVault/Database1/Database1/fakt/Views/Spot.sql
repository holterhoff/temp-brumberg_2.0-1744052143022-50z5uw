









CREATE VIEW [fakt].[Spot] as 


SELECT 

		CONCAT(h1.Gehaeuse_SK, '-', h2.Leuchte_SK, '-', h3.Treiber_SK) as ID
	,	h1.Leuchtentyp
	,	h1.Typ as Typ_Gehaeuse_DE
	,	h1.Typ as Typ_Gehaeuse_EN
	,	h1.Form_DE
	,	h1.Form_EN
	,	h1.Farbe_DE
	,	h1.Farbe_EN
	,	CONCAT(h1.Leuchtentyp, ' ', h1.Form_DE, ' ', h1.Farbe_DE, ' ', h1.Typ) as Bezeichnung_Gehaeuse_DE
	,	CONCAT(h1.Leuchtentyp, ' ', h1.Form_EN, ' ', h1.Farbe_EN, ' ', h1.Typ) as Bezeichnung_Gehaeuse_EN
	,	s1.Schutzart
	,	s1.Einbaudurchmesser	
	,	s1.Einbautiefe
	,	s1.Schwenkwinkel
	,	s1.Produktbeschreibung_DE as Produktbeschreibung_Gehaeuse_DE
	,	s1.Produktbeschreibung_EN as Produktbeschreibung_Gehaeuse_EN
	,	s1.Artikelnummer as Artikelnummer_Gehaeuse
	,	s1.Preis as Preis_Gehaeuse
	,	s1.Image as Gehaeuse_Image
	,	s1.SEO_Url_DE as SEO_Url_Gehaeuse_DE
	,	s1.SEO_Url_EN as SEO_Url_Gehaeuse_EN
	,	s1.Datenblatt_DE as Datenblatt_Gehaeuse_DE
	,	s1.Datenblatt_EN as Datenblatt_Gehaeuse_EN
	,	h2.Typ as Typ_LED
	,	h2.Lichtfarbe
	,	h2.Farbkanal
	,	h2.Lichtstrom
	,	h2.Leistung
	,	h2.Abstrahlwinkel
	,	S2.Artikelnummer as Artikelnummer_LED
	,	S2.Preis as Preis_LED
	,	s2.Image as Leuchten_Image
	,	s2.Produktbeschreibung_DE as Produktbeschreibung_LED_DE
	,	s2.Produktbeschreibung_EN as Produktbeschreibung_LED_EN
	,	s2.SEO_Url_DE as SEO_Url_LED_DE
	,	s2.SEO_Url_EN as SEO_Url_LED_EN
	,	s2.Datenblatt_DE as Datenblatt_LED_DE
	,	s2.Datenblatt_EN as Datenblatt_LED_EN
	,	CONCAT(h2.Farbkanal, ' ', h2.Lichtfarbe, ' ', h2.Leistung, ' ', h2.Abstrahlwinkel) as Bezeichnung_LED_DE
	,	CONCAT(h2.Farbkanal, ' ', h2.Lichtfarbe, ' ', h2.Leistung, ' ', h2.Abstrahlwinkel) as Bezeichnung_LED_EN
	,	CONCAT(h3.Beschreibung,' ', h3.Versorgung) as Treiber_DE
	,	CONCAT(h3.Beschreibung,' ', h3.Versorgung) as Treiber_EN
	,	h3.Beschreibung
	,	h3.Versorgung
	,	h3.Ansteuerung_DE
	,	h3.Ansteuerung_EN
	,	CONCAT(UPPER(h3.Ansteuerung_DE), ' - ', (h3.Leistung_Min), ' - ' , (h3.Leistung_Max), 'W') as Ansteuerung2_DE
	,	CONCAT(UPPER(h3.Ansteuerung_EN), ' - ', (h3.Leistung_Min), ' - ' , (h3.Leistung_Max), 'W') as Ansteuerung2_EN
	,	h3.Ausführung_DE
	,	h3.Ausführung_EN
	,	CONCAT(h3.Beschreibung, ' ', Ansteuerung_DE, ' ', Ausführung_DE ) as Bezeichnung_Treiber_DE
	,	CONCAT(h3.Beschreibung, ' ', Ansteuerung_EN, ' ', Ausführung_EN ) as Bezeichnung_Treiber_EN
	,	s3.Image as Treiber_Image
	,	s3.Produktbeschreibung_DE as Produktbeschreibung_Treiber_DE
	,	s3.Produktbeschreibung_EN as Produktbeschreibung_Treiber_EN
	,	h3.Typ as Typ_Treiber
	,	h3.Leistung_Min
	,	h3.Leistung_Max
	,	s3.Artikelnummer as Artikelnummer_Treiber
	,	s3.Preis as Preis_Treiber
	,	s3.SEO_Url_DE as SEO_Url_Treiber_DE
	,	s3.SEO_Url_EN as SEO_Url_Treiber_EN
	--,	CONCAT(h3.Beschreibung, ' ', h3.Versorgung, ' ', h3.Ansteuerung_DE ) as Bezeichnung_Treiber_DE
	--,	CONCAT(h3.Beschreibung, ' ', h3.Versorgung, ' ', h3.Ansteuerung_EN ) as Bezeichnung_Treiber_EN
	,	s3.Datenblatt_DE as Datenblatt_Treiber_DE
	,	s3.Datenblatt_EN as Datenblatt_Treiber_EN
	,	CASE WHEN CEILING(h3.Leistung_Min / h2.Leistung) = 0 THEN 1  ELSE CEILING(h3.Leistung_Min / h2.Leistung) END as Min_Anzahl
	,	Max_Anzahl = FLOOR(h3.Leistung_Max / h2.Leistung)
	,	Lampenplatz = 1



 from hub.Spot_Gehaeuse h1
 INNER JOIN sat.Spot_Gehaeuse_Stammdaten s1 ON h1.Gehaeuse_SK = s1.Gehaeuse_SK
 INNER JOIN Link.Spot_Gehaeuse__LED l1 ON h1.Gehaeuse_SK = l1.Gehaeuse_SK
 INNER JOIN hub.LED h2 ON h2.Leuchte_SK = l1.Leuchte_SK
 INNER JOIN sat.LED_Stammdaten s2 ON s2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN link.Spot_LED__Treiber l2 ON l2.Leuchte_SK = h2.Leuchte_SK
 INNER JOIN hub.Treiber h3 ON l2.Treiber_SK = h3.Treiber_SK
 INNER JOIN sat.Treiber_Stammdaten s3 ON h3.Treiber_SK = s3.Treiber_SK

where 1=1
AND s1.Status ='Online'
AND s2.Status ='Online'
AND s3.Status ='Online'


