CREATE TABLE [sat].[Biro40_Eulum_Stammdaten] (
    [Eulum_SK]            INT           NOT NULL,
    [Profilschnitt]       INT           NULL,
    [Optikschnitt]        INT           NULL,
    [LS/m]                INT           NULL,
    [LS/m INDI]           VARCHAR (512) NULL,
    [W/m]                 INT           NULL,
    [W/m INDI]            VARCHAR (512) NULL,
    [Ausschreibungstext]  VARCHAR (512) NULL,
    [Netzspannung AC]     VARCHAR (512) NULL,
    [Netzspannung DC]     VARCHAR (512) NULL,
    [Farbtoleranz]        VARCHAR (512) NULL,
    [Farbwiedergabeindex] VARCHAR (512) NULL,
    [Lebensdauer]         VARCHAR (512) NULL,
    [Schutzklasse]        VARCHAR (512) NULL,
    [Schutzart]           VARCHAR (512) NULL,
    [Blendbewertung]      VARCHAR (512) NULL,
    PRIMARY KEY CLUSTERED ([Eulum_SK] ASC)
);

