CREATE TABLE [dbo].[Position] (
  [PositionID] [int] IDENTITY,
  [PositionName] [nvarchar](255) NOT NULL,
  CONSTRAINT [PK_Position_PositionID] PRIMARY KEY CLUSTERED ([PositionID])
)
ON [PRIMARY]
GO