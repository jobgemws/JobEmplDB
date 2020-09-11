CREATE TABLE [dbo].[Employee] (
  [EmployeeID] [int] IDENTITY,
  [FirstName] [nvarchar](255) NOT NULL,
  [LastName] [nvarchar](255) NOT NULL,
  [BirthDate] [date] NOT NULL,
  [DocDate] [date] NOT NULL,
  [DocNumber] [nchar](10) NOT NULL,
  [CountRequest] [int] NOT NULL,
  [PaymentAmount] [decimal](18, 2) NOT NULL,
  [RemoteAccessCertificate] [varbinary](max) NOT NULL,
  [Address] [nvarchar](max) NULL,
  CONSTRAINT [PK_Employee_EmployeeID] PRIMARY KEY CLUSTERED ([EmployeeID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO