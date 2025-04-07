

CREATE VIEW fakt.Melody as 

SELECT 

	Hersteller,
	Leuchtenfamilie,
	Variante,
	Leuchtentyp,
	Gehaeusefarbe,
	Gehaeuseform,
	Montageart,
	Optik,
	Lichtrichtung,
	Lichtfarbe,
	Schaltungsart,
	Lichtstrom_Gesamt,
	--Systemleistung_lm_Watt,
	Farbwiedergabeindex,
	Website,
	CONCAT(Hersteller, ' ', Leuchtenfamilie, ' ', Variante, ' ', Leuchtentyp, ' ', Lichtrichtung) as Bezeichnung, 
	Artikelnummer,
	Preis,
	Produktbeschreibung


FROM hub.Melody_Stehleuchte h1
INNER JOIN sat.Melody_Stehleuchte_Stammdaten s1 ON  h1.Melody_SK = s1.Melody_SK
INNER JOIN sat.Melody_Stehleuchte_Artikel s2 ON h1.Melody_SK = s2.Melody_SK
