CREATE TABLE [hub].[Biro40_GT] (
    [GT_SK]         INT           IDENTITY (1, 1) NOT NULL,
    [Typ]           VARCHAR (512) NULL,
    [Lichtrichtung] VARCHAR (512) NULL,
    [Lichtfarbe]    VARCHAR (512) NULL,
    [Schaltungsart] VARCHAR (512) NULL,
    [Step]          INT           NULL,
    CONSTRAINT [PK_hub_Biro40_GT] PRIMARY KEY CLUSTERED ([GT_SK] ASC)
);

