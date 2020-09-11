CREATE TABLE [dbo].[JobHistory] (
  [EmployeeID] [int] NOT NULL,
  [CompanyID] [int] NOT NULL,
  [PositionID] [int] NOT NULL,
  [ProjectID] [int] NOT NULL,
  [StartDate] [date] NOT NULL,
  [FinishDate] [date] NULL,
  [Description] [nvarchar](max) NOT NULL,
  [Achievements] [nvarchar](max) NULL,
  [ReasonsForLeavingTheProject] [nvarchar](max) NULL,
  [ReasonsForLeavingTheCompany] [nvarchar](max) NULL,
  CONSTRAINT [PK_JobHistory] PRIMARY KEY CLUSTERED ([EmployeeID], [CompanyID], [PositionID], [ProjectID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[JobHistory]
  ADD CONSTRAINT [FK_JobHistory_Company_CompanyID] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
GO

ALTER TABLE [dbo].[JobHistory]
  ADD CONSTRAINT [FK_JobHistory_Employee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
GO

ALTER TABLE [dbo].[JobHistory]
  ADD CONSTRAINT [FK_JobHistory_Position_PositionID] FOREIGN KEY ([PositionID]) REFERENCES [dbo].[Position] ([PositionID])
GO

ALTER TABLE [dbo].[JobHistory]
  ADD CONSTRAINT [FK_JobHistory_Project_ProjectID] FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Project] ([ProjectID])
GO