CREATE TABLE [sat].[Biro40_Profil_Stammdaten] (
    [Profil_SK]                 INT             NOT NULL,
    [Kennung]                   VARCHAR (512)   NULL,
    [Bezeichnung]               VARCHAR (512)   NULL,
    [Artikelnummer]             VARCHAR (512)   NULL,
    [Preis]                     DECIMAL (18, 5) NULL,
    [Berechnungsfaktor]         INT             NULL,
    [Ausschreibungstext 1]      VARCHAR (512)   NULL,
    [Ausschreibungstext 2]      VARCHAR (512)   NULL,
    [Ausschreibungstext 3]      VARCHAR (512)   NULL,
    [Ausschreibungstext 4]      VARCHAR (512)   NULL,
    [Profilquerschnitt]         VARCHAR (512)   NULL,
    [Profilbreite]              INT             NULL,
    [Profilhöhe]                INT             NULL,
    [Delta_DA]                  VARCHAR (512)   NULL,
    [Erforderliche_Einbautiefe] VARCHAR (512)   NULL,
    [Gesamtgewicht kg/m]        INT             NULL,
    PRIMARY KEY CLUSTERED ([Profil_SK] ASC)
);

