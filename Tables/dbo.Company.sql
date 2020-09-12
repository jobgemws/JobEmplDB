CREATE TABLE [dbo].[Company] (
  [CompanyID] [int] IDENTITY,
  [CompanyName] [nvarchar](255) NOT NULL,
  [Description] [nvarchar](255) NOT NULL,
  [IsDeleted] [bit] NOT NULL DEFAULT (0),
  [Source] [nvarchar](255) NULL,
  CONSTRAINT [PK_Company_CompanyID] PRIMARY KEY CLUSTERED ([CompanyID])
)
ON [PRIMARY]
GO