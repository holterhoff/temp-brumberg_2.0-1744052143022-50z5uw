CREATE TABLE [hub].[Treiber] (
    [Treiber_SK]     INT            IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]    VARCHAR (512)  NULL,
    [Typ]            VARCHAR (512)  NULL,
    [Beschreibung]   VARCHAR (512)  NULL,
    [Ausführung_DE]  VARCHAR (512)  NULL,
    [Ausführung_EN]  VARCHAR (512)  NULL,
    [Ansteuerung_DE] VARCHAR (512)  NULL,
    [Ansteuerung_EN] VARCHAR (512)  NULL,
    [Versorgung]     VARCHAR (512)  NULL,
    [Leistung_Min]   DECIMAL (5, 2) NULL,
    [Leistung_Max]   DECIMAL (5, 2) NULL,
    CONSTRAINT [PK_hub_Spot_Treiber] PRIMARY KEY CLUSTERED ([Treiber_SK] ASC)
);





