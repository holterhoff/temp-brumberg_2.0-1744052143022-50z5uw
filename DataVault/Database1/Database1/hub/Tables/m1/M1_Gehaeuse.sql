CREATE TABLE [hub].[M1_Gehaeuse] (
    [Gehaeuse_SK]        INT           IDENTITY (1, 1) NOT NULL,
    [Leuchtentyp]        VARCHAR (512) NOT NULL,
    [Typ_DE]             VARCHAR (512) NOT NULL,
    [Typ_EN]             VARCHAR (512) NOT NULL,
    [Farbe_DE]           VARCHAR (512) NOT NULL,
    [Farbe_EN]           VARCHAR (512) NOT NULL,
    [Form_DE]            VARCHAR (512) NOT NULL,
    [Form_EN]            VARCHAR (512) NOT NULL,
    [Montageart_DE]      VARCHAR (512) NOT NULL,
    [Montageart_EN]      VARCHAR (512) NOT NULL,
    [Montageart_2_DE]    VARCHAR (512) NOT NULL,
    [Montageart_2_EN]    VARCHAR (512) NOT NULL,
    [Montageart_3_DE]    VARCHAR (512) NOT NULL,
    [Montageart_3_EN]    VARCHAR (512) NOT NULL,
    [Verstellbarkeit_DE] VARCHAR (512) NOT NULL,
    [Verstellbarkeit_EN] VARCHAR (512) NULL,
    CONSTRAINT [PK_hub_M1_Gehaeusee] PRIMARY KEY CLUSTERED ([Gehaeuse_SK] ASC)
);



