CREATE TABLE [dbo].[Skill] (
  [SkillID] [int] IDENTITY,
  [SkillName] [nvarchar](255) NOT NULL,
  CONSTRAINT [PK_Skill_SkillID] PRIMARY KEY CLUSTERED ([SkillID]),
  CONSTRAINT [UniqueSkillName] UNIQUE ([SkillName]) WITH (FILLFACTOR = 80)
)
ON [PRIMARY]
GO