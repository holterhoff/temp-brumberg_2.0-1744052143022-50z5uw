CREATE PROCEDURE [dbo].[load_hub_Treiber] as

TRUNCATE TABLE hub.Treiber

INSERT INTO hub.Treiber ([Leuchtentyp], [Typ], [Beschreibung], [Ausführung_DE], [Ausführung_EN], [Ansteuerung_DE], [Ansteuerung_EN], [Versorgung], [Leistung_Min], [Leistung_Max])

SELECT * FROM (VALUES



    ('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'schaltbar', 'on/off', '350mA', '1', '5'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'schaltbar', 'on/off', '350mA', '1', '7.2'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'schaltbar', 'on/off', '350mA', '1', '7.2'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'schaltbar', 'on/off', '350mA', '1', '7.2'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'schaltbar', 'on/off', '350mA', '1', '15'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'schaltbar', 'on/off', '350mA', '1', '15'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'schaltbar', 'on/off', '350mA', '1', '15'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'schaltbar', 'on/off', '350mA', '1', '21'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'schaltbar', 'on/off', '350mA', '1', '21'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'schaltbar', 'on/off', '350mA', '1', '21'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '2.8', '7'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '2.8', '7'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '2.8', '7'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '4.9', '7'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '4.9', '7'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '4.2', '10'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '4.2', '10'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '4.2', '10'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '10.2', '14'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '10.2', '14'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '10.2', '14'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '8.8', '18'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '8.8', '18'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '8.8', '18'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '0.7', '17'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '0.7', '17'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'Phasenabschnitt', 'Trailing-edge phase', '350mA', '0.7', '17'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', '1-10 V', '1-10 V', '350mA', '5.2', '18'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', '1-10 V', '1-10 V', '350mA', '5.2', '18'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'DALI-2', 'DALI-2', '350mA', '3.5', '17'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'DALI-2', 'DALI-2', '350mA', '3.5', '17'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'DALI-2', 'DALI-2', '350mA', '3.5', '17'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'DALI-2', 'DALI-2', '350mA', '2.8', '7'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'DALI-2', 'DALI-2', '350mA', '2.8', '7'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'DALI-2', 'DALI-2', '350mA', '2.8', '7'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'DALI, PUSH-Dimm', 'DALI', '350mA', '2.1', '9'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'DALI, PUSH-Dimm', 'DALI', '350mA', '2.1', '9'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'DALI, PUSH-Dimm', 'DALI', '350mA', '2.1', '9'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'ZigBee', 'Zigbee', '350mA', '3.5', '18.5'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'ZigBee', 'Zigbee', '350mA', '3.5', '18.5'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'ZigBee', 'Zigbee', '350mA', '3.5', '18.5'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play', 'Plug&Play', 'Casambi-Push', 'Casambi-Push', '350mA', '3.5', '18'),
	('MR16', 'Treiber', 'LED-Konverter', 'ohne', 'without', 'Casambi-Push', 'Casambi-Push', '350mA', '3.5', '18'),
	('MR16', 'Treiber', 'LED-Konverter', 'Plug&Play + Anschlussbox', 'Plug&Play + connection box', 'Casambi-Push', 'Casambi-Push', '350mA', '3.5', '18')





)t ([Leuchtentyp], [Typ], [Beschreibung], [Ausführung_DE], [Ausführung_EN], [Ansteuerung_DE], [Ansteuerung_EN], [Versorgung], [Leistung_Min], [Leistung_Max])


