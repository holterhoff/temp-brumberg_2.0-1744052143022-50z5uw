
CREATE PROCEDURE [dbo].[load_hub_Biro40_Eulum] as

TRUNCATE TABLE hub.Biro40_Eulum

INSERT INTO hub.Biro40_Eulum ([TYP], [Lichtrichtung], [Lichtfarbe], [Schaltungsart], [Optisches_System], [Min], [Max], [Step], [Ecklaenge], [Eckmodus])

SELECT * FROM (VALUES

	('DIREKT 3000 K-DALI PRISMATISCH (UGR <19) - (PR)', 'direkt', '3000 K', 'DALI', 'prismatisch (UGR <19)', '840', '2380', '140', '591', 'MOD A'),
	('DIREKT 3000 K-DALI SATINIERT - (SAT)', 'direkt', '3000 K', 'DALI', 'satiniert', '840', '2380', '140', '591', 'MOD A'),
	('DIREKT 3000 K-ON OFF PRISMATISCH (UGR <19) - (PR)', 'direkt', '3000 K', 'ON / OFF', 'prismatisch (UGR <19)', '560', '2380', '140', '591', 'MOD A'),
	('DIREKT 3000 K-ON OFF SATINIERT - (SAT)', 'direkt', '3000 K', 'ON / OFF', 'satiniert', '560', '2380', '140', '591', 'MOD A'),
	('DIREKT 4000 K-DALI PRISMATISCH (UGR <19) - (PR)', 'direkt', '4000 K', 'DALI', 'prismatisch (UGR <19)', '840', '2380', '140', '591', 'MOD A'),
	('DIREKT 4000 K-DALI SATINIERT - (SAT)', 'direkt', '4000 K', 'DALI', 'satiniert', '840', '2380', '140', '591', 'MOD A'),
	('DIREKT 4000 K-ON OFF PRISMATISCH (UGR <19) - (PR)', 'direkt', '4000 K', 'ON / OFF', 'prismatisch (UGR <19)', '560', '2380', '140', '591', 'MOD A'),
	('DIREKT 4000 K-ON OFF SATINIERT - (SAT)', 'direkt', '4000 K', 'ON / OFF', 'satiniert', '560', '2380', '140', '591', 'MOD A'),
	('DIREKT RGBW-DALI PRISMATISCH (UGR <19) - (PR)', 'direkt', 'RGBW', 'DALI (DT6)', 'prismatisch (UGR <19)', '2520', '5600', '280', '591', 'MOD A'),
	('DIREKT RGBW-DALI SATINIERT - (SAT)', 'direkt', 'RGBW', 'DALI (DT6)', 'satiniert', '2520', '5600', '280', '591', 'MOD A'),
	('DIREKT TW-DALI PRISMATISCH (UGR <19) - (PR)', 'direkt', 'TW (2700-6500K)', 'DALI (DT8)', 'prismatisch (UGR <19)', '980', '2520', '70', '591', 'MOD A'),
	('DIREKT TW-DALI SATINIERT - (SAT)', 'direkt', 'TW (2700-6500K)', 'DALI (DT8)', 'satiniert', '980', '2520', '70', '591', 'MOD A'),
	('DIREKT / INDIREKT 3000 K-DALI PRISMATISCH (UGR <19) - (PR)', 'direkt indirekt', '3000 K', 'DALI', 'prismatisch (UGR <19)', '560', '2240', '140', '591', 'MOD A'),
	('DIREKT / INDIREKT 3000 K-DALI SATINIERT - (SAT)', 'direkt indirekt', '3000 K', 'DALI', 'satiniert', '560', '2240', '140', '591', 'MOD A'),
	('DIREKT / INDIREKT 3000 K-ON OFF PRISMATISCH (UGR <19) - (PR)', 'direkt indirekt', '3000 K', 'ON / OFF', 'prismatisch (UGR <19)', '560', '2240', '140', '591', 'MOD A'),
	('DIREKT / INDIREKT 3000 K-ON OFF SATINIERT - (SAT)', 'direkt indirekt', '3000 K', 'ON / OFF', 'satiniert', '560', '2240', '140', '591', 'MOD A'),
	('DIREKT / INDIREKT 4000 K-DALI PRISMATISCH (UGR <19) - (PR)', 'direkt indirekt', '4000 K', 'DALI', 'prismatisch (UGR <19)', '560', '2240', '140', '591', 'MOD A'),
	('DIREKT / INDIREKT 4000 K-DALI SATINIERT - (SAT)', 'direkt indirekt', '4000 K', 'DALI', 'satiniert', '560', '2240', '140', '591', 'MOD A'),
	('DIREKT / INDIREKT 4000 K-ON OFF PRISMATISCH (UGR <19) - (PR)', 'direkt indirekt', '4000 K', 'ON / OFF', 'prismatisch (UGR <19)', '560', '2240', '140', '591', 'MOD A'),
	('DIREKT / INDIREKT 4000 K-ON OFF SATINIERT - (SAT)', 'direkt indirekt', '4000 K', 'ON / OFF', 'satiniert', '560', '2240', '140', '591', 'MOD A'),
	('DIREKT / INDIREKT TW DI-RGBW IN-DALI PRISMATISCH (UGR <19) - (PR)', 'direkt indirekt', 'TW (2700-6500K) / RGBW', 'TW (DALI DT8) / RGBW (DALI DT6)', 'prismatisch (UGR <19)', '2520', '2520', '2520', '591', 'MOD A'),
	('DIREKT / INDIREKT TW DI-RGBW IN-DALI SATINIERT - (SAT)', 'direkt indirekt', 'TW (2700-6500K) / RGBW', 'TW (DALI DT8) / RGBW (DALI DT6)', 'satiniert', '2520', '2520', '2520', '591', 'MOD A'),
	('DIREKT / INDIREKT TW-DALI (1330) PRISMATISCH (UGR <19) - (PR)', 'direkt indirekt', 'TW (2700-6500K)', 'DALI (DT8)', 'prismatisch (UGR <19)', '1330', '1330', '1330', '591', 'MOD A'),
	('DIREKT / INDIREKT TW-DALI (1330) SATINIERT - (SAT)', 'direkt indirekt', 'TW (2700-6500K)', 'DALI (DT8)', 'satiniert', '1330', '1330', '1330', '591', 'MOD A'),
	('DIREKT / INDIREKT TW-DALI (1260) PRISMATISCH (UGR <19) - (PR)', 'direkt indirekt', 'TW (2700-6500K)', 'DALI (DT8)', 'prismatisch (UGR <19)', '1260', '1260', '1260', '591', 'MOD A'),
	('DIREKT / INDIREKT TW-DALI (1260) SATINIERT - (SAT)', 'direkt indirekt', 'TW (2700-6500K)', 'DALI (DT8)', 'satiniert', '1260', '1260', '1260', '591', 'MOD A'),
	('DIREKT / INDIREKT TW-DALI (1190) PRISMATISCH (UGR <19) - (PR)', 'direkt indirekt', 'TW (2700-6500K)', 'DALI (DT8)', 'prismatisch (UGR <19)', '1190', '1190', '1190', '591', 'MOD A'),
	('DIREKT / INDIREKT TW-DALI (1190) SATINIERT - (SAT)', 'direkt indirekt', 'TW (2700-6500K)', 'DALI (DT8)', 'satiniert', '1190', '1190', '1190', '591', 'MOD A'),
	('DIREKT / INDIREKT TW-DALI (1120) PRISMATISCH (UGR <19) - (PR)', 'direkt indirekt', 'TW (2700-6500K)', 'DALI (DT8)', 'prismatisch (UGR <19)', '1120', '1120', '1120', '591', 'MOD A'),
	('DIREKT / INDIREKT TW-DALI (1120) SATINIERT - (SAT)', 'direkt indirekt', 'TW (2700-6500K)', 'DALI (DT8)', 'satiniert', '1120', '1120', '1120', '591', 'MOD A'),
	('DIREKT / INDIREKT TW-DALI (1050) PRISMATISCH (UGR <19) - (PR)', 'direkt indirekt', 'TW (2700-6500K)', 'DALI (DT8)', 'prismatisch (UGR <19)', '1050', '1050', '1050', '591', 'MOD A'),
	('DIREKT / INDIREKT TW-DALI (1050) SATINIERT - (SAT)', 'direkt indirekt', 'TW (2700-6500K)', 'DALI (DT8)', 'sariniert', '1050', '1050', '1050', '591', 'MOD A')
   

)t ([TYP], [Lichtrichtung], [Lichtfarbe], [Schaltungsart], [Optisches_System], [Min], [Max], [Step], [Ecklaenge], [Eckmodus])