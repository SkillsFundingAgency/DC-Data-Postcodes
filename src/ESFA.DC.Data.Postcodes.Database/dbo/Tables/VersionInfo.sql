CREATE TABLE [dbo].[VersionInfo] (
    [DataSource] NVARCHAR (50) NOT NULL,
    [VersionNumber] NVARCHAR(10) NOT NULL, 
    [Comments] NVARCHAR(1000) NULL, 
    [ModifiedBy] NVARCHAR(50) NOT NULL, 
    [ModifiedAt] DATETIME NOT NULL, 
    CONSTRAINT [PK_VersionInfo] PRIMARY KEY CLUSTERED ([VersionNumber], [DataSource])
);

