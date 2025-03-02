USE [TeatroManagementDb2]

INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('1dcb22fe-3db9-4e6b-92c5-568a58c429ec','TeatroUser','TEATROUSER',4)
INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('60739fe2-fef7-4781-8904-beaf1863043e','ReadOnly','READONLY',6)
INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('6e237f6c-fddb-4472-a554-1bb5883e03db','WebUser','WEBUSER',3)
INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('8fcc0046-121b-4bd1-b314-c4af894389cd','Supervisor','SUPERVISOR',5)
INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('aee102c8-2e8a-4c07-8656-3ef81e24acc3','Owner','OWNER',1)
INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('c435711d-76c0-4439-9202-bb8160ceb407','Admin','ADMIN',2)

INSERT INTO [dbo].[AspNetUserRoles]
           ([UserId]
           ,[RoleId])
     VALUES
           ('2e5b38e7-2387-4604-9ab9-198384124d13'
           ,'1dcb22fe-3db9-4e6b-92c5-568a58c429ec')
GO

