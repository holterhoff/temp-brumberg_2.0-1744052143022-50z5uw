CREATE TABLE [hub].[Biro40_Zubehoer] (
    [Zubehoer_SK]    INT           IDENTITY (1, 1) NOT NULL,
    [Typ]            VARCHAR (512) NULL,
    [Montageart]     VARCHAR (512) NULL,
    [Lichtpunkthöhe] VARCHAR (512) NULL,
    [Lichtrichtung]  VARCHAR (512) NULL,
    [Gehaeusefarbe]  VARCHAR (512) NULL,
    [Form]           VARCHAR (512) NULL,
    CONSTRAINT [PK_hub_Biro40_Zubehoer] PRIMARY KEY CLUSTERED ([Zubehoer_SK] ASC)
);

