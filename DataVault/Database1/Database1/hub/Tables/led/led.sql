CREATE TABLE [hub].[LED] (
    [Leuchte_SK]     INT           IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]    VARCHAR (100) NOT NULL,
    [Typ]            NVARCHAR (50) NOT NULL,
    [Farbkanal]      VARCHAR (100) NOT NULL,
    [Lichtfarbe]     VARCHAR (100) NOT NULL,
    [Versorgung]     VARCHAR (100) NOT NULL,
    [Leistung]       VARCHAR (100) NOT NULL,
    [Abstrahlwinkel] VARCHAR (100) NOT NULL,
    [Lichtstrom]     VARCHAR (100) NOT NULL
);



