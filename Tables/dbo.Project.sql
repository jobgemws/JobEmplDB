CREATE TABLE [dbo].[Project] (
  [ProjectID] [int] IDENTITY,
  [ProjectName] [nvarchar](255) NOT NULL,
  [Description] [nvarchar](max) NOT NULL,
  CONSTRAINT [PK_Project_ProjectID] PRIMARY KEY CLUSTERED ([ProjectID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO