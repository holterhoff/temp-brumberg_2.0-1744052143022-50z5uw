CREATE TABLE [hub].[Melody_Stehleuchte] (
    [Melody_SK] INT           IDENTITY (1, 1) NOT NULL,
    [Hersteller]              NVARCHAR(50) NOT NULL,
    [Leuchtenfamilie]         NVARCHAR(50) NOT NULL,
    [Variante]                NVARCHAR(50) NOT NULL,
    [Leuchtentyp]             NVARCHAR(50) NOT NULL,
    [Gehaeusefarbe]           NVARCHAR(50) NOT NULL,
    [Gehaeuseform]            NVARCHAR(50) NOT NULL,
    [Montageart]              NVARCHAR(50) NOT NULL,
    [Optik]                   NVARCHAR(50) NOT NULL,
    [Lichtrichtung]           NVARCHAR(50) NOT NULL,
    [Lichtfarbe]              NVARCHAR(50) NOT NULL,
    [Schaltungsart]           NVARCHAR(50) NOT NULL,
    

    
    CONSTRAINT [PK_hub_Melody_Stehleuchte] PRIMARY KEY CLUSTERED ([Melody_SK] ASC)
);

