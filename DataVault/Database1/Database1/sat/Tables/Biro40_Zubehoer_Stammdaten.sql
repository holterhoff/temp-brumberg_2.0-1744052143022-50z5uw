CREATE TABLE [sat].[Biro40_Zubehoer_Stammdaten] (
    [Zubehoer_SK]         INT             NOT NULL,
    [Bezeichnung]         VARCHAR (512)   NULL,
    [Artikelnummer]       VARCHAR (512)   NULL,
    [Preis]               DECIMAL (18, 5) NULL,
    [Material]            VARCHAR (512)   NULL,
    [ME_Pack]             INT             NULL,
    [Preisfaktor]         VARCHAR (512)   NULL,
    [Ausschreibungstext1] VARCHAR (512)   NULL,
    [Gewicht]             VARCHAR (512)   NULL,
    [Datenblatt_URL]      VARCHAR (512)   NULL,
    PRIMARY KEY CLUSTERED ([Zubehoer_SK] ASC)
);

