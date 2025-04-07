CREATE TABLE [hub].[Biro40_Eulum] (
    [Eulum_SK]         INT           IDENTITY (1, 1) NOT NULL,
    [Typ]              VARCHAR (512) NULL,
    [Lichtrichtung]    VARCHAR (512) NULL,
    [Lichtfarbe]       VARCHAR (512) NULL,
    [Schaltungsart]    VARCHAR (512) NULL,
    [Optisches_System] VARCHAR (512) NULL,
    [Min]              INT           NULL,
    [Max]              INT           NULL,
    [Step]             INT           NULL,
    [Ecklaenge]        INT           NULL,
    [Eckmodus]         VARCHAR (512) NULL,
    CONSTRAINT [PK_hub_Biro40_Eulum] PRIMARY KEY CLUSTERED ([Eulum_SK] ASC)
);

