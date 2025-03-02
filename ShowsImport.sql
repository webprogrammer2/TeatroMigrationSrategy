USE [TeatroManagementDb2]

SET IDENTITY_INSERT [dbo].[Shows] ON


INSERT INTO [dbo].[Shows]
           ([Id]
		   ,[Name]
           ,[TourId]
           ,[Description]
           ,[Duration]
           ,[ImagePath]
           ,[Comments]
           ,[WebShow]
           ,[WebDescription]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])


SELECT [id]     
	  ,[name]
	  ,[tour_id]
	  ,[description]
	  ,[duration]
	  ,''
	  ,''
	  ,[show_web]
      ,[web_description]
      ,''
	  ,GetDate()
	  ,''
	  ,GetDate()
  FROM TeatroDB.[dbo].[shows]

GO

SET IDENTITY_INSERT [dbo].[Shows] OFF



