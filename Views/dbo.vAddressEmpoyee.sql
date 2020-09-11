SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vAddressEmpoyee] AS
SELECT emp.[EmployeeID]
      ,emp.[FirstName]
      ,emp.[LastName]
	  ,emp.[EmployeeID] AS [AddressID]
	  ,emp.[Address]
  FROM [dbo].[Employee]		 AS emp
GO