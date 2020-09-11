CREATE TABLE [dbo].[Company] (
  [CompanyID] [int] IDENTITY,
  [CompanyName] [nvarchar](255) NOT NULL,
  [Description] [nvarchar](255) NOT NULL,
  CONSTRAINT [PK_Company_CompanyID] PRIMARY KEY CLUSTERED ([CompanyID])
)
ON [PRIMARY]
GO