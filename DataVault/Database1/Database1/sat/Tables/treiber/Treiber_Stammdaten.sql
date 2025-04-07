CREATE TABLE [sat].[Treiber_Stammdaten] (
    [Treiber_SK]             INT            NOT NULL,
    [Image]                  VARCHAR (512)  NULL,
    [Produktbeschreibung_DE] VARCHAR (MAX)  NULL,
    [Produktbeschreibung_EN] VARCHAR (MAX)  NULL,
    [SEO_Url_DE]             VARCHAR (MAX)  NULL,
    [SEO_Url_EN]             VARCHAR (MAX)  NULL,
    [Artikelnummer]          VARCHAR (512)  NULL,
    [Preis]                  DECIMAL (5, 2) NULL,
    [Nettogewicht]           VARCHAR (10)   NULL,
    [Laenge]                 VARCHAR (50)   NULL,
    [Breite]                 VARCHAR (50)   NULL,
    [Hoehe]                  VARCHAR (50)   NULL,
    [Aussendurchmesser]      VARCHAR (512)  NULL,
    [Leistungsfaktor]        VARCHAR (512)  NULL,
    [K_Prüfzeichen]          VARCHAR (50)   NULL,
    [Datenblatt_DE]          VARCHAR (MAX)  NULL,
    [Datenblatt_EN]          VARCHAR (MAX)  NULL,
    [Status]                 VARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([Treiber_SK] ASC)
);



