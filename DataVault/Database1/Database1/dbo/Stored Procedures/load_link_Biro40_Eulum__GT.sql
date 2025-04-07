
CREATE PROCEDURE [dbo].[load_link_Biro40_Eulum__GT] as

TRUNCATE TABLE link.Biro40_Eulum__GT

INSERT INTO link.Biro40_Eulum__GT (Eulum_SK, GT_SK)

SELECT 

		Eulum_SK
	,	GT_SK

FROM hub.Biro40_Eulum Eulum
inner join hub.Biro40_GT gt ON gt.Lichtrichtung = Eulum.Lichtrichtung and gt.Lichtfarbe = Eulum.Lichtfarbe and gt.Schaltungsart = Eulum.Schaltungsart and (gt.Step % Eulum.Step = 0 )  and (gt.Step BETWEEN Eulum.[Min] and Eulum.[Max]) 
or gt.Step = 90 and gt.Lichtrichtung = eulum.Lichtrichtung and gt.Lichtfarbe = Eulum.Lichtfarbe and gt.Schaltungsart = Eulum.Schaltungsart