CREATE TABLE [hub].[Biro40_Optik] (
    [Optik_SK]                  INT           IDENTITY (1, 1) NOT NULL,
    [Typ]                       VARCHAR (512) NULL,
    [Lichtrichtung]             VARCHAR (512) NULL,
    [Einsatz]                   VARCHAR (512) NULL,
    [Anfangswinkel]             INT           NULL,
    [Endwinkel]                 INT           NULL,
    [Schnittmass_Max]           INT           NULL,
    [Schnitttyp]                VARCHAR (512) NULL,
    [Optisches_System]          VARCHAR (512) NULL,
    [Optisches_System_Kurztext] VARCHAR (512) NULL,
    CONSTRAINT [PK_hub_Biro40_Optik] PRIMARY KEY CLUSTERED ([Optik_SK] ASC)
);



