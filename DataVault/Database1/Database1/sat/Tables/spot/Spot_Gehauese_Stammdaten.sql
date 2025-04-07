CREATE TABLE [sat].[Spot_Gehaeuse_Stammdaten] (
    [Gehaeuse_SK]            INT             NOT NULL,
    [Schutzart]              VARCHAR (10)    NULL,
    [Einbaudurchmesser]      VARCHAR (10)    NULL,
    [Einbautiefe]            VARCHAR (10)    NULL,
    [Schwenkwinkel]          VARCHAR (10)    NULL,
    [Leistung]               VARCHAR (10)    NULL,
    [Image]                  VARCHAR (50)    NULL,
    [Produktbeschreibung_DE] VARCHAR (MAX)   NULL,
    [Produktbeschreibung_EN] VARCHAR (MAX)   NULL,
    [Artikelnummer]          VARCHAR (50)    NULL,
    [Preis]                  DECIMAL (18, 2) NULL,
    [Anzahl_Leuchtmittel]    VARCHAR (10)    NULL,
    [Moegliche_Leuchtmittel] VARCHAR (512)   NULL,
    [Nettogewicht]           VARCHAR (50)    NULL,
    [Max_Deckenstaerke]      VARCHAR (50)    NULL,
    [SEO_Url_DE]             VARCHAR (MAX)   NULL,
    [SEO_Url_EN]             VARCHAR (MAX)   NULL,
    [Serienname]             VARCHAR (MAX)   NULL,
    [Maße]                   VARCHAR (50)    NULL,
    [Datenblatt_DE]          VARCHAR (MAX)   NULL,
    [Datenblatt_EN]          VARCHAR (MAX)   NULL,
    [Material_DE]            VARCHAR (50)    NULL,
    [Material_EN]            VARCHAR (50)    NULL,
    [Status]                 VARCHAR (50)    NULL,
    PRIMARY KEY CLUSTERED ([Gehaeuse_SK] ASC)
);



