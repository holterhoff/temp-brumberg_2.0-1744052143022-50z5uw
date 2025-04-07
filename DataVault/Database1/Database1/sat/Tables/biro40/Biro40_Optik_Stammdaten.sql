CREATE TABLE [sat].[Biro40_Optik_Stammdaten] (
    [Optik_SK]             INT             NOT NULL,
    [Kennung]              VARCHAR (512)   NULL,
    [Bezeichnung]          VARCHAR (512)   NULL,
    [Artikelnummer]        VARCHAR (512)   NULL,
    [Preis]                DECIMAL (18, 5) NULL,
    [Berechnungsfaktor]    INT             NULL,
    [Ausschreibungstext 1] VARCHAR (512)   NULL,
    [Gesamtgewicht kg/m]   VARCHAR (512)   NULL,
    PRIMARY KEY CLUSTERED ([Optik_SK] ASC)
);

