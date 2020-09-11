CREATE TABLE [dbo].[ProjectSkill] (
  [ProjectID] [int] NOT NULL,
  [SkillID] [int] NOT NULL,
  CONSTRAINT [PK_ProjectSkill] PRIMARY KEY CLUSTERED ([ProjectID], [SkillID])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProjectSkill] WITH NOCHECK
  ADD CONSTRAINT [FK_ProjectSkill_ProjectID] FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Project] ([ProjectID])
GO

ALTER TABLE [dbo].[ProjectSkill] WITH NOCHECK
  ADD CONSTRAINT [FK_ProjectSkill_SkillID] FOREIGN KEY ([SkillID]) REFERENCES [dbo].[Skill] ([SkillID])
GO