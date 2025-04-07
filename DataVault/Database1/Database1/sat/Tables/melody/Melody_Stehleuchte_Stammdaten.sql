CREATE TABLE [sat].[Melody_Stehleuchte_Stammdaten] (
    [Melody_SK]  INT           NOT NULL,
    [Lichtstrom_Gesamt]       NVARCHAR(50) NULL,
    [Systemleistung_Watt]     NVARCHAR(50) NULL,
    [Systemeffizienz_lm_Watt] NVARCHAR(50) NULL,
    [Farbwiedergabeindex]     NVARCHAR(50) NULL,
    [Laenge]                  NVARCHAR(50) NULL,
    [Breite]                  NVARCHAR(50) NULL,
    [Hoehe]                   NVARCHAR(50) NULL,
    [Durchmesser]             NVARCHAR(50) NULL,
    [Website]                 NVARCHAR(250) NULL,
    [Produktbeschreibung]     NVARCHAR(MAX) NULL

    PRIMARY KEY CLUSTERED ([Melody_SK] ASC)
);

