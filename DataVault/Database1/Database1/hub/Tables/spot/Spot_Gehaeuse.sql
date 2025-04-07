CREATE TABLE [hub].[Spot_Gehaeuse] (
    [Gehaeuse_SK] INT          IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp] VARCHAR (50) NULL,
    [Typ]         VARCHAR (50) NULL,
    [Farbe_DE]    VARCHAR (50) NULL,
    [Farbe_EN]    VARCHAR (50) NULL,
    [Form_DE]     VARCHAR (50) NULL,
    [Form_EN]     VARCHAR (50) NULL,
    CONSTRAINT [PK_hub_Spot_Gehaeusee] PRIMARY KEY CLUSTERED ([Gehaeuse_SK] ASC)
);



