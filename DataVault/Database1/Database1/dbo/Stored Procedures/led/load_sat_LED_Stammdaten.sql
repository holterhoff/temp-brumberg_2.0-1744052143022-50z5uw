﻿CREATE PROCEDURE [dbo].[load_sat_LED_Stammdaten] as

TRUNCATE TABLE sat.LED_Stammdaten

INSERT INTO sat.LED_Stammdaten ([Leuchte_SK], [Image], [Produktbeschreibung_DE], [Produktbeschreibung_EN], [SEO_Url_DE], [SEO_Url_EN], [Artikelnummer], [Preis], [Nettogewicht], [Außendurchmesser], [Hoehe], [Moegliche_Konverter], [Datenblatt_DE], [Datenblatt_EN], [Status])
SELECT * FROM (VALUES


	('1', '12925003.jpg', 'LED-Reflektoreinsatz MR16, 3 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 3W, Lichtstrom: 290lm, Farbtemperatur: 2.700 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 3 W, white, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 3W, Luminous flux: 290lm, Colour temperature: 2.700 K, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-3-w-350-ma-12925003', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-3-w-350-ma-12925003', '12925003', '44.5', '0.08', '50', '40', '17666000|17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12925003_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12925003_2021_EN.pdf', 'Online'),
	('2', '12926003.jpg', 'LED-Reflektoreinsatz MR16, 3 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 3W, Lichtstrom: 310lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 3 W, white, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 3W, Luminous flux: 310lm, Colour temperature: 3.000 K, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-3-w-350-ma-12926003', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-3-w-350-ma-12926003', '12926003', '44.5', '0.08', '50', '40', '17666000|17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12926003_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12926003_2021_EN.pdf', 'Online'),
	('3', '12925004.jpg', 'LED-Reflektoreinsatz MR16, 3 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 3W, Lichtstrom: 340lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 3 W, white, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 3W, Luminous flux: 340lm, Colour temperature: 4.000 K, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-3-w-350-ma-12925004', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-3-w-350-ma-12925004', '12925004', '44.5', '0.08', '50', '40', '17666000|17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12925004_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12925004_2021_EN.pdf', 'Online'),
	('4', '12923383.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 600lm, Farbtemperatur: 2.700 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 6 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Luminous flux: 600lm, Colour temperature: 2.700 K, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923383', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-6-w-350-ma-12923383', '12923383', '63.5', '0.08', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12923383_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12923383_2021_EN.pdf', 'Online'),
	('5', '12923603.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 570lm, Farbtemperatur: 2.700 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 6 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Luminous flux: 570lm, Colour temperature: 2.700 K, Beam angle: 60°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923603', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-6-w-350-ma-12923603', '12923603', '63.5', '0.08', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12923603_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12923603_2021_EN.pdf', 'Online'),
	('6', '12924383.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 680 lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 6 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Luminous flux: 680lm, Colour temperature: 3.000 K, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924383', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-6-w-350-ma-12924383', '12924383', '63.5', '0.08', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12924383_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12924383_2021_EN.pdf', 'Online'),
	('7', '12924603.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 660lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 6 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Luminous flux: 660lm, Colour temperature: 3.000 K, Beam angle: 60°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924603', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-6-w-350-ma-12924603', '12924603', '63.5', '0.08', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12924603_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12924603_2021_EN.pdf', 'Online'),
	('8', '12924384.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 680 lm, Farbtemperatur: 3.500 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 6 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Luminous flux: 680lm, Colour temperature: 3.500 K, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924384', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-6-w-350-ma-12924384', '12924384', '63.5', '0.08', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12924384_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12924384_2021_EN.pdf', 'Online'),
	('9', '12924604.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 660lm, Farbtemperatur: 3.500 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 6 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Luminous flux: 660lm, Colour temperature: 3.500 K, Beam angle: 60°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12924604', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-6-w-350-ma-12924604', '12924604', '63.5', '0.08', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12924604_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12924604_2021_EN.pdf', 'Online'),
	('10', '12923384.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 720 lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 6 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Luminous flux: 720lm, Colour temperature: 4.000 K, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923384', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-6-w-350-ma-12923384', '12923384', '63.5', '0.08', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12923384_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12923384_2021_EN.pdf', 'Online'),
	('11', '12923604.jpg', 'LED-Reflektoreinsatz MR16, 6 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 700lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 6 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Luminous flux: 700lm, Colour temperature: 4.000 K, Beam angle: 60°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-350-ma-12923604', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-6-w-350-ma-12923604', '12923604', '63.5', '0.08', '50', '32', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12923604_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12923604_2021_EN.pdf', 'Online'),
	('12', '12963383.jpg', 'LED-Reflektoreinsatz MR16, 6 W, dim2warm, 350 mA, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 460lm, Farbtemperatur: von 1.800 K bis 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 6 W, dim2warm, round. If the LED module is dimmed, the color temperature is reduced. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Luminous flux: 460lm, Colour temperature: from 1.800 K up to 3.000 K, Light colour : White, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-dim2warm-350-ma-12963383', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-6-w-dim2warm-350-ma-12963383', '12963383', '79.9', '0.08', '50', '32', '17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12963383_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12963383_2021_EN.pdf', 'Online'),
	('13', '12963603.jpg', 'LED-Reflektoreinsatz MR16, 6 W, dim2warm, 350 mA, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Lichtstrom: 430lm, Farbtemperatur: von 1.800 K bis 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 6 W, dim2warm, round. If the LED module is dimmed, the color temperature is reduced. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Luminous flux: 430lm, Colour temperature: from 1.800 K up to 3.000 K, Light colour : White, Beam angle: 60°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-6-w-dim2warm-350-ma-12963603', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-6-w-dim2warm-350-ma-12963603', '12963603', '79.9', '0.08', '50', '32', '17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12963603_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12963603_2021_EN.pdf', 'Online'),
	('14', '12920183.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 640lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 18°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED insert DISC, MR16, 6 W, with lens optics, round. Lamp holder: Plug&Play, Material: Aluminium / Plastic, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Amount of light sources / fittings: 1.0 Qty, Luminous flux: 640lm, Colour temperature: 3.000 K, Beam angle: 18°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920183', 'https://www.brumberg.com/en/products/disc-led-insert-mr16-6-w-with-lens-optics-350-ma-12920183', '12920183', '39.5', '0.06', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920183_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920183_2021_EN.pdf', 'Online'),
	('15', '12920243.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 690lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 24°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED insert DISC, MR16, 6 W, with lens optics, round. Lamp holder: Plug&Play, Material: Aluminium / Plastic, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Amount of light sources / fittings: 1.0 Qty, Luminous flux: 690lm, Colour temperature: 3.000 K, Beam angle: 24°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920243', 'https://www.brumberg.com/en/products/disc-led-insert-mr16-6-w-with-lens-optics-350-ma-12920243', '12920243', '39.5', '0.06', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920243_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920243_2021_EN.pdf', 'Online'),
	('16', '12920003.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 670lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED insert DISC, MR16, 6 W, with lens optics, round. Lamp holder: Plug&Play, Material: Aluminium / Plastic, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Amount of light sources / fittings: 1.0 Qty, Luminous flux: 670lm, Colour temperature: 3.000 K, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920003', 'https://www.brumberg.com/en/products/disc-led-insert-mr16-6-w-with-lens-optics-350-ma-12920003', '12920003', '39.5', '0.06', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920003_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920003_2021_EN.pdf', 'Online'),
	('17', '12920603.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 620lm, Farbtemperatur: 3.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED insert DISC, MR16, 6 W, with lens optics, round. Lamp holder: Plug&Play, Material: Aluminium / Plastic, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Amount of light sources / fittings: 1.0 Qty, Luminous flux: 620lm, Colour temperature: 3.000 K, Beam angle: 60°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920603', 'https://www.brumberg.com/en/products/disc-led-insert-mr16-6-w-with-lens-optics-350-ma-12920603', '12920603', '39.5', '0.06', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920603_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920603_2021_EN.pdf', 'Online'),
	('18', '12920184.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 685lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 18°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED insert DISC, MR16, 6 W, with lens optics, round. Lamp holder: Plug&Play, Material: Aluminium / Plastic, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Amount of light sources / fittings: 1.0 Qty, Luminous flux: 685lm, Colour temperature: 4.000 K, Beam angle: 18°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920184', 'https://www.brumberg.com/en/products/disc-led-insert-mr16-6-w-with-lens-optics-350-ma-12920184', '12920184', '39.5', '0.06', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920184_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920184_2021_EN.pdf', 'Online'),
	('19', '12920244.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 740lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 24°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED insert DISC, MR16, 6 W, with lens optics, round. Lamp holder: Plug&Play, Material: Aluminium / Plastic, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Amount of light sources / fittings: 1.0 Qty, Luminous flux: 740lm, Colour temperature: 4.000 K, Beam angle: 24°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920244', 'https://www.brumberg.com/en/products/disc-led-insert-mr16-6-w-with-lens-optics-350-ma-12920244', '12920244', '39.5', '0.06', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920244_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920244_2021_EN.pdf', 'Online'),
	('20', '12920004.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 720lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED insert DISC, MR16, 6 W, with lens optics, round. Lamp holder: Plug&Play, Material: Aluminium / Plastic, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Amount of light sources / fittings: 1.0 Qty, Luminous flux: 720lm, Colour temperature: 4.000 K, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920004', 'https://www.brumberg.com/en/products/disc-led-insert-mr16-6-w-with-lens-optics-350-ma-12920004', '12920004', '39.5', '0.06', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920004_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920004_2021_EN.pdf', 'Online'),
	('21', '12920604.jpg', 'LED-Einsatz, MR16, 6 W, mit Linsenoptik, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 6W, Anzahl der Leuchtmittel / Fassungen: 1.0 Stk, Lichtstrom: 660lm, Farbtemperatur: 4.000 K, Abstrahlwinkel: 60°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED insert DISC, MR16, 6 W, with lens optics, round. Lamp holder: Plug&Play, Material: Aluminium / Plastic, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 6W, Amount of light sources / fittings: 1.0 Qty, Luminous flux: 660lm, Colour temperature: 4.000 K, Beam angle: 60°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/disc-led-einsatz-mr16-6-w-mit-linsenoptik-350-ma-12920604', 'https://www.brumberg.com/en/products/disc-led-insert-mr16-6-w-with-lens-optics-350-ma-12920604', '12920604', '39.5', '0.06', '50', '31', '17662000|17662010|17662020|17613000|17613010|17613020|17621000|17621010|17621020|17663000|17663010|17663020|17652000|17652020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17640000|17640010|17640020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920604_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12920604_2021_EN.pdf', 'Online'),
	('22', '12953003.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.120lm, Farbtemperatur: 2.700 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 12 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 12W, Luminous flux: 1.120lm, Colour temperature: 2.700 K, Light colour : White, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12953003', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-12-w-350-ma-12953003', '12953003', '99.9', '0.14', '50', '70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12953003_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12953003_2021_EN.pdf', 'Online'),
	('23', '12954003.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.210lm, Farbtemperatur: 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 12 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 12W, Luminous flux: 1.210lm, Colour temperature: 3.000 K, Light colour : White, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12954003', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-12-w-350-ma-12954003', '12954003', '99.9', '0.14', '50', '70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12954003_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12954003_2021_EN.pdf', 'Online'),
	('24', '12954004.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.240lm, Farbtemperatur: 3.500 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 12 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 12W, Luminous flux: 1.240lm, Colour temperature: 3.500 K, Light colour : White, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12954004', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-12-w-350-ma-12954004', '12954004', '99.9', '0.14', '50', '70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12954004_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12954004_2021_EN.pdf', 'Online'),
	('25', '12953004.jpg', 'LED-Reflektoreinsatz MR16, 12 W, 350 mA, rund. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 1.250lm, Farbtemperatur: 4.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 12 W, round. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 12W, Luminous flux: 1.250lm, Colour temperature: 4.000 K, Light colour : White, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-350-ma-12953004', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-12-w-350-ma-12953004', '12953004', '99.9', '0.14', '50', '70', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12953004_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12953004_2021_EN.pdf', 'Online'),
	('26', '12965003.jpg', 'LED-Reflektoreinsatz MR16, 12 W, dim2warm, 350 mA, rund. Wird das LED-Modul gedimmt, verringert sich die Farbtemperatur. Ausführung: Plug&Play, Material: Aluminium / Glas, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12W, Lichtstrom: 930lm, Farbtemperatur: von 1.800 K bis 3.000 K, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 12 W, dim2warm, round. If the LED module is dimmed, the color temperature is reduced. Lamp holder: Plug&Play, Material: Aluminium / Glass, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 12W, Luminous flux: 930lm, Colour temperature: from 1.800 K up to 3.000 K, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-w-dim2warm-350-ma-12965003', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-12-w-dim2warm-350-ma-12965003', '12965003', '119.9', '0.14', '50', '70', '17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12965003_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12965003_2021_EN.pdf', 'Online'),
	('27', '12983003.jpg', 'LED-Reflektoreinsatz MR16, 12,5 W, SunLike, CRI > 97, 350 mA. Ausführung: Plug&Play, Material: Aluminium / Kunststoff, Schutzart raumseitig: nach DIN EN 60529: IP20, Schutzklasse: (EN 61140) III, Leistung: 12.5W, Lichtstrom: 920lm, Farbtemperatur: 3.000 K, Lichtfarbe: weiß, Abstrahlwinkel: 38°, Art der Dimmung: abhängig vom Betriebsgerät.', 'LED reflector insert MR16, 12,5 W, SunLike, CRI > 97. Lamp holder: Plug&Play, Material: Aluminium / Plastic, Degree of protection: according to DIN EN 60529 IP20, Protection class: (EN 61140) III, Current: 350 mA, Power: 12.5W, Luminous flux: 920lm, Colour temperature: 3.000 K, Light colour : White, Beam angle: 38°, Control: Dimming depending on driver.', 'https://www.brumberg.com/de/produkte/led-reflektoreinsatz-mr16-12-5-w-sunlike-cri-gt-97-350-ma-12983003', 'https://www.brumberg.com/en/products/led-reflector-insert-mr16-12-5-w-sunlike-cri-97-350-ma-12983003', '12983003', '119.9', '0.13', '50', '95', '17613000|17613010|17613020|17621000|17621010|17621020|17664000|17664010|17664020|17657000|17657010|17657099|17683000|17683010|17683020|17643000|17643010|17643020|17648000|17648010|17648020|17671000|17671010|17671020|17672000|17672010|17672020', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12983003_2021_DE.pdf', 'https://www.brumberg.com/fileadmin/products/Datenblatt_12983003_2021_EN.pdf', 'Online')


)t ([Leuchte_SK], [Image], [Produktbeschreibung_DE], [Produktbeschreibung_EN], [SEO_Url_DE], [SEO_Url_EN], [Artikelnummer], [Preis], [Nettogewicht], [Außendurchmesser], [Hoehe], [Moegliche_Konverter], [Datenblatt_DE], [Datenblatt_EN], [Status])


