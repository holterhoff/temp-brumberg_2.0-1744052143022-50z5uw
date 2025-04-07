CREATE TABLE [hub].[Biro40_Profil] (
    [Profil_SK]              INT           IDENTITY (1, 1) NOT NULL,
    [Profiltyp]              VARCHAR (512) NULL,
    [Montageart]             VARCHAR (512) NULL,
    [Lichtrichtung]          VARCHAR (512) NULL,
    [Montageart_Kurztext]    VARCHAR (512) NULL,
    [Anfangswinkel]          INT           NULL,
    [Endwinkel]              INT           NULL,
    [Schnittmass_Max]        INT           NULL,
    [Schnitttyp]             VARCHAR (512) NULL,
    [Gehaeusefarbe]          VARCHAR (512) NULL,
    [Gehaeusefarbe_Kurztext] VARCHAR (512) NULL,
    CONSTRAINT [PK_hub_Biro40_Profil] PRIMARY KEY CLUSTERED ([Profil_SK] ASC)
);



