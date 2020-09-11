SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchEmployee]
@SkillList NVARCHAR(MAX),
@CountNotSkill INT = 1
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @count_skills INT;

	SELECT
		[value] INTO #tbl_skill_tmp
	FROM STRING_SPLIT(@SkillList, N';');

	SELECT
		s.[SkillID]
	   ,s.[SkillName] INTO #tbl_skill
	FROM #tbl_skill_tmp AS tt
	INNER JOIN [dbo].[Skill] AS s
		ON s.[SkillName] = tt.[value];

	SET @count_skills = (SELECT
			COUNT(*)
		FROM #tbl_skill);

	SELECT
		jh.*
	   ,p.[ProjectName]
	   ,p.[Description] AS [ProjectDescription]
	   ,ts.* INTO #tbl_res0
	FROM [dbo].[JobHistory] AS jh
	INNER JOIN [dbo].[Project] AS p
		ON p.[ProjectID] = jh.[ProjectID]
	INNER JOIN [dbo].[ProjectSkill] AS ps
		ON ps.[ProjectID] = p.[ProjectID]
	INNER JOIN #tbl_skill AS ts
		ON ps.[SkillID] = ts.[SkillID];

	SELECT
		[EmployeeID]
	   ,[SkillID]
	   ,MIN([SkillName]) AS [SkillName]
	   ,SUM(DATEDIFF(DAY, [StartDate], COALESCE([FinishDate], GETDATE()))) AS [Days]
	   ,MIN([StartDate]) AS [StartDate]
	   ,MAX(COALESCE([FinishDate], GETDATE())) AS [FinishDate] INTO #tbl_res
	FROM #tbl_res0
	GROUP BY [SkillID]
			,[EmployeeID];

	SELECT
		emp.[EmployeeID]
	   ,emp.[LastName]
	   ,emp.[FirstName]
	   ,r.[SkillID]
	   ,r.[SkillName]
	   ,r.[StartDate]
	   ,r.[FinishDate]
	   ,r.[Days] / 365 AS [Years]
	   ,(r.[Days] - (r.[Days] / 365) * 365) / 30 AS [Months]
	   ,r.[Days] - (r.[Days] / 365) * 365 - ((r.[Days] - (r.[Days] / 365) * 365) / 30) * 30 AS [Days] INTO #tbl_res2
	FROM #tbl_res AS r
	INNER JOIN [dbo].[Employee] AS emp
		ON emp.[EmployeeID] = r.[EmployeeID];

	SELECT
		[EmployeeID]
	   ,[LastName]
	   ,[FirstName] INTO #tbl_empl
	FROM #tbl_res2;

	SELECT
		ts.[SkillID]
	   ,te.[EmployeeID]
	   ,ts.[SkillName]
	   ,te.[LastName]
	   ,te.[FirstName] INTO #tbl_skill_empl
	FROM #tbl_skill AS ts
	CROSS JOIN #tbl_empl AS te;

	SELECT
		tse.[EmployeeID]
	   ,tse.[LastName]
	   ,tse.[FirstName]
	   ,tse.[SkillID]
	   ,tse.[SkillName]
	   ,tr2.[StartDate]
	   ,tr2.[FinishDate]
	   ,tr2.[Years]
	   ,tr2.[Months]
	   ,tr2.[Days] INTO #tbl_res3
	FROM #tbl_skill_empl AS tse
	LEFT OUTER JOIN #tbl_res2 AS tr2
		ON tse.[SkillID] = tr2.[SkillID]
			AND tse.[EmployeeID] = tr2.[EmployeeID];

	SELECT
		[EmployeeID] INTO #tbl_empl_res
	FROM (SELECT
			[EmployeeID]
		   ,[SkillID]
		FROM #tbl_res3
		WHERE [Months] >= 6 OR [Years]>=1
		GROUP BY [EmployeeID]
				,[SkillID]) AS t
	GROUP BY [EmployeeID]
	HAVING COUNT(*) >= @count_skills - @CountNotSkill;

	SELECT
		tr2.[EmployeeID],
		tr2.[LastName],
		tr2.[FirstName],
		tr2.[SkillID],
		tr2.[SkillName],
		tr2.[StartDate],
		tr2.[FinishDate],
		tr2.[Years],
		tr2.[Months],
		tr2.[Days]
	FROM #tbl_empl_res AS ter
	INNER JOIN #tbl_res2 AS tr2
		ON ter.[EmployeeID] = tr2.[EmployeeID];

	--SELECT
	--	tr2.[EmployeeID],
	--	tr2.[LastName],
	--    tr2.[FirstName],
	--    tr0.[CompanyID],
	--	(SELECT TOP(1) com.[CompanyName] FROM [dbo].[Company] AS com WHERE com.[CompanyID]=tr0.[CompanyID]) AS [CompanyName],
	--	tr0.[PositionID],
	--	(SELECT TOP(1) p.[PositionName] FROM [dbo].[Position] AS p WHERE p.[PositionID]=tr0.[PositionID]) AS [PositionName],
	--	tr0.[ProjectID],
	--	tr0.[StartDate],
	--	tr0.[FinishDate],
	--	tr0.[Description],
	--	tr0.[ProjectName],
	--	tr0.[ProjectDescription],
	--	tr0.[SkillID],
	--	tr0.[SkillName],
	--	tr0.[Achievements],
	--	tr0.[ReasonsForLeavingTheProject],
	--	tr0.[ReasonsForLeavingTheCompany]
	--FROM #tbl_res2 AS tr2
	--INNER JOIN tbl_res0 AS tr0
	--	ON tr0.[EmployeeID] = tr2.[EmployeeID]
	--INNER JOIN #tbl_skill AS ts
	--	ON ts.[SkillID] = tr0.[SkillID];

	DROP TABLE #tbl_skill_tmp;
	DROP TABLE #tbl_skill;
	DROP TABLE #tbl_res;
	DROP TABLE #tbl_res2;
	DROP TABLE #tbl_empl;
	DROP TABLE #tbl_skill_empl;
	DROP TABLE #tbl_res3;
	DROP TABLE #tbl_empl_res;
	DROP TABLE #tbl_res0;
END
GO