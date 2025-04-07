CREATE TABLE [sat].[M1_Gehaeuse_Stammdaten] (
    [Gehaeuse_SK]            INT             NOT NULL,
    [Maße]                   VARCHAR (512)   NULL,
    [Einbaudurchmesser]      VARCHAR (512)   NULL,
    [Hoehe]                  INT             NULL,
    [Anzahl_Leuchtmittel]    VARCHAR (512)   NULL,
    [Schwenkwinkel]          VARCHAR (512)   NULL,
    [Image]                  VARCHAR (512)   NULL,
    [Produktbeschreibung_DE] VARCHAR (MAX)   NULL,
    [Produktbeschreibung_EN] VARCHAR (MAX)   NULL,
    [Artikelnummer]          INT             NULL,
    [Preis]                  DECIMAL (18, 2) NULL,
    [Moegliche_Konverter]    VARCHAR (MAX)   NULL,
    [Moegliche_Leuchtmittel] VARCHAR (MAX)   NULL,
    [Schutzart]              VARCHAR (512)   NULL,
    [Nettogewicht]           VARCHAR (50)    NULL,
    [Max_Deckenstaerke]      INT             NULL,
    [SEO_Url_DE]             VARCHAR (MAX)   NULL,
    [SEO_Url_EN]             VARCHAR (MAX)   NULL,
    [Datenblatt_DE]          VARCHAR (MAX)   NULL,
    [Datenblatt_EN]          VARCHAR (MAX)   NULL,
    [Status]                 VARCHAR (512)   NULL,
    PRIMARY KEY CLUSTERED ([Gehaeuse_SK] ASC)
);


