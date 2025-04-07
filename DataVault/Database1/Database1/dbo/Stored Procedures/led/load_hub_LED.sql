CREATE PROCEDURE [dbo].[load_hub_LED] as

TRUNCATE TABLE hub.LED

INSERT INTO hub.LED(Leuchtentyp, Typ, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom )

SELECT * FROM (VALUES

	
	('MR16', 'Leuchteneinsatz', 'Statisch', '2700 K', '350mA', '3', '38°', '290'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '3000 K', '350mA', '3', '38°', '310'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '4000 K', '350mA', '3', '38°', '340'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '2700 K', '350mA', '6', '38°', '600'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '2700 K', '350mA', '6', '60°', '570'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '3000 K', '350mA', '6', '38°', '680'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '3000 K', '350mA', '6', '60°', '660'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '3500 K', '350mA', '6', '38°', '680'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '3500 K', '350mA', '6', '60°', '660'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '4000 K', '350mA', '6', '38°', '720'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '4000 K', '350mA', '6', '60°', '700'),
	('MR16', 'Leuchteneinsatz', 'dim2warm', '3000 K - 1800 K', '350mA', '6', '38°', '460'),
	('MR16', 'Leuchteneinsatz', 'dim2warm', '3000 K - 1800 K', '350mA', '6', '60°', '430'),
	('MR16', 'Leuchteneinsatz', 'DISC', '3000 K', '350mA', '6', '18°', '640'),
	('MR16', 'Leuchteneinsatz', 'DISC', '3000 K', '350mA', '6', '24°', '690'),
	('MR16', 'Leuchteneinsatz', 'DISC', '3000 K', '350mA', '6', '38°', '670'),
	('MR16', 'Leuchteneinsatz', 'DISC', '3000 K', '350mA', '6', '60°', '620'),
	('MR16', 'Leuchteneinsatz', 'DISC', '4000 K', '350mA', '6', '18°', '685'),
	('MR16', 'Leuchteneinsatz', 'DISC', '4000 K', '350mA', '6', '24°', '740'),
	('MR16', 'Leuchteneinsatz', 'DISC', '4000 K', '350mA', '6', '38°', '720'),
	('MR16', 'Leuchteneinsatz', 'DISC', '4000 K', '350mA', '6', '60°', '660'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '2700 K', '350mA', '12', '38°', '1.120'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '3000 K', '350mA', '12', '38°', '1.210'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '3500 K', '350mA', '12', '38°', '1.240'),
	('MR16', 'Leuchteneinsatz', 'Statisch', '4000 K', '350mA', '12', '38°', '1.250'),
	('MR16', 'Leuchteneinsatz', 'dim2warm', '3000 K - 1800 K', '350mA', '12', '38°', '930'),
	('MR16', 'Leuchteneinsatz', 'SunLike', '3000 K', '350mA', '12.5', '38°', '920')
	
	
	
	




)t (Leuchtentyp, Typ, Farbkanal, Lichtfarbe, Versorgung, Leistung, Abstrahlwinkel, Lichtstrom)


