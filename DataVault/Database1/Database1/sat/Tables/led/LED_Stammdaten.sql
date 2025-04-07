CREATE TABLE [sat].[LED_Stammdaten] (
    [Leuchte_SK]             INT            NOT NULL,
    [Image]                  VARCHAR (512)  NULL,
    [Produktbeschreibung_DE] VARCHAR (MAX)  NULL,
    [Produktbeschreibung_EN] VARCHAR (MAX)  NULL,
    [SEO_Url_DE]             VARCHAR (MAX)  NULL,
    [SEO_Url_EN]             VARCHAR (MAX)  NULL,
    [Artikelnummer]          INT            NULL,
    [Preis]                  DECIMAL (5, 2) NULL,
    [Nettogewicht]           DECIMAL (5, 2) NULL,
    [Außendurchmesser]       INT            NULL,
    [Hoehe]                  INT            NULL,
    [Moegliche_Konverter]    VARCHAR (MAX)  NULL,
    [Datenblatt_DE]          VARCHAR (MAX)  NULL,
    [Datenblatt_EN]          VARCHAR (MAX)  NULL,
    [Status]                 VARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([Leuchte_SK] ASC)
);



